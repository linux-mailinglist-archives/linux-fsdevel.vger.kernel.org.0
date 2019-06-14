Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF97A45B99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 13:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfFNLn4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 07:43:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbfFNLnz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 07:43:55 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7B4C2082C;
        Fri, 14 Jun 2019 11:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560512634;
        bh=V5TLl3oUisgPhny7jBZzlzXvD3OZn0HlPaCP4bvCOO0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CrU50yk3V8PR1EQDQ2O9NNU3r/+nL1xthZXZR9bKmtbQlIWL9MbHn0tj72rylWU+4
         W4U1a4lcUyaJiDkMexshJFXKw/0n9JR25UwywctyaKIXALyr1s3pe7bUVRyR6wm4Fz
         xBnpk04REDgSEIJzX6YjUQmHnWx49AGeZdw26U6s=
Message-ID: <e9d51b85eef556f5ebe74bd581961953c5d9f2b4.camel@kernel.org>
Subject: Re: [PATCH] ceph: copy_file_range needs to strip setuid bits and
 update timestamps
From:   Jeff Layton <jlayton@kernel.org>
To:     Luis Henriques <lhenriques@suse.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org
Date:   Fri, 14 Jun 2019 07:43:52 -0400
In-Reply-To: <87v9x87dmi.fsf@suse.com>
References: <20190610174007.4818-1-amir73il@gmail.com>
         <ed2e4b5d26890e96ba9dafcb3dba88427e36e619.camel@kernel.org>
         <87zhml7ada.fsf@suse.com>
         <38f6f71f6be0b5baaea75417aa4bcf072e625567.camel@kernel.org>
         <87v9x87dmi.fsf@suse.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2019-06-14 at 09:52 +0100, Luis Henriques wrote:
> So, do you think the patch below would be enough?  It's totally
> untested, but I wanted to know if that would be acceptable before
> running some tests on it.
> 
> Cheers,
> --
> Luis
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index c5517ffeb11c..f6b0683dd8dc 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1949,6 +1949,21 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
>                 goto out;
>         }
>  
> +       ret = ceph_do_getattr(dst_inode, CEPH_CAP_AUTH_SHARED, false);
> +       if (ret < 0) {
> +               dout("failed to get auth caps on dst file (%zd)\n", ret);
> +               goto out;
> +       }
> +

I think this is still racy. You could lose As caps before file_modified
is called. IMO, this code should hold a reference to As caps until the
c_f_r operation is complete.

That may get tricky however if you do need to issue a setattr to change
the mode, as the MDS may try to recall As caps at that point. You won't
be able to release them until you drop the reference, so will that
deadlock? I'm not sure.

> +       /* Should dst_inode lock be held throughout the copy operation? */
> +       inode_lock(dst_inode);
> +       ret = file_modified(dst_file);
> +       inode_unlock(dst_inode);
> +       if (ret < 0) {
> +               dout("failed to modify dst file before copy (%zd)\n", ret);
> +               goto out;
> +       }
> +
>         /*
>          * We need FILE_WR caps for dst_ci and FILE_RD for src_ci as other
>          * clients may have dirty data in their caches.  And OSDs know nothing

-- 
Jeff Layton <jlayton@kernel.org>


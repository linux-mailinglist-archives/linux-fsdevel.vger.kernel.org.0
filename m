Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 432CB2E718
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 23:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfE2VJJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 17:09:09 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36349 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfE2VJJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 17:09:09 -0400
Received: by mail-yw1-f67.google.com with SMTP id e68so1692500ywf.3;
        Wed, 29 May 2019 14:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pyyIg1feZBNJIOhAeqOm6voCt8dVu19c0GgtaObDKJ4=;
        b=khBn2JsXbz31CjWCwT0lgFatYodQo+vX1CyVs6m9K+NUubSGgvBtj/AIj7nRCQRhx5
         WLAEY8+1qqY9wTuT4f/Um/9JFo0pFxwKfbt42NyvSJzBxm+5pi6tDX99QFPwSLuRCYdq
         nLPqhtLe7lKAXe2MmfSSop6mau30E1NIDyq9p/UjmVSefVXM2BfIku/MG2/PILCf2YwS
         hq6kOumFUUIUer5U3TW+NL0GcV+q1eejGacmXMuzzMQueSLxWp2j2+nQSlUsdnVDOcwA
         M2NhVBSjt+9sQK0lWkkA9PzQ4/17yLkzK96fzS+qdPSmRjQo47gxh6ZrYXPNOqCWbsqR
         OFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pyyIg1feZBNJIOhAeqOm6voCt8dVu19c0GgtaObDKJ4=;
        b=O+Qs9vUYiWkdDdijUfvxUJJUlhekHTgfv61ksccw49vfXQtx13+Q7zhSvX3oeeVCpR
         ybISK80NgIIN6Qp8v9kVj0uHke9DQ9PFV7yQDSxWIu7ahRdFuATJMnQg0ijUuUv3Wfk/
         d00dy1GDQ/44FExrEme/RjmR2fCEms0vAnOxGjVzqx9qit5tDrZFin4HONTMzISpZZNp
         rp8Kuxh1+V0ezT2vqTUfdo32/2Mzokq7f6CE4Wt415sqgGWDMZ9ei4ARgdHKpnXQdC8V
         +R2rf3b7P75jiKgRohzJb2MRkSTbWFQE26+0m3ZxBodWQGgi5HuUm31dk1hXcSf/5UG1
         q8dg==
X-Gm-Message-State: APjAAAXlhc4T2LvXOm7hAsYjmXRbQhoyexUvUm3U6ygt64IozFDE+INv
        a9MHAemLNIeChz+LpYL9tCGZsXidegffs42tvF60tWwqeNw=
X-Google-Smtp-Source: APXvYqw4+6WHlbq1/hdBYT0j6sWeY46tQL+hvGmOlLuYyaRNMv8Wv1i6JkrHWJ/s16NkHy0X8+ZG43jnvlddUrrS1wY=
X-Received: by 2002:a81:3956:: with SMTP id g83mr19628ywa.183.1559164148335;
 Wed, 29 May 2019 14:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190529174318.22424-1-amir73il@gmail.com> <20190529174318.22424-9-amir73il@gmail.com>
 <20190529183333.GH5231@magnolia>
In-Reply-To: <20190529183333.GH5231@magnolia>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 30 May 2019 00:08:56 +0300
Message-ID: <CAOQ4uxgttcbN7xtztB0A3wEV61NABgSsXufdOjPSiP8bb0iN0A@mail.gmail.com>
Subject: Re: [PATCH v3 08/13] vfs: copy_file_range needs to strip setuid bits
 and update timestamps
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        ceph-devel@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 29, 2019 at 9:33 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Wed, May 29, 2019 at 08:43:12PM +0300, Amir Goldstein wrote:
> > Because generic_copy_file_range doesn't hold the destination inode lock
> > throughout the copy, strip setuid bits before and after copy.
> >
> > The destination inode mtime is updated before and after the copy and the
> > source inode atime is updated after the copy, similar to
> > generic_file_read_iter().
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Looks reasonable,

Actually, it isn't reasonable. I'd like to recall this patch :-/
As one might expect, splice_direct_to_actor() already has file_accessed()
and "file_modified" is the responsibility of filesystem's ->write_iter().

Thanks,
Amir.

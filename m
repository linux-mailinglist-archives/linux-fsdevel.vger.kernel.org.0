Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593626B34D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 04:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjCJD0l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 22:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjCJD0h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 22:26:37 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD322F8F37;
        Thu,  9 Mar 2023 19:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u8e2ZdAGsrDs5mc8tdhL4wOZzMMIPUZ2NIMj6U1DMDU=; b=EyM1eRQycjfDodnwphsbE/w0GD
        4GSBdTKxZjNXgFXT3S1cfE2Cj2w7p++EBUL20k8CV/WQ5IJV6TnxjKIHfOp23yKTH1yv8sH+bnhso
        NQzHkrlD0K6ebfI0YbzvAaUrXy56zWlrvdGLol5HZ0gTtl6Z/sxYpU0zPoxR6V5CSKsaAUM0+xfoG
        Crd/TrAtj1NTfS8pi4d6K9U9JcIa60NnEM+2x2Tia4PS2feU2NQ7VPBycgaCHA7/z0P52ZZ9Zl38H
        NOKFsMJWnEN18CIiLLqiZyw1pERtByrbV4R4qgBHCXcbx6wXhTqQVHbZo2gmfRWW8wrreGNuhKout
        AUZwnThg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1paTOV-00FCYB-32;
        Fri, 10 Mar 2023 03:26:12 +0000
Date:   Fri, 10 Mar 2023 03:26:11 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
        mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        brauner@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] ocfs2: convert to use i_blockmask()
Message-ID: <20230310032611.GF3390869@ZenIV>
References: <20230309152127.41427-1-frank.li@vivo.com>
 <20230309152127.41427-5-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309152127.41427-5-frank.li@vivo.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 09, 2023 at 11:21:26PM +0800, Yangtao Li wrote:
> Use i_blockmask() to simplify code. BTW convert ocfs2_is_io_unaligned
> to return bool type.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v3:
> -none
>  fs/ocfs2/file.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
> index efb09de4343d..baefab3b12c9 100644
> --- a/fs/ocfs2/file.c
> +++ b/fs/ocfs2/file.c
> @@ -2159,14 +2159,14 @@ int ocfs2_check_range_for_refcount(struct inode *inode, loff_t pos,
>  	return ret;
>  }
>  
> -static int ocfs2_is_io_unaligned(struct inode *inode, size_t count, loff_t pos)
> +static bool ocfs2_is_io_unaligned(struct inode *inode, size_t count, loff_t pos)
>  {
> -	int blockmask = inode->i_sb->s_blocksize - 1;
> +	int blockmask = i_blockmask(inode);
>  	loff_t final_size = pos + count;
>  
>  	if ((pos & blockmask) || (final_size & blockmask))
> -		return 1;
> -	return 0;
> +		return true;
> +	return false;
>  }

Ugh...
	return (pos | count) & blockmask;
surely?  Conversion to bool will take care of the rest.  Or you could make
that
	return ((pos | count) & blockmask) != 0;

And the fact that the value will be the same (i.e. that ->i_blkbits is never
changed by ocfs2) is worth mentioning in commit message...

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E7A4790F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Dec 2021 17:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbhLQQHO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Dec 2021 11:07:14 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:49926 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbhLQQHO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:07:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ED4C9CE256C
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Dec 2021 16:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABF8C36AE7;
        Fri, 17 Dec 2021 16:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639757231;
        bh=Nw2qYC4zWyZleo0QiV+P/Oe8akNTTifA49QiiPctp88=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=O6y9ZN1iYwyzwNx2gp66GljozzVdXJKY3f6z+DEhul4upH5pXyXmUTkqFzUAJvmkt
         pfwy4DZm9ZTIt6gI1xihpwSxixTTSQuLh4tXUQTayTkI+xBZfnEaze6MYYp1VeS176
         +vEq9tvItYkfpdQ/fgJRUwa6zJX6nmGEOZ0XnR52rPcIEM2UZvc2isUFHlkpJ43jRn
         T1M1CV3/l3QjJMAHvxozZH+zyWxPB3JVs3bRTp1R1j6ND9wNeLbVaEo9+Jk3BIpY3N
         FcqXdov9nCf3UD71yygaAGOK0Unki48G1MbnMiDrd9ERqElIlcWVpIuuH9IVCb/GCq
         tcUrZjjpko+Lg==
Message-ID: <7017d22f7e09b1c8f6b181cdfcc8fd4c9f8566ce.camel@kernel.org>
Subject: Re: [PATCH v2 2/2] ceph: Remove some other inline-setting bits
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     idryomov@gmail.com, linux-fsdevel@vger.kernel.org
Date:   Fri, 17 Dec 2021 11:07:09 -0500
In-Reply-To: <163975499268.2021751.9526015087273381693.stgit@warthog.procyon.org.uk>
References: <163975498535.2021751.13839139728966985077.stgit@warthog.procyon.org.uk>
         <163975499268.2021751.9526015087273381693.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-12-17 at 15:29 +0000, David Howells wrote:
> Remove some other bits where a ceph file can't be inline because we
> uninlined it when we opened it for writing.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  fs/ceph/addr.c |    4 +---
>  fs/ceph/file.c |    4 ----
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 6e1b15cc87cf..553e2b5653f3 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1534,11 +1534,9 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
>  		ceph_put_snap_context(snapc);
>  	} while (err == 0);
>  
> -	if (ret == VM_FAULT_LOCKED ||
> -	    ci->i_inline_version != CEPH_INLINE_NONE) {
> +	if (ret == VM_FAULT_LOCKED) {
>  		int dirty;
>  		spin_lock(&ci->i_ceph_lock);
> -		ci->i_inline_version = CEPH_INLINE_NONE;
>  		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR,
>  					       &prealloc_cf);
>  		spin_unlock(&ci->i_ceph_lock);
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index d16ba8720783..4a0aeed7f660 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1031,7 +1031,6 @@ static void ceph_aio_complete(struct inode *inode,
>  		}
>  
>  		spin_lock(&ci->i_ceph_lock);
> -		ci->i_inline_version = CEPH_INLINE_NONE;
>  		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR,
>  					       &aio_req->prealloc_cf);
>  		spin_unlock(&ci->i_ceph_lock);
> @@ -1838,7 +1837,6 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		int dirty;
>  
>  		spin_lock(&ci->i_ceph_lock);
> -		ci->i_inline_version = CEPH_INLINE_NONE;
>  		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR,
>  					       &prealloc_cf);
>  		spin_unlock(&ci->i_ceph_lock);
> @@ -2116,7 +2114,6 @@ static long ceph_fallocate(struct file *file, int mode,
>  
>  	if (!ret) {
>  		spin_lock(&ci->i_ceph_lock);
> -		ci->i_inline_version = CEPH_INLINE_NONE;
>  		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR,
>  					       &prealloc_cf);
>  		spin_unlock(&ci->i_ceph_lock);
> @@ -2509,7 +2506,6 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
>  	}
>  	/* Mark Fw dirty */
>  	spin_lock(&dst_ci->i_ceph_lock);
> -	dst_ci->i_inline_version = CEPH_INLINE_NONE;
>  	dirty = __ceph_mark_dirty_caps(dst_ci, CEPH_CAP_FILE_WR, &prealloc_cf);
>  	spin_unlock(&dst_ci->i_ceph_lock);
>  	if (dirty)
> 
> 

I'll probably just fold this one into the first patch if that's ok.
-- 
Jeff Layton <jlayton@kernel.org>

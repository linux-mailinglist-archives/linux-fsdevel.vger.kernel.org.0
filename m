Return-Path: <linux-fsdevel+bounces-58773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FC9B3164B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 13:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39B31A26E35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 11:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E002FABEC;
	Fri, 22 Aug 2025 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArygcnHe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5E62F6184;
	Fri, 22 Aug 2025 11:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755862072; cv=none; b=RTEKDA3qlHpxiiJid3QsbnTkK6sZ7LyrKVBxRAVwjGs82+LWWEzs/9z8sYoTtEAIXZsJolh1aD1Tn7QYxUxu8XnbiOsZvNfn3wXZSwYKpNhCa1bMKkMg9iB2nQhkwuSYhFUbdceNPMDW86FwIlh+M8MIzABy71088BoYdafJyEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755862072; c=relaxed/simple;
	bh=WpWiRLhNlzKzziHrtTeGg8bZVKhIKrv23ZA8D5pstQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rl2lH7MCMNuLonlUPx4hT4rO0B3IQT08zQNrdkUag8pVim2lh13RFWP8Or4OuwAlELULcLsVoCpdI9Y8xfVw8w8EzMnprCkolKciVtmlLnn33VlO088A+yU8T+hBHwHLoAhTXVUPSXS+O0ucR5CXxSUV3vP4A2+KrHY2+dchE10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArygcnHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F62C4CEED;
	Fri, 22 Aug 2025 11:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755862071;
	bh=WpWiRLhNlzKzziHrtTeGg8bZVKhIKrv23ZA8D5pstQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ArygcnHeqgYR+aKUGakpG1htxfUHJvCuask3y27mI50i23hfQN8iLBSFS3l3QqNsX
	 9IeZX9N3sLYDOpew6SwZ7qHYJ2L6b9faGXEPThhdhhik4o4XqtxD8oK8FJd9b7YxLY
	 E+Q2pjX6Dw6bcwCy70LtKz61MMqUDWsJ+xknDVO0l6q6DY3KgOd9C4kdZQ05L1qVoR
	 BrWGaS6+GnB/R0qYtOhur4VQios4d9I+GHGtuEwAnFxbLE7OZFXEwFKi4CFuB1oy2B
	 FADAUucp0y/zOnBkI4QXjUWXFZRdhaQeuG5ge1PeLm58cbiUjt1r1I/hl3BNEyiIMQ
	 DJnebdtKIlR5g==
Date: Fri, 22 Aug 2025 13:27:47 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 04/50] fs: hold an i_obj_count reference for the i_wb_list
Message-ID: <20250822-donnerstag-sowas-477e66bd0cf1@brauner>
References: <cover.1755806649.git.josef@toxicpanda.com>
 <39379ac2620e98987f185dcf3a20f7b273d7ca33.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39379ac2620e98987f185dcf3a20f7b273d7ca33.1755806649.git.josef@toxicpanda.com>

On Thu, Aug 21, 2025 at 04:18:15PM -0400, Josef Bacik wrote:
> If we're holding the inode on one of the writeback lists we need to have
> a reference on that inode. Grab a reference when we add i_wb_list to
> something, drop it when it's removed.
> 
> This is potentially dangerous, because we remove the inode from the
> i_wb_list potentially under IRQ via folio_end_writeback(). This will be
> mitigated by making sure all writeback is completed on the final iput,
> before the final iobj_put, preventing a potential free under IRQ.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/fs-writeback.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 001773e6e95c..c2437e3d320a 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1332,6 +1332,7 @@ void sb_mark_inode_writeback(struct inode *inode)
>  	if (list_empty(&inode->i_wb_list)) {
>  		spin_lock_irqsave(&sb->s_inode_wblist_lock, flags);
>  		if (list_empty(&inode->i_wb_list)) {
> +			iobj_get(inode);
>  			list_add_tail(&inode->i_wb_list, &sb->s_inodes_wb);
>  			trace_sb_mark_inode_writeback(inode);
>  		}
> @@ -1346,15 +1347,26 @@ void sb_clear_inode_writeback(struct inode *inode)
>  {
>  	struct super_block *sb = inode->i_sb;
>  	unsigned long flags;
> +	bool drop = false;
>  
>  	if (!list_empty(&inode->i_wb_list)) {
>  		spin_lock_irqsave(&sb->s_inode_wblist_lock, flags);
>  		if (!list_empty(&inode->i_wb_list)) {
> +			drop = true;
>  			list_del_init(&inode->i_wb_list);
>  			trace_sb_clear_inode_writeback(inode);
>  		}
>  		spin_unlock_irqrestore(&sb->s_inode_wblist_lock, flags);
>  	}
> +
> +	/*
> +	 * This can be called in IRQ context when we're clearing writeback on
> +	 * the folio. This should not be the last iobj_put() on the inode, we
> +	 * run all of the writeback before we free the inode in order to avoid
> +	 * this possibility.
> +	 */
> +	if (drop)
> +		iobj_put(inode);

In that case it might be valuable to have a:

VFS_WARN_ON_ONCE(refcount_read(&inode->i_obj_count) < 2);

before calling iobj_put() here? It'll compile out without
CONFIG_VFS_DEBUG set.

Btw, you should also be able to write this as removing the condition.

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 2e10cc2f955f..cfdb2c2793cb 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1366,13 +1366,13 @@ void sb_mark_inode_writeback(struct inode *inode)
 void sb_clear_inode_writeback(struct inode *inode)
 {
        struct super_block *sb = inode->i_sb;
+       struct inode *drop = NULL;
        unsigned long flags;
-       bool drop = false;

        if (!list_empty(&inode->i_wb_list)) {
                spin_lock_irqsave(&sb->s_inode_wblist_lock, flags);
                if (!list_empty(&inode->i_wb_list)) {
-                       drop = true;
+                       drop = inode;
                        list_del_init(&inode->i_wb_list);
                        trace_sb_clear_inode_writeback(inode);
                }
@@ -1385,8 +1385,7 @@ void sb_clear_inode_writeback(struct inode *inode)
         * run all of the writeback before we free the inode in order to avoid
         * this possibility.
         */
-       if (drop)
-               iobj_put(inode);
+       iobj_put(drop);
 }

>  }
>  
>  /*
> @@ -2683,6 +2695,8 @@ static void wait_sb_inodes(struct super_block *sb)
>  		 * to preserve consistency between i_wb_list and the mapping
>  		 * writeback tag. Writeback completion is responsible to remove
>  		 * the inode from either list once the writeback tag is cleared.
> +		 * At that point the i_obj_count reference will be dropped for
> +		 * the i_wb_list reference.
>  		 */
>  		list_move_tail(&inode->i_wb_list, &sb->s_inodes_wb);
>  
> -- 
> 2.49.0
> 


Return-Path: <linux-fsdevel+bounces-13902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C96687544F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 17:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5EB1C23A12
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 16:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BC312F5B3;
	Thu,  7 Mar 2024 16:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTt6NQt8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699D212FB1B
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829484; cv=none; b=DTZHMaEcpdAZdY98jZ1SzM/S1Ofzh8kk4pIPoG2Yn2//bZX3r/lZ0pdghhdoZSZZMxOBBtB4qVm85hug6dtJ3u9wqDNAM1Dd0nbJQTyZG6vFT7T6MVNYD474feYzsINpE3aPg78N78QvPCQJgOk/6rz0Jc6NaZqynTdBvVCtp3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829484; c=relaxed/simple;
	bh=Xc1RADxWRD/rXuDLCCMl83+O+tvdf56UaM6pkmSM49w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8qmZUxL/B0a7LykyaYu2kkgxpGJmJ2+1jy0h2dJOjrmCw3UA5nyNJuoWFJ8D6cR+G2HC6b7u+pvgBDwnArc6eU2wSDZNrrx3HDo/o6H6gzc8bf+HwXbQopPAB1onocu5N+lC0H+NOVqnpCd7E4j7a+Zred04p3w694cIw7wAxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CTt6NQt8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709829481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=61k6sxXDaK1YvW1pSsT3dp5hGMMA9prNBnhq5UMhGsk=;
	b=CTt6NQt8rljWTNgm3IEAScf3gKugueZtteu1cdq/0wczrZz1GSroHu4ahF9tVuHj9c6iSa
	MgIozoKBLthhHVoErTnCW1yvw/LSNPQ9ITyvL/CFpvf3oNYR32h3uytVpwHQeLaSQ9M73o
	R0XhmBEJYufyDh0RbH7BAOK3cDV2Itc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-51UoDzXpNp2e1pvE4C899Q-1; Thu,
 07 Mar 2024 11:37:59 -0500
X-MC-Unique: 51UoDzXpNp2e1pvE4C899Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E12B1C5406A;
	Thu,  7 Mar 2024 16:37:59 +0000 (UTC)
Received: from redhat.com (unknown [10.22.32.76])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E1B51121306;
	Thu,  7 Mar 2024 16:37:58 +0000 (UTC)
Date: Thu, 7 Mar 2024 10:37:57 -0600
From: Bill O'Donnell <bodonnel@redhat.com>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: Re: [PATCH] minix: convert minix to use the new mount api
Message-ID: <ZentZRp2Y506kIh2@redhat.com>
References: <20240305210829.943737-1-bodonnel@redhat.com>
 <c4a2e820-70e5-453c-b022-a3207fb9119d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4a2e820-70e5-453c-b022-a3207fb9119d@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Tue, Mar 05, 2024 at 03:27:17PM -0600, Eric Sandeen wrote:
> On 3/5/24 3:08 PM, Bill O'Donnell wrote:
> > Convert the minix filesystem to use the new mount API.
> > 
> > Tested using mount and remount on minix device.
> > 
> > Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
> > ---
> >  fs/minix/inode.c | 64 ++++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 46 insertions(+), 18 deletions(-)
> > 
> > diff --git a/fs/minix/inode.c b/fs/minix/inode.c
> > index 73f37f298087..248e78a118e7 100644
> > --- a/fs/minix/inode.c
> > +++ b/fs/minix/inode.c
> > @@ -20,11 +20,11 @@
> >  #include <linux/mpage.h>
> >  #include <linux/vfs.h>
> >  #include <linux/writeback.h>
> > +#include <linux/fs_context.h>
> >  
> >  static int minix_write_inode(struct inode *inode,
> >  		struct writeback_control *wbc);
> >  static int minix_statfs(struct dentry *dentry, struct kstatfs *buf);
> > -static int minix_remount (struct super_block * sb, int * flags, char * data);
> >  
> >  static void minix_evict_inode(struct inode *inode)
> >  {
> > @@ -111,19 +111,19 @@ static const struct super_operations minix_sops = {
> >  	.evict_inode	= minix_evict_inode,
> >  	.put_super	= minix_put_super,
> >  	.statfs		= minix_statfs,
> > -	.remount_fs	= minix_remount,
> >  };
> >  
> > -static int minix_remount (struct super_block * sb, int * flags, char * data)
> > +static int minix_reconfigure(struct fs_context *fc)
> >  {
> > -	struct minix_sb_info * sbi = minix_sb(sb);
> >  	struct minix_super_block * ms;
> > +	struct super_block *sb = fc->root->d_sb;
> > +	struct minix_sb_info * sbi = sb->s_fs_info;
> >  
> >  	sync_filesystem(sb);
> >  	ms = sbi->s_ms;
> > -	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
> > +	if ((bool)(fc->sb_flags & SB_RDONLY) == sb_rdonly(sb))
> >  		return 0;
> > -	if (*flags & SB_RDONLY) {
> > +	if (fc->sb_flags & SB_RDONLY) {
> >  		if (ms->s_state & MINIX_VALID_FS ||
> >  		    !(sbi->s_mount_state & MINIX_VALID_FS))
> >  			return 0;
> > @@ -170,7 +170,7 @@ static bool minix_check_superblock(struct super_block *sb)
> >  	return true;
> >  }
> >  
> > -static int minix_fill_super(struct super_block *s, void *data, int silent)
> > +static int minix_fill_super(struct super_block *s, struct fs_context *fc)
> >  {
> >  	struct buffer_head *bh;
> >  	struct buffer_head **map;
> > @@ -180,6 +180,7 @@ static int minix_fill_super(struct super_block *s, void *data, int silent)
> >  	struct inode *root_inode;
> >  	struct minix_sb_info *sbi;
> >  	int ret = -EINVAL;
> > +	int silent = fc->sb_flags & SB_SILENT;
> >  
> >  	sbi = kzalloc(sizeof(struct minix_sb_info), GFP_KERNEL);
> >  	if (!sbi)
> > @@ -371,6 +372,39 @@ static int minix_fill_super(struct super_block *s, void *data, int silent)
> >  	return ret;
> >  }
> >  
> > +static int minix_get_tree(struct fs_context *fc)
> > +{
> > +	 return get_tree_bdev(fc, minix_fill_super);
> > +}
> > +
> > +static void minix_free_fc(struct fs_context *fc)
> > +{
> > +	kfree(fc->fs_private);
> > +}
> > +
> > +struct minix_context {
> > +	unsigned long s_mount_opts;
> 
> This is never used. The context is typically used for storing mount
> options during parsing, but minix has none, so this isn't needed.
> 
> > +};
> > +
> > +static const struct fs_context_operations minix_context_ops = {
> > +	.get_tree	= minix_get_tree,
> > +	.reconfigure	= minix_reconfigure,
> > +	.free		= minix_free_fc,
> > +};
> > +
> > +static int minix_init_fs_context(struct fs_context *fc)
> > +{
> > +	struct minix_context *ctx;
> > +
> > +	ctx = kzalloc(sizeof(struct minix_context), GFP_KERNEL);
> > +	if (!ctx)
> > +		return -ENOMEM;
> > +	fc->ops = &minix_context_ops;
> > +	fc->fs_private = ctx;
> 
> and so it doesn't need to be allocated & stored, or freed.
> 
> -Eric

Thanks for the review. v2 sent.
-Bill


> 
> 
> 



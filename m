Return-Path: <linux-fsdevel+bounces-13025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1207A86A458
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 01:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4237C1C2338C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 00:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C27D394;
	Wed, 28 Feb 2024 00:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKIuInr6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D252363
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 00:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709079611; cv=none; b=WQ1p27A8l9HDTFP1uAl6roMdaoWG3GWpYRO2h+t9OkO6oLP2Lx9ko5HtORM0WOHG6yfJiw0Xvi0jANENJh/REASNWS6QdXcGbZ/XKgs5szgBmnV1S6BHxE+HB74Xm8EmJphv5i0y1OoUevOmeVmbZ4Om4MLI1IMUdYnMNSdh61o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709079611; c=relaxed/simple;
	bh=ysFHxw4xCx5XWBhExbn5CpvHKpdFnktgHX2sTRU+Qag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQHx+SIE8qKN0x0jDK6qdKFRRQh10NJTyv3/retFKaHQTomX/pyVMKYtUfmwHOx00369Ao705AA+xmE9w3VKmjD8fnQUYLymCnJF5sPhfbfyClnpvjKbSaIpzfKUhqOyasG76AdoEuJsF/zMyDuQmLRgaa1kIYtYzLV9lC1cy40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SKIuInr6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709079609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1oxjIpuR40GN269ZNip633ZIGGymIJAfYOhFRmI3l9M=;
	b=SKIuInr6kNh9YzLV9+dFjzmetfYIIZmsg4jkqEhm99BPq19W+37HBespHCAbtF7Uv5+ng/
	RcCY0YkyxaM/LfIlHweo9/z7j0I56vGFWK0GUeTYH6BPajsQOSbjnnQgZb1EKJZLvaPsEi
	tu4FCF3ARIWDiBBC34ib5rIH3/cHq/c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-o5Wcs_auMRib56lnkBWjhg-1; Tue, 27 Feb 2024 19:20:07 -0500
X-MC-Unique: o5Wcs_auMRib56lnkBWjhg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2DEBC88D019;
	Wed, 28 Feb 2024 00:20:07 +0000 (UTC)
Received: from redhat.com (unknown [10.22.9.199])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9852D2026D0A;
	Wed, 28 Feb 2024 00:20:06 +0000 (UTC)
Date: Tue, 27 Feb 2024 18:20:05 -0600
From: Bill O'Donnell <bodonnel@redhat.com>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: linux-fsdevel@vger.kernel.org, al@alarsen.net, brauner@kernel.org,
	sandeen@redhat.com
Subject: Re: [PATCH] qnx4: convert qnx4 to use the new mount api
Message-ID: <Zd58NdyYetuVakMi@redhat.com>
References: <20240226224628.710547-1-bodonnel@redhat.com>
 <ff9e0d7b-49e7-4c4d-95d1-76bbf8b0b685@sandeen.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff9e0d7b-49e7-4c4d-95d1-76bbf8b0b685@sandeen.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Tue, Feb 27, 2024 at 04:49:04PM -0600, Eric Sandeen wrote:
> On 2/26/24 4:46 PM, Bill O'Donnell wrote:
> > Convert the qnx4 filesystem to use the new mount API.
> > 
> > Tested mount, umount, and remount using a qnx4 boot image.
> > 
> > Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
> > ---
> >  fs/qnx4/inode.c | 49 +++++++++++++++++++++++++++++++------------------
> >  1 file changed, 31 insertions(+), 18 deletions(-)
> > 
> > diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
> > index 6eb9bb369b57..c36fbe45a0e9 100644
> > --- a/fs/qnx4/inode.c
> > +++ b/fs/qnx4/inode.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/buffer_head.h>
> >  #include <linux/writeback.h>
> >  #include <linux/statfs.h>
> > +#include <linux/fs_context.h>
> >  #include "qnx4.h"
> >  
> >  #define QNX4_VERSION  4
> > @@ -30,28 +31,33 @@ static const struct super_operations qnx4_sops;
> >  
> >  static struct inode *qnx4_alloc_inode(struct super_block *sb);
> >  static void qnx4_free_inode(struct inode *inode);
> > -static int qnx4_remount(struct super_block *sb, int *flags, char *data);
> >  static int qnx4_statfs(struct dentry *, struct kstatfs *);
> > +static int qnx4_get_tree(struct fs_context *fc);
> >  
> >  static const struct super_operations qnx4_sops =
> >  {
> >  	.alloc_inode	= qnx4_alloc_inode,
> >  	.free_inode	= qnx4_free_inode,
> >  	.statfs		= qnx4_statfs,
> > -	.remount_fs	= qnx4_remount,
> >  };
> >  
> > -static int qnx4_remount(struct super_block *sb, int *flags, char *data)
> > +static int qnx4_reconfigure(struct fs_context *fc)
> >  {
> > -	struct qnx4_sb_info *qs;
> > +	struct super_block *sb = fc->root->d_sb;
> > +	struct qnx4_sb_info *qs = sb->s_fs_info;
> 
> You assign *qs here at declaration
>   
> >  	sync_filesystem(sb);
> >  	qs = qnx4_sb(sb);
> 
> and then reassign it here (qnx4_sb() just gets sb->s_fs_info as well)
> 
> Don't need both, I'd stick with just the uninitialized *qs as was
> originally in qnx4_remount().

I did wonder about that. I'll submit a v2. Thanks for your review.
-Bill

> 
> The rest looks fine to me,
> -Eric
> 
> 



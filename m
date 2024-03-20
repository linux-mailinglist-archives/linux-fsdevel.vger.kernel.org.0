Return-Path: <linux-fsdevel+bounces-14911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F960881588
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 17:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33011C20BC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 16:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D64254FB7;
	Wed, 20 Mar 2024 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UURchn5Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D275466C
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710951751; cv=none; b=pL8g0ei/lJc5KXxdnn/WWwZcXGoT5YKTx7qexr1vWIVsAEkxVtqwYD7v633vmmuuU5OEg1Bq2tT4kLJMdMYTz3mAhjqXeRUg+X1K5yMky6FnyuQtH0CYzem7uW9Mdh/MQXurOkU3mSciomIei7f+yj+atvzWcbL/1JQw5uIzBv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710951751; c=relaxed/simple;
	bh=41tjM+J6WGDCzpOXj69URQ1sTfiQe8Lh93Zr3nJSrwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGnv0XvpeV5ieF+j93Woq22nPdaeUv4TOR9n6JKnh89SYs/k3RaBgCW+T1GqNa1HBHaRNL2x81CDL08bJhFguL47NhCOM/yBfREExnf3LS1KbfKaNi4XV0SzOUSbiuZ+DtyL4gFzWvMJ1QCV87gbgkdXIcC8gurLCo2WopC7yIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UURchn5Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710951748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1PNmHTETrb06QIsSR2/EHe/MAGIbj5F6opVNo6zaJeM=;
	b=UURchn5ZUee2MTogNcXP9ef2nifL+EGgIR20mm/FsE19XJCQpSORkHMgz22jIo27UkVYqb
	JTKop0YXHKDjIC9DdfAsfKE+ZfIYYrmPWVCuVMJpla5ZrKm7XedivJ5h+NBueSheZXsibP
	WppMSfUoOfWsZBIiiU0buGpuoPh1+o4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-sL8Sf4yBO4aDe5JN7eDRkA-1; Wed, 20 Mar 2024 12:22:27 -0400
X-MC-Unique: sL8Sf4yBO4aDe5JN7eDRkA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a4675f4361dso724766b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 09:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710951745; x=1711556545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PNmHTETrb06QIsSR2/EHe/MAGIbj5F6opVNo6zaJeM=;
        b=dr1lkgSvFi4Vpy60XnreiJPSU4dHp+eSu/DEK1Tq4wRyjWoBb6dcHJgZXYL7ywTlwW
         LkWlNb7N4q9zG5Opmpt/T8Lc9XNxLFsZf9SBWWZ1ifgbgYIrCrQ7q0DRSzyKtVtfo8pX
         xNF4sdoUwyQjfXzcs9gWIVyynoMc1akpjs00tgQy6kBIL2oK3gowvkl9KXNX9dGJvIYW
         W2lgM4F1gwZqxezUCUwB4gwu8MeviV6z1H07jMazpLhxjlQuXNotQLoOgYbDP82tvwz4
         yvzyOPYt3L8AaprczTFVBDL/6F1VpozdIvND2pUmXqnqBSMIDoj5irkVkrBckF64dsxa
         wpVA==
X-Forwarded-Encrypted: i=1; AJvYcCVbepQHsJPq0hLAv81V4Tj1QmGeSjz2Jkn5jNRDRY6g6j8hbkpNtUZqgt5z6iyeJaduuou8DGF2krBOMNjzDSm5xBKyGppKA23j7RdPSA==
X-Gm-Message-State: AOJu0Yz134vekhnK2nJ5hQJKviAY+MPY3SMfKxpBZYkSmgyV1YTNbQjK
	lR6jYPDeCzqDk201BxcBpysCrrKkSU3k5PBeg6aDSmId2LrlGNgki9drjEilvRblyQVeFzAdGi+
	pJ0nzVImy+yIntNIRoX4envsDutvNj1BqhyZEDyJNr6vF3IadW9/9tGKgCPvWlXNbRfhbiQ==
X-Received: by 2002:a17:906:6009:b0:a44:b9e0:8592 with SMTP id o9-20020a170906600900b00a44b9e08592mr1687366ejj.8.1710951745314;
        Wed, 20 Mar 2024 09:22:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFG7Udrm6I52hNnwHrU2ypGXiKfrtE7hJ7eDswBpRY1MNY22ZWL6AD5QA9JT8JzOvVqArGrUA==
X-Received: by 2002:a17:906:6009:b0:a44:b9e0:8592 with SMTP id o9-20020a170906600900b00a44b9e08592mr1687352ejj.8.1710951744752;
        Wed, 20 Mar 2024 09:22:24 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id wg8-20020a17090705c800b00a46cc48ab13sm3161782ejb.62.2024.03.20.09.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 09:22:24 -0700 (PDT)
Date: Wed, 20 Mar 2024 17:22:23 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 08/29] fsverity: add per-sb workqueue for post read
 processing
Message-ID: <tuidl6b6miayxekeqfpdgegvxyisqjryf5zvgnz5dfbqab5def@cnks2upytvto>
References: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
 <171035223488.2613863.7583467519759571221.stgit@frogsfrogsfrogs>
 <20240319233010.GV1927156@frogsfrogsfrogs>
 <ktc3ofsctond43xfc3lerr4evy3a3hsclyxm24cmhf7fsxxfsw@gjqnq57cbeoy>
 <20240320145504.GY1927156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320145504.GY1927156@frogsfrogsfrogs>

On 2024-03-20 07:55:04, Darrick J. Wong wrote:
> On Wed, Mar 20, 2024 at 11:37:28AM +0100, Andrey Albershteyn wrote:
> > On 2024-03-19 16:30:10, Darrick J. Wong wrote:
> > > On Wed, Mar 13, 2024 at 10:54:39AM -0700, Darrick J. Wong wrote:
> > > > From: Andrey Albershteyn <aalbersh@redhat.com>
> > > > 
> > > > For XFS, fsverity's global workqueue is not really suitable due to:
> > > > 
> > > > 1. High priority workqueues are used within XFS to ensure that data
> > > >    IO completion cannot stall processing of journal IO completions.
> > > >    Hence using a WQ_HIGHPRI workqueue directly in the user data IO
> > > >    path is a potential filesystem livelock/deadlock vector.
> > > > 
> > > > 2. The fsverity workqueue is global - it creates a cross-filesystem
> > > >    contention point.
> > > > 
> > > > This patch adds per-filesystem, per-cpu workqueue for fsverity
> > > > work. This allows iomap to add verification work in the read path on
> > > > BIO completion.
> > > > 
> > > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > > ---
> > > >  fs/super.c               |    7 +++++++
> > > >  include/linux/fs.h       |    2 ++
> > > >  include/linux/fsverity.h |   22 ++++++++++++++++++++++
> > > >  3 files changed, 31 insertions(+)
> > > > 
> > > > 
> > > > diff --git a/fs/super.c b/fs/super.c
> > > > index d35e85295489..338d86864200 100644
> > > > --- a/fs/super.c
> > > > +++ b/fs/super.c
> > > > @@ -642,6 +642,13 @@ void generic_shutdown_super(struct super_block *sb)
> > > >  			sb->s_dio_done_wq = NULL;
> > > >  		}
> > > >  
> > > > +#ifdef CONFIG_FS_VERITY
> > > > +		if (sb->s_read_done_wq) {
> > > > +			destroy_workqueue(sb->s_read_done_wq);
> > > > +			sb->s_read_done_wq = NULL;
> > > > +		}
> > > > +#endif
> > > > +
> > > >  		if (sop->put_super)
> > > >  			sop->put_super(sb);
> > > >  
> > > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > > index ed5966a70495..9db24a825d94 100644
> > > > --- a/include/linux/fs.h
> > > > +++ b/include/linux/fs.h
> > > > @@ -1221,6 +1221,8 @@ struct super_block {
> > > >  #endif
> > > >  #ifdef CONFIG_FS_VERITY
> > > >  	const struct fsverity_operations *s_vop;
> > > > +	/* Completion queue for post read verification */
> > > > +	struct workqueue_struct *s_read_done_wq;
> > > >  #endif
> > > >  #if IS_ENABLED(CONFIG_UNICODE)
> > > >  	struct unicode_map *s_encoding;
> > > > diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> > > > index 0973b521ac5a..45b7c613148a 100644
> > > > --- a/include/linux/fsverity.h
> > > > +++ b/include/linux/fsverity.h
> > > > @@ -241,6 +241,22 @@ void fsverity_enqueue_verify_work(struct work_struct *work);
> > > >  void fsverity_invalidate_block(struct inode *inode,
> > > >  		struct fsverity_blockbuf *block);
> > > >  
> > > > +static inline int fsverity_set_ops(struct super_block *sb,
> > > > +				   const struct fsverity_operations *ops)
> > > > +{
> > > > +	sb->s_vop = ops;
> > > > +
> > > > +	/* Create per-sb workqueue for post read bio verification */
> > > > +	struct workqueue_struct *wq = alloc_workqueue(
> > > > +		"pread/%s", (WQ_FREEZABLE | WQ_MEM_RECLAIM), 0, sb->s_id);
> > > 
> > > Looking at this more closely, why is it that the fsverity_read_queue
> > > is unbound and tagged WQ_HIGHPRI, whereas this one is instead FREEZEABLE
> > > and MEM_RECLAIM and bound?
> > > 
> > > If it's really feasible to use /one/ workqueue for all the read
> > > post-processing then this ought to be a fs/super.c helper ala
> > > sb_init_dio_done_wq.  That said, from Eric's comments on the v5 thread
> > > about fsverity and fscrypt locking horns over workqueue stalls I'm not
> > > convinced that's true.
> > 
> > There's good explanation by Dave why WQ_HIGHPRI is not a good fit
> > for XFS (potential livelock/deadlock):
> > 
> > https://lore.kernel.org/linux-xfs/20221214054357.GI3600936@dread.disaster.area/
> > 
> > Based on his feedback I changed it to per-filesystem.
> 
> Ah, ok.  Why is the workqueue tagged with MEM_RECLAIM though?  Does
> letting it run actually help out with reclaim?  I guess it does by
> allowing pages involved in readahead to get to unlocked state where they
> can be ripped out. :)

Not sure how much it actually helps with reclaims, leaving it out
would probably have the same effect in most cases. But I suppose at
least one reserved execution context is good thing to not block BIO
finalization.

-- 
- Andrey



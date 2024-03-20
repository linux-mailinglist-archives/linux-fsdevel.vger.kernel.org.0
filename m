Return-Path: <linux-fsdevel+bounces-14883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C0A88100A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 11:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CECC6283D7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 10:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F4838398;
	Wed, 20 Mar 2024 10:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="irOxKMZv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF63383A0
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710931056; cv=none; b=UnYY7t+WZcXYj8pgsP+/B/EQ4IHV2AEHwOQ+14qRzqSdFrasv2t6/SKWsKU6wzSEhTuBvUmQ/pntCp2Awh7l5Ea/XqnGXi2iaQt3vVPoG3fXjstbk500Ae7uXSjEn+tz2a4/msvnwG9ie0ysrYaqyWJ9MgWDfRmIOaLmbPqWh1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710931056; c=relaxed/simple;
	bh=9UYs4ZwejA0f5HPmQh6g5I9ponZ+C0/FZF4IS9lsAzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8yqk3zuoy50ryEJAep1sFfZZ0c0FL/LLybYf/ua6/PF4uOFcvdO6C0Y9oBpr0xfHmkkJeLXzVxfAz3njZGg1EQF3Qu65GUy6YxLnrDDGUHqspewBKfbWGId2fKIy2KmVjaGAZSF7FPhqwKvl8GC8ifTPyu9pWeN+qHWjj5bH28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=irOxKMZv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710931053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ADJP39t1GFmXzKGwztEyWbu3Yu1GQbVpqFj8SngTSA0=;
	b=irOxKMZvknRAEvnJ6eqlPEvWWot60ztPvaVBRFJejWzIczMGPSqvFoo5Vs4RZzMcDYckbN
	lc2EC15eZf0+4rWwIocp59QB+HsOaIQ/qHvlQREwkl9NUmLZTG4EkSlsA1r0108gA2LniI
	H1/3Uk54zxIG5FX8mc3CJiVb/FGLHr4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-h10gS5e1Nu6yX3g4AxepZQ-1; Wed, 20 Mar 2024 06:37:31 -0400
X-MC-Unique: h10gS5e1Nu6yX3g4AxepZQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a46b82df33cso216205566b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 03:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710931050; x=1711535850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADJP39t1GFmXzKGwztEyWbu3Yu1GQbVpqFj8SngTSA0=;
        b=c/bBXX4Q0FRKb0mzQ96jriyG0kBcQ5yp2irjF4GUZeVW4C7IPE6lLXWIZkFn71sISf
         o81R/EBhBDe0tqcAFl/uqda0+S63XA+Pv+ycT7k2CWLC2kYREBeYFYHhl9z5yt/48a87
         u7A/SqLbbeFmRkrACwlDrte5JusL0HE5CPTfUmjO4nxeqxHYY4H6qoWC/nvplKRhLsxJ
         YH5NoYSbU8xdO9lgQ+Oijha3eAWwADFBepisM61aQyoLVk6EOnwfeHG20bHM1mMOLtp9
         ViFbyHjj6n9WPzFFPmDPzxhPHueTf9Jhm1X55TQ3ZSalp6mGeqruti77fVhdo5OjiPDH
         dpwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjXXdIuMySNAt94+ytqrj8KCrqpZsOcopN6PyRO+LniDvddJefYfoXm51FpYsaIZQ2MSU+hU43JnD1nVNvtXwiZZ6egnZ+ZyYH1ZwZ8w==
X-Gm-Message-State: AOJu0YyUBuQxRlF9yfGsH8ymRGB5lHEWguWDRXshoAK+DL4pRGWscL12
	W/irqcNzox+feyka7k5Y49Pa1mlWcLTIICkF0GjFMbSO7ZZtCjrIPmAete1Yqj93aSRYLO+yemV
	SFmYP5mivbrrG2Ep3K6nDYyFMxR8ix59UbzoPBZmbA4z6TUBd8TmzelFjPVvgrw==
X-Received: by 2002:a17:907:6d0d:b0:a46:a927:115e with SMTP id sa13-20020a1709076d0d00b00a46a927115emr10378527ejc.39.1710931050414;
        Wed, 20 Mar 2024 03:37:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIJTAG9ko72Loy57po7F4TUY1dy0JWk8zC92Uf2ucyNg7WDekar5E7XdbMe/WRMTnJxVjXFg==
X-Received: by 2002:a17:907:6d0d:b0:a46:a927:115e with SMTP id sa13-20020a1709076d0d00b00a46a927115emr10378499ejc.39.1710931049760;
        Wed, 20 Mar 2024 03:37:29 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id wr6-20020a170907700600b00a4623030893sm7019903ejb.126.2024.03.20.03.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 03:37:29 -0700 (PDT)
Date: Wed, 20 Mar 2024 11:37:28 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 08/29] fsverity: add per-sb workqueue for post read
 processing
Message-ID: <ktc3ofsctond43xfc3lerr4evy3a3hsclyxm24cmhf7fsxxfsw@gjqnq57cbeoy>
References: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
 <171035223488.2613863.7583467519759571221.stgit@frogsfrogsfrogs>
 <20240319233010.GV1927156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319233010.GV1927156@frogsfrogsfrogs>

On 2024-03-19 16:30:10, Darrick J. Wong wrote:
> On Wed, Mar 13, 2024 at 10:54:39AM -0700, Darrick J. Wong wrote:
> > From: Andrey Albershteyn <aalbersh@redhat.com>
> > 
> > For XFS, fsverity's global workqueue is not really suitable due to:
> > 
> > 1. High priority workqueues are used within XFS to ensure that data
> >    IO completion cannot stall processing of journal IO completions.
> >    Hence using a WQ_HIGHPRI workqueue directly in the user data IO
> >    path is a potential filesystem livelock/deadlock vector.
> > 
> > 2. The fsverity workqueue is global - it creates a cross-filesystem
> >    contention point.
> > 
> > This patch adds per-filesystem, per-cpu workqueue for fsverity
> > work. This allows iomap to add verification work in the read path on
> > BIO completion.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  fs/super.c               |    7 +++++++
> >  include/linux/fs.h       |    2 ++
> >  include/linux/fsverity.h |   22 ++++++++++++++++++++++
> >  3 files changed, 31 insertions(+)
> > 
> > 
> > diff --git a/fs/super.c b/fs/super.c
> > index d35e85295489..338d86864200 100644
> > --- a/fs/super.c
> > +++ b/fs/super.c
> > @@ -642,6 +642,13 @@ void generic_shutdown_super(struct super_block *sb)
> >  			sb->s_dio_done_wq = NULL;
> >  		}
> >  
> > +#ifdef CONFIG_FS_VERITY
> > +		if (sb->s_read_done_wq) {
> > +			destroy_workqueue(sb->s_read_done_wq);
> > +			sb->s_read_done_wq = NULL;
> > +		}
> > +#endif
> > +
> >  		if (sop->put_super)
> >  			sop->put_super(sb);
> >  
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index ed5966a70495..9db24a825d94 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -1221,6 +1221,8 @@ struct super_block {
> >  #endif
> >  #ifdef CONFIG_FS_VERITY
> >  	const struct fsverity_operations *s_vop;
> > +	/* Completion queue for post read verification */
> > +	struct workqueue_struct *s_read_done_wq;
> >  #endif
> >  #if IS_ENABLED(CONFIG_UNICODE)
> >  	struct unicode_map *s_encoding;
> > diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> > index 0973b521ac5a..45b7c613148a 100644
> > --- a/include/linux/fsverity.h
> > +++ b/include/linux/fsverity.h
> > @@ -241,6 +241,22 @@ void fsverity_enqueue_verify_work(struct work_struct *work);
> >  void fsverity_invalidate_block(struct inode *inode,
> >  		struct fsverity_blockbuf *block);
> >  
> > +static inline int fsverity_set_ops(struct super_block *sb,
> > +				   const struct fsverity_operations *ops)
> > +{
> > +	sb->s_vop = ops;
> > +
> > +	/* Create per-sb workqueue for post read bio verification */
> > +	struct workqueue_struct *wq = alloc_workqueue(
> > +		"pread/%s", (WQ_FREEZABLE | WQ_MEM_RECLAIM), 0, sb->s_id);
> 
> Looking at this more closely, why is it that the fsverity_read_queue
> is unbound and tagged WQ_HIGHPRI, whereas this one is instead FREEZEABLE
> and MEM_RECLAIM and bound?
> 
> If it's really feasible to use /one/ workqueue for all the read
> post-processing then this ought to be a fs/super.c helper ala
> sb_init_dio_done_wq.  That said, from Eric's comments on the v5 thread
> about fsverity and fscrypt locking horns over workqueue stalls I'm not
> convinced that's true.

There's good explanation by Dave why WQ_HIGHPRI is not a good fit
for XFS (potential livelock/deadlock):

https://lore.kernel.org/linux-xfs/20221214054357.GI3600936@dread.disaster.area/

Based on his feedback I changed it to per-filesystem.

-- 
- Andrey



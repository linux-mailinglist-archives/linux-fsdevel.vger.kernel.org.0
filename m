Return-Path: <linux-fsdevel+bounces-58805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC232B319B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 15:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FAF21D22062
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 13:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25CE307AE1;
	Fri, 22 Aug 2025 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="m4AyDOqZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29750302CA0
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 13:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869517; cv=none; b=YuCaGZHsJ1ONbFcAi87s63OPSookavqjMlAU6TqC1Xku9+J54C96BTXGS1K46dzbSWgMfpfvcNfZoAd9bwWJ+Y5FS4qURdzLYxYSpBE04JH8Wgto4acMxFGnU8nJx62YqXIyhVwSxMOgh9Owf8EeO/z7bKUcRBEzbZjsH9GOSkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869517; c=relaxed/simple;
	bh=doC7mMX6Qib2P8llXBZPDzV0rg9Aoj4aCzPhSQRvmpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnPN2uT+HIXkSpk7ApL4CMz9Wn25k2BV7L90BegsIm0phricCbV+4sRZoSpnLLPv8kK3A0w6LfhkG9TWRxJQRyDLsj/pjlL9sp7SD/iJWzXZsAjcQmlqwmty9KyCY7+ginY+sQK7yr3ig6ve7uf1C0IGSD4QhbJkmvUuEGzOXS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=m4AyDOqZ; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e95230750ceso518437276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 06:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755869513; x=1756474313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O1UHIuV1R9kJlTum1IUZl89jWukXHK0SZ9mLRMY0AeM=;
        b=m4AyDOqZd3/SMkwmzBLgWZHnUR01cCkYdjU/LiqdqJR4S5LGsIkq7eywmJJflfiwlx
         yRWdYqAKk0Hlh+StZYzw9dTI9TfIcoAyRKRw9nWgANVHQLOrJHkx7vdjhR1JxizyebuB
         1ZZIn64ahupkbBnekETkD5yAhhc3wNJbs0fEJvtUVSPAsR4l4Wj/VrYyZAFPP+1Qz0fE
         +irUu1OVMdPT9bRftBnjpEMnmoX0gtm2g4SOBo3bxoSeyVpH85onwoJDYxXTHcP6T64l
         MByAySXjN4jFB8uO/432cpVLOT/YJtjoD9l+5NRs33uro/DYU27hP2rmt4yGBnW8aerb
         Krzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755869513; x=1756474313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1UHIuV1R9kJlTum1IUZl89jWukXHK0SZ9mLRMY0AeM=;
        b=sGf58nWbBiB4VLkyYToVJbZVdhk+PKZjEoc8De/5aZiqMQMfz1ktgltT/nQnrOo8b0
         HRdSCNsQskYIGdaspL4zSpTmjmPj/rx0jbRx0jIALPg7D2m6qZRRUhOOz6cu8WmiAw12
         prxYl0W+icJgZkXS8cki8EO/N+LL8TGoMh7fg6nAqYudBZRxUTVXLadGe2+ZerEy3n/c
         CLDd3C1qhK3EhcTQK+j/K3ImiMcw1bgw5+EHXauM5IG5Y5D+2VFrcAo+CecZil9+2Pau
         /HfafRvKC99ulezG3NPSu2f78ji2W+J0BEAV+I46kOCI/KCgO+I8ovG/wwIR7xbkxsFb
         weKA==
X-Gm-Message-State: AOJu0YwUQ9+7RQl6MwfTVqMYuWyb3SIFLlr/FBQEUGywrErf54oA6zQG
	lfPQH02DxkRmIasyymKadN8Z+Wz9AkROgvVIvpBQ1WVMbO5CVyZyJfadC5HufmyOHWI=
X-Gm-Gg: ASbGncvUuJz6uIxNLDjaCw60EMhFvis9TWQXdnbak8b9NPg4fOWYL+qNkO1Fnq6N1n8
	GwPMOJjzR1n5JR5FtI9/s9PNKvk7i7LhfvtptwDRSbCl0YTNbCe0VjQDanngPt74PQHUIQ0CfCK
	2sM9LnRZyhR11rr6SeuXwsfFRT9QuAUfcIQJQ71V/vZfmQoqqI2BhE0cyDagPyXtBX0ZMX7x6ck
	XaDi+B9iJFxfMfw9Sunb2aGVmv01/7XBTduINzVnS5P8a1nLodeFmCPQJHBW21mM1xahFxvufvN
	qLETMdZFKMJnTkPDD6iNPKmYwpAQDO8WVAEaByxYxbi46ucJTCtU/yC7GPFIfH8oBFSpr/2CZW6
	T3+GZ8dD7etprij+gXWFE0nvxklC3nhsDeybVc3f1lEt7rFIyBxJ3bo7ANCM=
X-Google-Smtp-Source: AGHT+IHOMcdXFoBNlqJp1nvuHeuGm4jjp9gkJ74n4aiOq3a9UsdZVSTvCfFQFaKC6IhpCYd+XHR/sQ==
X-Received: by 2002:a05:6902:2412:b0:e94:e1e6:d1d with SMTP id 3f1490d57ef6-e951d11229fmr2850101276.25.1755869512847;
        Fri, 22 Aug 2025 06:31:52 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e94f805c56fsm2505171276.3.2025.08.22.06.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:31:52 -0700 (PDT)
Date: Fri, 22 Aug 2025 09:31:51 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 02/50] fs: make the i_state flags an enum
Message-ID: <20250822133151.GB927384@perftesting>
References: <cover.1755806649.git.josef@toxicpanda.com>
 <02211105388c53dc68b7f4332f9b5649d5b66b71.1755806649.git.josef@toxicpanda.com>
 <20250822-orcas-bemannten-728c9946b160@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822-orcas-bemannten-728c9946b160@brauner>

On Fri, Aug 22, 2025 at 01:08:07PM +0200, Christian Brauner wrote:
> On Thu, Aug 21, 2025 at 04:18:13PM -0400, Josef Bacik wrote:
> > Adjusting i_state flags always means updating the values manually. Bring
> > these forward into the 2020's and make a nice clean macro for defining
> > the i_state values as an enum, providing __ variants for the cases where
> > we need the bit position instead of the actual value, and leaving the
> > actual NAME as the 1U << bit value.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  include/linux/fs.h | 234 +++++++++++++++++++++++----------------------
> >  1 file changed, 122 insertions(+), 112 deletions(-)
> > 
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 9a1ce67eed33..e741dc453c2c 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -665,6 +665,127 @@ is_uncached_acl(struct posix_acl *acl)
> >  #define IOP_MGTIME	0x0020
> >  #define IOP_CACHED_LINK	0x0040
> >  
> > +/*
> > + * Inode state bits.  Protected by inode->i_lock
> > + *
> > + * Four bits determine the dirty state of the inode: I_DIRTY_SYNC,
> > + * I_DIRTY_DATASYNC, I_DIRTY_PAGES, and I_DIRTY_TIME.
> > + *
> > + * Four bits define the lifetime of an inode.  Initially, inodes are I_NEW,
> > + * until that flag is cleared.  I_WILL_FREE, I_FREEING and I_CLEAR are set at
> > + * various stages of removing an inode.
> > + *
> > + * Two bits are used for locking and completion notification, I_NEW and I_SYNC.
> > + *
> > + * I_DIRTY_SYNC		Inode is dirty, but doesn't have to be written on
> > + *			fdatasync() (unless I_DIRTY_DATASYNC is also set).
> > + *			Timestamp updates are the usual cause.
> > + * I_DIRTY_DATASYNC	Data-related inode changes pending.  We keep track of
> > + *			these changes separately from I_DIRTY_SYNC so that we
> > + *			don't have to write inode on fdatasync() when only
> > + *			e.g. the timestamps have changed.
> > + * I_DIRTY_PAGES	Inode has dirty pages.  Inode itself may be clean.
> > + * I_DIRTY_TIME		The inode itself has dirty timestamps, and the
> > + *			lazytime mount option is enabled.  We keep track of this
> > + *			separately from I_DIRTY_SYNC in order to implement
> > + *			lazytime.  This gets cleared if I_DIRTY_INODE
> > + *			(I_DIRTY_SYNC and/or I_DIRTY_DATASYNC) gets set. But
> > + *			I_DIRTY_TIME can still be set if I_DIRTY_SYNC is already
> > + *			in place because writeback might already be in progress
> > + *			and we don't want to lose the time update
> > + * I_NEW		Serves as both a mutex and completion notification.
> > + *			New inodes set I_NEW.  If two processes both create
> > + *			the same inode, one of them will release its inode and
> > + *			wait for I_NEW to be released before returning.
> > + *			Inodes in I_WILL_FREE, I_FREEING or I_CLEAR state can
> > + *			also cause waiting on I_NEW, without I_NEW actually
> > + *			being set.  find_inode() uses this to prevent returning
> > + *			nearly-dead inodes.
> > + * I_WILL_FREE		Must be set when calling write_inode_now() if i_count
> > + *			is zero.  I_FREEING must be set when I_WILL_FREE is
> > + *			cleared.
> > + * I_FREEING		Set when inode is about to be freed but still has dirty
> > + *			pages or buffers attached or the inode itself is still
> > + *			dirty.
> > + * I_CLEAR		Added by clear_inode().  In this state the inode is
> > + *			clean and can be destroyed.  Inode keeps I_FREEING.
> > + *
> > + *			Inodes that are I_WILL_FREE, I_FREEING or I_CLEAR are
> > + *			prohibited for many purposes.  iget() must wait for
> > + *			the inode to be completely released, then create it
> > + *			anew.  Other functions will just ignore such inodes,
> > + *			if appropriate.  I_NEW is used for waiting.
> > + *
> > + * I_SYNC		Writeback of inode is running. The bit is set during
> > + *			data writeback, and cleared with a wakeup on the bit
> > + *			address once it is done. The bit is also used to pin
> > + *			the inode in memory for flusher thread.
> > + *
> > + * I_REFERENCED		Marks the inode as recently references on the LRU list.
> > + *
> > + * I_WB_SWITCH		Cgroup bdi_writeback switching in progress.  Used to
> > + *			synchronize competing switching instances and to tell
> > + *			wb stat updates to grab the i_pages lock.  See
> > + *			inode_switch_wbs_work_fn() for details.
> > + *
> > + * I_OVL_INUSE		Used by overlayfs to get exclusive ownership on upper
> > + *			and work dirs among overlayfs mounts.
> > + *
> > + * I_CREATING		New object's inode in the middle of setting up.
> > + *
> > + * I_DONTCACHE		Evict inode as soon as it is not used anymore.
> > + *
> > + * I_SYNC_QUEUED	Inode is queued in b_io or b_more_io writeback lists.
> > + *			Used to detect that mark_inode_dirty() should not move
> > + *			inode between dirty lists.
> > + *
> > + * I_PINNING_FSCACHE_WB	Inode is pinning an fscache object for writeback.
> > + *
> > + * I_LRU_ISOLATING	Inode is pinned being isolated from LRU without holding
> > + *			i_count.
> > + *
> > + * Q: What is the difference between I_WILL_FREE and I_FREEING?
> > + *
> > + * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to wait
> > + * upon. There's one free address left.
> > + */
> > +
> > +/*
> > + * As simple macro to define the inode state bits, __NAME will be the bit value
> > + * (0, 1, 2, ...), and NAME will be the bit mask (1U << __NAME). The __NAME_SEQ
> > + * is used to reset the sequence number so the next name gets the next bit value
> > + * in the sequence.
> > + */
> > +#define INODE_BIT(name)			\
> > +	__ ## name,			\
> > +	name = (1U << __ ## name),	\
> > +	__ ## name ## _SEQ = __ ## name
> 
> I'm not sure if this is the future we want :D
> I think it's harder to parse than what we have now.
> 
> > +
> > +enum inode_state_bits {
> > +	INODE_BIT(I_NEW),
> > +	INODE_BIT(I_SYNC),
> > +	INODE_BIT(I_LRU_ISOLATING),
> > +	INODE_BIT(I_DIRTY_SYNC),
> > +	INODE_BIT(I_DIRTY_DATASYNC),
> > +	INODE_BIT(I_DIRTY_PAGES),
> > +	INODE_BIT(I_WILL_FREE),
> > +	INODE_BIT(I_FREEING),
> > +	INODE_BIT(I_CLEAR),
> > +	INODE_BIT(I_REFERENCED),
> > +	INODE_BIT(I_LINKABLE),
> > +	INODE_BIT(I_DIRTY_TIME),
> > +	INODE_BIT(I_WB_SWITCH),
> > +	INODE_BIT(I_OVL_INUSE),
> > +	INODE_BIT(I_CREATING),
> > +	INODE_BIT(I_DONTCACHE),
> > +	INODE_BIT(I_SYNC_QUEUED),
> > +	INODE_BIT(I_PINNING_NETFS_WB),
> > +};
> 
> Good idea but I really dislike this macro indirection.
> Can't we just do the really boring?
> 
> enum inode_state_bits {
> 	__I_BIT_NEW		= 0U
> 	__I_BIT_SYNC		= 1U
> 	__I_BIT_LRU_ISOLATING	= 2U
> }
> 
> enum inode_state_flags_t {
> 	I_NEW			= (1U << __I_BIT_NEW)
> 	I_SYNC			= (1U << __I_BIT_SYNC)
> 	I_LRU_ISOLATING		= (1U << __I_BIT_LRU_ISOLATING)
> 	I_DIRTY_SYNC		= (1U << 3)
> 	I_DIRTY_DATASYNC	= (1U << 4)
> 	I_DIRTY_PAGES		= (1U << 5)
> 	I_WILL_FREE		= (1U << 6)
> 	I_FREEING		= (1U << 7)
> 	I_CLEAR			= (1U << 8)
> 	I_REFERENCED		= (1U << 9)
> 	I_LINKABLE		= (1U << 10)
> 	I_DIRTY_TIME		= (1U << 11)
> 	I_WB_SWITCH		= (1U << 12)
> 	I_OVL_INUSE		= (1U << 13)
> 	I_CREATING		= (1U << 14)
> 	I_DONTCACHE		= (1U << 15)
> 	I_SYNC_QUEUED		= (1U << 16)
> 	I_PINNING_NETFS_WB	= (1U << 17)
> };
> 
> Note that inode_state_wait_address() and that only works on four bits so
> we can't really use higher bits anyway without switching back to a
> scheme where we have to use unsigned long and waste for bytes for
> nothing on 64 bit.
> 
> With that out of the way,
> 
> Reviewed-by: Christian Brauner <brauner@kernel.org>

Yup totally, I'll fix this and add your RB. Thanks!

Josef


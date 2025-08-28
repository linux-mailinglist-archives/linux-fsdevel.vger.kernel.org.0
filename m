Return-Path: <linux-fsdevel+bounces-59484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4A0B39BE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 13:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A411188E19D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 11:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EF430EF96;
	Thu, 28 Aug 2025 11:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="gTt3uz5e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA8026C39F
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 11:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756381577; cv=none; b=VjibcyTVBUHbjqljnx3XmXhM3n+stN5pqxZixAKmZVloxv//pMuj439OD0tUw2RWXznT3a8HfDM1bLUXRa4rxpRM4qqlka/oMgtvrr7qni7gE7+ylD/8sLBYEJAUSfAX/6VGeEv7ahs1iKLD+0IU2m5sERNg6eexxoQz8JummzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756381577; c=relaxed/simple;
	bh=uAGCJDmp6cJsS5qz70KZAgSZxtvKiuj4rYNnVtudL4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9dMJZVNHks6OZrGWIJKunaOfQr2MDorR16hLt1UNcPbt/Lhc08QqFWGned+Wm8+41zgWiZ565utJho/7MeYmleLSJvpXt+nskTKxWVdstZrE4c+l3ksH080+3i2D9nfS/fk0RzWYiPAdBtMn1U3RzF1duBCJQ+ojaYJnmKGd6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=gTt3uz5e; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d6083cc69so6802677b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 04:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1756381575; x=1756986375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bkW7vRfw5fmjfl6Szg391djOpIwzx0Kzah7uxGUnsRM=;
        b=gTt3uz5eNf7X1OGusQGWx08Zvs0tFg98T5qv2dZ47hhRP0P/X6u8zsQK2zlACUSOPn
         1s1SM/GARczGBQ1vOsAPsjHiqTAKVQ5W06vwjcF9uSD55UalFkoxuH7wC9Tkxw2VQ2N4
         ejTi6hDn9z8jrJk4LTSMo4O+2YQk9aYzF0qhDm+YtNm9Q/kHGhTQ6Nz0zvQEL9eraP/i
         0DhrVioaLr3HuQ6prYs6YB4RFLkNjVoXUaoOM+8eoMITial9OUF2I0UAY3F5CFBPsSfk
         wuXK1REf3xGn5U3f7+Pyrzye+yX4P9JmupIsHwb2hnkCITlXdLA990qHCl34ZYK/fPHP
         p1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756381575; x=1756986375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkW7vRfw5fmjfl6Szg391djOpIwzx0Kzah7uxGUnsRM=;
        b=Jj6nckfiNuUFNcFZllP/dy0o10wfX7QWg5Ecy0EpvOqsvSRMItruHGk8W2ZoNeK19e
         vxswJAAAqoaOZAMyUY+YJoCpthcARJh4Qw/7ZDjTYpwlqiposk3QNbffDfUDYvUvUtPl
         vCFcTRNfONlp3xZl0RPeulZ63FcjLSJXch2nKuJaop/joBAtdjqmOBdazzyuS49+E6Ik
         IVSkN4AHhFwJ81DT88nPmI4JuCfCRzOrnW80fRCIskmkUycUiPjoumcgpsS0BwxBjx/u
         CHKHGjRviZUpJXMpZLPp7opu+2/bmNjCf4p9RWpOGDPYZlnYqxS6oE177JbxgNiZJ5yd
         Nwkw==
X-Forwarded-Encrypted: i=1; AJvYcCUolTu4Ib6XF6p5XJT5yR2WfBpeVeWMz+z7I/IfWRPXspv1OfRVCTnEJkXvbPDG9QG1SxeusXUOnnnz5Uxw@vger.kernel.org
X-Gm-Message-State: AOJu0YzketZkTJxfDNWkQnA2sMIFetVJ7qxfsx88XNUhsf4yCbCOf6jo
	3fkcAuGwo78HLgMx6eilIg3ilCJTVdsnScSlDfAUeNdlOh4OpUDp2yG58WZEHfN/yrM=
X-Gm-Gg: ASbGncthF92Aab63AJa8l3aDbje5w2XqN1tw683OlyG17w+60nJ6uso1AGuvCy/ymRT
	McVW/xpbrwhwvn9Vxn7XcmgcpUidVqxtQVWqr+FlkcqkC6Po/DIDx+TRTll55InBMDRqlPhwQaz
	twMNWA5E9ikuVaOtp+J/b/RQL4EzY7h32n069IHAPMHpEdABiodpgK1KeJNQUmsoceRCfZZad4e
	9oAZPVMF1sI1JPWbck6ZsAUDHtCU6DBBVxCv05aIWzdXhtH2b3XXbV11KKr2Rr8XkDqMj4j3SRF
	MfRBqxzdrr2qaSVSt0czg3Ub67Pagi9scdxigYjLmAzIlUIZyMeFMbEQ62fTQCWabq/mOcBJSUX
	cFFXY+kpHVYVoP8zTUr2HpqSRZH/+6CD8yPQ3qH5xRHEZJ2FC5DG33MQCbDsan1LbVH4jnw==
X-Google-Smtp-Source: AGHT+IEg0qq6vVFcC8HtHbolYGh9JI2dm7wBds4DDkIYpwL5F/tmw9T7MssYibXngJRFYi8Fu+PtoA==
X-Received: by 2002:a05:690c:c14:b0:721:6b2e:a07f with SMTP id 00721157ae682-7216b2ea4cfmr2820057b3.24.1756381574661;
        Thu, 28 Aug 2025 04:46:14 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff17354cdsm38508237b3.20.2025.08.28.04.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 04:46:13 -0700 (PDT)
Date: Thu, 28 Aug 2025 07:46:13 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 17/54] fs: remove the inode from the LRU list on
 unlink/rmdir
Message-ID: <20250828114613.GC2848932@perftesting>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <3552943716349efa4ff107bb590ac6b980183735.1756222465.git.josef@toxicpanda.com>
 <20250827-bratkartoffeln-weltschmerz-fc60227f43e7@brauner>
 <aK-AQ6Xzkmz7zQ6X@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK-AQ6Xzkmz7zQ6X@dread.disaster.area>

On Thu, Aug 28, 2025 at 08:01:39AM +1000, Dave Chinner wrote:
> On Wed, Aug 27, 2025 at 02:32:49PM +0200, Christian Brauner wrote:
> > On Tue, Aug 26, 2025 at 11:39:17AM -0400, Josef Bacik wrote:
> > > We can end up with an inode on the LRU list or the cached list, then at
> > > some point in the future go to unlink that inode and then still have an
> > > elevated i_count reference for that inode because it is on one of these
> > > lists.
> > > 
> > > The more common case is the cached list. We open a file, write to it,
> > > truncate some of it which triggers the inode_add_lru code in the
> > > pagecache, adding it to the cached LRU.  Then we unlink this inode, and
> > > it exists until writeback or reclaim kicks in and removes the inode.
> > > 
> > > To handle this case, delete the inode from the LRU list when it is
> > > unlinked, so we have the best case scenario for immediately freeing the
> > > inode.
> > > 
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > ---
> > 
> > I'm not too fond of this particular change I think it's really misplaced
> > and the correct place is indeed drop_nlink() and clear_nlink().
> 
> I don't really like putting it in drop_nlink because that then puts
> the inode LRU in the middle of filesystem transactions when lots of
> different filesystem locks are held.
> 
> IF the LRU operations are in the VFS, then we know exactly what
> locks are held when it is performed (current behaviour). However,
> when done from the filesystem transaction context running
> drop_nlink, we'll have different sets of locks and/or execution
> contexts held for each different fs type.
> 
> > I'm pretty sure that the number of callers that hold i_lock around
> > drop_nlink() and clear_nlink() is relatively small.
> 
> I think the calling context problem is wider than the obvious issue
> with i_lock....

This is an internal LRU, so yes potentially we could have locking issues, but
right now all LRU operations are nested inside of the i_lock, and this is purely
about object lifetime. I'm not concerned about this being in the bowls of any
filesystem because it's purely list manipulation.

And if it makes you feel better, the next patchset queued up for after the next
merge window is deleting the LRU, so you won't have to worry about it for long
:).  Thanks,

Josef


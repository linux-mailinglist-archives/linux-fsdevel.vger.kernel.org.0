Return-Path: <linux-fsdevel+bounces-45438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F73A779A6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 13:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F031C188FD6F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 11:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00951FAC55;
	Tue,  1 Apr 2025 11:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="DB+RAUeq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690FD1FA26C
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Apr 2025 11:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743507366; cv=none; b=sNpvI6fI9Zgof1hWJOFOo6SEj90hjvxl8MkTRM922Hcw9JIFgG8jwhHQ6b9nJ3lDYEoOC9KZKosaXwGiSOESfnzJC84uuS8QGRsF6chhASY0XV/XqawQPFkb6OfsuIXcCdujSLkqoO8Nq6/iuHbH1MwbdHsXKoz7rEXWuLTEPZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743507366; c=relaxed/simple;
	bh=R7SoiPCBNIDNzLkKbNN/bk7U6Bot5GWsF1bFWcdnudY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbRhjDJPzfcrbl8goy0QuCn0y4yRJhpy2WjuW0cafzK1QNKoWo97Za/ApL9XqawyftC6AgbR9OhAUdeC/3jnRoV1bWLZ8SrdDWMUBBbozfmC861Y/oCjFihPflrzwzx6ofJhWWvH3Y+UDcfbMFwkR9o/gLCNHeYpWodS61ZR4m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=DB+RAUeq; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22438c356c8so105406155ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Apr 2025 04:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1743507363; x=1744112163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g2+c00bn9QMrYYncqUoX4E1bu9uetuu45V5+u5h/AVY=;
        b=DB+RAUeql1+nxpXAllys+DY0MWr8w5xmkNVokRa+THxevO3nJW98NCMMu9rLD+NfJf
         x6Q+EWEP8Xhy79EyhyCbczCvb0zc/d9Y4S2+JNzogcfHDbSrjhhzjyHJkSIWplBAK7LS
         hPhKwBZRNeMOofAfSXT6NtNKeGESU17JT7+/w+Iuir8ryjphV/WXfR/NnSJ6X5VPGd1j
         eykZlspMb67ul8+M0gsCZ1cM21hOyAUXxnKy6EI/canQf7/0G4diLLqAoPDad07lrlUw
         IdJS9Vyqq9/5YoQWDrLeDBzfHu7E47pMTHs+2+X3LT2l96UUysq0sw9Cs0en9Qyhglou
         mkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743507363; x=1744112163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2+c00bn9QMrYYncqUoX4E1bu9uetuu45V5+u5h/AVY=;
        b=AoHZNk/hb88JRBMwb/K9DUPgNidaAh7QuWzrhHqlssPXDC1On/1A6Z6Xzx+NeSpKmo
         CgBL2FFeZ2ptR+0ImcVuqFNY9h9eMH6UERyTBT1pND3u2UBx6uN9NotHBbgp7zYz8ur0
         ACastM6KZOwdw+7uCPhqAW6ntYh5Hyv4sQmwfNDR/IlJ/tACImm1YdLCdoVlPymT0JLU
         wUwExCrQgZp31GmAk+pxLGu4ycdRnchn20rHV1BUZEy4QW9KCG4oQVd+J7SGuJLLy5gZ
         lfIia7UAs5nxDDwXMZH87RsmTyCGgsz+Yu3yEz2IP1HfzLjKiOTq9flBfCmOwanj7Pe7
         Qgrw==
X-Gm-Message-State: AOJu0Yxsh48gixuRXxqUI9wAr0zHlZV2cuk5NlJr+yIs4N9Jkqrxw0Tl
	4we3HKGGvUP5nJaQtQQDVtU1reXdYITOkT2rCZ9yoeHTNeA/UQ6B95KrLph7POM=
X-Gm-Gg: ASbGncujB2ozzZzbFHrqEq26L0GCqJwA9cs1Mt4XIR3CrICV/PUq2jS3dLZKjkgHLez
	KH2uJh2RuzWn+ZOtRxvM+Yom38zy+uAgTLwXD42PMbCfxa2ihiAcbGE/akpSZADmL6bLra1dNb4
	m7iJAmApZ1dkJBmWPZdHAl7JJ+I/Z8Xan6B+7b1JqSh8y7pI/JBoAMbkqM8JStBItYWbcR2ne+T
	R9wGmkmyrtIcIzLKrl+pIgKaR5zUpwPGj6JA5UoGPLGVKeBAmXo+umD/E5nj+7NE5RP7/v0aaE/
	FwAoo8xt1MwpkVTGPsw5C7PAh9fdyvCDcZ3/Sln1BKMk70WdW9pX5+QuvnT8XPuTkexW9Vj9+AJ
	qojaJIhLcIK8mjk79oA==
X-Google-Smtp-Source: AGHT+IGBEYa638WvHr8VMrPemZg8f/SzTMUOvkeQN2v3HXx0k+tLbTzE07k8CRKzbkFjDvvHpsuneg==
X-Received: by 2002:a05:6a00:3a23:b0:736:3979:369e with SMTP id d2e1a72fcca58-73980387a87mr16755789b3a.9.1743507362409;
        Tue, 01 Apr 2025 04:36:02 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970e22449sm8647733b3a.49.2025.04.01.04.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 04:36:01 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tzZuQ-000000035eq-3DKl;
	Tue, 01 Apr 2025 22:35:58 +1100
Date: Tue, 1 Apr 2025 22:35:58 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz,
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	mcgrof@kernel.org, hch@infradead.org, rafael@kernel.org,
	djwong@kernel.org, pavel@kernel.org, peterz@infradead.org,
	mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH 3/6] xfs: replace kthread freezing with auto fs freezing
Message-ID: <Z-vPnmL7wn_8cFim@dread.disaster.area>
References: <20250401-work-freeze-v1-0-d000611d4ab0@kernel.org>
 <20250401-work-freeze-v1-3-d000611d4ab0@kernel.org>
 <Z-s9KG-URzB9DwUb@dread.disaster.area>
 <20250401-baubeginn-ausdehnen-3a7387b756aa@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401-baubeginn-ausdehnen-3a7387b756aa@brauner>

On Tue, Apr 01, 2025 at 09:17:12AM +0200, Christian Brauner wrote:
> On Tue, Apr 01, 2025 at 12:11:04PM +1100, Dave Chinner wrote:
> > On Tue, Apr 01, 2025 at 02:32:48AM +0200, Christian Brauner wrote:
> > > diff --git a/fs/xfs/xfs_zone_gc.c b/fs/xfs/xfs_zone_gc.c
> > > index c5136ea9bb1d..1875b6551ab0 100644
> > > --- a/fs/xfs/xfs_zone_gc.c
> > > +++ b/fs/xfs/xfs_zone_gc.c
> > > @@ -993,7 +993,6 @@ xfs_zone_gc_handle_work(
> > >  	}
> > >  
> > >  	__set_current_state(TASK_RUNNING);
> > > -	try_to_freeze();
> > >  
> > >  	if (reset_list)
> > >  		xfs_zone_gc_reset_zones(data, reset_list);
> > > @@ -1041,7 +1040,6 @@ xfs_zoned_gcd(
> > >  	unsigned int		nofs_flag;
> > >  
> > >  	nofs_flag = memalloc_nofs_save();
> > > -	set_freezable();
> > >  
> > >  	for (;;) {
> > >  		set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE);
> > 
> > Same question here for this newly merged code, too...
>
> I'm not sure if this is supposed to be a snipe or not but just in case
> this is a hidden question:

No, I meant that this is changing shiny new just-merged XFS code
(part of zone device support). It only just arrived this merge
window and is largely just doing the same thing as the older aild
code. It is probably safe to assume that this new code has never
been tested against hibernate...

-Dave.
-- 
Dave Chinner
david@fromorbit.com


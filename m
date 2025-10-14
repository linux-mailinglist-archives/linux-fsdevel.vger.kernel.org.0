Return-Path: <linux-fsdevel+bounces-64163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B55BDB81E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 23:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E30734FBB26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 21:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7853E30CDBE;
	Tue, 14 Oct 2025 21:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="T9FjswIc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F632E54B0
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 21:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760479048; cv=none; b=VMPZIPQHaGn/3CCsU6qrSY+BRQWcshYTZYat5TBgcAZWshrFFuVjgrY3AZJtIGVuOX/b9Ju1huRC98CpmV0wjJ+2gn6AclyDoCyxTQ6UYCbq55bWWjE6R7RkWoGoNgDP+2ikZB8zuEgQMFOn3154BIAYXYEOPD7/Z3RHol+5P3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760479048; c=relaxed/simple;
	bh=lbp/svBrqIT8k+MRq3/jmjxuU8akOPgMPTESYka1epE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkHil6ySS/arTpewtAsSvU+OfSqI0ScG0Nu5eqmYNvNKu2ys4gWCO61urw+1jsdTJQPSa4mk8t/u7p9GxGYd7YCirhFNhUDNFhq+o7G09qTIww5aTzjArho0vXowxQNOvEjMQpxpiI1Ge4RxLO2s3PkAR2HCcvOPLbbLVS6Bb9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=T9FjswIc; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-78118e163e5so295561b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 14:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1760479046; x=1761083846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AL/bnV/py/dxrrqchUFB69kdjG2EwxKxcNMsAmNeKP0=;
        b=T9FjswIcdHH/j2782D1jjnXNP42OV1TStmHEnhaKyPrqOsbVq9lQfvfZv3GCqPnHD8
         FexeoNXr3/gm3oCR/0fP2A3kMQ4O8hZjZlZs5bHR6KK7D52M04Q8LLKmoNukfj521A3p
         sx4DxPtKTjzkrOpxhir6wMCuPKzdV7iifb99ogfvN80U8/qJNKEJttNWXwOGOxyovtPt
         1KybvFhAZBPZ7QT3cLgvrcVjxoWkmfgcEIbeRc0d7Kf044/O1eXmAKkl6zfRrqnsnBAZ
         ZrXMMCoeBhowPB7sMJ/esusntK1LQWjp/Pc4IlmJ2IJBA4N+e8cCd1lN8kPIsP3nlgzP
         zp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760479046; x=1761083846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AL/bnV/py/dxrrqchUFB69kdjG2EwxKxcNMsAmNeKP0=;
        b=hr0wDhSzcB7rMkWY6nR18QXZXa68RihIAJbYD5Mx9+j67RaofOhCFW0TXRpCEwSKeY
         W04qb4b602oI7zG8pVlIKfpBrKnquAlOngFRh3Pzsx82peXel/BJ1sPedkZQ0kX33Ckp
         Ctra3m4ZlupD4AwyRzKm9hG2rOqUWosFGK8A898PcLimIzCYD0EEnp30ClyD+gGLQwgF
         wPlwHNARWiMSkKhDz4hBdTuxVExjbn62tjt9ng1StW7LCXDcAu3EleUEDIyj53wREHlC
         +B7h6WwlWBVVhR260CwdQUKKjMjntAMHYEahop2hNBf5M5Qws/HlOvaFf6bLj5vzeYBN
         UUKw==
X-Forwarded-Encrypted: i=1; AJvYcCWUhykeugAbR3eJfOGJZWBGHZCvErS9d/Evtr2XfxO6MXdrpzseQGnOJF0aFbPC8tO4uBbi6mUJ1KMbT1EX@vger.kernel.org
X-Gm-Message-State: AOJu0YwCLhfR3zcXAfao+aecz513xll8vuOtoAj7292xWg8Toq0HkCPQ
	D1l+wPQEetKRHV9naoBhNcr6wX9xVTNFgnS4rY7tu+1B+QsetRnMrAnC133aWZMLVqk=
X-Gm-Gg: ASbGncvBbI/Jp+iww5uyA1rIBSx/zS6Ff/WpOspV8d8Y9e9BY7/N8DVh2QnnKFAaJWL
	1RAfwJHBNwLuyCXdfH8lW5w+pmHoyrUCmxNP8Ds5N4HXHPf3kwrg8D4mA6xgiRBzB7IdhVi8Ftv
	ssHV0sJ+Qkj/V662Ccsp61RKxnKRC7glCvXOrl/jp3Jrvg+vm7jaKojthmQU6zUQ1JIVKXwHaGU
	TJO44bZKaFwB/P3F8HJda58f5wlBLJEOfnXOgd3W8WvIRMuEBAfg3Sr+VYKCt1YYCWqSbvfsoqi
	OxuqX5OmreNMkqPQTdh2B559pWTE7DALiFVQNEW+QMRxpUU2Mw8bGsvXiz6zDGHmQVkT18K+NeC
	GwYiStYZkODbvpCoASjcc2RmUvJo0Y5zdj11Tl5OHuWOPkT0RlHXJJkPzYjkMFHvojTW505Xvts
	G1H+TtNRraKmgztyxp53FXfRwC4wsQ3/0Y/098gA==
X-Google-Smtp-Source: AGHT+IFEm7YEffZsxkb8K+nehDd+qD29oTSduQqQSjJ7xgEV6CAlDHsQGWe8Y3vIo1bRLa8jllHUlA==
X-Received: by 2002:a05:6a21:3383:b0:2ac:7445:4947 with SMTP id adf61e73a8af0-32da8f7b6b6mr32112486637.19.1760479045581;
        Tue, 14 Oct 2025 14:57:25 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678dcbf919sm12945398a12.9.2025.10.14.14.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 14:57:24 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1v8n1G-0000000EtZi-0ICM;
	Wed, 15 Oct 2025 08:57:22 +1100
Date: Wed, 15 Oct 2025 08:57:22 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jan Kara <jack@suse.cz>
Cc: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org,
	viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
	kernel-team@fb.com, amir73il@gmail.com, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v7 03/14] fs: provide accessors for ->i_state
Message-ID: <aO7HQkF8UOfjXGcd@dread.disaster.area>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
 <20251009075929.1203950-4-mjguzik@gmail.com>
 <h2etb4acmmlmcvvfyh2zbwgy7bd4xeuqqyciqjw6k5zd3thmzq@vwhxpsoauli7>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <h2etb4acmmlmcvvfyh2zbwgy7bd4xeuqqyciqjw6k5zd3thmzq@vwhxpsoauli7>

On Fri, Oct 10, 2025 at 04:44:19PM +0200, Jan Kara wrote:
> On Thu 09-10-25 09:59:17, Mateusz Guzik wrote:
> > +static inline void inode_state_set_raw(struct inode *inode,
> > +				       enum inode_state_flags_enum flags)
> > +{
> > +	WRITE_ONCE(inode->i_state, inode->i_state | flags);
> > +}
> 
> I think this shouldn't really exist as it is dangerous to use and if we
> deal with XFS, nobody will actually need this function.

XFS does it's own inode caching outside the VFS, so for the moment
it needs to have access to the same VFS inode initialisation APIs as
the core VFS inode cache instantiation functions to maintain the
same externally visible behaviours.

Yes, if we change how the VFS inode caches initialise inodes, we
have to update the XFS code, but that's always been the case. This
isn't very hard to do....

Keep in mind that XFS has been caching inodes outside the VFS and
doing external state initialisation since it was first ported to
Linux (i.e. ~25 years ago). It's kinda strange to suddenly hear
people claim that this sort of VFS inode state manipulation thing is
"too dangerous" to allow anyone to use given how long we've actually
been doing this....

-Dave.
-- 
Dave Chinner
david@fromorbit.com


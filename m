Return-Path: <linux-fsdevel+bounces-21430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976E3903A96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 13:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D5E1C236AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 11:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B507C17BB3F;
	Tue, 11 Jun 2024 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsDoxiZi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C5117B43F;
	Tue, 11 Jun 2024 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106051; cv=none; b=Eddlpwe7kKYCUJdYKqAYT7vg5c029XoxgFmgZRWfrIy66dIM4QR6w5G5T1XoRV6u8CUhSP7nGQ9fh8huxW1BE3v9pzGX8AJfbMT8rX6HjJXf9RCd3+z35YpuwBk0Ir8NIBBYPWK3O8A9/8og51QaqaHct389EyN0xjtbAcIPrpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106051; c=relaxed/simple;
	bh=YeyXKtlCu8QG4qMRA8+2qFlxo89AdJ1zUyTJx043lfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGEWu02ytXTWruWY+lZ599d9bJP4AdWhenfU3sQMoYDLLi4aUkEQ+QabLAfxV6CkYEWlPjrS5asR2o6adtBqhaq8SIOMuKgX6dPMDgywAWuhy5rhxKuYNM6Kgcni23TL2fgtwcEc271r16RNeXRHS7a3cb81UYQJqCSQGY9j6AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsDoxiZi; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52c8c0d73d3so2550834e87.1;
        Tue, 11 Jun 2024 04:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718106047; x=1718710847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L8XxjvcCgXk/Pl/HdvcUec+tIi9qW/w8D9MOpEhghSw=;
        b=jsDoxiZiXVD7I9jTTFkj/QV89S34+p2HAotfp3i+luhUFz76XkVXTSYpliq/3YwL4Y
         8LxtCgVboyHxg7pAjo1FNA71xeOh1JpLDyql/zn7uIHplBomZqA+s7BVRRPXbPmlsoOD
         DIK6wWzKGQPmzS+9Zn1zUssrIla8BpJhWbEFadhiJDZVDInbJ0gb7mgTMTe7kwWa6aBh
         jdoLY0mBHlk3OvXl+QE01MzGMvw/ZG/VlaCJ3sQCJZuO9b3sL7ExkMHe+Q8wNwzboo1u
         +1TJVYMpkne6nAlbyaCc7FYigIAXaD/fN8KScLiUx4gKe28+WP2QXW0+hFOVW3iXPGCO
         h9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718106047; x=1718710847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8XxjvcCgXk/Pl/HdvcUec+tIi9qW/w8D9MOpEhghSw=;
        b=N6j/OKnwZFs4U9lVxMJxrFB1W9mJEtBbzHsYq9SqXcf5g8ArRc6m7eCbsAm8a2UJV9
         u42pHruSkGIZThh+dhz2xU5vVMEwhwN/8Rv4X2caTBWYzf9JWwEFylUa0INkJl5btBpa
         E8FNRRDQYXelv0ZtyrFzKXllFXKaJe4x61dtG03JItegUJdfuBaY0PwpqTpyzrzP4WU7
         tT3i0uxVBG7oCm21fnO10BB3qTvmK/o+K2MM4pAbmjJDkWqZ8V7ze6Hg0nyJrHRjz70Y
         UFVfz6vr+XMV/NB1ERr1EeQw9tkQem1uVQAFmi2NAfZy201eqt37IFvSc46dDdPJoJMI
         /vzA==
X-Forwarded-Encrypted: i=1; AJvYcCVkkfAJXDQ95xTXQHx36n+jesaesZFv2qtPMp8sdWwmlk/uSuKfs33hVgWl6d48/DEjZgiQ14pIqn5qZJ95B46nxnb5P26C+iBvCqIX/zROE5oB11v/6CPzbbbQfCn6mNwRiUFaa6w/B1HBkjumI6YwlO3vVl7+Na0utWSlg3JG5SWpo3AL4dRy
X-Gm-Message-State: AOJu0Yw0SxPw8rrJOhoilYayO7574NXgcHcdpSFIup2yf+90phB00avW
	m5J4QF0MEpCRJR+ZAwrlG749WV1ls4tOjojsjBbhEmBWbA6fDHjx
X-Google-Smtp-Source: AGHT+IERbDwVmhIESs931NWqqFELi2rg1koDN0thpr+FI0e//xVSCLH20AdXJ7EgJX3zslCQB9lLYA==
X-Received: by 2002:a05:6512:3041:b0:52b:bdbd:2c43 with SMTP id 2adb3069b0e04-52bbdbd3144mr8397626e87.61.1718106047032;
        Tue, 11 Jun 2024 04:40:47 -0700 (PDT)
Received: from f (cst-prg-65-249.cust.vodafone.cz. [46.135.65.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0e49e898sm9819416f8f.22.2024.06.11.04.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 04:40:46 -0700 (PDT)
Date: Tue, 11 Jun 2024 13:40:37 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	josef@toxicpanda.com, hch@infradead.org
Subject: Re: [PATCH v3 1/2] vfs: add rcu-based find_inode variants for iget
 ops
Message-ID: <2aoxtcshqzrrqfvjs2xger5omq2fjkfifhkdjzvscrtybisca7@eoisrrcki2vw>
References: <20240611101633.507101-1-mjguzik@gmail.com>
 <20240611101633.507101-2-mjguzik@gmail.com>
 <20240611105011.ofuqtmtdjddskbrt@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240611105011.ofuqtmtdjddskbrt@quack3>

On Tue, Jun 11, 2024 at 12:50:11PM +0200, Jan Kara wrote:
> On Tue 11-06-24 12:16:31, Mateusz Guzik wrote:
> > +/**
> > + * ilookup5 - search for an inode in the inode cache
>       ^^^ ilookup5_rcu
> 

fixed in my branch

> > + * @sb:		super block of file system to search
> > + * @hashval:	hash value (usually inode number) to search for
> > + * @test:	callback used for comparisons between inodes
> > + * @data:	opaque data pointer to pass to @test
> > + *
> > + * This is equivalent to ilookup5, except the @test callback must
> > + * tolerate the inode not being stable, including being mid-teardown.
> > + */
> ...
> > +struct inode *ilookup5_nowait_rcu(struct super_block *sb, unsigned long hashval,
> > +		int (*test)(struct inode *, void *), void *data);
> 
> I'd prefer wrapping the above so that it fits into 80 columns.
> 

the last comma is precisely at 80, but i can wrap it if you insist

> Otherwise feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 

thanks

I'm going to wait for more feedback, tweak the commit message to stress
that this goes from 2 hash lock acquires to 1, maybe fix some typos and
submit a v4.

past that if people want something faster they are welcome to implement
or carry it over the finish line themselves.

> 									Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR


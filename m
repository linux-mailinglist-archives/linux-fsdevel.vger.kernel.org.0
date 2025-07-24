Return-Path: <linux-fsdevel+bounces-55963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80455B1111F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 20:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C23E16F19C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 18:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6040A2EBDD5;
	Thu, 24 Jul 2025 18:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rd+PqRY1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3324A2ECE81;
	Thu, 24 Jul 2025 18:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753382664; cv=none; b=LUXF+MQqHYMaeFGEUoiln1hFZdlwva5LX1ZDRbMMxwRKev2aXt4CCFxpgdCnkAEdniqFjixSr0M1gWWt5NGriE79vqRXPaGArih6wHp8tpUYPH7sXdDduwmhuJY86uTA0IcEsVHW6i6jeAou3ZClLroeFTsf6d7I/lWASfJWLv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753382664; c=relaxed/simple;
	bh=FoP3U69gsdzWmU+5oI439paESdJlH8VQeHvTkq2I/x4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwfDDTYxz/cc6sHfYzxSebD6zgyPpsC5wcJHjApOb+17YTAKewi+MvQrphhO+DwcHUgiC/iFEMSBxk1+cT17CdUy9G4UZQgxPmM8pigX0XPQfX7gO0epCWkBI5iREmvWA41FONgY9zfQRoohXjx+kYFNqw2Y5e8SFL/PkMSoP+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rd+PqRY1; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60c5b8ee2d9so2777674a12.2;
        Thu, 24 Jul 2025 11:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753382661; x=1753987461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j7+q8dRRfA5GgBYiWux0v69kMhtHXNqDklMUXZlNiHQ=;
        b=Rd+PqRY14qAsFw7ZxuXAspMl1C6nF4aiHiMhTyKOgA5Ok/U9c2hWuS+rxprujlt0iy
         TDkS3XfxzX1yhc29zkY9+7IT18JNroSUUS6bHiTwABWWYsLQBycbIbeMFn898rrDpp1S
         MgXBnjHkK24Xu+FOanhRUr7Wq0mSWA8/RPl8tYREXcRWIPackAE4J96wkS6KWgbBLK9V
         UKgsSTSaUkHvs8WGjE6Ts56p4OwuMm0HTMYob5KuAjeJdfCbs7tVTZrq8y67uwi0HqC6
         Cdi4hVjRcRKxAembY6PlvT80JiWi20GN/vLFRGjRl76tzQSBXPqRI4mKapNRJIRRCfQe
         6rPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753382661; x=1753987461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7+q8dRRfA5GgBYiWux0v69kMhtHXNqDklMUXZlNiHQ=;
        b=Q/Lc9mWuuF40EWErxApuVSSeS9u0YVBc59Z+kml4MilwZ33tyliGi9Av2smNTvE+rK
         5xfqTAj4SiFBOzYi6twvhParAI/5bejI7DPcnwqSwWNMGsht01mlL+HjIVq/uPxikXhE
         pjmKPqRiwcLDZbvV8dHCnomoHzl9SXLQmRdFlCpO83Fsvw7IxQ+/N6Q0FcyF6H8SlGxf
         1zTuV/c5+ys+jcIhMcWouZSWv4OekVEd4uhqLClFoN6gfs7Zh0JnyMeHxRofcNhwsXFs
         Fxj2R9xgNj8gMquqC2ifOed/+JBOIBedV1IUmHEFCWNpb5QNtoCBEk5frzl9IapjeSpk
         iLNw==
X-Forwarded-Encrypted: i=1; AJvYcCU90neodHMDNX6Cw7RJynM9bwd9fpO9yc++X5xetpfhqSSIXq1DRTFFSNvZdbiLSsPf0D9UrsbHApVaofKQ@vger.kernel.org, AJvYcCX9p3TkfJJV2ItKf97ksqPC2EXJZlk962Fy6J3Tg0PZ6HkZNTmjajLvkEK2OK37kD+/ZHhbxmE3P3x+VG2E@vger.kernel.org
X-Gm-Message-State: AOJu0YxJjX+FbCw81vU6NYOPLGbZS1YdaiOgomaLzNYRYFGJvStL+Gr5
	fb1KuZZ2GuUaoGdRHeBd1ply0lRW/orOGPDUzcGR8+vPtdVto7Px4EO0
X-Gm-Gg: ASbGncstyl4v/pVSWtfPqMyz/u5IWtmiMA66TraqaVq9yaWjV4fpSk4OV9Bz6a4GPy6
	K9Bx2AsWqY66SH0gnJOC03ZlDK+upjykX5tjY/V57YYJMf+l9Dsk2162nL/QbY34GBIk+LHSwEJ
	kmgHRYidHpNGZhR1qg6R1ujfE7Ud09yd9J5XzRT0oSTNXujZkjjNrRGHZax1xVtoyal4LCh7BIX
	nIeKeX1pl+yskydlR0dLAJyIVGtqef0wDTUFTCUQJiIGNtXvj2ahX6GY8ra1von0x35LQuMNqKK
	Z8Qjjn/eP5ZuSTaHVWu1qgoTpuskO9nkf05W2mu8eIRHgA2KYkDmLbBAP6P7B9El7OZ/du+JCB3
	+UgSKfF9sbX4VO3dglKYh+oqP9cADQOJTjQyt7wXHIgSA5IoGVEfSUT+fW8YM0yo/ytalg/4Tie
	Nt4rvzWRon7pK8Ka3HdKYc
X-Google-Smtp-Source: AGHT+IHqwxGrMB/kYJLV5xxT1Fa74191c/jXvZmV4l/VXMSmyxI8kRsfYr9CdgrHHLwCc9aVL2Kcng==
X-Received: by 2002:a05:6402:34d6:b0:608:176f:9b5c with SMTP id 4fb4d7f45d1cf-6149b593e30mr7955302a12.20.1753382661151;
        Thu, 24 Jul 2025 11:44:21 -0700 (PDT)
Received: from antoni-VivoBook-ASUSLaptop-X512FAY-K512FA (u-5r-80-68-185.4bone.mynet.it. [80.68.185.178])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-614cd31a67dsm1067608a12.55.2025.07.24.11.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 11:44:20 -0700 (PDT)
Date: Thu, 24 Jul 2025 20:44:16 +0200
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: Mikulas Patocka <mpatocka@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com
Subject: Re: [PATCH] hpfs: add checks for ea addresses
Message-ID: <20250724184317.yglbwckofzou6owk@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
References: <20250720142218.145320-1-apokusinski01@gmail.com>
 <784a100e-c848-3a9c-74ef-439fa12df53c@redhat.com>
 <20250721224228.nzt7l7knum5hupgl@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
 <9ca81125-1c7b-ddaf-09ea-638bc5712632@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ca81125-1c7b-ddaf-09ea-638bc5712632@redhat.com>

On Thu, Jul 24, 2025 at 04:21:47PM +0200, Mikulas Patocka wrote:
> 
> 
> On Tue, 22 Jul 2025, Antoni Pokusinski wrote:
> 
> > > If you get a KASAN warning when using "check=normal" or "check=strict", 
> > > report it and I will fix it; with "check=none" it is not supposed to work.
> > > 
> > > Mikulas
> > > 
> > 
> > I'm just wondering what should be the expected kernel behaviour in the situation where
> > "check=none" and the "ea_offs", "acl_size_s", "ea_size_s" fields of fnode are corrupt?
> > If we assume that in such case running into some undefined behavior (which is accessing
> > an unknown memory area) is alright, then the code does not need any changes.
> > But if we'd like to prevent it, then I think we should always check the extended
> > attribute address regardless of the "check" parameter, as demonstrated
> > in the patch.
> > 
> > Kind regards,
> > Antoni
> 
> There is a trade-off between speed and resiliency. If the user wants 
> maximum speed and uses the filesystem only on trusted input, he can choose 
> "check=none". If the user wants less performance and uses the filesystem 
> on untrusted input, he can select "check=normal" (the default). If the 
> user is modifying the code and wants maximum safeguards, he should select 
> "check=strict" (that will degrade performance significantly, but it will 
> stop the filesystem as soon as possible if something goes wrong).
> 
> I think there is no need to add some middle ground where "check=none" 
> would check some structures and won't check others.
> 
> Mikulas
>

Thanks for the explanation. Yeah I think I agree with your point, I
guess that the patch is not necessary then.

Kind regards,
Antoni



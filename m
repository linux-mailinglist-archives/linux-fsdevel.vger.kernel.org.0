Return-Path: <linux-fsdevel+bounces-70192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC263C93559
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 01:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D13D4E1CF0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 00:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B04917AE1D;
	Sat, 29 Nov 2025 00:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="alSD9Drp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153B9D531
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Nov 2025 00:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764377381; cv=none; b=S0zcha3yRygrtDLYeShaYCYUImvfSiV16O9eBWXCm2BJigeAGw8TgiRPEX/JRF3Le01Z6/uWlUQGx8GvWD/JFPOIJMGJX0qfXQMjeAKiTcd+gTvZEbbTexneInd7Kg/UfKX9FEOf+BO5+GJVPpQIs2m659qdjOB/P5ff0sRTVfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764377381; c=relaxed/simple;
	bh=bvUWfeqND5iYI3fYtNWTkGE+acwlkkMi+lHnsimIgqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JyEvQZgoVeij1xC9i3TrdOAMvk8021nV9UFhwGWHoRqG4jmiwU2r6y/4VCB3QvMdBFQ3JHQjXhiQ1zdud6vkav9gBtgAYlK6xj2n3+Rn97HnEvaIbxiHVMXlKgXtDDuqDakNnNFhN6YsY+FRePhd0zSbbZscrNtqH7/BFPV2FXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=alSD9Drp; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b727f452fffso561926266b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 16:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764377377; x=1764982177; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WC5qZFm76mVuoRRGt+B/+VFzejiI2E4I2INjsgBUNHo=;
        b=alSD9DrpMTYhidFR+O/KLLn7OSaNzHV7tDHWUKzXdah60zF/HMg12IqRnxCMJn8usu
         R9ClyavkAUoKUfgO7yKbhe3ghkWoe9J2lqPuS5JMVYgAVSbkRWWB4xKK68O60Gn8GWaO
         MfPcsQA853t7KBgnxIZyiEAbihf9fLiygVEh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764377377; x=1764982177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WC5qZFm76mVuoRRGt+B/+VFzejiI2E4I2INjsgBUNHo=;
        b=STDDFtn4jwH5JHBsh1sy5I1crWOKh4czmZK6qhU18UAUPSfglFk0aLBPch174rO5yX
         oJtvMNZQO/HhDaRrnArICSbYHcQKo8/ZjXCI5wauO1bBj2BT+BfbaoP3Gfiu+gDjwsyp
         mJpFwYhd0Foxa2jJ1jzVTPj73NRv21ywXVLXgFPzCmznOWjwv4Nm2mukqchxTwhnrQsy
         jQXr42exKRXR0Gk63G4FzhfLnYvdm4Ok9ZXug3dKpsTIawt+6s2v/uwMxb6KjFl8z/PP
         MTocKLurkVutUbO/8vY86ESY/Hq41YH6ay+09uieYopq1xRWFg4XGhWNMFj26bTo1DCI
         87HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW+aazHYENe+T73cQwYy+n2DcEMI02d94GPzcuoiHCVlERlAUxbd4KQwpZhkX/vlUy4M018GmXkMNtmmvL@vger.kernel.org
X-Gm-Message-State: AOJu0YzCBe6LcVZ4kr4Nu/x0cyU5we51AZa1z4H66lseRDgXOOQ1FB9y
	KXBJ8WTfVzWO17St0zZJvZrVVx65qx2VkuIcGNyPtiYj7Mp7CUl96pX/UAE5jdRicEXrnW01kxP
	mV9c+KSRHDQ==
X-Gm-Gg: ASbGncvnebxnr8vgEdDT3Q6sZjG9DGUrJz9ciRHmG8n6QRgt6grCr2BAKSuyzaFco8N
	CT5kojtxdpwOCCAoFKZ7+geeoBkb6WADFWLnkwxJFi9iXNk6MmmWS/SlpYT692kNVILsftSkXjv
	C1J2kCt9WbD2lbGG+QieB0CSbKD5ipcyKkd8re7hmVie2ekq0NL42lCCrH7XlLBr+e4AVDrT/fH
	I0ktHih+A64vrwi22YNdN33DUUsGzShpeX3OoaX+ws3ddQe5NW1pegLoU5WlkaFrT6H3kBFzP2S
	7nJoSEliEir29rI7ldzJW6NZXUGcChw+O5QLDHo7q/dc1JWW0DhIamo2BJIo8rWnhFAGpe5tqeR
	Lz9/UfIvQ4XXT4YLJs1ROQoU5bVpeJtcPiYhLyY/t044BuSuFJyYaANQPr3Fk2nroAQL4pN+P8u
	N7ey4Om80E5eax8IA/xzCU4EMQCYvkJt6g1uz31JGhpUI0obnLYakyhMBC2y4m
X-Google-Smtp-Source: AGHT+IF9tSQdqP6mrFyItmZYc9AhHKlPybju0C44eJnrNcc8A0k5FIBg6gnZToWM9pJH5LAAyBMHOg==
X-Received: by 2002:a17:907:7f15:b0:b72:b7cd:f59e with SMTP id a640c23a62f3a-b766edb7c94mr3687229766b.8.1764377377203;
        Fri, 28 Nov 2025 16:49:37 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59aece0sm559399866b.32.2025.11.28.16.49.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 16:49:36 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64320b9bb4bso4649170a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 16:49:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU2bx0cCdDQ+cLoNBX7k55EvGI2xWZi6tA1bN/Qzrp+hDPa0+Aen8XKSFifvSNCbMouHqEe+0Nv0z5rJj+k@vger.kernel.org
X-Received: by 2002:aa7:c6d7:0:b0:644:fc07:2d08 with SMTP id
 4fb4d7f45d1cf-6453962437fmr24783211a12.2.1764377376197; Fri, 28 Nov 2025
 16:49:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1205721.1764376811@warthog.procyon.org.uk>
In-Reply-To: <1205721.1764376811@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 28 Nov 2025 16:49:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whqqAAwUwu07_FykKaiFw+WBHyc4VQpPVdzOeDFdCQVMw@mail.gmail.com>
X-Gm-Features: AWmQ_bkrvgmXs7Myd-OJLwxqdrkElLnkefR-HN1YEquqYfy9JgTtXixI5e1DtoI
Message-ID: <CAHk-=whqqAAwUwu07_FykKaiFw+WBHyc4VQpPVdzOeDFdCQVMw@mail.gmail.com>
Subject: Re: [PATCH] afs: Fix uninit var in afs_alloc_anon_key()
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Paulo Alcantra <pc@manguebit.org>, 
	syzbot+41c68824eefb67cdf00c@syzkaller.appspotmail.com, 
	Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I've applied this directly, since it seems to be a recent regression
and final 6.18 is days away.

And it seems like an obvious fix. Famous last words...

            Linus

On Fri, 28 Nov 2025 at 16:40, David Howells <dhowells@redhat.com> wrote:
>
> Fix an uninitialised variable (key) in afs_alloc_anon_key() by setting it
> to cell->anonymous_key.  Without this change, the error check may return a
> false failure with a bad error number.


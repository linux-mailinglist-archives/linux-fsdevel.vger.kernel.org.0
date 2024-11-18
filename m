Return-Path: <linux-fsdevel+bounces-35142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F339D19D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 21:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFBD51F22A6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 20:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503601E6DC2;
	Mon, 18 Nov 2024 20:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="s8haaCrq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497861E571A
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 20:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731962628; cv=none; b=OZJuZKqQEKg5f86SUY+3BbCsmQUbCNll2QeckLUQyVeWJp7P1WXHU3ZE/lE8MxGYW4LV+X57gLX7+5dmfojZ/kg/2EbVUJJLkyhPuk1l18Bpo+VO6cGTSjyWbl4tWhkW2x+7OEFXxPM56jCvxfwOoBZxMV9lg75qMcO95Tz4/8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731962628; c=relaxed/simple;
	bh=2L0jUsFxTDaCzEDTuhMc0l5SEQuiyx34/3gYStPf1dA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7c6DzsJNFAvEmsHdQWUIqfQnuDRUKWphbMu2AsyRShlJEzYabi8lwIyeWO6iidzVvYTalR1ymV5aZg5ttmWOZdISmz8GkwGgH3N5wXO4DgYH/7MepMyTz9vCwk8hzzCM3hmjOj1YswK4FXrQyBhhYR9l5yjy/jfsigEtWF3VQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=s8haaCrq; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5ebc349204cso997469eaf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 12:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1731962626; x=1732567426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKE5WXVcANzplYCvLukBM8ucFIajNbuRun8q9IwLc70=;
        b=s8haaCrq0qPwt68vIa4jhFK22RoKOpm+map77XBWVkvhhCDUNKVNcYMnJ9FklWNW40
         O35htGCSqYGpQoYgfePOrah+Rqs/jlwRzcGvOj3C1OZDydl929NX34V2Jc+AKA4igj+i
         9zGICDFS9+JXpa1AtunKOlkvewS4NuNXjfpdVbGM7xkIYHah3Yg5Pyvr0mzqr1JTYNY3
         5UsOVhj6VztuyKaUbh0jeodDJeq/RE6M9Q2Q6J5qtqcFJcut5Ln589w9Giq8ghx3rcjo
         0xQZPqPwbeY+woInSQ0o+YqUsVR13mOrjKejNMzXdPFjovXsq4Bj0QlLXN7/sq+dZK1F
         UKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731962626; x=1732567426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKE5WXVcANzplYCvLukBM8ucFIajNbuRun8q9IwLc70=;
        b=MhwIlXYAQQe7p6SHOkjXIWADn4ZtFi7qxtwNvZHlQQZ0TTg6frujTv4rTFHS0xCjdr
         3C3HzmuByoSQfmsVd1dPo30l72Xt+bPMR5FXrLcWcPcrn7CxCEgprmuBo74+LnXiEjUA
         saa2Rk8YO5Ef9ZxuM1fpK++/vB1hiUl1G/11wnZQgA7PDqBWWDOBkBtBRPbXAjayTemr
         RDPslFn62iDuIm69EGM3MuakE+dI1aJgAny+zmTszn7rLRiLXFbtlEQCs5dMFBgEJ0JP
         RE7GutRLYxlf2EyhD96cfpUOtDIvEa/SAabL5oaRrhCiwOx525txp1PH7eON+RpJE3hO
         TdmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU69FrZKLjTEPusongOZhkuFpGjtu/iRj9s6iwdNq2YkTGw9U7UTvBJZVnuylnIe9l/BR6ulw4/nJKne6vP@vger.kernel.org
X-Gm-Message-State: AOJu0YwwDeMIKsbMR+Wu8uStEklHIfDUTUnCip2vI5RuQYJFbUYVhpW8
	/bG5WtPLquwu2JjLkDaZfMh3VQoOpJP4TbrI4pEwOC7feec+y++OIlR87VDwg/A9SekUGucpIoX
	ylwfit6TMNJxBguqNkjZxB2gVB/jkJcxFM6OalA==
X-Google-Smtp-Source: AGHT+IEf5Ob7EXtqd8iWcFGFwDUCq53TzMogOqE3dzw3L/nuaDYAwShT+BhejHjdqP1p2ni0LVReVdAVYfYCT0xWwgo=
X-Received: by 2002:a05:6358:2743:b0:1c3:94bf:643e with SMTP id
 e5c5f4694b2df-1c6cd14a63bmr595917955d.16.1731962626353; Mon, 18 Nov 2024
 12:43:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <20241116175922.3265872-5-pasha.tatashin@soleen.com> <87cyiukehs.fsf@trenco.lwn.net>
In-Reply-To: <87cyiukehs.fsf@trenco.lwn.net>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 18 Nov 2024 15:43:09 -0500
Message-ID: <CA+CK2bCFNPpzKr8wfpTwFAMnO-e5-AbC4siU4b+ESu2GVeMuyw@mail.gmail.com>
Subject: Re: [RFCv1 4/6] misc/page_detective: Introduce Page Detective
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	akpm@linux-foundation.org, derek.kiernan@amd.com, dragan.cvetic@amd.com, 
	arnd@arndb.de, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, tj@kernel.org, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	vbabka@suse.cz, jannh@google.com, shuah@kernel.org, vegard.nossum@oracle.com, 
	vattunuru@marvell.com, schalla@marvell.com, david@redhat.com, 
	willy@infradead.org, osalvador@suse.de, usama.anjum@collabora.com, 
	andrii@kernel.org, ryan.roberts@arm.com, peterx@redhat.com, oleg@redhat.com, 
	tandersen@netflix.com, rientjes@google.com, gthelen@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 5:20=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> Pasha Tatashin <pasha.tatashin@soleen.com> writes:
>
> > Page Detective is a kernel debugging tool that provides detailed
> > information about the usage and mapping of physical memory pages.
> >
> > It operates through the Linux debugfs interface, providing access
> > to both virtual and physical address inquiries. The output, presented
> > via kernel log messages (accessible with dmesg), will help
> > administrators and developers understand how specific pages are
> > utilized by the system.
> >
> > This tool can be used to investigate various memory-related issues,
> > such as checksum failures during live migration, filesystem journal
> > failures, general segfaults, or other corruptions.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  Documentation/misc-devices/index.rst          |   1 +
> >  Documentation/misc-devices/page_detective.rst |  78 ++
>
> This seems like a strange place to bury this document - who will look
> for it here?  Even if it is truly implemented as a misc device (I didn't
> look), the documentation would belong either in the admin guide or with
> the MM docs, it seems to me...?

I will put it under MM docs in the next version, as I will also
convert Page Detective to be part of core mm.

Thank you,
Pasha


Return-Path: <linux-fsdevel+bounces-35167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C92809D1D50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 02:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770B51F21B5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 01:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890FE7711F;
	Tue, 19 Nov 2024 01:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="k8lzIUIs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A7F25634
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2024 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979835; cv=none; b=RBoKH9IdABffG/1/jxdtLlQWMxPBMA/0j9Ti3eJP4Zkd3ohCJo+rwl2RTPGGkv79RE7X6TRpAx5gjhvo5nZiMWrRWLK1uGlJyUWlQwMjEyEQCcXC/z3aOgxFP1kaycE7+36WoSX4DcWdxqLEVeoyCkqDO03j3z+iwzwK/5LNxUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979835; c=relaxed/simple;
	bh=dwhbrEEfePVbvJU2Ozddu2A4+flvh6qun9KERWZBa38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MERQH5Eo1luiCuYSBPDoKsDEAQhFTy/w/C5uCDsFaebdkn5ye35iRKbhQpZi1Y9MbcPBJGccWYWlTfPAYk4fULjrSKPOhAbEUoT1YAuoiXpE9rvjdml/NPMANG+On1AaEsh68FWUZLU4BUDrEs2pfqEgKVWHAE4RPMQUnbC2O80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=k8lzIUIs; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-856ec390e30so1423039241.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 17:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1731979832; x=1732584632; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dwhbrEEfePVbvJU2Ozddu2A4+flvh6qun9KERWZBa38=;
        b=k8lzIUIsmYElffpbh57rlY3tRxUBQ7HRQZILiWErsvaby4Cd9m5Y+ixX0pOAIwxI2l
         hMNomGeRJwFJKbhkwHbsRNBjw4hzfn5R5PCNTcoFkK6fVthKO3qRuOb2rU1QLV7Wgqps
         MPjmY7qjE10pmxF2MCLONbn0lz7+5gMQWekRntaCbhGWP2TBjnIKAAnNfWvZS6D618RW
         OPSb4YuDI1c0sQrKybSfkm25ptjvCJgvkgPcfU5oO+S8isODuIdUSm8inbfXJaRYqbzB
         KTf42sNiJBhJeuNMw/ntrBARMYfNDUhQfgMhb8CrnEBpvT0MtUU4ePeoBKRe0L55X/PD
         VlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731979832; x=1732584632;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dwhbrEEfePVbvJU2Ozddu2A4+flvh6qun9KERWZBa38=;
        b=NjGZJcIaYGbQZaVwEC2zwH37CBXwd04WhFO8wjStTFCEmCwbPJlZ4+SgYkFHa7FMLq
         yahMYXRu1jEdMC+X/Gv76UIY+MALPj8avwAzvFXS6Y4Le8kYPVk7/PxTHMtjbJOnApEg
         89aeqe8aosddvuj/ycY+7HYWIjgWfrz3rqXyxyWeAo3Naef8H5QM2f963+CLG4bNgSCI
         flveu0XWbeM6WTC4BTNEO3Ey6rz2hOV8+DOu8i3hheuZ5A8d3SX2z6i99vR+8UQv8sDu
         zeRRpGUzNX/P4W5KKu6MSv893NrwxlciRfVy1vzfrl85VB7x0ICmKbzWspmkgaWeNKfg
         ulhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFVdjKYCcsE3vi6120f+Lotz4Av07vAkQatMUt+VrnAIvWx8hBpQs/3LH2WHpXvwzpnI0Uhq2mq7Kf5uUl@vger.kernel.org
X-Gm-Message-State: AOJu0YyhVsA21WH/sVsquY0u5gd/muGNG135FFgKtQL6EaadwlP4GsSk
	bRNjYbouMzYO9dDUSzDUldm/V78X856zctl67zaWSHfW/LtzJX+MXeJK4NgLsAzFUOWpGT4qEI8
	X+WTcBw4qwDv+MPVl+5Uy+ci4AhVYD7PrOSvXmw==
X-Google-Smtp-Source: AGHT+IEnblF5WP9b6MMjtXTC6Vjj1Iy7OkpDZ4PeMU+Uc4InANfSMt/pice9eNGMRdH2BcrKEejfz0Ajo3xoxrMqxY0=
X-Received: by 2002:a05:6102:3f04:b0:4a9:14:3ee9 with SMTP id
 ada2fe7eead31-4ad62d52711mr12363521137.23.1731979832190; Mon, 18 Nov 2024
 17:30:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <a0372f7f-9a85-4d3e-ba20-b5911a8189e3@lucifer.local> <CAG48ez2vG0tr=H8csGes7HN_5HPQAh4WZU8U1G945K1GKfABPg@mail.gmail.com>
 <CA+CK2bB0w=i1z78AJbr2gZE9ybYki4Vz_s53=8URrxwyPvvB+A@mail.gmail.com> <CAG48ez1KFFXzy5qcYVZLnUEztaZxDGY2+4GvwYq7Hb=Y=3FBxQ@mail.gmail.com>
In-Reply-To: <CAG48ez1KFFXzy5qcYVZLnUEztaZxDGY2+4GvwYq7Hb=Y=3FBxQ@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 18 Nov 2024 20:29:55 -0500
Message-ID: <CA+CK2bCBwZFomepG-Pp6oiAwHQiKdsTLe3rYtE3hFSQ5spEDww@mail.gmail.com>
Subject: Re: [RFCv1 0/6] Page Detective
To: Jann Horn <jannh@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com, 
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, tj@kernel.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, shuah@kernel.org, vegard.nossum@oracle.com, 
	vattunuru@marvell.com, schalla@marvell.com, david@redhat.com, 
	willy@infradead.org, osalvador@suse.de, usama.anjum@collabora.com, 
	andrii@kernel.org, ryan.roberts@arm.com, peterx@redhat.com, oleg@redhat.com, 
	tandersen@netflix.com, rientjes@google.com, gthelen@google.com, 
	linux-hardening@vger.kernel.org, 
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"

> Can you point me to where a refcounted reference to the page comes
> from when page_detective_metadata() calls dump_page_lvl()?

I am sorry, I remembered incorrectly, we are getting reference right
after dump_page_lvl() in page_detective_memcg() -> folio_try_get(); I
will move the folio_try_get() to before dump_page_lvl().

> > > So I think dump_page() in its current form is not something we should
> > > expose to a userspace-reachable API.
> >
> > We use dump_page() all over WARN_ONs in MM code where pages might not
> > be locked, but this is a good point, that while even the existing
> > usage might be racy, providing a user-reachable API potentially makes
> > it worse. I will see if I could add some locking before dump_page(),
> > or make a dump_page variant that does not do dump_mapping().
>
> To be clear, I am not that strongly opposed to racily reading data
> such that the data may not be internally consistent or such; but this
> is a case of racy use-after-free reads that might end up dumping
> entirely unrelated memory contents into dmesg. I think we should
> properly protect against that in an API that userspace can invoke.
> Otherwise, if we race, we might end up writing random memory contents
> into dmesg; and if we are particularly unlucky, those random memory
> contents could be PII or authentication tokens or such.
>
> I'm not entirely sure what the right approach is here; I guess it
> makes sense that when the kernel internally detects corruption,
> dump_page doesn't take references on pages it accesses to avoid
> corrupting things further. If you are looking at a page based on a
> userspace request, I guess you could access the page with the
> necessary locking to access its properties under the normal locking
> rules?

I will take reference, as we already do that for memcg purpose, but
have not included dump_page().

Thank you,
Pasha


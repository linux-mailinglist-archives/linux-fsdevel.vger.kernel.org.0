Return-Path: <linux-fsdevel+bounces-35214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B78C9D293D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 16:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 126AE282F55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 15:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB5C1CF5CA;
	Tue, 19 Nov 2024 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="i0bFmwNS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D720922067
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2024 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028956; cv=none; b=oZ0fEliJhijvyHp1f/7j+qArS3jNB2GOS4s0N7F70R/YuLX/d2um89OaN61OaThuawyKBJXK2tmBsUHQZ7CUPL3eq24Z6NU71PAPJ7oV8M+cxNF44rS4M4dnK6wTJs/T7+VsopMfP7mBpKcchZQFmH2pkvvnpL5KvJwMkMzqWdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028956; c=relaxed/simple;
	bh=term3+YtnkBCGLWYkrPNKsOYQOVa1JK6phDy6+5uneQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnj11a307uD1diqPZsQgsXfjxXlBAS/bDuuQTcTKCUWnxyVNC2PSmGhiDzUkk+oO99j4ipb/7SSNo9VOREICa32UZJrEURlmBtoq6fbyLXstvxGem3d2oW75HDSVqAOobOT9SnM9kvA5WJBZCcJwiq66qBre2HhCr5s1IGS7sp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=i0bFmwNS; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-46375ac25fbso24417771cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2024 07:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1732028954; x=1732633754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihpfPch2+vS1oLDpcfa8u6AKTSTYRMwvV9Is7Fw0VNM=;
        b=i0bFmwNSYKDu56w+1KfoI9Wv/z7Q56Y3/FuWrIs4et2f725i3dexI5l4TgIuzEinev
         wcmXM0FIuAANPqkGDtDBKNOCtQgXcInxDAbAExbksuY3PHsg/XhlwlOF0jrmmPtxgNGB
         3ozG5M2Hh+5JZ4PRRxkzdhh9FBLO8fB6vuXD0EV5/gDmqsiLney6iD06PKghiruCZ2sT
         beqNIkYtAmdgmNHe6NcyUlPGa6IWlOBZCjwkQ0570tvTHBe63gecz24InBzRz6jYbk6y
         48IRg23n1UfQvNuvYBLDbq/cQt74DqFNBOeFO/LIUOdgbMUlQwrlNqLchCHK3kKt6aI+
         wrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732028954; x=1732633754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihpfPch2+vS1oLDpcfa8u6AKTSTYRMwvV9Is7Fw0VNM=;
        b=gXlI91o+5MVYyUNr1lGa4uquotmrIMz8gnU+wI9HE99EQMluB5JCmyaWc8GMlwOIXt
         nqbkG2nmCZA18ZMYA4f+MGcktVxAEEL4ZDRN+zGjtoyutTRNxO3oC9jrlaAopkJzSNdQ
         oGJus41NYzELSjrzfuxfS2pj0O9CI2Rimz1329gnVfX2/+G+q+YQy0KgjHFEgvuF6e8S
         Gp1hAKwvgQ+aIddQPdWqI0hTzQNj9XdRJH93OV40YJ9w5yvduQd1vwDANV3l5GgDUq6t
         6Ft5Ril7O/8U6d8K+IlPzd5yTIH65h6R27ETJ/SrBpKgsJNtD058SDqe1e7mQL5GCOR8
         jApA==
X-Forwarded-Encrypted: i=1; AJvYcCUL6CC+RyOR8f+8CVBFbinBDNK6CBzU6rDKEaLK5SOs51VEtzB1UVPkMgJ05OGQC8JPajZn0z8ZYP/9V8mg@vger.kernel.org
X-Gm-Message-State: AOJu0YymwbMR8G1q+VNatDqnrX/GQhFMyQyj4b7xRpdtCeHC/6nODsFh
	YtfA1dVSU5eaSmfaEBSGbw/1aBP91d8cfVPBaHDU8jp+ZMw8neDhAzahHy7ixdaGm20ZauI0H9S
	oEXhZVJLRFWgaJT8SPGlL3Je576huOZQ+JPuFyw==
X-Google-Smtp-Source: AGHT+IHRGpOUonbjsJFvyqtYHjjDkldWUt457Akk0CmInRHYKiSo8TSkt2aWu9nazV3c0hbsQ8hzQfAATih5DjFXh3E=
X-Received: by 2002:ac8:7d4c:0:b0:463:990:4250 with SMTP id
 d75a77b69052e-46363e93fbcmr224538141cf.38.1732028953763; Tue, 19 Nov 2024
 07:09:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <ZzuRSZc8HX9Zu0dE@google.com> <CA+CK2bAAigxUv=HGpxoV-PruN_AhisKW675SxuG_yVi+vNmfSQ@mail.gmail.com>
 <2024111938-anointer-kooky-d4f9@gregkh>
In-Reply-To: <2024111938-anointer-kooky-d4f9@gregkh>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 19 Nov 2024 10:08:36 -0500
Message-ID: <CA+CK2bD88y4wmmvzMCC5Zkp4DX5ZrxL+XEOX2v4UhBxet6nwSA@mail.gmail.com>
Subject: Re: [RFCv1 0/6] Page Detective
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com, 
	dragan.cvetic@amd.com, arnd@arndb.de, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, tj@kernel.org, hannes@cmpxchg.org, 
	mhocko@kernel.org, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz, 
	jannh@google.com, shuah@kernel.org, vegard.nossum@oracle.com, 
	vattunuru@marvell.com, schalla@marvell.com, david@redhat.com, 
	willy@infradead.org, osalvador@suse.de, usama.anjum@collabora.com, 
	andrii@kernel.org, ryan.roberts@arm.com, peterx@redhat.com, oleg@redhat.com, 
	tandersen@netflix.com, rientjes@google.com, gthelen@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 8:09=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Nov 18, 2024 at 05:08:42PM -0500, Pasha Tatashin wrote:
> > Additionally, using crash/drgn is not feasible for us at this time, it
> > requires keeping external tools on our hosts, also it requires
> > approval and a security review for each script before deployment in
> > our fleet.
>
> So it's ok to add a totally insecure kernel feature to your fleet
> instead?  You might want to reconsider that policy decision :)

Hi Greg,

While some risk is inherent, we believe the potential for abuse here
is limited, especially given the existing  CAP_SYS_ADMIN requirement.
But, even with root access compromised, this tool presents a smaller
attack surface than alternatives like crash/drgn. It exposes less
sensitive information, unlike crash/drgn, which could potentially
allow reading all of kernel memory.

Pasha


Return-Path: <linux-fsdevel+bounces-66373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6424CC1D656
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 22:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6F2189C68A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 21:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B66A3191C0;
	Wed, 29 Oct 2025 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nCYmfsCb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84603161AA
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 21:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761772432; cv=none; b=SmoURprHvtTfx8oSeEHmw8wiKzqzCsfcs42JAAM1o3Jh1yeBpMnsNHrTGFITJzZQFF5ULZJvReyT05LNucdRUxpEyLC4Nnv4lYsouv0jW9vBHVHRQ5LNITV9/15PI5OAH5yEgpSPkUuU1WNC46PAVNFFsNkiXIrJDajOb3HUPLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761772432; c=relaxed/simple;
	bh=JEkVL2yw/xHlwVM5DiMfV/wkuCa8mgAwcpgYx81B7GM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxuKgU2zhFHdDGrmDPZnULaM4Jsk6/D0+O1NPc7uloXK5ptep3NGDq1Ri62T9HGdsgHEN2AxThGq/AhCX7gj8o4wV9dJCbo/1fVuhWOMyGGmZbVmXLfOEYeJGT53k/71g6xfMbVYjAw0TjKlP94UUR4RR1bfsNx3gRMkO+dN1LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nCYmfsCb; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-592f1988a2dso1590158e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 14:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761772429; x=1762377229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEkVL2yw/xHlwVM5DiMfV/wkuCa8mgAwcpgYx81B7GM=;
        b=nCYmfsCbMA9NzQaa64kEC4baExLRtapT8fdvk0MH1d4zIRtbMvV0rLZ/ptvT0vq5CH
         +HkkqrBp5hoG9mo4GWeyy0x7qGtAdVpMS8K3dMJpsG8R4Gt+JjDASlsjGYQqmymIoVyT
         A6Sryrmiwb5pfkfJp9gETz5OEwTM4FvK/RviWFqKH+bjnkpz5JWpDmMTDjF4RehWZFUL
         PWQrbsWOFTWFRGCylRTz4MVqnJZ/baSDn+D5saaFFFU3XmtfX799iUDrSmrCGfm9+ds4
         P9T3r0jAjxlhY13vVHr/97QV9jAZlnFLnIVoGydDVThAbYOXAg19krfWu3pizUwtsxj8
         vr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761772429; x=1762377229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEkVL2yw/xHlwVM5DiMfV/wkuCa8mgAwcpgYx81B7GM=;
        b=f3z7lw3d6Da7NcHYMJOs5cFie23Jz5ZxbCjTT18l0qsx7d7Keq4iWWFSpmoVTKwlCC
         ctsidgWd2LkH1Chx3M9pjtNfquk2+06oY9G2H26LGDNgmeQS0bd1rzaU8ejFHRLZIgdc
         whbTO91t4G3Kgaw0LdBryLhVNJKbIbvb4qXagiv+PxjhbHqEyCaG/CZSoTDAdHtWnKQX
         sq/S5X1oz1Lj6aHQFa40NyPWoi0PTOeSmaMhwib2aV0p4WoZi7xfQOhVSqL80s8+9mrd
         xTvvlAM+BVkluxKado5Occ89YyTHeyoFshmeFv5mtFUHVPqa02NCf82F8vnvlSNxtM8P
         27lg==
X-Forwarded-Encrypted: i=1; AJvYcCUvu0+QQyemEmlid2ovwqyZ1DuFljjPP1+qWdmynN6jrLRFLnQpRzUZxHQGL3ncorGb+rxMXC8aUXDRbdjQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwQF+w2hlAKE1NtLQ7c2ZY6ek7W94cN8SfxYIweo9YRox1/lCZE
	yHc/1p8l2Q2h5Z1JE1LVjOOcin7Mib7cWVKfLyAqJ9cfWL67Qb9HeEjOC4CGdx7gtI32SEBdDqZ
	VnU3+cPixDqPeKVxJeSwRGPaOK4FMPsoWLkykWIcv
X-Gm-Gg: ASbGncsyOIYNeIxccs7hLHEziklvAZ79kPxd54ZSTA0pUBvXo6mhZGxACkVTCssY8gt
	sO0eF1N9jUXDH/Km7TxQVjR0ORoVnefrmxP7MGmU6jO1YweGxUvIZz7NLQ2UqsQkEcPY7Pf8Flh
	YmZvP+pheAjJMDa+WSRkMZSwPZ8NjnPQtzHqN0hdqxZ6GKQrusoVPjR7Zu7PktVDjT74JMx/IZ9
	lhT9hNZNDERdNql1Fn/vDy6vo2A2P8eDR6Z5YJxTuKxpHyMWGshCGzWnp67HyarWXMs6MxAnbCS
	D4UxsQ==
X-Google-Smtp-Source: AGHT+IHZQoB9yL+ldFaXMM1bMXJiwccZfdn7OWdIICrdEFPtCJ4NB2qUJ+qk4p2BEZhWEpH+XIXLyp9M3uzoemzEy4A=
X-Received: by 2002:a05:6512:3ca2:b0:58b:75:8fc6 with SMTP id
 2adb3069b0e04-59416d8ce02mr294670e87.19.1761772428439; Wed, 29 Oct 2025
 14:13:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <20250929010321.3462457-15-pasha.tatashin@soleen.com> <mafs0tszhcyrw.fsf@kernel.org>
 <CA+CK2bBVSX26TKwgLkXCDop5u3e9McH3sQMascT47ZwwrwraOw@mail.gmail.com>
In-Reply-To: <CA+CK2bBVSX26TKwgLkXCDop5u3e9McH3sQMascT47ZwwrwraOw@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 29 Oct 2025 14:13:20 -0700
X-Gm-Features: AWmQ_bnOObc6BWBaYvrzlZGN0Gzs0AQqmxe0DWfFCoP14pNjDRBJcsWZpskW2fo
Message-ID: <CALzav=frK48c1=nsbVJ4EvqqOqr33pUArP4G17su0hxOYveALw@mail.gmail.com>
Subject: Re: [PATCH v4 14/30] liveupdate: luo_session: Add ioctls for file
 preservation and state management
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com, hughd@google.com, skhawaja@google.com, chrisl@kernel.org, 
	steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 1:13=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:

> Simplified uAPI Proposal
> The simplest uAPI would look like this:
> IOCTLs on /dev/liveupdate (to create and retrieve session FDs):
> LIVEUPDATE_IOCTL_CREATE_SESSION
> LIVEUPDATE_IOCTL_RETRIEVE_SESSION

> - If everything succeeds, the session becomes an empty "outgoing"
> session. It can then be closed and discarded or reused for the next
> live update by preserving new FDs into it.

I think it would be useful to cleanly separate incoming and outgoing
sessions. The only way to get an outgoing session is with
LIVEUPDATE_IOCTL_CREATE_SESSION. Incoming sessions can be retrieved
with LIVEUPDATE_IOCTL_RETRIEVE_SESSION.

It is fine and expected for incoming and outgoing sessions to have the
same name. But they are different sessions. This way, the kernel can
easily keep track of incoming and outgoing sessions separately, and
there is not need to "transition" and session from incoming to
outgoing.


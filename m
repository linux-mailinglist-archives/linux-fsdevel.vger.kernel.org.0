Return-Path: <linux-fsdevel+bounces-61925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 753C7B7E8BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E81164E1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 12:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4587D306B1E;
	Wed, 17 Sep 2025 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="cMDTF90E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88030183CA6
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113302; cv=none; b=SAKS014SJyTNoRJ/oaVPeR3+3kG2NJLvLxGjvdRJzw6XXZQz0SB7T+Qruzsexpm0/iv57kBPLaIGhjasCHjPqHafZ2h7hSbJJudXRO90kH4sDTZM6X8AgWD40GTmmNztfvq0JcK7XXZ6ad82eJXilE9T91ke9gYEMJke2i9AFRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113302; c=relaxed/simple;
	bh=mzoJJTaUHkHZHToYowEQCZnMPpDM4R66Ou5zGDbIBXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqMh9GUfsgO27ktjGuMi3sHjr8imDV+2PUTyWi4aP0HdztRARL5jdKj6Cao50zWpH954Fl4Yua7kxOjD4wYROVYKOIht+tBna/MlGJXb5k1Wfc0YZjq2BzPHKwODQEVu3p/Zt1CPd5vyHhHlqTB0zVeYa5IBdO90rK9r1T8UO4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=cMDTF90E; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b042cc39551so1103933466b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 05:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758113299; x=1758718099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzoJJTaUHkHZHToYowEQCZnMPpDM4R66Ou5zGDbIBXA=;
        b=cMDTF90EGBeuHInGda+w93d1GOwo2rHKkwntG0bwK+MWxwhfBaJFYt5If1zJdMil24
         5xX3bI2z91Y8/9jTDIzQUP2OqhEPBttZlBiN0MZ1RwtFljVXPaOlAxidBHG1bHKGyzoP
         QTkuajgM283DoE5D3a/0vq56noXNHVURz2XTLjBoYcF7KTd9nf8YPUUNlhoYxtIKi9C4
         p9tCADKAmVwYGS1AOMtO8qemwur1QETYSt37hZZKVFKHI9pzl1Y5Q2ORFAEEvyDtovFU
         tgQ5sV1z7fR10O3pL+ixZnw57A7rQBpgvY0OpvdyxvqgbmfPG3A2uj4GOEwCOk9YeN2n
         neNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758113299; x=1758718099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzoJJTaUHkHZHToYowEQCZnMPpDM4R66Ou5zGDbIBXA=;
        b=lRsmScG7zQ5luMt+VVT3YHeB38Uzca68F/aNVi9cAkAhfYPGu8jq35+L1IZpRAV3Gp
         woFU1Fc3jKqQ7XwVuNcfJpTB9hDFUeo9FshXwSVLpXFBSQ+y4lBXv7r0c6Oz7avtDEJn
         zAQZR4++Zo1NQxDFPlbqcJZuekdVVEz/O+qUp18+kzBdQYR1XGwg69y8Eh1cpixh0j0b
         tWngOePDn7KFi+aYzwZHdwRL1nQ2LXYGzlCevNYxzPrPeInsINzezyHBWpz1uZt3jkFQ
         bVsTMM4myFtGdTwDnvmv4HaakZNfGiGPv39oFaXdBqI5rlu9yG5ZKixHQ6QMNj1wzEN4
         Y90A==
X-Gm-Message-State: AOJu0YxaJzec3nmf3chnS4v1y9pps8iXVdDiHL1/Bo5brzxI/qjz/Di7
	fStGdY9lNHYWqW5dk8kJIs8qP2tmqe7WY1NH/YMR6ubsosMNubG2aBrj0OqfKt/zTbq3BHtlPDG
	VAPfxHHeyPUEZllUWCRBeGjILNdbhGsnNaB4SsyhHMg==
X-Gm-Gg: ASbGnctKFJSg4NpyF6HkibBS9bXWnMCUsXaosbzTHsjiXrVm6j7FWkr0Yu8VYNVoWRC
	niCuDZPuieStD9/AT/4Sw2GDQO3ZOYrUxRQyvYSZE57ci6ZYMI3AlubSiDeZt3xowEkAJND4xVB
	ZRXUK/a2SR11FmuLOvnS/GJthMLLYSxdhwmwBVeBPY1ude7H6sFlxeWbChsqnsDMSTrAn3YFDcO
	BJtZqiIl6QwtnwXqDqRa491AaWYfYO8NdrF
X-Google-Smtp-Source: AGHT+IGxLydLDJb0VdYSaq6Lk+OQ4q1aEqSqriHtwbCsy+e8WDZN7b+TQjeMCOhaF7PVT8Bkog08GU6BKCkdGttIS0I=
X-Received: by 2002:a17:907:3e27:b0:b09:6ff1:e65d with SMTP id
 a640c23a62f3a-b1bc2778d71mr257244066b.61.1758113298807; Wed, 17 Sep 2025
 05:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+-QRTC_j15=Cc4YeU3TAcpQCrFWmBZcNxfnw1LndVzASg@mail.gmail.com>
 <4z3imll6zbzwqcyfl225xn3rc4mev6ppjnx5itmvznj2yormug@utk6twdablj3>
 <CAKPOu+--m8eppmF5+fofG=AKAMu5K_meF44UH4XiL8V3_X_rJg@mail.gmail.com>
 <CAGudoHEqNYWMqDiogc9Q_s9QMQHB6Rm_1dUzcC7B0GFBrqS=1g@mail.gmail.com> <CAKPOu+_B=0G-csXEw2OshD6ZJm0+Ex9dRNf6bHpVuQFgBB7-Zw@mail.gmail.com>
In-Reply-To: <CAKPOu+_B=0G-csXEw2OshD6ZJm0+Ex9dRNf6bHpVuQFgBB7-Zw@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 17 Sep 2025 14:48:07 +0200
X-Gm-Features: AS18NWBvdouXUe1Mvci0ghTgQgjd6tzI9CRI7bVed8MohvrSsbtpRmVZImWkHk8
Message-ID: <CAKPOu+-xr+nQuzfjtQCgZCqPtec=8uQiz29H5+5AeFzTbp=1rw@mail.gmail.com>
Subject: Re: Need advice with iput() deadlock during writeback
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 11:20=E2=80=AFAM Max Kellermann
<max.kellermann@ionos.com> wrote:
> I had already started writing exactly this, very similar to your
> sketch.

I just submitted the patch, and it was even simpler than my first
draft, because I could use the existing work_struct in ceph_inode_info
and donate the inode reference to it.
I'd welcome your opinion on this approach.


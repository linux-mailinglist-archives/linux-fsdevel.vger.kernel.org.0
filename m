Return-Path: <linux-fsdevel+bounces-54183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A69AFBD33
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 23:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5541B561DD1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 21:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B20285C8F;
	Mon,  7 Jul 2025 21:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WT62MW0i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073A828507E
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 21:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751922381; cv=none; b=p7j56qobK7v5pg8Jzg49u5KrgHDvNPrCQBSuDXDj6WqapchdssSP7Kwf9ouPdrLrpjEjH/oaOZFbFc+qyJhT5UHF1iL5RbN1FuLbKZ/H0L6i+Up2HljIOVwWxNBZYFqFfzlgBQB+NkvzLWlfJ29t70O249h4nDHZzel9s2k1f18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751922381; c=relaxed/simple;
	bh=27bHZ/4eKvwAUCagjp6sf6uz6xVWNuE4Dw+QOys8IA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VdkSq5vRR4ODJMG7BDXfQPw7vsptVOqSQ5g4tXnhTaRnMsEE/AHxDCBvSBClBoVBB2/8JAGIknnO4PPUsR9ZkHDzYd+uA7ffO/rN6m0Ni5Q/Cc1jc3PlWE56yV1qU+RDod3Ew5WvF8bayMnw+FAZxGhNdjjBMp0qnKbJbWAWM80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WT62MW0i; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so750469766b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 14:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1751922377; x=1752527177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10PSMDzHwVgV/mqQhAfZ9cWCULE5QFj3JDa6enCguHg=;
        b=WT62MW0ies0kcBDB0PTRpFCEoAwXBIjTTWx8qhR9SsnpUaIke1MxEjReXhdVq9o+dR
         Bl5t6mkaWFPPO+iKTqf3lPddMm4vxXBDeAKwHUwygpfnLoe4u3uJt5CnHV1GPF9q6lRB
         Nv4CDykOrmkWrWXonoTq4K87G0LzjOz7xLv+dFhVUUBRwwOLeTpyZ1kUSUby0TbpnSMG
         KlJXulJvqrfFfWhb5zl//5fQo2REHLDpB88Tux9taz24LS9G8bu0n76j0KrbI6bS4KDV
         YTpN66yBss5t3mQJ0HMbzSHDwW+GeyRKES9a+xWfXMthGRVXtHp+ODUl5ldEX+ynv8dI
         a1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751922377; x=1752527177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10PSMDzHwVgV/mqQhAfZ9cWCULE5QFj3JDa6enCguHg=;
        b=jkIvfBi2eFwb3FSBlyZpdNEVLq3gF/+49n549a6RdJgJ8xBtJQR87wrvvqO27G32Su
         Ah/nmsDYFWRPc1cUV0lvUH3CCPGGquKw6yJYTg8MS96d4FhV8iXNxYyjEBafrhrcl+IU
         aeomVzN6Yy+wYZ9qJjHTrwys3VENeMYN3LRx3hA/Gc4C8i+7F72PKz2/jmRjet57e5k5
         oyV6MgJnLuICZ8WkNA+CK6lYpnwjvaSRy8IS6NVPykX0+/H/n+ZPSS5w8I+vBpFYPgjK
         0JjhcrqB+gYai819A5/AG6tRYFE9osselXbIeIoXbYfDAasQ+ONSa49WhsHLhEf/aLu5
         XGoQ==
X-Gm-Message-State: AOJu0YwEwMzSVzsfOddGvC0fqwAy/BaVX2WrxDTOxqxbEHxGDRnqh1QT
	qECcjaLQLlb8CEnmmZyKe3R4C1gceK93IgTux1OnSM0YfY/jWnzA6PDnWdGFSYe/K6balsMb3Fe
	g6fCqkZRLlL+l/u6wj/umyxJxhBlotblE4HU+GxU2dA==
X-Gm-Gg: ASbGncs/hjB+oZFZAeKYRd2H+cRopK0qfmQK01f/pB84uBy2cXTFKRFcebzK5Ev3zE5
	GXiUzoDNt+enwzqwaE7gfAJOJfu2juw9iOd8MCTWDYDwwmdffUzGUvru8cK65UJbUbmBhibm522
	/3PGHgGWoruAA2qCjx7vWL4+F3NUjQzUqd4htvjsrenCZaDWWGw5wVBwWYZbRrhH+J7gcyzk8=
X-Google-Smtp-Source: AGHT+IE43oRWvMb64GujIJJWzdPLDEMjenv4v0Jum7a6AMAGjdiKsKVlgDSBcomtOCCjl6Gzq3fmh8OM1iG4AkHi16w=
X-Received: by 2002:a17:907:d583:b0:ae0:bf55:5c48 with SMTP id
 a640c23a62f3a-ae6b0048ef1mr71288366b.7.1751922377307; Mon, 07 Jul 2025
 14:06:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707172956.GF1880847@ZenIV> <CAKPOu+87UytVk_7S4L-y9We710j4Gh8HcacffwG99xUA5eGh7A@mail.gmail.com>
 <20250707180026.GG1880847@ZenIV> <CAKPOu+-QzSzUw4q18FsZFR74OJp90rs9X08gDxWnsphfwfwxoQ@mail.gmail.com>
 <20250707193115.GH1880847@ZenIV> <CAKPOu+_q7--Yfoko2F2B1WD=rnq94AduevZD1MeFW+ib94-Pxg@mail.gmail.com>
 <20250707203104.GJ1880847@ZenIV> <CAKPOu+8kLwwG4aKiArX2pKq-jroTgq0MSWW2AC1SjO-G9O_Aog@mail.gmail.com>
 <20250707204918.GK1880847@ZenIV> <CAKPOu+9qpqSSr300ZDduXRbj6dwQo8Cp2bskdS=gfehcVx-=ug@mail.gmail.com>
 <20250707205952.GL1880847@ZenIV>
In-Reply-To: <20250707205952.GL1880847@ZenIV>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 7 Jul 2025 23:06:06 +0200
X-Gm-Features: Ac12FXy6F50P4NXWOvvKplRVqEF2pMhcw6bU6vdK48DU3ApJChGmWA58w4Y44CU
Message-ID: <CAKPOu+8zjtLkjYzCCVyyC80YgekMws4vGOvnPLjvUiQ6zWaqaA@mail.gmail.com>
Subject: Re: [PATCH v3 20/21] __dentry_kill(): new locking scheme
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 10:59=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
> Umm...  Note that further in that loop we'll be actively stealing the stu=
ff from that
> shrink list that hasn't gotten to __dentry_kill().  Does your busy loop g=
o into
> if (data.victim) after the second d_walk()?  IOW, does it manage to pull =
anything out
> of that shrink list?

No, I traced this, there is never a "data.victim" because none of the
dentries has DCACHE_SHRINK_LIST. "data.found" is only ever incremented
once (per loop iteration) because a "dead" lockref was found. The
second d_walk() doesn't find anything because it doesn't look for dead
(dying) dentries. You added that check only to the first call (only to
select_collect(), but not to select_collect2()).

I think we're getting closer to the point I was trying to make :-)


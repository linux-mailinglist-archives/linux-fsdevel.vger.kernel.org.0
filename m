Return-Path: <linux-fsdevel+bounces-54186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF1EAFBDD4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 23:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1933BA499
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 21:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C2A26AA83;
	Mon,  7 Jul 2025 21:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="I1yqhyV2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613E71BF37
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 21:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751924839; cv=none; b=Tzk5J93YiBw3Zv2BoVpjMfhBi/n6WPJMP3nSpfWajJ3NSxRneBxuRFKoTT/kjI0ig2xgY4excbuBQ3EVOsH87basyMKazQIHg/cw3pcNs0B7CnLdzZRQ2/nuhrqnz7EKPJLYSItYw7IFwP+ijqiFHDhUzJK6Qpm4r9nRIyRJ9wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751924839; c=relaxed/simple;
	bh=xQDbRNfVfZv0+y11tB2EKaA8FFqA1z3RBvBPSbFeA54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GL1+GCaxLGD/DCWivskwkNaDMXaEg3oMb2MXr7xuGfzcL+Cp6G5n1Lk3rrGTFif4CooGlclXBgg8oQNO/FlJtTT5l3IIjIf/qwbCcR2GAo3/hSGrLJRosPcbCQ+5TbZcH/YSrgwKB4OkHTkc80Qms/CH1vNAPJZW1dD1aYd9D2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=I1yqhyV2; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae361e8ec32so742832766b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 14:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1751924835; x=1752529635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqRVwJSKQQY1nSLn4FD47iWJkCmPkugCmM3eGBfPGHU=;
        b=I1yqhyV2odvwzxWvpMbpf/82KvQ45JEuNCbbQnU92/4Sg/WO4WLWf+tj9nlPkN5nmH
         g9skFBVuqsk9JxuXkXalv7csXub7RmmLxHKlUWA1fTygCl0nEFWrt0Tmdskl0AYA3+CF
         JQtom/cuVXV6lCGhvYr0Y8LpuupR2QE41ZW2hFmQfiw4hw53SZzF8TnCDSJWwKRv4jkd
         sJr2EubV+Psb8NeGweUT/7BgwlIWuOQvx7mcjb16KHsL2Y8ehi7yaSxUo1JnS9eXbPsn
         XnDGznT3ulG6ofkPmXKhTXedDjVLdtE+lZ4NlnW73h/ZgUf4z/sjfNLaPj1t2/PvNu4R
         jheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751924835; x=1752529635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqRVwJSKQQY1nSLn4FD47iWJkCmPkugCmM3eGBfPGHU=;
        b=S6ZaE1U9iTaktkPC7LSsmf4lp/TxrSFs196ZKYIHKUD4RquQv1yh/9Ebk17lL+sWql
         unG28rsXGKUz7LVmKme3pppwNCKdCt3uPsPVL8cAY/Z0Q69E+3SENM/psRgbz14zu7Bn
         nZnOfiMc06dypFjirr8ECcLEvHZOsvXMLl2cemFFB1fQ/o7xLt8WQTLCf1OVa721rQwc
         dLwzIVKn2CTvdExd1LTQh0Rvt1S8Z7m7waOYANA3BsU8pjMi5JGdVD/U3Z/uRyF9wEE1
         k47oX53fQszlvSfDg/b/eLBDdiDF5oIfejeTwT3A+Nca3qqdW+mCzfqgr7xTybxjXeA0
         xvRg==
X-Gm-Message-State: AOJu0Yw66rrk89ZxjukCqhEd3gBCqNU0v5tc0vJvfIdVynczdF09CXpE
	2YxzrnAFIOfjrTsVL93CZXaRz0m5RQTl87tqmORUoW96fm/4xz27gK3MOt5+eh5O2YBnoYSkr6e
	VE0P8Zlr2VEfxBieNHxAWQzNuEcT81TsJeJk7t6+BVg==
X-Gm-Gg: ASbGncthCEw+VqwxVhLSVkF1IZDx6TQ1zdl2XdRfEzlZmO3HKlX97Rk7wi/zMSwdXW1
	ZO7qyk7Waj3QVKniWlMQGnPNCrUeziNUr6CmpqtNYzYP6eI0Y+jxosmaUvrLEmD+L5qIWY3b789
	ZWZzn/6V86UtVtqBn73yUoWBdxif6mVp084rbBhhOtXbpRt0dFWNZxHAXaJNhAFshI8bCyaHr6P
	GBaiiiTWQ==
X-Google-Smtp-Source: AGHT+IFPNoVmEcs7wAEqVmA7HP71JAVStC82SXtVhf0LshRru5Fe87brBKKj2kBthtNK6RIi+HisBFxJJ25oCTP+9Ag=
X-Received: by 2002:a17:907:3cc9:b0:ae0:da2f:dcf3 with SMTP id
 a640c23a62f3a-ae6b0ef437fmr55035866b.59.1751924835558; Mon, 07 Jul 2025
 14:47:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707180026.GG1880847@ZenIV> <CAKPOu+-QzSzUw4q18FsZFR74OJp90rs9X08gDxWnsphfwfwxoQ@mail.gmail.com>
 <20250707193115.GH1880847@ZenIV> <CAKPOu+_q7--Yfoko2F2B1WD=rnq94AduevZD1MeFW+ib94-Pxg@mail.gmail.com>
 <20250707203104.GJ1880847@ZenIV> <CAKPOu+8kLwwG4aKiArX2pKq-jroTgq0MSWW2AC1SjO-G9O_Aog@mail.gmail.com>
 <20250707204918.GK1880847@ZenIV> <CAKPOu+9qpqSSr300ZDduXRbj6dwQo8Cp2bskdS=gfehcVx-=ug@mail.gmail.com>
 <20250707205952.GL1880847@ZenIV> <CAKPOu+8zjtLkjYzCCVyyC80YgekMws4vGOvnPLjvUiQ6zWaqaA@mail.gmail.com>
 <20250707213214.GM1880847@ZenIV>
In-Reply-To: <20250707213214.GM1880847@ZenIV>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 7 Jul 2025 23:47:04 +0200
X-Gm-Features: Ac12FXzyHE2ANbrRtR4qKsoA3RappyPKFiS-DEojD2-bZWUpdKSvG5cpmZY2wDo
Message-ID: <CAKPOu+-JxtBnjxiLDXWFNQrD=4dR_KtJbvEdNEzJA33ZqKGuAw@mail.gmail.com>
Subject: Re: [PATCH v3 20/21] __dentry_kill(): new locking scheme
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 11:32=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
> The second d_walk() does not have the if (!data.found) break; after it.
> So if your point is that we should ignore these and bail out as soon as w=
e
> reach that state, we are not getting any closer to it.

Not quite. My point is that you shouldn't be busy-waiting. And
whatever it is that leads to busy-waiting, it should be fixed

I don't know how the dcache works, and whatever solution I suggest,
it's not well-founded. I still don't even know why you added that "<0"
check.

> The second d_walk() is specifically about the stuff already in some other
> thread's shrink list.  If it finds more than that, all the better, but th=
e
> primary goal is to make some progress in case if there's something in
> another thread's shrink list they are yet to get around to evicting.
>
> Again, what would you have it do?  The requirement is to take out everyth=
ing
> that has no busy descendents.

A descendant that is dying (i.e. d_lockref.count<0 but still linked in
its parent because Ceph is waiting for an I/O completion), is that
"busy" or "not busy"? What was your idea of handling such a dentry
when you wrote this patch?

> BTW, is that the same dentry all along in your reproducer?  Or does it sw=
itch
> to a different dentry after a while?

I'm hunting a Ceph bug that causes I/O completion wait to never finish
while reconnecting to the Ceph MDS, therefore it's always the same
dentry. But that's only an extreme example - the general problem with
busy looping in the dentry cache is always there, even when the
request finishes after a few milliseconds - that means you'll be
busy-waiting for these milliseconds, which is still a bad idea. It
wastes CPU cycles for no reason and drains the battery / accelerates
climate change.


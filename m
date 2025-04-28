Return-Path: <linux-fsdevel+bounces-47480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAE0A9E670
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 05:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7F697A26C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 03:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBF41940A1;
	Mon, 28 Apr 2025 03:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PEIBo2nv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BEC155389
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 03:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745810208; cv=none; b=iwv6NVH/k+v2oXN6DWrJXRLRPo0lz57SSbUSeXAo8nqt7SuqWwYsw4APqNVYaB+cBzuT4TjfFucnp0qMFWIBkW7l5juAXUUH2eUmgN4BJTWZp9EsjKWwVc20JK1xVbYd2uOZbWFx46ovv3ktXSE1YpWf5IhOXY6ImuIsTmEvGkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745810208; c=relaxed/simple;
	bh=bo4XRnmv/C9CPBRc+eOmyFUi6OPxRNkntH1IlX/FEsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kE6eAJrc8AU9onG6klnlpy7JecBjGI+r7Tqz10Pcvt2Swu9G0i0UTOCiVUrWDYDI5jFXrZwaMdhdimeu/otRhUv9TfTeVymx4zRYkn49RZPotfgsHTmud+2OEygitBVJcb3J3hhchoIHM1K9wHHWSQqQQ4aLiSJsQiHUS4QtDbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PEIBo2nv; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e677f59438so6349080a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Apr 2025 20:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1745810203; x=1746415003; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t0e7nP3hjcaqKwc01vRHOmUcHsrAvpBqvUnI+4uZsG0=;
        b=PEIBo2nvRF6oFabH4hrt65iJCDuMZY768lQo7dWPPbeS6VP/E+xYsmt2TK1oUbnvlR
         Q/A8hjwE9ylUZNRnd0hB81TRi0bU2lHvLFPP7miV+SYR0OI4X4OuRfsyHAZirosrX/sR
         vnHMCZH8k4NXCzQBvIbyYnoBBXB8EATt4TUTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745810203; x=1746415003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0e7nP3hjcaqKwc01vRHOmUcHsrAvpBqvUnI+4uZsG0=;
        b=tcg7hmp7zJ6Hq/s0KGDhgP57SNxW6Fc6kv6X6kgAxIV1at4snCPV2RtAp8VTqmg7UB
         gUzQwbow74Cv8CMdlyurRSXQcoy5vl64ATyud8F6tr+tgfatmWC2b4e0bglMOLciHmE6
         IU9voGjBCLNry1MRBvb5Oh84N4hpScNaUnWBAqYMxXz+e3E4VnaxVC9XdlAqq6ZdkLJi
         7edUuiSjG6J+ZoIKgtM8zIQrZNfEn+deqS8mLqyGmkh18AsCWiQ+Qwfz9g0NBYGksjZs
         deWL981aAO1BJdBNQMXhav6cs3bQWdReYTusiTtaNYhtbIWK3fhfjKNixaAASFSTcD93
         FxFg==
X-Forwarded-Encrypted: i=1; AJvYcCWRgrRfYDx4FULR+R6lhKWIvG898N+lYDzCAm2mWXvQevdgBGGPqQf1CZlOU0pUX5z320ec19zGUkEBr+KZ@vger.kernel.org
X-Gm-Message-State: AOJu0YznBMcGWh9PYvd7SoCFHhJvEtJTYGShGoaM6TaCws1bRRKT/Qca
	XnLmqZtdFNFZi3Z8lvPueN+YZtqs3atYufTyghUCisU/tiUdANN012yhAfcYX7yrxedz8wtEtLV
	PXCA=
X-Gm-Gg: ASbGnct38iTqbPGllLm5c0tASW6ifs6RqzhAs8T2FTGMIr65844JgoQN2snAVxJLO2L
	21u2qWquQsAocTYV5hIYO0uDwmmPL7QZzs74LqdkoLC54PcDae18spR5e/YJ2IY+/OSMggKkEsP
	MQxeVEuNVGgDE7jhBr/mxlJ7wBPAphLatYUqX15DGqtIXU8+/LnhsJRbLAJjDeDMqHyeVbpedko
	duPV9uanaXErRRoamOaXr121EsmrLlM9bEAbnXA+EKzhweR31GcPpEEv5INMD69nKD3AHfGGy91
	8GLDnoxs4YcbFyJ4KJ8oms2n41tPBkup44xBCtH7urb6d5O/e/MRIzjuxvDYmrS7r/i1ljmH8P/
	kkxjFL5620zUNuO+fh/xdU+4rkw==
X-Google-Smtp-Source: AGHT+IGFvzYpagn24j9gjsMiKmKXYF7WmHs3hmOlBuRcCm4DalDjOGb5InoA5DFs9FuHZYniObAo4A==
X-Received: by 2002:a17:906:6a0b:b0:acb:8a27:2727 with SMTP id a640c23a62f3a-ace711652f7mr936787866b.33.1745810203457;
        Sun, 27 Apr 2025 20:16:43 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ecf7397sm552815366b.92.2025.04.27.20.16.42
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Apr 2025 20:16:42 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2bdea5a38so612094466b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Apr 2025 20:16:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUtv4JfKjcCNtwZ35nn2rpF2ygD/j4WXVokYVwGeemOWXu3iYg3UQup5Lpz2tXb5HJUxf6fv65fgfB8+Xzp@vger.kernel.org
X-Received: by 2002:a17:907:1b22:b0:acb:6746:8769 with SMTP id
 a640c23a62f3a-ace71098d77mr1016463866b.18.1745810202119; Sun, 27 Apr 2025
 20:16:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
 <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>
 <aAvlM1G1k94kvCs9@casper.infradead.org> <ahdxc464lydwmyqugl472r3orhrj5dasevw5f6edsdhj3dm6zc@lolmht6hpi6t>
 <20250428013059.GA6134@sol.localdomain> <ytjddsxe5uy4swchkn2hh56lwqegv6hinmlmipq3xxinqzkjnd@cpdw4thi3fqq>
 <5ea8aeb1-3760-4d00-baac-a81a4c4c3986@froggi.es> <20250428022240.GC6134@sol.localdomain>
 <CAHk-=wjGC=QF0PoqUBTo9+qW_hEGLcgb2ZHyt9V8xo5pvtj3Ew@mail.gmail.com> <yarkxhxub75z3vj47cidpe4vfk5b6cdx5mip2ummgyi6v6z4eg@rnfiud3fonxs>
In-Reply-To: <yarkxhxub75z3vj47cidpe4vfk5b6cdx5mip2ummgyi6v6z4eg@rnfiud3fonxs>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 27 Apr 2025 20:16:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjib+vjy9R69+gSC7socoA2tD72vAYk6JFqZ-+4BBFeNw@mail.gmail.com>
X-Gm-Features: ATxdqUFmSSiIZ5FtR5ZekGeIsPhc_hAWXu7IuqzkCaCNgzlj8JjW49lq9NjLN_I
Message-ID: <CAHk-=wjib+vjy9R69+gSC7socoA2tD72vAYk6JFqZ-+4BBFeNw@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Eric Biggers <ebiggers@kernel.org>, Autumn Ashton <misyl@froggi.es>, 
	Matthew Wilcox <willy@infradead.org>, "Theodore Ts'o" <tytso@mit.edu>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 27 Apr 2025 at 20:01, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> I'm having trouble finding anything authoritative, but what I'm seeing
> indicates that NTFS does do Unicode casefolding (and their own
> incompatible version, at that).

I think it's effectively a fixed table, yes.

I've never actually used NT. Back in the DOS days, you could set the
codepage on your medium, and people did. And it did cause problems,
but they were pretty rare.

People in non-US locales tended to learn to not rely on local case
folding rules for the local odd characters.

[ And I don't know if the Finnish situation was typical, but we
actually had a *7-bit* version of Finnish characters, which meant that
there were special case folding rules where '{' was the lowercase
version of '['. I know, that sounds insane, but there you are.

  Those rules never extended to the filesystem, though, but they
showed up in editors etc ]

> I'm becoming more and more convinced that I want more separation between
> casefolded lookups and non casefolded lookups, the potential for
> casefolding rule changes to break case-sensitive lookups is just bad.

Yeah. The problem is that it's just *hard*.

So when I am made Emperor and Grand Poo-Bah, I will solve all these
problems by just making case folding illegal.

But until that time, I really wish that people would at least try to
actively minimize the damage.

It would be interesting to hear from the Wine people (and Android
people) what the minimal set of case folding would be.

Because I really do suspect that there may not be any actual steam
games that rely on *anything* else than just A-Z.

That case really is much simpler to handle. You can do some really
cheap things like saying "for hashing filenames, I will just ignore
bit #5".

Of course, for *existing* setups, we're kind of screwed. The "two
different versions of the heart emoji" was from a real case,
apparently. Because those filesystems had already encoded the overly
complex rules in their hashes.

               Linus


Return-Path: <linux-fsdevel+bounces-12155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A15A685BD18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 14:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0F51F237DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 13:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFB16A32A;
	Tue, 20 Feb 2024 13:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2+kYIfsF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337EE6A035
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 13:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708435343; cv=none; b=qrnna86Kiu1KMBukT6rcCZdUMR+edWrNG888FSCkqORIiWeoKy/X20WzMPZ8H4YXjq5MOL2QDMksX1m+upRag9A0iDaHNYlCO4gq+e7LUN3iKVFr4/b9GdRDNoyLQKlRW686N5UNmb95MXTJqiXFaQIj/70f/lsnw2oYM6qxQdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708435343; c=relaxed/simple;
	bh=o0xRepjUnYiSiEcYPL2K6bmUQMgSoJTcVGYeumgAp/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvoBUcbeIRem9W/jNAwQlf9ApJiHvlKKPfzNApGR/cH/ycGS1jFsrRuluocJ5lVV6dIPF19wCuGNwBXI1CpDptmJ445pl1Qxd3jtV+HsUft1emnqc6r+Tox3uDrh72AxQt5LdEKY5DgwsYXW648rpF5SZSHGWNpdlHfZ84v5LFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2+kYIfsF; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3e82664d53so284679866b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 05:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708435339; x=1709040139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8B/NFmfqoyBPMsxDp+WDF9UL3KyYLkhiqUPY5SMyjdk=;
        b=2+kYIfsF27rP5ohy2mglzr5xpGQjrJldBXpy3iaga8hoSPwRlLauuSxmJucYGb/1V2
         kVpbJyrqjUTbfnxXGgR7KdY3wd0sV8boZeo4znqW/kKtceVIVbJuAfraAB3P6YZ8969O
         1XQlDRTjhX3wpGPzMuuB4Bke1QqKtQ/9L36M1u1fEZaIGD7VpkZn3Wjw6ToXlj7741Hn
         76dV5iA22SB2tQKtD5+7nU03+0ftmmsBst6x2PliKCgC4cqNpGcDYlEBzO4AJHJ8C9rz
         Vcqz55YPsuFmonhSzTRhSY+TKXStKzwCneoIgSlH8JdtJeiGdzpkmtMLnYUpGYS8Vo9b
         1Buw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708435339; x=1709040139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8B/NFmfqoyBPMsxDp+WDF9UL3KyYLkhiqUPY5SMyjdk=;
        b=piFpG7oAfWxKgzRhU4kBb/lpjhoLt3bxmChvSVAT5waLgI75tSJV4H54Dtt47Eg9bJ
         MoC1+KSHIGUbRelGpBuHV83dNKsXRaIsTTgen90HKE1u11a0xGqxiB28/AgVvzHqU1hX
         mn5xBmfo2ShPnunTNJObsKyFt+pOocG4P55tKaltk6oYeliHY9n6gD/FRT/J5EVDugH3
         BBYen5aYozBeaBb1ksYYqQN6Ut/strp7e3lSIUmsw9oPLmBpoLrLLOZQ9ridzr4ZZGAk
         HC18R8Kb6tLag+h+nknvH0Cz4Tw4AkzMoVVql4XPckHA3fooqFsDeSrdELOqmv9Tqj24
         Wo0A==
X-Forwarded-Encrypted: i=1; AJvYcCUAHpqXLN20jE1helqeu253AVfz6wdp9hgnLKQ7sXrbSPQdoI8mWgQLJRCi4F3blMX+36RRrmrfv/pIMwbMJuyrXsNIAcaZeOV7geNLww==
X-Gm-Message-State: AOJu0YypjQfTg5HCEpPix/MSe2gLAxBTslC9QhTXzM00A9zbsykGOoZf
	806DwPidirW/1zR1aPYglbK0EEz6sMkZZs893AyCFNIoKWawWJ+L4WE9lKJBgw==
X-Google-Smtp-Source: AGHT+IHM3r3mCpqoJIGBtRxw3x+74bF8MV4e++ZPwM7Qrin9FZU1JhFz8hSgTSqkyBRbGZNjFvQzXw==
X-Received: by 2002:a17:906:7f92:b0:a3e:6465:4195 with SMTP id f18-20020a1709067f9200b00a3e64654195mr4181663ejr.63.1708435339303;
        Tue, 20 Feb 2024 05:22:19 -0800 (PST)
Received: from google.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id y13-20020a170906470d00b00a3ec0600ddasm1539091ejq.148.2024.02.20.05.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 05:22:18 -0800 (PST)
Date: Tue, 20 Feb 2024 13:22:14 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	kpsingh@google.com, jannh@google.com, jolsa@kernel.org,
	daniel@iogearbox.net, linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH bpf-next 01/11] bpf: make bpf_d_path() helper use
 probe-read semantics
Message-ID: <ZdSnhqkO_JbRP5lO@google.com>
References: <cover.1708377880.git.mattbobrowski@google.com>
 <5643840bd57d0c2345635552ae228dfb2ed3428c.1708377880.git.mattbobrowski@google.com>
 <20240220-erstochen-notwehr-755dbd0a02b3@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-erstochen-notwehr-755dbd0a02b3@brauner>

On Tue, Feb 20, 2024 at 10:48:10AM +0100, Christian Brauner wrote:
> On Tue, Feb 20, 2024 at 09:27:23AM +0000, Matt Bobrowski wrote:
> > There has now been several reported instances [0, 1, 2] where the
> > usage of the BPF helper bpf_d_path() has led to some form of memory
> > corruption issue.
> > 
> > The fundamental reason behind why we repeatedly see bpf_d_path() being
> > susceptible to such memory corruption issues is because it only
> > enforces ARG_PTR_TO_BTF_ID constraints onto it's struct path
> > argument. This essentially means that it only requires an in-kernel
> > pointer of type struct path to be provided to it. Depending on the
> > underlying context and where the supplied struct path was obtained
> > from and when, depends on whether the struct path is fully intact or
> > not when calling bpf_d_path(). It's certainly possible to call
> > bpf_d_path() and subsequently d_path() from contexts where the
> > supplied struct path to bpf_d_path() has already started being torn
> > down by __fput() and such. An example of this is perfectly illustrated
> > in [0].
> > 
> > Moving forward, we simply cannot enforce KF_TRUSTED_ARGS semantics
> > onto struct path of bpf_d_path(), as this approach would presumably
> > lead to some pretty wide scale and highly undesirable BPF program
> > breakage. To avoid breaking any pre-existing BPF program that is
> > dependent on bpf_d_path(), I propose that we take a different path and
> > re-implement an incredibly minimalistic and bare bone version of
> > d_path() which is entirely backed by kernel probe-read semantics. IOW,
> > a version of d_path() that is backed by
> > copy_from_kernel_nofault(). This ensures that any reads performed
> > against the supplied struct path to bpf_d_path() which may end up
> > faulting for whatever reason end up being gracefully handled and fixed
> > up.
> > 
> > The caveats with such an approach is that we can't fully uphold all of
> > d_path()'s path resolution capabilities. Resolving a path which is
> > comprised of a dentry that make use of dynamic names via isn't
> > possible as we can't enforce probe-read semantics onto indirect
> > function calls performed via d_op as they're implementation
> > dependent. For such cases, we just return -EOPNOTSUPP. This might be a
> > little surprising to some users, especially those that are interested
> > in resolving paths that involve a dentry that resides on some
> > non-mountable pseudo-filesystem, being pipefs/sockfs/nsfs, but it's
> > arguably better than enforcing KF_TRUSTED_ARGS onto bpf_d_path() and
> > causing an unnecessary shemozzle for users. Additionally, we don't
> 
> NAK. We're not going to add a semi-functional reimplementation of
> d_path() for bpf. This relied on VFS internals and guarantees that were
> never given. Restrict it to KF_TRUSTED_ARGS as it was suggested when
> this originally came up or fix it another way. But we're not adding a
> bunch of kfuncs to even more sensitive VFS machinery and then build a
> d_path() clone just so we can retroactively justify broken behavior.

OK, I agree, having a semi-functional re-implementation of d_path() is
indeed suboptimal. However, also understand that slapping the
KF_TRUSTED_ARGS constraint onto the pre-existing BPF helper
bpf_d_path() would outright break a lot of BPF programs out there, so
I can't see how taht would be an acceptable approach moving forward
here either.

Let's say that we decided to leave the pre-existing bpf_d_path()
implementation as is, accepting that it is fundamentally succeptible
to memory corruption issues, are you saying that you're also not for
adding the KF_TRUSTED_ARGS d_path() variant as I've done so here
[0]. Or, is it the other supporting reference counting based BPF
kfuncs [1, 2] that have irked you and aren't supportive of either?

[0] https://lore.kernel.org/bpf/20240220-erstochen-notwehr-755dbd0a02b3@brauner/T/#m542b86991b257cf9612406f1cc4d5692bcb75da8
[1] https://lore.kernel.org/bpf/20240220-erstochen-notwehr-755dbd0a02b3@brauner/T/#mc2aaadbe17490aeb1dde09071629b0b2a87d7436
[2] https://lore.kernel.org/bpf/20240220-erstochen-notwehr-755dbd0a02b3@brauner/T/#m07fa7a0c03af530d2ab3c4ef25c377b1d6ef17f8

/M


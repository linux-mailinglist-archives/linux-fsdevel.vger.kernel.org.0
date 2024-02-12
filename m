Return-Path: <linux-fsdevel+bounces-11128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71888851894
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 17:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597481C21FEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 16:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8333D0B6;
	Mon, 12 Feb 2024 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Akz1t5R0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0949F3CF72;
	Mon, 12 Feb 2024 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707753647; cv=none; b=L81FNAdMQdXzHVIx01z4eKREh9oqv2ikNyuK8eW/IFMMqC05YYHLD0yfsjb1breV7g3oN2BhNctuSVD7qCA9/rOBWc/lIWTkPU3YFc5oMpgTJ+fUERnuJZ6xGth1NYRmC5jJBxQYQd3em0glrRMiwntaEQNz3anchU4flfbuBK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707753647; c=relaxed/simple;
	bh=m4d+0unINKl4tk2+p/lo5cqI8u+m5SoJ2O9SqUlpjTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRgfCs8q2HZkPQ+FvBNExFLqNrUhoVExcxHc3fx8KX8YFSf2VaIAgn3dEyWgr4pAuddACBMltzRyWaUq0u+BpemxStsS3f1+vS1SU/YIMMyjuxS1aJIkjL/PC/c8A0O/5z9foNAIPM1uNdgXres9VEH594EbQFgZaP+rqgrY1iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Akz1t5R0; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-783f553fdabso232853885a.0;
        Mon, 12 Feb 2024 08:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707753645; x=1708358445; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ts9JKQjzC/NxAzYOh4VItjpOni9YdKKmqYr+RzhZOeo=;
        b=Akz1t5R0puubKDCQ6+VKTa17JRuVmVA3Qd+Nx5j2zttO2trMLPX345FKB+COf/BQY4
         dMhCVWklhbK6TZzDnYe/zkyrrOokilXalrgzDtLyOlcOn9DC9TUDUJBWn1RhJTYMaDAP
         JjgoPGqImbdxxwqA3DIyqZH9xc2BXeydyOfWXmia93tcakYMD6OrswsWoEztfHgz5yYX
         OiBp1VdDjeLd8jXEv06UiCvPGRBfi0z20LvloQUvUj6a7VErzwFfahv4Lk1v2GYR/NyC
         jg/NNZAnytJ65naFcJLaftqoFamSB+0Y8mpN4GiClIxOvGBZA0NT2ZUtWNDzfXzPms8W
         sw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707753645; x=1708358445;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ts9JKQjzC/NxAzYOh4VItjpOni9YdKKmqYr+RzhZOeo=;
        b=t8eaVEXWXDmiW8E1J2p1rr3PipYMEO90KgVWsRETH9MK9ZFh1V/Q8KOO3717Z8DNZb
         lSNyIHwsJfihC8G3mKZ0RVQZTlmx+CPdrGwwe1AyXlTpctxp2jpNly396NU0hH7qZ8GA
         dgWod6ziabFdvw5stA2UAz4E+l4n7exfgLIeCqwNB5/3hhdKb8Azc/GzZiuVxrLVPUeE
         UQSu30J5NONiy24dqTLa1M6Bkh0bE8vONez8GHQ40cvDB4ZizVJnf5v3toGmxpspLGF5
         hvlahNHussn6jgFjXXWQGO4z29H48HErrpt+n2OcI3IXgRBxlOIOOkDX3C3nFrxPZmj8
         JOGw==
X-Forwarded-Encrypted: i=1; AJvYcCUTVHHlc4AR++eDElmWjFtZsTeotmdl+B4nQY34vCvbC771OgXymwEKABDXK/lT3dj67x7PjefuFaIxcdUWWDjsjBGrD+L3BF9BDl0Q6sP8xy4MC50uIBC4weqKvIOiG9koX8D41gCr6V24bjaN9i8VvaCbjDn8El5OIwUedXxT/shAIRdQ6d4pOuQB
X-Gm-Message-State: AOJu0Yw050HYUMSy0R4iPXeAqx5jk4SfCV7DZqS7kVLoWr12jNmNyOrh
	+6h7xzHuq26hlPcYU1HxOGeXQoNa0JSj8Ri5H1ZIml91QnSvdGOz
X-Google-Smtp-Source: AGHT+IFG75rJ3qu/2phQU9bvEloW8fxWWnmgNbGRO3LvRqh5KDM4vCwGKyXLKTVtoc7EyRJX6bu3pA==
X-Received: by 2002:ae9:e913:0:b0:785:b078:c509 with SMTP id x19-20020ae9e913000000b00785b078c509mr13088072qkf.22.1707753644775;
        Mon, 12 Feb 2024 08:00:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX36IW/4fuSd+P5VhVTxCQpup5ZpOfCa80EwhqDBZRSwy24HBcrTcF81yjtcM3KzkigGmkq7eInD7ockprdNTGeMD315tIr1jIL2GBcWYB9a8SzXl5+RoA+Ix7ZvPGCC9Z/JUrsXX6Cerf7vBk1US7bj0m1rIpzT0WBGJstRKNWy3Iu6DXwZF2fUXDDlKSegszJr+nXMUYa3/zecbAPw7+7iG3u2ghchIrQuYa/3m8GJOd6wS0ARep5TPYYYk2xWz6iG0RDT/AYx0cyX+ldw1aU2ASCzbjM1kHooa+fTtVg5SI+v1b/CG7gJQAwrOJyDCvCIogDL4rlrXcAobCFUPc5GTY0+QNIIotEoSnUq3lXhh+m2tK+o6Bwok24OP5nWCeQypkVk978yJ0M+Dw6ALvGEqe08c067E0lD0gJH036NQ2Aj02l7Z/vJnO6oRZ9uzXqIwvZ5LOtc1z3F5c7ARJZyiY0Q94a20brWUSnoft6Nc5/6A8W9xd8TgRToHW0Z7ldvMyQPsH3XdDQlL0Yumt1zteUias5X3NOyBTV1XelEesAPuVonTPg0eGB/MYz+nq8i8BrgiOFpc8QK73ly3k/qNUNQGbo8r4XyWkNlycObJOzJDqji1s2/tUp8SOJtjLoDDheHNq+84jA+mwY/nBLUGxEapfVreD+11g1akTIpgUEISKgdDcIu/znfM0leVvZuwvukukjMwiJhLS0VMoAmdEAJPooGDUrIq9nudtwcF9sAlcHzNR5yOgK6HgLX2a/XAYNhjXhSO70k7XgyWa15dKIkkKsbeNmXUrXkoMEGxiChIgtLMxa+NBU57GDbkngLy9MheTrCBoleh8Pjc8+EFf17wYHknPx
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id x7-20020a05620a0ec700b00783feb25669sm2131418qkm.116.2024.02.12.08.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 08:00:44 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 94C0C1200066;
	Mon, 12 Feb 2024 11:00:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 12 Feb 2024 11:00:42 -0500
X-ME-Sender: <xms:qEDKZS-jzw5pQvII0yTr75u-LSeHmwye1_a9NqRHq62wXTQfOXxuFA>
    <xme:qEDKZSvRTlQO8rQh2j-vJ6rYcbj95FsfYzIPJpg_zuzYCBVAsJKjoUOq5U740JGb6
    wAxvbp8d2qasQH-3w>
X-ME-Received: <xmr:qEDKZYAJgMoK-k-mrzbIiC0tUeGQQ6TkV8YYTb6anlabZnCmSq1eOIdp-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeevgffhueevkedutefgveduuedujeefledthffgheegkeekiefgudekhffg
    geelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:qEDKZad38Ec6qGEyWp7zCF3LJSx4u4SodMZuL1vik1iBX7pOxq83MA>
    <xmx:qEDKZXPAGgkRAQqhZoxJqwBVoCBO-NsRR0Fl9VtfzBHhV7iWWg6UhQ>
    <xmx:qEDKZUnfNY5vCJxZKLzHYF5dPNzeKuVKalkFF_qd5n1uCm9F7qPmKw>
    <xmx:qkDKZUaMHq7SMqte9n48ebWsvLbisFiaAoDZtKskpXlBxwBvmr4omX3ygi0>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Feb 2024 11:00:40 -0500 (EST)
Date: Mon, 12 Feb 2024 08:00:38 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Trevor Gross <tmgross@umich.edu>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Kees Cook <keescook@chromium.org>,	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v5 7/9] rust: file: add `Kuid` wrapper
Message-ID: <ZcpApgAK8CI3HsE2@Boquns-Mac-mini.home>
References: <20240209-alice-file-v5-0-a37886783025@google.com>
 <20240209-alice-file-v5-7-a37886783025@google.com>
 <CALNs47tTTbWL3T9rk_ismPT0Bwi8Kcm5aT9k8jfPsh=1wKvrPA@mail.gmail.com>
 <CAH5fLgj8u925_5qW3n7OBd3tPxxdy4=BR=yWvzhyLN6TT6M+dQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgj8u925_5qW3n7OBd3tPxxdy4=BR=yWvzhyLN6TT6M+dQ@mail.gmail.com>

On Mon, Feb 12, 2024 at 11:04:47AM +0100, Alice Ryhl wrote:
> On Sat, Feb 10, 2024 at 8:43 AM Trevor Gross <tmgross@umich.edu> wrote:
> >
> > On Fri, Feb 9, 2024 at 5:22 AM Alice Ryhl <aliceryhl@google.com> wrote:
> > >
> > > Of course, once a wrapper for rcu_read_lock is available, it is
> > > preferable to use that over either of the two above approaches.
> >
> > Is this worth a FIXME?
> 
> Shrug. I think a patch to introduce rcu_read_lock would go through the
> helpers as a matter of course either way. But it also doesn't hurt.
> 

Right. And if I understand correctly, we actually need more than RCU
wrappers to "improve" the cases here: we also need the RCU interface to
be inline, plus the extra maintainship of Rust version of kuids getters.
These are all outside the scope of this patchset, and we may need to
revisit later.

The commit log here basically says: what's done in the patch is OK and
probably the best way to proceed. I think it's fine.

Regards,
Boqun

> Alice


Return-Path: <linux-fsdevel+bounces-75536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WL0fIInSd2mFlwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 21:46:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CDA8D3F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 21:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 073C23058394
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 20:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251EB2D7DF3;
	Mon, 26 Jan 2026 20:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="PXJ9VFxS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A932D77E5
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 20:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769460209; cv=none; b=gFfc273DU33QCw647KuXUXRdzwX1HGKuKG6CHrPiud/j+EaO5rA4VH93a+nJsn1AdMDgS+DX+85XTQh2PZNkFCK5SUEAS+TdLnUFmF6ZPemw+z9OWtLLjG3/gLbVG8bl0EUdNyRUdxhoCCgFD3qbnAiShkeu+UfiXOfWETxQyYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769460209; c=relaxed/simple;
	bh=2ImvZniPDzFetnyqCWbg0zblKqhE8c/sMpTgsU+ZG+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2PyxwHqRM+bQt3IhAib14fiHV5Y8yNR+6EsYttgGsDrsydPeUlAri8F68a6fWmGtLRu9/FXpPYlA9C0YffkDegqIzoC0g7d8RbvXPlkPNiClzcPT8V48Yt0DVYsfzhofL7ISmVeMRIsz4dgAD+Kq2O46+INS7WYLQBjxJAZn5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=PXJ9VFxS; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2b70abe3417so11178389eec.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 12:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1769460207; x=1770065007; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s0UipC5QHyJnTmDWXctjUpxhkNyTA6jh9RjXD3Q3T9M=;
        b=PXJ9VFxSjyN7jT6HpQvw3Be1870o/akPKIBYteU+9y4pc4JKWkWSlVVZJG9svjhYaO
         QNQltekxPSEKZz3E8CCa0xhAMOBANuOOR/9BQ7se9cqNTA73kBz6rwlKM3hKE6P3o8jP
         /2pNwK3HcvKn9B8LBxYSHqfcHaOS/aDi2D0wf2orHCgBR2VymuZRj31zkzLDvv2MTTBI
         fBk0YnCYiSx2YDhTvdcnPzdGpjep8uf7u/PBeVG76moqqJ+7dkV5G6nBf/UugVGQ21el
         FGLUeoqcTFBfToCiDMTM5w7Fu+FbZczcDLz51FQymVRGNfcQKrw6r3aMskOgYdoHfwKy
         0peQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769460207; x=1770065007;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0UipC5QHyJnTmDWXctjUpxhkNyTA6jh9RjXD3Q3T9M=;
        b=WNSmq1pK8BKPPgkQweOAuX2EMQwECoFYfFudKca97n7N6nxgTF8EjTl216xvwbYFhW
         DimkKoBorVI3mYaJ9hEzagLN5d7wT/dHuYDaH4ROcYMC5p6pLCnIyrLW7DB4GYdktdou
         7omZaiIT0CddNQDjfSd+F/tIXuqNFvnZLiVOPDF8Fh93Jh5MimjweoUkQElLspWxO2Nq
         KFWk9+XP/a/6K/bxs/aKj3tfaOA7VVNXUFSFKW4xuFX09aNVeafG+KCYELQCObVpKPs9
         PjZjeYhIcFqcFyXhV4KS0yKdDmllFWSinM1EuMg10ypOcqs0HGWX7cJnpC7nti8yUgoh
         WQYA==
X-Forwarded-Encrypted: i=1; AJvYcCUW4y6Ba7E0Wyn5jPx4Vp6CQMrz2hYfLO3S6HQvNB08NZ63b7XbnC2Fg2NalIDfiYHsNxo9m6rEkpXYLckK@vger.kernel.org
X-Gm-Message-State: AOJu0YwAEDEyBEY9oP3UacevcMiByyTctZ6+mV0BWMTJG6ULgwuX56y5
	CVyHzwx9VyxoIWbbI06Wyda1a9JVUJrPHxosFvQ7soyfLPwH0n8zSJuGmJpVKaG08vQ=
X-Gm-Gg: AZuq6aJUjtlSw2+eEzkqi9oghMMjSuqDaEa0ZWDklIAyqiKoicNBk7rqDxaBf+1pVIo
	zswjjF/d/3o0cvqo580giuYh9OgV5B6ctB+jWxuBxRcA4pmdz+lsv/M077h/gPcqOyWl6tRMSSp
	Kv5t+CT23siJ4T1d/feB6rE2kbBlnCNj+vHesJ8v5q3S4Et/GXKyP1Wft9css9Oh0GvvuIbwqiB
	zFPm1ZPWOVv6wJLTzbj8hPnGiqWjDeptTF4S3MPCyaH0vbpJ2KD62Zc2RGhBzpL7vFtXJeaH5ZZ
	3zcDyQ7CdIM4FrO2+GxQQ6xalpg6jk1camCpQebXBCodBTSV3AedTI1uHiolp8kpbNC5mYmDRTH
	q1QX01mdLZyqKuFRUAm20EB4RM2ljlh10VLLSIO4ChqQS68bm9cCCl5pIgeytBIHqNUXBaYbazD
	QQE7QOjHoEht8+8eO+o00U
X-Received: by 2002:a05:7301:d16:b0:2af:7ee:5300 with SMTP id 5a478bee46e88-2b7643466e8mr2954218eec.14.1769460207055;
        Mon, 26 Jan 2026 12:43:27 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73aa08964sm14741354eec.28.2026.01.26.12.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 12:43:26 -0800 (PST)
Date: Mon, 26 Jan 2026 12:43:24 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Zong Li <zong.li@sifive.com>
Cc: Paul Walmsley <pjw@kernel.org>, x86@kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com,
	richard.henderson@linaro.org, jim.shu@sifive.com,
	Andy Chiu <andybnac@gmail.com>, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org,
	Andreas Korb <andreas.korb@aisec.fraunhofer.de>,
	Valentin Haudiquet <valentin.haudiquet@canonical.com>,
	Charles Mirabile <cmirabil@redhat.com>,
	Jesse Huang <jesse.huang@sifive.com>
Subject: Re: [PATCH v26 00/28] riscv control-flow integrity for usermode
Message-ID: <aXfR7NhAxHlND3z9@debug.ba.rivosinc.com>
References: <20251211-v5_user_cfi_series-v26-0-f0f419e81ac0@rivosinc.com>
 <e052745b-6bf0-c2a3-21b2-5ecd8b04ec70@kernel.org>
 <aTxf7IGlkGLgHgI2@debug.ba.rivosinc.com>
 <CAKC1njQ-hS+kUJ0C_v0oqZW1EZw2zAXMp-SnnA-ZXh_H-SoVdQ@mail.gmail.com>
 <CANXhq0rpjSvOThACrB6_MMc8S34--xJsUYZ+HtMu1GUNyk8zOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXhq0rpjSvOThACrB6_MMc8S34--xJsUYZ+HtMu1GUNyk8zOg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rivosinc.com,none];
	R_DKIM_ALLOW(-0.20)[rivosinc.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[rivosinc.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,sifive.com,dabbelt.com,eecs.berkeley.edu,arndb.de,infradead.org,redhat.com,xmission.com,lwn.net,google.com,gmail.com,garyguo.net,protonmail.com,umich.edu,vger.kernel.org,kvack.org,lists.infradead.org,wdc.com,linaro.org,rivosinc.com,intel.com,aisec.fraunhofer.de,canonical.com];
	TAGGED_FROM(0.00)[bounces-75536-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[debug@rivosinc.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[54];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[debug.ba.rivosinc.com:mid,rivosinc.com:email,rivosinc.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07CDA8D3F3
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 09:32:20AM +0800, Zong Li wrote:
>On Thu, Jan 8, 2026 at 11:10 PM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> Hi Paul,
>>
>> I have a bugfix for a bug reported by Jesse Huang (thanks Jesse) in riscv
>> implementation of `map_shadow_stack`.
>>
>> Should I send a new series or only the bugfix-patch for implementation
>> of `map_shadow_stack`
>>
>
>Hi Deepak,
>Not sure if I missed the bugfix patch, I couldn't find it on the
>mailing list. Could I know have you submitted it? If so, could you
>please point me where the patch is?
>Thanks

No you didn't miss anything. I had been busy with job change and even though
change was small. I wanted to do some basic testing before sending fix. I just
sent the fix on this v26 series, patch #10/28.

Sorry about the delay here.

>
>> Let me know. Thanks.
>>
>> -Deepak
>>
>> -Deepak
>>
>>
>>
>> On Fri, Dec 12, 2025 at 10:33 AM Deepak Gupta <debug@rivosinc.com> wrote:
>> >
>> > On Fri, Dec 12, 2025 at 01:30:29AM -0700, Paul Walmsley wrote:
>> > >On Thu, 11 Dec 2025, Deepak Gupta via B4 Relay wrote:
>> > >
>> > >> v26: CONFIG_RISCV_USER_CFI depends on CONFIG_MMU (dependency of shadow stack
>> > >> on MMU). Used b4 to pick tags, apparantly it messed up some tag picks. Fixing it
>> > >
>> > >Deepak: I'm now (at least) the third person to tell you to stop resending
>> > >this entire series over and over again.
>> >
>> > To be very honest I also feel very bad doing and DOSing the lists. Sorry to you
>> > and everyone else.
>> >
>> > But I have been sitting on this patch series for last 3-4 merge windows with
>> > patches being exactly same/similar. So I have been a little more than desperate
>> > to get it in.
>> >
>> > I really haven't had any meaningful feedback on patch series except stalling
>> > just before each merge window for reasons which really shouldn't stall its
>> > merge. Sure that's the nature of open source development and it's maintainer's
>> > call at the end of the day. And I am new to this. I'll improve.
>> >
>> > >
>> > >First, a modified version of the CFI v23 series was ALREADY SITTING IN
>> > >LINUX-NEXT.  So there's no reason you should be resending the entire
>> > >series, UNLESS your intention for me is to drop the entire existing series
>> > >and wait for another merge window.
>> > >
>> > >Second: when someone asks you questions about an individual patch, and you
>> > >want to answer those questions, it's NOT GOOD for you to resend the entire
>> > >28 series as the response!  You are DDOSing a bunch of lists and E-mail
>> > >inboxes.  Just answer the question in a single E-mail.  If you want to
>> > >update a single patch, just send that one patch.
>> >
>> > Noted. I wasn't sure about it. I'll explicitly ask next time if you want me to
>> > send another one.
>> >
>> > >
>> > >If you don't start paying attention to these rules then people are going
>> > >to start ignoring you -- at best! -- and it's going to give the entire
>> > >community a bad reputation.
>> >
>> > Even before this, this patch series has been ignored largely. I don't know
>> > how to get attention. All I wanted was either feedback or get it in. And as I
>> > said I've been desparate to get it in. Also as I said, I'll improve.
>> >
>> > >
>> > >Please acknowledge that you understand this,
>> >
>> > ACKed.
>> >
>> > >
>> > >
>> > >- Paul


Return-Path: <linux-fsdevel+bounces-74765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBKnCNAscGniWwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 02:33:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B98854F226
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 02:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4EB3F3EEC20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 01:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5234307492;
	Wed, 21 Jan 2026 01:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="A5BCDI+7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B1B239E88
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 01:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768959159; cv=pass; b=rEnhLRhC3uCJ9U9LLYn2pJK7CwA8udoE7ywDmmWr+SdJLn6Lptm6mfKxoVvgdXvTy2ZTOOVUw5hVJrhcVszrx1X0U3VtKSqc8Cjidd6W7PWbRfvYazarrMXS1ZSZ+Z8dEhohuD9Pwwwj/HVglQmvUqWabdVACsdr74JrkeCFBfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768959159; c=relaxed/simple;
	bh=ShWRak8oUy88OSaopaw+aLPDpDo1ZpJd6cDyp++LarM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCSqNRzwFZ2QnmUQu3B8yI7IfIRHAOR8EQwgtmbCmhTF+Oa3+l3C3xfPweBpjrC6UEb5H8KSilTYKZi05dsC8D8BsHKmpJ27uVEXVisSy1yp5p9mZfGec/9NDpYahUsYzGm8WOzcSpscTD92ZrVz4knXzcz19DbX7QNteYD3rUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=A5BCDI+7; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b871cfb49e6so948153466b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 17:32:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768959152; cv=none;
        d=google.com; s=arc-20240605;
        b=lgScEiC9CIX6iTdKbRLlE2IqXUqtQzaHQ7qu/qJClmxE9J4KfvZNLb2d/4818xdFqd
         WGi5+c3t7xQ8XunS8tfOyoYcm+BK0XmxPwcYJ26viSW4Z2kDXoTrvOgamZtRGinogSsJ
         85hprOX/UWjLAiq6z6CqrXRIqbNyr2NpN3qC7bnffa8/jCbtiie2KSK7N2rkLUwEgZAH
         ZBfAbk/Yzw2UwBP8xqtZIfFGh+4DdAGAOSgpk4+MkA02M5dK5cpJEDwD8H357GMJ4cxA
         Lk81UW40BTd7ROxoCV3C3TQzgKo6MuwoOPiFXynZPgAH+dYljV6SilhSF7hDAUU6AYFZ
         YcZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=phhznUg1me3aMCDh6RtpPgdrBfYLQTkKfqDDafoKBZI=;
        fh=kSqQ/4OQRnQxJQBUuWUrQRlDRLZAmBEl5wfHggURWOQ=;
        b=Uqk1nfqM8h1yU10v6kGgpN+2X2TgYK/wAtmWh3fUuBSKWf8xGiia6mV0Yl5vXpeuVw
         kCEo02YVMsraBy4vjEUaUfS+5SbnoqtmGQjAqzGesUwWXHO58G/4n5QEcXxgyzKEeUP/
         v1+W5HE8WPgSwCVPylRC+z6o+eh9MbHX0htifYL5h75acPQEONCUS7YtU3sE1fE7OP/O
         DIl1E+eT8PljpskanXHiryOSEv4vuB2MUPr9QeJOzzfLMnFkzIkBZVEpFKhCFEbuarKn
         b8f0jewl9I0UmOpPfMO3rE0HU+n6e/6tEufKqQ50D7Zuxt+uQwLw1lBsjJacJbwxM1ga
         gUGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1768959152; x=1769563952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phhznUg1me3aMCDh6RtpPgdrBfYLQTkKfqDDafoKBZI=;
        b=A5BCDI+7uaow+L1pkR0/vhbZZn6AJyq7brkzi3g5PXQfBD4lA4/eE0X3H0eaNyQ9uI
         BhpW1W5q/SgcOo9bLiXBhGEOuJjNOLdsgI1yomjhhtiMc4yYgjkRRCEZEjOgjfqf0UZm
         alaado9gHlyuyjKWjd2TKsKjKgLfd7fX9KqgYnaBHFx227Fx+cmQlNknKxxjjBc6MhHc
         tG3tvKjpIj28uMUF7HVJL7ZayB6r9Ecpz7T11yD3GxnJ2kYCvSe5zS/YTgO0OkPIEynl
         85aax+WRhLPNanwVxq+Dtb0SSQHEK2jnBzPJpDYm/K1qIbTkzVoB1lPQoyDUEHDmqQ9K
         uN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768959152; x=1769563952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=phhznUg1me3aMCDh6RtpPgdrBfYLQTkKfqDDafoKBZI=;
        b=LLVt8M7tTKaEp7bkArprzvApPtfDaPUCVHwTsR0QE8G469yxFtAqC4bxvgakZ7fKYX
         sH4l9uNYNqXtqCP9d3ID7hs/RvWW/S0Fuf41h1Ag/sUCY+GVcSjHpUDm0E9ExB9ayk1+
         uiXFGNghMwov8jg6hkRNNV/fjvegeuFcFuyaqtaC2yZO9U9tqECE9/xnV/gmkXWAw1D7
         3cScWc95bcvTEGAEfs6Lu1v0Pp6ujEdCm9aGmS9r0Ie4YqHJFA9qMR7TfPvoz5kXiAvM
         4ctCaCwqnhNFAsccvSfm6QfDkwsrUEuHiLXxctLhRG7FtQGhUN6ia4FNSqMsEK1zDb//
         nZhg==
X-Forwarded-Encrypted: i=1; AJvYcCVqSHf73TaGdTFrk1Gb8reYa87f4QHC1jhVd3R6QVVkC62VjXjQjamcPmCtHhiJa06VvzqpTt3RXlXmdUAh@vger.kernel.org
X-Gm-Message-State: AOJu0YympbAsj3cpDOpvshIjgpUBWp1yPDCfotEEZH1A+9X3Zwjv0A/0
	wnBeY9nGRpvrG5qY+0InjrwEsQR0ev1KARHewcdHAmf0mguWEvVB2iPOuWfFVCoFeOVu1+CO1As
	KBqQs8aVeVP3mBMXLxglwOm+4YsWPDBS2sqMESzPipQ==
X-Gm-Gg: AZuq6aLRq36DnfR63eemFFK4kBTZtDQJFZPyuH9Tg+Yu6aKF9T6UxE7Gs7K9UYo+udw
	SfV8tf9sYAWJxnctSDcathVXIC4VBvNaHLs2v7zCZnvNZAcumRjIUHmjeFXXb6yIUAV4yUgcIyv
	OYwoHODW3rlPdGgIA0u4VmYyEUqT2r1VkUzHFX/kjO1s+i4Rhi14GwX9+pSmNytTolTTUMKKtbz
	/nqgQCb/EnAqHKha/npkTWQGXUhE/7grmPRa50arWFx8nD2WeQHI++l/BXWRcXIzHXNhUi/tw==
X-Received: by 2002:a17:907:9488:b0:b87:7634:b20c with SMTP id
 a640c23a62f3a-b8796b215a4mr1301363166b.38.1768959152268; Tue, 20 Jan 2026
 17:32:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211-v5_user_cfi_series-v26-0-f0f419e81ac0@rivosinc.com>
 <e052745b-6bf0-c2a3-21b2-5ecd8b04ec70@kernel.org> <aTxf7IGlkGLgHgI2@debug.ba.rivosinc.com>
 <CAKC1njQ-hS+kUJ0C_v0oqZW1EZw2zAXMp-SnnA-ZXh_H-SoVdQ@mail.gmail.com>
In-Reply-To: <CAKC1njQ-hS+kUJ0C_v0oqZW1EZw2zAXMp-SnnA-ZXh_H-SoVdQ@mail.gmail.com>
From: Zong Li <zong.li@sifive.com>
Date: Wed, 21 Jan 2026 09:32:20 +0800
X-Gm-Features: AZwV_QgpJ38WsQTA-JLh1W5jk7su1plcAErfmIKl7ceT3yMsB0wZBJHvBBZ5Ujw
Message-ID: <CANXhq0rpjSvOThACrB6_MMc8S34--xJsUYZ+HtMu1GUNyk8zOg@mail.gmail.com>
Subject: Re: [PATCH v26 00/28] riscv control-flow integrity for usermode
To: Deepak Gupta <debug@rivosinc.com>
Cc: Paul Walmsley <pjw@kernel.org>, x86@kernel.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
	richard.henderson@linaro.org, jim.shu@sifive.com, 
	Andy Chiu <andybnac@gmail.com>, kito.cheng@sifive.com, charlie@rivosinc.com, 
	atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
	alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
	rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
	Andreas Korb <andreas.korb@aisec.fraunhofer.de>, 
	Valentin Haudiquet <valentin.haudiquet@canonical.com>, Charles Mirabile <cmirabil@redhat.com>, 
	Jesse Huang <jesse.huang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[sifive.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,sifive.com,dabbelt.com,eecs.berkeley.edu,arndb.de,infradead.org,redhat.com,xmission.com,lwn.net,google.com,gmail.com,garyguo.net,protonmail.com,umich.edu,vger.kernel.org,kvack.org,lists.infradead.org,wdc.com,linaro.org,rivosinc.com,intel.com,aisec.fraunhofer.de,canonical.com];
	TAGGED_FROM(0.00)[bounces-74765-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[sifive.com,reject];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[sifive.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zong.li@sifive.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sifive.com:dkim,mail.gmail.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: B98854F226
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Jan 8, 2026 at 11:10=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> Hi Paul,
>
> I have a bugfix for a bug reported by Jesse Huang (thanks Jesse) in riscv
> implementation of `map_shadow_stack`.
>
> Should I send a new series or only the bugfix-patch for implementation
> of `map_shadow_stack`
>

Hi Deepak,
Not sure if I missed the bugfix patch, I couldn't find it on the
mailing list. Could I know have you submitted it? If so, could you
please point me where the patch is?
Thanks

> Let me know. Thanks.
>
> -Deepak
>
> -Deepak
>
>
>
> On Fri, Dec 12, 2025 at 10:33=E2=80=AFAM Deepak Gupta <debug@rivosinc.com=
> wrote:
> >
> > On Fri, Dec 12, 2025 at 01:30:29AM -0700, Paul Walmsley wrote:
> > >On Thu, 11 Dec 2025, Deepak Gupta via B4 Relay wrote:
> > >
> > >> v26: CONFIG_RISCV_USER_CFI depends on CONFIG_MMU (dependency of shad=
ow stack
> > >> on MMU). Used b4 to pick tags, apparantly it messed up some tag pick=
s. Fixing it
> > >
> > >Deepak: I'm now (at least) the third person to tell you to stop resend=
ing
> > >this entire series over and over again.
> >
> > To be very honest I also feel very bad doing and DOSing the lists. Sorr=
y to you
> > and everyone else.
> >
> > But I have been sitting on this patch series for last 3-4 merge windows=
 with
> > patches being exactly same/similar. So I have been a little more than d=
esperate
> > to get it in.
> >
> > I really haven't had any meaningful feedback on patch series except sta=
lling
> > just before each merge window for reasons which really shouldn't stall =
its
> > merge. Sure that's the nature of open source development and it's maint=
ainer's
> > call at the end of the day. And I am new to this. I'll improve.
> >
> > >
> > >First, a modified version of the CFI v23 series was ALREADY SITTING IN
> > >LINUX-NEXT.  So there's no reason you should be resending the entire
> > >series, UNLESS your intention for me is to drop the entire existing se=
ries
> > >and wait for another merge window.
> > >
> > >Second: when someone asks you questions about an individual patch, and=
 you
> > >want to answer those questions, it's NOT GOOD for you to resend the en=
tire
> > >28 series as the response!  You are DDOSing a bunch of lists and E-mai=
l
> > >inboxes.  Just answer the question in a single E-mail.  If you want to
> > >update a single patch, just send that one patch.
> >
> > Noted. I wasn't sure about it. I'll explicitly ask next time if you wan=
t me to
> > send another one.
> >
> > >
> > >If you don't start paying attention to these rules then people are goi=
ng
> > >to start ignoring you -- at best! -- and it's going to give the entire
> > >community a bad reputation.
> >
> > Even before this, this patch series has been ignored largely. I don't k=
now
> > how to get attention. All I wanted was either feedback or get it in. An=
d as I
> > said I've been desparate to get it in. Also as I said, I'll improve.
> >
> > >
> > >Please acknowledge that you understand this,
> >
> > ACKed.
> >
> > >
> > >
> > >- Paul


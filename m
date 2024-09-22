Return-Path: <linux-fsdevel+bounces-29805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6538B97E21F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Sep 2024 17:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972C61C2084F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Sep 2024 15:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E3DE567;
	Sun, 22 Sep 2024 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jb1oDkJ3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740574A28
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Sep 2024 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727017315; cv=none; b=Tvhl+WzY70joIDyu1B+IADIFnrgoRkDf8T0SBu91AqMzrmpUWwVbCYWl2loCXFc8pEhsVHskOS3LRrWH9RzDCRkG9CleK5EwzLQ0aw2W9v6zx//uUmoYxvbraE4pDF0fymqQMTTegh6EAm2em7CdyjMSbPtSaHnoZZlwRE1evt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727017315; c=relaxed/simple;
	bh=s0cShEYCAg+X7bWLg16m54ENQ3s7Xz+W1wGNdQR3+kE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LYuB2Yv62w6/5p66Y/kls8WxVq57/XHPgZxAfSOaCriPlnGJIk8iVawcpWTrrpkp207OuZdXCDWHxtkJTMe42m9+3iovEbsJ65w0TEhuxjAevsZOaJSoRfyB+TVHj0iZcn8BI3VMrcfrPDR9IN2/IerT2ghCH77yh+IXLww5DfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jb1oDkJ3; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-42cb6ed7f9dso32760295e9.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Sep 2024 08:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727017312; x=1727622112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ncjkm+xBj4wAiYMDJEPjMYUCoBiTLntYFoQkyKAzX14=;
        b=Jb1oDkJ3H7aBKFNJEWFyPgBQBBR97CB1W++3olg361eINWwG+xHmdarp+p6WWQCcZp
         nZV6r3LOF7jz4oyY6YLBIByvHkQzxUCYQaO2cgY0CZ6bF0eJ8dlP3vCa5auqWHvB8FMM
         Kk2CU5+fBYg+yvhmdUYOoxxPYlMe8pYH3d4AH03VH7a9WHb/v8JNqNDHpXSPkRwFF++x
         qtsOhA4N82/+EX2t4fsgEHPbqEYVdvmitOGsjJcFABdSfsGqRXcQxTXe769OnQd5BAeY
         QzbcCDw//nIxtm5nn34rSOinnCyZyxwmzJRzf/Gwa05BYxdJVnlH1Krpnb2WvgI6PBZj
         rTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727017312; x=1727622112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ncjkm+xBj4wAiYMDJEPjMYUCoBiTLntYFoQkyKAzX14=;
        b=uVz83SUhp/7Is60gqvu3EOS36PWrFbubKyqlCfgO25oNlq0dh/TPK/pDtL4TTgKfTs
         4ifseFN+KQ1xcAvD784hwzFqled9u43+HmZwzPCgy6GFAEu+XDidJaAsdcRL8CArj14+
         1oquFzlz+l2BdMSAJl8zCNKx9Tqys4xgdfOmBWx8Uiy9PqJSceCBJYDO0Myi6ZOe850s
         psp8uyYkJA3pJ4Mbmr0O4pr+iELThjWLzDc1pa6qEX/yNc7i+MnCyN3zEx3CTy3NKseO
         djqh8TA8jFbMTRRCV0+wE2CL4/W2J3B32Tq4rUhuP/RqFq+zIH7voP8PcUOGs3TijWKA
         +HlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVDe/5d1YyBHFfYv2yoEiQCQeShzKylbPWfhRvmTt84unoZoZkTEqBO0JgtP5+BVCyt+k1LxcYlFAG2DT1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+cnQFhr4TlSJcd7k34hiYHfjmFAPkQfS2hZBeSL4EYUVyongg
	LaKLtxXQYylPrOXS7MD1sZ0QW7TJEEtsQ96S2K5vpW/8CoOjzN/BNc6Q+HunkXF1OohqF0cui8K
	DuFKGLRLVitZNVA==
X-Google-Smtp-Source: AGHT+IECOclje4KsJl4Qt6l3KZ6Ti1CSsZjZP+0DmuLkcdwDN8cc/Ojour1aePp9l+ZstwUCPP+UzAnPRELuCaU=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:600c:1515:b0:42c:b32e:6ba7 with SMTP
 id 5b1f17b1804b1-42e7ad85690mr98575e9.6.1727017311494; Sun, 22 Sep 2024
 08:01:51 -0700 (PDT)
Date: Sun, 22 Sep 2024 15:01:49 +0000
In-Reply-To: <CAHC9VhQX0k68fwWF08eMCiMsewRRSqN3q=QwirV_0XjoJ4wo5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAHC9VhQX0k68fwWF08eMCiMsewRRSqN3q=QwirV_0XjoJ4wo5A@mail.gmail.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240922150149.3133570-1-aliceryhl@google.com>
Subject: Re: [PATCH v10 5/8] rust: security: add abstraction for secctx
From: Alice Ryhl <aliceryhl@google.com>
To: paul@paul-moore.com
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, 
	arve@android.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, brauner@kernel.org, casey@schaufler-ca.com, 
	cmllamas@google.com, dan.j.williams@intel.com, dxu@dxuuu.xyz, 
	gary@garyguo.net, gregkh@linuxfoundation.org, jmorris@namei.org, 
	joel@joelfernandes.org, kees@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	maco@android.com, ojeda@kernel.org, peterz@infradead.org, 
	rust-for-linux@vger.kernel.org, serge@hallyn.com, surenb@google.com, 
	tglx@linutronix.de, tkjos@android.com, tmgross@umich.edu, 
	viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org, 
	yakoyoku@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 3:18=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mon, Sep 16, 2024 at 11:40=E2=80=AFAM Casey Schaufler <casey@schaufler=
-ca.com> wrote:
> > On 9/15/2024 2:07 PM, Alice Ryhl wrote:
> > > On Sun, Sep 15, 2024 at 10:58=E2=80=AFPM Kees Cook <kees@kernel.org> =
wrote:
> > >> On Sun, Sep 15, 2024 at 02:31:31PM +0000, Alice Ryhl wrote:
> > >>> Add an abstraction for viewing the string representation of a secur=
ity
> > >>> context.
> > >> Hm, this may collide with "LSM: Move away from secids" is going to h=
appen.
> > >> https://lore.kernel.org/all/20240830003411.16818-1-casey@schaufler-c=
a.com/
> > >>
> > >> This series is not yet landed, but in the future, the API changes sh=
ould
> > >> be something like this, though the "lsmblob" name is likely to chang=
e to
> > >> "lsmprop"?
> > >> security_cred_getsecid() =C2=A0 -> security_cred_getlsmblob()
> > >> security_secid_to_secctx() -> security_lsmblob_to_secctx()
> >
> > The referenced patch set does not change security_cred_getsecid()
> > nor remove security_secid_to_secctx(). There remain networking interfac=
es
> > that are unlikely to ever be allowed to move away from secids. It will
> > be necessary to either retain some of the secid interfaces or introduce
> > scaffolding around the lsm_prop structure ...
>
> First, thanks for CC'ing the LSM list Alice, I appreciate it.
>
> As Kees and Casey already pointed out, there are relevant LSM changes
> that are nearing inclusion which might be relevant to the Rust
> abstractions. =C2=A0I don't think there is going to be anything too
> painful, but I must admit that my Rust knowledge has sadly not
> progressed much beyond the most basic "hello world" example.

We discussed this email in-person at Plumbers. I'll outline what we
discussed here.

> This brings up the point I really want to discuss: what portions of
> the LSM framework are currently accessible to Rust,

It's relatively limited. I'm adding a way to access the secctx as a
string, and a way to manipulate `struct cred`. Basically it just lets
you take and drop refcounts on the credential and pass a credential to
functions.

Other than what is in this patch series, Binder also needs a few other
methods. Here are the signatures:

fn binder_set_context_mgr(mgr: &Credential) -> Result;
fn binder_transaction(from: &Credential, to: &Credential) -> Result;
fn binder_transfer_binder(from: &Credential, to: &Credential) -> Result;
fn binder_transfer_file(from: &Credential, to: &Credential, file: &File) ->=
 Result;

These methods just call into the equivalent C functions. The `Result`
return type can hold either an "Ok" which indicates success, or an "Err"
which indicates an error. In the latter case, it will hold whichever
errno that the C api returns.

> and what do we
> (the LSM devs) need to do to preserve the Rust LSM interfaces when the
> LSM framework is modified?  While the LSM framework does not change
> often, we do modify both the LSM hooks (the security_XXX() calls that
> serve as the LSM interface/API) and the LSM callbacks (the individual
> LSM hook implementations) on occasion as they are intentionally not
> part of any sort of stable API.

That's fine. None of the Rust APIs are stable either.

Rust uses the bindgen tool to convert C headers into Rust declarations,
so changes to the C api will result in a build failure. This makes it
easy to discover issues.

> In a perfect world we/I would have a
> good enough understanding of the Rust kernel abstractions and would
> submit patches to update the Rust code as appropriate, but that isn't
> the current situation and I want to make sure the LSM framework and
> the Rust interfaces don't fall out of sync. =C2=A0Do you watch the LSM li=
st
> or linux-next for patches that could affect the Rust abstractions? =C2=A0=
Is
> there something else you would recommend?

Ideally, you would add a CONFIG_RUST build to your CI setup so that you
catch issues early. Of course, if something slips through, then we run
build tests on linux-next too, so anything that falls through the cracks
should get caught by that.

If anything needs Rust changes, you can CC the rust-for-linux list and
me, and we will take a look. Same applies to review of Rust code.

Alice



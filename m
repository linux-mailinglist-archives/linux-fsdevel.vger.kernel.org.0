Return-Path: <linux-fsdevel+bounces-29511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914AF97A56E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 17:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6D59B29374
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 15:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC2415A843;
	Mon, 16 Sep 2024 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="i0JfVMC6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B089A15749A
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726501234; cv=none; b=reX6W+2udKr7BYTKZ1VCXBf/5AFn2Y1ycA43mnwl8TQ5o48X0DPG07bcgNZvx3LPFrMU6KppVeyD0VjMHZ3Vr9f1XofaEFCJ/TtmYY6+RD+w7K9W50cnfHrirsWYoE/XDFvWKZ9t+UNY7Pc/5vje5be4zUfBtnaClZs7848qQY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726501234; c=relaxed/simple;
	bh=lO9KtSC3OSmcPVqS7FhAEp6EptYmKdYo7TyNBLg8ioc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IW4sDGOX4rJgWemqlS/2dCckcMUdEwmoY00fnSg6mH2It2w5eDnusaVsNf6THrAGCtIkDY4DcAnEMDaWmVWbHsgc/AR7AR1t4rqUPWvNz0sWdCP2DiBd2i7FYgFORgMu4S0n7RF3+Ac7kPxwJre73NoNxmbcnCCMtJBglav8lsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=i0JfVMC6; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726501225; bh=sUhQibpO8/62h1XbBXqtDdXmPfgnrqmifo7tdJ+Dqy4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=i0JfVMC6bM6lsj8IqY6dJVJVa/TgxQJYnYNbE64PPuzpPUAIm2MsVFm8Sgx19M8FSYhPDJaElOKNYrKjgFALuL1Tyan919ZNsjyqkrnu70Avfu19DN4obTaupcpQB6GF5fIYwBTAeMZ9Prht7v9WYdDegEQPDJ/k6H2Um8q6yJ+8/QQA+n/m7BxrsRzbAeSyMSDWZBimc9EFVMQxfkIEHpQysY5FfF/8lhqrh3INVYATktuWf6AJAb8QV9dcSkWyjfhCIopqcjv2nYTdb+BowKCfm3KXLr+vJ1vSvdIR2alUJNKsli2wkoMlfo25JKG8T+AjqqZULWIxtrp4GoJTsw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726501225; bh=P9RAbSPxpe4ABX0Lcolo4ZOQacHr3qIA9WPAH8LGJm6=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=N17KLeloRL8E67tt8awItFqDoT/iJpTKT4uwCorr9uRzdGigqFqoZvW2jIUGW5m3ywnO8n8fWGiXSpjd6sTUnhALX0DNNokN/CJOw7nXHPoSrCVgZMkjUcEWsHjjXxYQh81T6UWH2WBRE/Gwm5EpG4muUvg/p2lXCAqDdASayGauVsoK0uwHVe+FDoMHv+//PzzcWudGwLqoxEnlnNAsBkMD0dW2d8pf2iHJRnrHmYTBn4lwAW/Mx3cujSoMFs+nWtBawymT5Re9SiuXCiVJM9dt6LhUA4iaZ6wh5BuYGeuNgZaIVf6ziJczST9RuP9xwoydlO1z8Xz6mM7NQjwfiQ==
X-YMail-OSG: cmZZNKQVM1k7lILdYPfPSycxposlR_QA_LerQEDgjYI6_sRhR15jaSBx_OdpZGh
 h54LtXvLWlyHiy1uy.jWkWT823G8Ko3AYXM8Bba09CQfzcXYTfoOSxd9PpeQm68m.CP_SVn5ScvT
 ZJMLH_3BUbLCvB4681YtCGAVHAFoCxsPPsJIcOI2TjmYXf.l2pQNLTICINrzuIW2t3Ae8ClcJTis
 8ssMaR1EGUvECbXZh9vQDjQINL6YyJihfYmfelfq9AHt2rx1cd7OPAKMvJC_KmN0OgXQEEJzU8Wx
 ouxO.91rq2nHhoMll5ERP1vH4t8tov8cWTeop8pa51furUJPDLHhfyxjWsZKAynyCBxOHSVQvJhi
 hcjatktQEFl6fTHz.zhD944YXZQlrdAFcsJGvQ.2cM7tN1haRO_GVFptCU8OYXYxwSGYFKtUP5RK
 cXxHdOXBk1ZcQ.VhNzA05fmXE8mioB0_KYqGfcxgRuVN.u.zG3YSHHzrhD_qr0uxHd8l..X3SUBl
 06lDbunI81fsEbpJE18.1MCi4g.6_c_Sr.xwtXhg5nNe2OAcGzcJiHeNZ0ifFAxoCA45zdh1Bqh6
 BpwCMTCewEadtRN64mVVyAB2BHsN2aPItlFbdCy6hOgtCvvqKbC9qdzotj4_wHn7avs14sBfa9p3
 qLzCYgC_h14nXfXCZx8bWW4xsfefqyqJJ4TIQ3XEhzeZ9rd38NIGG7QIsyIziz0uKPAbd.r9M1HJ
 yLSrdIovvwNsYXmrhQ3md8TLYihEp1kBkQcepZxaxeegsq2XmyDePuZaMgHnsRYOfrqb1630SUH4
 RmZcsMiD0UCeTaxU6ZVLcbxH6g3bRLJL6pMGvnLTpxDKO6JiPUyg11LDm_ObkXkx8eQTgC1QvcQC
 _hphmtrvP_G45n.yTE0foZTUfpAjlYze4hXmpPi0XACK8aG4qtOFOJZQ9KU8IExVV3.TZJ0OYo.H
 0ycOrwFyTNXSCc5KSqPOul.UwTZMR4VChDY2nWOm_x6n45eqJqY4MiKcVhbExqoaCL4ax5kiKbgM
 ygPue6J.jpDKJVPFYWn0ikALh1MozYNfo_ifTFtlYAuXCAvh46aXPUFHIE2jTDNb8lOaZEskIei5
 JwdNsAtGevjAM68jRr.ofPAkFEeSHsA8uupQGoZb3x9Ir93iVEuc5fb9c1kdl.35o7HDmxDlMJGh
 SLTmnSA_.BgLmOAxhtFd9TdKrHXwFrV_SWBFxiOtYJDo02nBcBUQOEDKq.pHj.xh11P.YbtHRePF
 fV88v33iEWn9aWj87SGv7PD7RMxRAD2DEWigmASM7znVHVDP0EmePnJvs15qWuyUz1Gf0BUkZVuS
 cPOmFYVuGnU3fr7W2uGT.h0VB.Gk.LxkBUT1xBULObGw6ZMRnvaKe5QLmhXeENrZhfzqpXdk6MoD
 Wov_akHBZpIEslJa8FFS.RuIY2Lt6fVpeQVKutsysq2X6efNyQZymH.lNQGLOV7sA4SIZEue.oCB
 hIlSamGZR5UFvVGD6U_MZFoC7vituZTWRKbRCC8cojyXYlO.0K4bPm6r2wg0T_.W_hzCMSmAdo8i
 rEcjEUaYNVEg12bKSBgOyzxnydHcw7iD9ayjWAnI2KfDorYiPphOBPS5iysI9Y7UOe7ozktudVJA
 Jls2oZ1aa1ASwihG9Tm5OZ4ul3Vr6MDbRHiPxNo_M_DMjKl1bJWJY3pIx4XKm5H7bghYMa5fjarH
 p0g2uBdFO2ZWcleyBnXYsWgOWKj0uZE8qieO1gN4pGmhqAXriNMTcPD7.bDErDvGhKCaQZES0rHP
 kGuEIPSoM76UQ.CLMmPd5qaVAwOVGDQZFc.bDcGpdxFj2s8f7OduAkH.AeXHzsyOM0i8Izy7o_bc
 M1m2_Sy6haM7BeEaaTnd4LRztUI2k2_TX9xK.Ax7NxX4FCGqxoU238C_DA1zjZMVMNT9OjYSaLEs
 zjkBswResIlP4PrX2JhfI0zqpFQwhxGpQdVvGzaEEexobhsHYv_NhziizwswPHLRfEgGVjN_Js5w
 6zp1Jx_gWiHabfGDWAZlu.kKvkxGxKFpW4TuTc52GSnxIvEWq2G.Yn36g0UZXYuZ.e.A1ECfKNVI
 CNSKB.lXHXtGUuoU09oj4CCPrJ0Y_ZaPViQ6vG3tP_z0X43zuwcG0rT7ZCEi492Th43rENw9kcIN
 bAgTLdwyEoxSqxnu2yacXF_M5OVOT7XsLVx2SQTypKf0RVJdAZdjqY79hHX6arLXOvsqkzwHuWSH
 mz644M8ZTJIFFVM8RDjHLGk83gzmn.5obS1aBWxawNojk5hn09fT4pnzw_P4.1oR5ez..iHoJTQs
 -
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ea7ae0a5-a46d-479a-be24-f6099b835234
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Sep 2024 15:40:25 +0000
Received: by hermes--production-gq1-5d95dc458-xmcnd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a2007bf44c595f8ef49bc843a498bceb;
          Mon, 16 Sep 2024 15:40:20 +0000 (UTC)
Message-ID: <39306b5d-82a5-48df-bfd3-5cc2ae52bedb@schaufler-ca.com>
Date: Mon, 16 Sep 2024 08:40:18 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 5/8] rust: security: add abstraction for secctx
To: Alice Ryhl <aliceryhl@google.com>, Kees Cook <kees@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
 Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas
 <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>,
 Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
 <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Daniel Xu <dxu@dxuuu.xyz>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
 Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
 <20240915-alice-file-v10-5-88484f7a3dcf@google.com>
 <202409151325.09E4F3C2F@keescook>
 <CAH5fLghA0tLTwCDBRrm+GAEWhhY7Y8qLtpj0wwcvTK_ZRZVgBw@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAH5fLghA0tLTwCDBRrm+GAEWhhY7Y8qLtpj0wwcvTK_ZRZVgBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 9/15/2024 2:07 PM, Alice Ryhl wrote:
> On Sun, Sep 15, 2024 at 10:58 PM Kees Cook <kees@kernel.org> wrote:
>> On Sun, Sep 15, 2024 at 02:31:31PM +0000, Alice Ryhl wrote:
>>> Add an abstraction for viewing the string representation of a security
>>> context.
>> Hm, this may collide with "LSM: Move away from secids" is going to happen.
>> https://lore.kernel.org/all/20240830003411.16818-1-casey@schaufler-ca.com/
>>
>> This series is not yet landed, but in the future, the API changes should
>> be something like this, though the "lsmblob" name is likely to change to
>> "lsmprop"?
>> security_cred_getsecid()   -> security_cred_getlsmblob()
>> security_secid_to_secctx() -> security_lsmblob_to_secctx()

The referenced patch set does not change security_cred_getsecid()
nor remove security_secid_to_secctx(). There remain networking interfaces
that are unlikely to ever be allowed to move away from secids. It will
be necessary to either retain some of the secid interfaces or introduce
scaffolding around the lsm_prop structure.

Binder is currently only supported in SELinux, so this isn't a real issue
today. The BPF LSM could conceivably support binder, but only in cases where
SELinux isn't enabled. Should there be additional LSMs that support binder
the hooks would have to be changed to use lsm_prop interfaces, but I have
not included that *yet*.

> Thanks for the heads up. I'll make sure to look into how this
> interacts with those changes.

There will be a follow on patch set as well that replaces the LSMs use
of string/length pairs with a structure. This becomes necessary in cases
where more than one active LSM uses secids and security contexts. This
will affect binder.

>
>>> This is needed by Rust Binder because it has a feature where a process
>>> can view the string representation of the security context for incoming
>>> transactions. The process can use that to authenticate incoming
>>> transactions, and since the feature is provided by the kernel, the
>>> process can trust that the security context is legitimate.
>>>
>>> This abstraction makes the following assumptions about the C side:
>>> * When a call to `security_secid_to_secctx` is successful, it returns a
>>>   pointer and length. The pointer references a byte string and is valid
>>>   for reading for that many bytes.
>> Yes. (len includes trailing C-String NUL character.)
> I suppose the NUL character implies that this API always returns a
> non-zero length? I could simplify the patch a little bit by not
> handling empty strings.
>
> It looks like the CONFIG_SECURITY=n case returns -EOPNOTSUPP, so we
> don't get an empty string from that case, at least.
>
>>> * The string may be referenced until `security_release_secctx` is
>>>   called.
>> Yes.
>>
>>> * If CONFIG_SECURITY is set, then the three methods mentioned in
>>>   rust/helpers are available without a helper. (That is, they are not a
>>>   #define or `static inline`.)
>> Yes.
>>
>>> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
>>> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
>>> Reviewed-by: Trevor Gross <tmgross@umich.edu>
>>> Reviewed-by: Gary Guo <gary@garyguo.net>
>>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>> Reviewed-by: Kees Cook <kees@kernel.org>
> Thanks for the review!
>
> Alice
>


Return-Path: <linux-fsdevel+bounces-73854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 881B1D21EED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 02:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4EE7302E079
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 01:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AB223B628;
	Thu, 15 Jan 2026 01:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nYWF16rZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F1E22173A
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 01:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768439091; cv=pass; b=mlxxsYHrxpgvsSMHIX4qEg+2A4mfR9UItoX0hLQdeuCxpj1RfX8TIO7ThNA0BYalGp5PUXUarxt4k3fVfte0fYB0Yy7EQwl5SWHnUTj34LRf4cueUjzhnF192/KGYN3p6boq3BPGD1m24aIfAZVvSFp6DMyxDK9RBsIsj1Jdmpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768439091; c=relaxed/simple;
	bh=5mCWz7xL4PBvLNRTs9Q9eGlmAi7gmrPzY2rOjVDSSxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cCsR561AMsQwZWDAHq9FsnkoUtDZ43RM50L9tA6mcKHibVPK3b4m+RpIx0AMvYdEXcfH/Vu6vaSQFqN8oFbkJkkfFgThXKSXNvx5SgUU+I6hUbuIISRJnjDYXOU65r92tLm/dDj422lyAROVmjJh8uqDtA8auu2rj9MoD5N7O7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nYWF16rZ; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5014b5d8551so169351cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 17:04:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768439087; cv=none;
        d=google.com; s=arc-20240605;
        b=Ep1gRudyo8pLjj/vxgWwG6EfGOSCwARYH1HDlbshl090dRjhDRgfjZayAlTk2Q1+Ks
         5mvAxFyJo+VydQwD9mlWyhcjSLzdz9CcroG8TtVb8t3JxQITva52Jv62ec4m0i2tynpi
         MgbgI8rNbxi5v8wfSH2gctANPpgGexm+GwJ60jpMcF8kDG1QL2sLznzSsvaGt4hguQza
         2pKTmy9iIICWComH38VVh4DPUlkBa9rH3Zh0C4cJlx2TFQrfngcOh2KidFowEH8SotTn
         5M1sESP/bB1h+OxAeSEm+c09dG7u5MgnTKq570nN8ojz+LoaTW1LbpwVv7XqXaFnvDva
         9RSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=URRy9HALKtlI4zSd8J7xEpQeeiDnF3QwKlnFWFMKwTg=;
        fh=EjKjwFxwPJPbsM3gC1LAOLnDhmj5tsgLz0lqGT+NzdY=;
        b=QUDOfyk/5eRbqi/6/+qj5/QtPoW1vhF5o/jfM232/UvCDOugdwx/xgSo/Hej2VvJC7
         LLC1dQ9wv5PTaZMaaoH5PdhLqV8gc8H9l4I54q5dWW15808R33KGFeLQgzttaqV1qm+O
         KHOO3FT9kxXf6lU+0IEtDxVY/oz1f65xmsngdgJD6/WHjrV7AVynpAHmD8U0/5VTufsR
         +t6VRnf0ODoEkTghVOwhaJvqAEg2Sp7Hqtyfgt4I4wbg+f3J8ldiphTfb50u++Kq7P5x
         VRuyFQZ7f5qyIHkpCAt568S6q9imgguSpXD5jVQaSmrqXMjHlJ4WE/N2UfRysE8DIRuH
         h5YA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768439087; x=1769043887; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=URRy9HALKtlI4zSd8J7xEpQeeiDnF3QwKlnFWFMKwTg=;
        b=nYWF16rZnrR1Nsy6m1RXgOn11au4IMt89CUv6CKtbiyjzkH6JGVHgJ6M1tm0SrrlHg
         aBxhgOrdaVHDiL/pF1Vcusl9X7nDr9zpri77TKAqSGnnP8p56La1h8wnrf6f2JZv94Di
         hA4qpChP1+CQJC8FEWjc/dm06Tu/lrw6E+fMIXO5wM3G8b6UVdHJkaNM2uMdH476P5U8
         UWiClLt11UuR4YaA+rGwu9wi7H9QobbMzqsvO76cMzzVBi4NIV30GACkEUJtw7jUW/Az
         7AFxlYgB92eza9XzU32oeajVoy4SpP9ZW3vgJjamgj3zAYjXT6kcBcuXOrIHqT8wM1Tw
         Un3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768439087; x=1769043887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URRy9HALKtlI4zSd8J7xEpQeeiDnF3QwKlnFWFMKwTg=;
        b=X758z/DRYfwrVSNgkLe0MszveL94tpTNrmzNMB+VlEh42rdscmbpDEfFHMua4Kvwpk
         MKGZZ7si/FkVPzlMLbjO+8Z6bMgJeIWMAUP8z+aZC5pDVlkFRxqHmsIMutuwLAvj2OJl
         dUpoCzSBMPNOClCLHjNuvnZ5s1nMgdK5cdBfbqSbSeVK+2lByg3nrgK8Eqo+40fmaDNy
         L3FmiNqMyh1Leb01Rm+Si87fMlUyMITJfgn9Q66uUqbNjDxmlkqyBdXnUskjt42n/bbu
         LaQ9mSYj5THjQ63uuBQSu3wZplTer0CKEjpz8Mr8U6ePrrUg3UACVQRxJb6SEtnpzHoG
         6i4A==
X-Forwarded-Encrypted: i=1; AJvYcCVVkRr8En8E3EOuOG4LHsevQYUIQeBAu0dHnzvnmYIR8+efWmrKhHWTu3sy1pomEkRMgVBrNK31DbyVEdlJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7q8zx42xuw0BPoOLE6lZIUvxI8cHPLCHbEq1A55XzHFDJv83V
	P3V05mLHcfcTrXP9E2NVIRP50E9pdfrXqYRcbeJgKGPF/FUH6eBjUWX0LtZ+Hd3gokhfMlURYi/
	gDS4F+Tufe0xHukie+tfBKswGBfJY4iaiGUEfr5KC
X-Gm-Gg: AY/fxX4HDnbrWtG3DIQaCyDxZZP2JN0QQtiKV1SiYDLJwF28N2WY+YiV9UCJHUZWXV6
	0o9frJFoW+MphUPqKe+Wt9vr+ahcS0cAMsWAZrJL3sUvY1vMHWiyilcge7BnyVJ9N2rlQ+pWq1Z
	F5CwYIm7HCJoKF9ud+SBRIIVBb6RXyGPZnzJ2ZLkTkYUUVR0LODFQhCSMfZad3f9KweS/RCUrks
	r7LowkM0XtOjBloxtrgIgTDsrPbKoXxIkxKPZXp4Mn8rn/jM/NYQb2Qg/9IIKpsqssJRBo=
X-Received: by 2002:a05:622a:10b:b0:4ff:c109:6a4 with SMTP id
 d75a77b69052e-501debdf6bemr5145441cf.4.1768439086933; Wed, 14 Jan 2026
 17:04:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOdxtTZ=SuV2GMPuqQJe6h-h-CDiG5yBW+07f1QYEw+kTA4-2w@mail.gmail.com>
 <CAOQ4uxggQekxqavkt+RiJd9s9cdDgXZuVfQrL_qNciBNf=4Lww@mail.gmail.com>
In-Reply-To: <CAOQ4uxggQekxqavkt+RiJd9s9cdDgXZuVfQrL_qNciBNf=4Lww@mail.gmail.com>
From: Chenglong Tang <chenglongtang@google.com>
Date: Wed, 14 Jan 2026 17:04:35 -0800
X-Gm-Features: AZwV_QgbmQP1U1OhJ0e2CgeJA64Ox4mwR6vGX901aFxd-1G0AZoiLALBYa7TcoQ
Message-ID: <CAOdxtTas63Wky=NeKVMFBfTanCqhGS-9cX-kwc7wFx9COSD+Zw@mail.gmail.com>
Subject: Re: [Regression 6.12] NULL pointer dereference in submit_bio_noacct
 via backing_file_read_iter
To: Amir Goldstein <amir73il@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"

Hi Amir,

Thanks for the suggestion. I followed your advice and cherry-picked
the 4 recommended commits (plus the backing-file cleanup and a fix for
it) onto 6.12.

However, the system now panics immediately during boot with a NULL
pointer dereference.

The commit chain applied:

ovl: allocate a container struct ovl_file for ovl private context (87a8a76c34a2)
ovl: store upper real file in ovl_file struct (18e48d0e2c7b)
ovl: do not open non-data lower file for fsync (c2c54b5f34f6)
ovl: use wrapper ovl_revert_creds() (fc5a1d2287bf)
backing-file: clean up the API (48b50624aec4)
fs/backing_file: fix wrong argument in callback (2957fa4931a3)

The Crash: The panic occurs in backing_file_read_iter because it
receives a NULL file pointer from ovl_read_iter.

[    7.443266] #PF: error_code(0x0000) - not-present page
[    7.444208] PGD 0 P4D 0
[    7.445270] Oops: Oops: 0000 [#1] SMP PTI
[    7.446175] CPU: 0 UID: 0 PID: 423 Comm: sudo Tainted: G
O       6.12.55+ #1
[    7.447669] Tainted: [O]=OOT_MODULE
[    7.448330] Hardware name: Google Google Compute Engine/Google
Compute Engine, BIOS Google 10/25/2025
[    7.449825] RIP: 0010:backing_file_read_iter+0x1a/0x250
[    7.450810] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
f3 0f 1e fa 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 41 55 41 54 53 48
83 ec 10 <8b> 47 0c a9 00 00 00 02 0f 84 d9 01 00 00 49 89 f6 48 83 7e
18 00
[    7.453754] RSP: 0018:ffff9e95407b7db0 EFLAGS: 00010282
[    7.454694] RAX: 0000000000000000 RBX: ffff9e95407b7e78 RCX: 0000000000000000
[    7.455892] RDX: ffff9e95407b7e78 RSI: ffff9e95407b7e50 RDI: 0000000000000000
[    7.457158] RBP: ffff9e95407b7de8 R08: ffff9e95407b7df8 R09: 0000000000000001
[    7.458331] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[    7.459593] R13: 0000000000001000 R14: ffff9e95407b7e50 R15: 0000000000000000
[    7.460968] FS:  00007a330957cb80(0000) GS:ffff9cb0ac000000(0000)
knlGS:0000000000000000
[    7.463015] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.464268] CR2: 000000000000000c CR3: 000000010bfc0003 CR4: 00000000003706f0
[    7.465453] Call Trace:
[    7.465994]  <TASK>
[    7.466487]  ovl_read_iter+0x9a/0xe0
[    7.467424]  ? __pfx_ovl_file_accessed+0x10/0x10
[    7.468353]  vfs_read+0x2b1/0x300
[    7.469137]  ksys_read+0x75/0xe0
[    7.469894]  do_syscall_64+0x61/0x130
[    7.470603]  ? clear_bhb_loop+0x40/0x90
[    7.471381]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    7.472486] RIP: 0033:0x7a330967221d

It appears ovl: store upper real file in ovl_file struct introduces a
bug when backported to 6.12. In ovl_real_fdget_path, the code
initializes real->word = 0. If ovl_change_flags is called and
succeeds, it returns 0 immediately. However, because of the early
return, real->word is never assigned the realfile pointer (which
happens at the bottom of the function). The caller sees success but
gets a NULL file pointer.

I wonder is there an upstream commit that corrects this logic, or does
this dependency chain require the larger ovl_real_file refactor from
6.13 to work correctly?

Best,

Chenglong


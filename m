Return-Path: <linux-fsdevel+bounces-2695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8A87E7935
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 07:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C1F11C20D3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 06:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F07563CD;
	Fri, 10 Nov 2023 06:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FYrHofvw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5CA6130
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 06:22:35 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702566EA8
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 22:22:33 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso2739485a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Nov 2023 22:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699597352; x=1700202152; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z2NiLyvaFOu+7jfXyTA0Y+4+iQo8EadnFqrwOxFniBc=;
        b=FYrHofvwMJ5Yina7jxKJ1ody3/HpQdc3SRv8E8tMrxESiB8rCJ9hzZ0NUfdEBFCDQ2
         /NAPJiq2A+1NcHwAphGSj8B4hHFR0fMLmgnaDHQdtiuqP7asB4ikDmObQmN2RP/CceQc
         3e9b76lcqAGoklv2URBMQunsPIWFHdCvrEBD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699597352; x=1700202152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z2NiLyvaFOu+7jfXyTA0Y+4+iQo8EadnFqrwOxFniBc=;
        b=N1r954Av2cgXM7peyjKTKTuTij8okSLV4YvPSC9qPt85M/StuHg9zyXGhyq04mY3vS
         5rnT7Cmw7AVqpgUO5HWy0MebS+rPIN7oSNoySLb2tkomf2lKRJ4kbduWkDEWBHQHqukJ
         ntgh03e15Vgyc8xoIvFA7RVscbbYDyCryAMyCzdyMNn7Vph3tL8WOkox8k27gtHTnr9E
         xdMdTgHzLZefoUG0v+iQ4Ta9tan71nUldDCqV7phJ4xtVoGVO1oVjpf6zFfuYuEmYlyc
         nOKe4PSt5Y6dLWvatJcimHk66lJ0I7o2ZY3j4OWWiAA0csEuWq6XDBgJ5eKt7Woze3xa
         bXow==
X-Gm-Message-State: AOJu0Yw2huTN4OzgYVm0XjFy24Gb9Wvqo9jGxufPq7Z3FrO5hHZ6hS7q
	/Asit5v57PxfJlHS64+WUjE9eq9PzJzcug2YlL9liGEp
X-Google-Smtp-Source: AGHT+IFSWxu7i2PN568XA86ROYR8jCMksq50ifYwTc1KFpjyEGvECuQLR+3qpG+CWTGkr8V+dN19kQ==
X-Received: by 2002:a50:d59b:0:b0:531:11fa:eacf with SMTP id v27-20020a50d59b000000b0053111faeacfmr6800351edi.2.1699597351668;
        Thu, 09 Nov 2023 22:22:31 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id ck17-20020a0564021c1100b0054130b1bc77sm711358edb.51.2023.11.09.22.22.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 22:22:30 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso2739459a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Nov 2023 22:22:30 -0800 (PST)
X-Received: by 2002:a50:a452:0:b0:544:91dd:2aec with SMTP id
 v18-20020a50a452000000b0054491dd2aecmr5757436edb.32.1699597350564; Thu, 09
 Nov 2023 22:22:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031061226.GC1957730@ZenIV> <20231101062104.2104951-1-viro@zeniv.linux.org.uk>
 <20231101062104.2104951-9-viro@zeniv.linux.org.uk> <20231101084535.GG1957730@ZenIV>
 <CAHk-=wgP27-D=2YvYNQd3OBfBDWK6sb_urYdt6xEPKiev6y_2Q@mail.gmail.com>
 <20231101181910.GH1957730@ZenIV> <20231110042041.GL1957730@ZenIV> <CAHk-=wgaLBRwPE0_VfxOrCzFsHgV-pR35=7V3K=EHOJV36vaPQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgaLBRwPE0_VfxOrCzFsHgV-pR35=7V3K=EHOJV36vaPQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 Nov 2023 22:22:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=whNRv0v6kQiV5QO6DJhjH4KEL36vWQ6Re8Csrnh4zbRkQ@mail.gmail.com>
Message-ID: <CAHk-=whNRv0v6kQiV5QO6DJhjH4KEL36vWQ6Re8Csrnh4zbRkQ@mail.gmail.com>
Subject: Re: lockless case of retain_dentry() (was Re: [PATCH 09/15] fold the
 call of retain_dentry() into fast_dput())
To: Al Viro <viro@zeniv.linux.org.uk>, Peter Zijlstra <peterz@infradead.org>, 
	Guo Ren <guoren@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000579e6f0609c65810"

--000000000000579e6f0609c65810
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Nov 2023 at 21:57, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So something like this should fix lockref. ENTIRELY UNTESTED, except
> now the code generation of lockref_put_return() looks much better,
> without a pointless flush to the stack, and now it has no pointless
> stack frame as a result.

Heh. And because I was looking at Al's tree, I didn't notice that
commit c6f4a9002252 ("asm-generic: ticket-lock: Optimize
arch_spin_value_unlocked()") had solved the ticket spinlock part of
this in this merge window in the meantime.

The qspinlock implementation - which is what x86 uses - is still
broken in mainline, though.

So that part of my patch still stands. Now attached just the small
one-liner part. Adding Ingo and Guo Ren, who did the ticket lock part
(and looks to have done it very similarly to my suggested patch.

Ingo?

                     Linus

--000000000000579e6f0609c65810
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_los8bcxd0>
X-Attachment-Id: f_los8bcxd0

IGluY2x1ZGUvYXNtLWdlbmVyaWMvcXNwaW5sb2NrLmggfCAyICstCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2FzbS1n
ZW5lcmljL3FzcGlubG9jay5oIGIvaW5jbHVkZS9hc20tZ2VuZXJpYy9xc3BpbmxvY2suaAppbmRl
eCA5OTU1MTNmYTI2OTAuLjA2NTVhYTViNTdiMiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9hc20tZ2Vu
ZXJpYy9xc3BpbmxvY2suaAorKysgYi9pbmNsdWRlL2FzbS1nZW5lcmljL3FzcGlubG9jay5oCkBA
IC03MCw3ICs3MCw3IEBAIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgaW50IHF1ZXVlZF9zcGluX2lz
X2xvY2tlZChzdHJ1Y3QgcXNwaW5sb2NrICpsb2NrKQogICovCiBzdGF0aWMgX19hbHdheXNfaW5s
aW5lIGludCBxdWV1ZWRfc3Bpbl92YWx1ZV91bmxvY2tlZChzdHJ1Y3QgcXNwaW5sb2NrIGxvY2sp
CiB7Ci0JcmV0dXJuICFhdG9taWNfcmVhZCgmbG9jay52YWwpOworCXJldHVybiAhbG9jay52YWwu
Y291bnRlcjsKIH0KIAogLyoqCg==
--000000000000579e6f0609c65810--


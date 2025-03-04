Return-Path: <linux-fsdevel+bounces-43118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA00AA4E409
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 16:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D17D19C270F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 15:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803FA25FA0E;
	Tue,  4 Mar 2025 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIhMDz6Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F2127C864;
	Tue,  4 Mar 2025 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101954; cv=none; b=n+GHGRflZ7bKXDMzZoWQalasfPHwviNmIDETPnCFgH8Jdva/5u1hV6iHsFq+nMwKZzu8wlJVTzG5cLfLppGBSMb3bmdVQltZg3+6uDcZZOM0cexcHEehlaG9DRLTbU2y86ANNdZUEMpkyeHkrSe/FzjJzQi/0yS3mkRO8l0A/Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101954; c=relaxed/simple;
	bh=1dT1ZQG8zIh7Gs5jAvVES4thTDk3VGJ0Bbji0R1yCyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCGBwJ88Vl8GZSVENO9G9WC9wV1Y6oQqtNrL+1cho3YEZ3oJn4fxqqdfx+MrfBeVna42rY11wzDZUMUs55bolhpeez7jmj7RE7RbAC0ABjOuc1uBFlR/1XmlAIrV3pLqyrUwlTsqhdxsQ/LDLuC8D/NC+/jYMXurzdacKd7fC0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIhMDz6Q; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so1084369366b.3;
        Tue, 04 Mar 2025 07:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741101951; x=1741706751; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WJS+qqw8o7vF6zKnEstKfN0OskJxtx7myn+Wz5p/+WI=;
        b=YIhMDz6Q3biDW+V+yLXkkt0CWG5z5yyR/fcgv6tVb4ws1X5UQIokxgIuduy0K4QD2c
         3V7mhZie2heY/bK46ntTgxCxxr7lkL3vJXI8732zhbl/g24wde18Hwq7MPkoOhF3GG51
         C67mtkfOxxFaNLitjv9dx5SG6J1MoruYqUHOFpDgLSR3V1mm2nQcW2t9ozjuXYSIS5Y9
         ivcud45SJq/nTIT4V1kZ/CqQTp3N4jMSWwZ60tfjqpWmg6ew5YOMNlcRc6xCAW5JKr0c
         f+Qja59BfOYdjRbIZL9r/hKVwOiBczKGXHmemsunjOUXJUraZMzS/fI64BaMg2EHmYr3
         c9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741101951; x=1741706751;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJS+qqw8o7vF6zKnEstKfN0OskJxtx7myn+Wz5p/+WI=;
        b=Ndfn54SGBz8XND0jyaFsrGB7qjOm9bqa9Ekg+BZnADxMrtFjmKm6kEEq5ZYQsW3SQH
         uC9HkIEJYg6f4OcR/apCHXpnvpfCCGVl9Kjs3MagH2ccd6R1OfnCffZtZsF3FYoLknfl
         GHN8J0pmQdiOq+VIP20/f542NLU70VJ/gNIL2dQeNtM9KctPYWtFtN5T4O4ZDtbAAxot
         LzzchCmnsKDOdeftH01rvYvyuWPlYNJUx0//7Tn0iP1kQt/FMygAkMdmHICP+ECiricC
         sxUSM8f6XZPn8myb00jSI631HYw6oQaclSyh7U8E63pr/wo8yNXbSOaSnmXW6dgEaqGg
         BVbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRZmn3T1XiZ6Jho068AWeaPIgLzIovGllpjquj1x5IP5To7sgwHRkFO4oLqOaXCmXbnKFHtulds8+7ohVG@vger.kernel.org, AJvYcCXxJ5t8Up99YJMtF9wb8bA8sP+km/Ki3yMC3Wl4U9+7lajiOP8nIUzDdxls1PWxyUBDqT8Qm1fdlp2p/9kG@vger.kernel.org
X-Gm-Message-State: AOJu0YyiI2ClzyTW5y1sDS/I9eKM+UypJeSMqY5/z1+ptFoPmH8TR1Jg
	Y+L6zhQQXR0FEzwjRntMFzvplrIAQeaLTVz0ZP/ZtWmD9MwaLavUnjcEZURgTC5GQWGi7449p9I
	e4tdMMFoImv1y8szP3rppC+N8kbpBDOiZLvA=
X-Gm-Gg: ASbGnctJMpb81neD4TUKHRFHH7uc2HJTKX4GbMH2go0rtW1OM1x0OECvKRnGeCNh6ZB
	Av7tCY/Za79jTOoahs0y39P1RHIswGSh9tkpoZtm9YWLKRz/iopDdWIITgKRjDtyQpJd0e2pG4x
	0Pm+uF2xEOeBgIMRutBuliPzHJ
X-Google-Smtp-Source: AGHT+IFGHeVYz38TGOV840COFqtkKSeZ5k6jmZrag10T/g7B+stQSDtu1qOvalE7rAOmf25YwCBwt7AQ1aZWnxysvyw=
X-Received: by 2002:a17:907:8692:b0:ac1:f002:d840 with SMTP id
 a640c23a62f3a-ac1f002dad3mr392459066b.45.1741101950621; Tue, 04 Mar 2025
 07:25:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303230409.452687-1-mjguzik@gmail.com> <20250303230409.452687-4-mjguzik@gmail.com>
 <20250304141946.GM5880@noisy.programming.kicks-ass.net>
In-Reply-To: <20250304141946.GM5880@noisy.programming.kicks-ass.net>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 4 Mar 2025 16:25:37 +0100
X-Gm-Features: AQ5f1JogDr32Wjf_6y39UBN0_-QDtpl8NMRtmgym3YqTHHIFOzc1kgxCHJXxr4E
Message-ID: <CAGudoHG66-gnSkyAQ4O-ez09ef-0WuvrXah-nu_j2DEXKFsDag@mail.gmail.com>
Subject: Re: [PATCH 3/3] wait: avoid spurious calls to prepare_to_wait_event()
 in ___wait_event()
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, oleg@redhat.com, brauner@kernel.org, 
	mingo@redhat.com, rostedt@goodmis.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000049204f062f85e341"

--00000000000049204f062f85e341
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 3:19=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Tue, Mar 04, 2025 at 12:04:09AM +0100, Mateusz Guzik wrote:
> > In vast majority of cases the condition determining whether the thread
> > can proceed is true after the first wake up.
> >
> > However, even in that case the thread ends up calling into
> > prepare_to_wait_event() again, suffering a spurious irq + lock trip.
> >
> > Then it calls into finish_wait() to unlink itself.
> >
> > Note that in case of a pending signal the work done by
> > prepare_to_wait_event() gets ignored even without the change.
> >
> > pre-check the condition after waking up instead.
> >
> > Stats gathared during a kernel build:
> > bpftrace -e 'kprobe:prepare_to_wait_event,kprobe:finish_wait \
> >                { @[probe] =3D count(); }'
> >
> > @[kprobe:finish_wait]: 392483
> > @[kprobe:prepare_to_wait_event]: 778690
> >
> > As in calls to prepare_to_wait_event() almost double calls to
> > finish_wait(). This evens out with the patch.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
> >
> > One may worry about using "condition" twice. However, macros leading up
> > to this one already do it, so it should be fine.
> >
> > Also one may wonder about fences -- to my understanding going off and o=
n
> > CPU guarantees a full fence, so the now avoided lock trip changes
> > nothing.
>
> so it always helps if you provide actual numbers. Supposedly this makes
> it go faster?
>
> Also, how much bytes does it add to the image?
>
> Anyway, no real objection, but it would be good to have better
> substantiation etc.
>

I did not bother benchmarking this per se, but I did demonstrate with
bpftrace above that this does avoid the irq and lock usage, which is
normally the desired outcome.

It is a fair point that in this case this is a tradeoff with i-cache footpr=
int.

bloat-o-meter claims:
add/remove: 2/2 grow/shrink: 159/5 up/down: 3865/-250 (3615)
[..]
Total: Before=3D29946099, After=3D29949714, chg +0.01%

The biggest growth, by a large margin:
will_read_block.part                           -     183    +183
fuse_get_req                                 800     924    +124
load_module                                 9137    9255    +118
fuse_do_readfolio                            415     528    +113
fuse_page_mkwrite                            157     259    +102

On the other hand the shrinkage:
port_fops_read                               504     503      -1
__ps2_command                               1402    1401      -1
fcntl_setlk                                  961     947     -14
__pfx_fuse_wait_on_folio_writeback            16       -     -16
load_compressed_image                       4007    3974     -33
uprobe_notify_resume                        3384    3323     -61
fuse_wait_on_folio_writeback                 124       -    -124

The entire thing is attached.


--
Mateusz Guzik <mjguzik gmail.com>

--00000000000049204f062f85e341
Content-Type: text/plain; charset="US-ASCII"; name="bloat.txt"
Content-Disposition: attachment; filename="bloat.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m7un4sji0>
X-Attachment-Id: f_m7un4sji0

YWRkL3JlbW92ZTogMi8yIGdyb3cvc2hyaW5rOiAxNTkvNSB1cC9kb3duOiAzODY1Ly0yNTAgKDM2
MTUpCkZ1bmN0aW9uICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9sZCAgICAg
bmV3ICAgZGVsdGEKd2lsbF9yZWFkX2Jsb2NrLnBhcnQgICAgICAgICAgICAgICAgICAgICAgICAg
ICAtICAgICAxODMgICAgKzE4MwpmdXNlX2dldF9yZXEgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICA4MDAgICAgIDkyNCAgICArMTI0CmxvYWRfbW9kdWxlICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgOTEzNyAgICA5MjU1ICAgICsxMTgKZnVzZV9kb19yZWFkZm9saW8gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgNDE1ICAgICA1MjggICAgKzExMwpmdXNlX3BhZ2VfbWt3
cml0ZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAxNTcgICAgIDI1OSAgICArMTAyCndhaXRf
cG9ydF93cml0YWJsZSAgICAgICAgICAgICAgICAgICAgICAgICAgIDU0NSAgICAgNjQyICAgICAr
OTcKa3NtX3NjYW5fdGhyZWFkICAgICAgICAgICAgICAgICAgICAgICAgICAgICA4MTg5ICAgIDgy
NzAgICAgICs4MQpzZ19pb2N0bCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDI4
MzkgICAgMjkxOCAgICAgKzc5CmZ1c2Vfd2FpdF9vbl9mb2xpb193cml0ZWJhY2sucGFydCAgICAg
ICAgICAgIDIwMiAgICAgMjgwICAgICArNzgKcmluZ19idWZmZXJfd2FpdCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgNDMxICAgICA1MDAgICAgICs2OQpfX2Jpb19xdWV1ZV9lbnRlciAgICAg
ICAgICAgICAgICAgICAgICAgICAgICA1NTEgICAgIDYxNyAgICAgKzY2CmRybV93YWl0X3ZibGFu
a19pb2N0bCAgICAgICAgICAgICAgICAgICAgICAgMTY5MiAgICAxNzU2ICAgICArNjQKYmxrX3F1
ZXVlX2VudGVyICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgNDkwICAgICA1NTQgICAgICs2
NAphZGRfdHJhbnNhY3Rpb25fY3JlZGl0cyAgICAgICAgICAgICAgICAgICAgICA3MDAgICAgIDc2
MiAgICAgKzYyCmtodWdlcGFnZWQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMjE5
NyAgICAyMjU2ICAgICArNTkKc2dfb3BlbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAxNjYzICAgIDE3MjEgICAgICs1OApzZ19yZWFkICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDE1MjMgICAgMTU3OSAgICAgKzU2CmZ1c2VfZGV2X2RvX3JlYWQgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgMjQwNSAgICAyNDU5ICAgICArNTQKam95ZGV2X3JlYWQgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAxMTA2ICAgIDExNTggICAgICs1MgpidHJmc193
YWl0X2Jsb2NrX2dyb3VwX2NhY2hlX3Byb2dyZXNzICAgICAgICAzNzAgICAgIDQyMCAgICAgKzUw
CnN5c2xvZ19wcmludCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDcwOSAgICAgNzU3
ICAgICArNDgKdXNiX3dhaXRfYW5jaG9yX2VtcHR5X3RpbWVvdXQgICAgICAgICAgICAgICAgMjM1
ICAgICAyODAgICAgICs0NQptbXVfaW50ZXJ2YWxfbm90aWZpZXJfcmVtb3ZlICAgICAgICAgICAg
ICAgICA0MTIgICAgIDQ1NiAgICAgKzQ0CmVjX2d1YXJkICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDUxMCAgICAgNTU0ICAgICArNDQKa2NvbXBhY3RkICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgOTYxICAgIDEwMDQgICAgICs0Mwp3YWl0X2Zvcl90cG1fc3Rh
dCAgICAgICAgICAgICAgICAgICAgICAgICAgICA2NjkgICAgIDcxMSAgICAgKzQyCnBzaV9ydHBv
bGxfd29ya2VyICAgICAgICAgICAgICAgICAgICAgICAgICAgIDkwNiAgICAgOTQ4ICAgICArNDIK
YW5vbl9waXBlX3dyaXRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAxNTgxICAgIDE2MjEg
ICAgICs0MAprc2d4ZCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAzNTcg
ICAgIDM5NCAgICAgKzM3CmJ0cmZzX2NvbW1pdF90cmFuc2FjdGlvbiAgICAgICAgICAgICAgICAg
ICAgMzU5OCAgICAzNjM0ICAgICArMzYKc2NzaV9ibG9ja193aGVuX3Byb2Nlc3NpbmdfZXJyb3Jz
ICAgICAgICAgICAgMjAwICAgICAyMzQgICAgICszNApzYXZlX2NvbXByZXNzZWRfaW1hZ2UgICAg
ICAgICAgICAgICAgICAgICAgIDI2OTUgICAgMjcyOCAgICAgKzMzCnZpcnRpb19ncHVfaW5pdCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgMjI0OSAgICAyMjgxICAgICArMzIKcmVnbWFwX2Fz
eW5jX2NvbXBsZXRlLnBhcnQgICAgICAgICAgICAgICAgICAgNDEzICAgICA0NDQgICAgICszMQpm
dXNlX3dhaXRfb25fcGFnZV93cml0ZWJhY2sgICAgICAgICAgICAgICAgICAxODUgICAgIDIxNiAg
ICAgKzMxCmZhbm90aWZ5X2hhbmRsZV9ldmVudCAgICAgICAgICAgICAgICAgICAgICAgNjA1NiAg
ICA2MDg3ICAgICArMzEKY3J0Y19jcmNfcmVhZCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgNzE4ICAgICA3NDkgICAgICszMQphY3BpX2VjX3N0b3AgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICA0MTggICAgIDQ0OCAgICAgKzMwCmZ1c2VfcmVhZGFoZWFkICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIDkzMCAgICAgOTU5ICAgICArMjkKcGlwZV93YWl0X3dyaXRhYmxl
ICAgICAgICAgICAgICAgICAgICAgICAgICAgMjM0ICAgICAyNjIgICAgICsyOApldmRldl9yZWFk
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA2NDMgICAgIDY3MSAgICAgKzI4CnBz
Ml9kcmFpbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDMyMiAgICAgMzQ5ICAg
ICArMjcKX190cG1fdGlzX3JlcXVlc3RfbG9jYWxpdHkgICAgICAgICAgICAgICAgICAgNDY2ICAg
ICA0OTIgICAgICsyNgp0aHJvdHRsZV9kaXJlY3RfcmVjbGFpbSAgICAgICAgICAgICAgICAgICAg
ICA2MjYgICAgIDY1MSAgICAgKzI1CnBzMl9kb19zZW5kYnl0ZSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIDUzOSAgICAgNTYzICAgICArMjQKZHJtX2F0b21pY19oZWxwZXJfd2FpdF9mb3Jf
dmJsYW5rcy5wYXJ0ICAgICAgNTM4ICAgICA1NjIgICAgICsyNApkZXZrbXNnX3JlYWQgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICA0NjcgICAgIDQ5MSAgICAgKzI0CnNldF90ZXJtaW9z
LnBhcnQgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDYzNyAgICAgNjYwICAgICArMjMKZnVz
ZV93YWl0X2Fib3J0ZWQgICAgICAgICAgICAgICAgICAgICAgICAgICAgMjUyICAgICAyNzUgICAg
ICsyMwpidHJmc19jYWNoaW5nX2N0bF93YWl0X2RvbmUgICAgICAgICAgICAgICAgICAxNzcgICAg
IDIwMCAgICAgKzIzCmZ1c2VfZmlsZV9jYWNoZWRfaW9fb3BlbiAgICAgICAgICAgICAgICAgICAg
IDM3NyAgICAgMzk5ICAgICArMjIKYnRyZnNfc2NydWJfcGF1c2UgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgMjMzICAgICAyNTUgICAgICsyMgp2aXJ0YmFsbG9vbl9mcmVlX3BhZ2VfcmVwb3J0
ICAgICAgICAgICAgICAgICAyMTkgICAgIDI0MCAgICAgKzIxCmxvY2tzX2xvY2tfaW5vZGVfd2Fp
dCAgICAgICAgICAgICAgICAgICAgICAgIDM1NyAgICAgMzc4ICAgICArMjEKdXNiaGlkX3dhaXRf
aW8gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMjM4ICAgICAyNTggICAgICsyMApzZXJp
b19yYXdfcmVhZCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA1MjEgICAgIDU0MSAgICAg
KzIwCnJlcXVlc3Rfd2FpdF9hbnN3ZXIgICAgICAgICAgICAgICAgICAgICAgICAgIDUxOSAgICAg
NTM5ICAgICArMjAKYnRyZnNfcGF1c2VfYmFsYW5jZSAgICAgICAgICAgICAgICAgICAgICAgICAg
MjY0ICAgICAyODQgICAgICsyMApibGtfbXFfZnJlZXplX3F1ZXVlX3dhaXRfdGltZW91dCAgICAg
ICAgICAgICAyMTMgICAgIDIzMyAgICAgKzIwCmFub25fcGlwZV9yZWFkICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDk3MCAgICAgOTkwICAgICArMjAKc2hwY193cml0ZV9jbWQgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgNjU2ICAgICA2NzUgICAgICsxOQptb3VzZWRldl9yZWFk
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA0NTcgICAgIDQ3NiAgICAgKzE5CmJ0cmZz
X2NvbW1pdF90cmFuc2FjdGlvbl9hc3luYyAgICAgICAgICAgICAgIDI1MyAgICAgMjcyICAgICAr
MTkKdGVsbF9ob3N0ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMjI2ICAgICAy
NDQgICAgICsxOApvb21fa2lsbGVyX2Rpc2FibGUgICAgICAgICAgICAgICAgICAgICAgICAgICAy
ODEgICAgIDI5OSAgICAgKzE4CnZpcnRncHVfdmlydGlvX2dldF91dWlkICAgICAgICAgICAgICAg
ICAgICAgIDIwMCAgICAgMjE3ICAgICArMTcKcGlwZV93YWl0X3JlYWRhYmxlICAgICAgICAgICAg
ICAgICAgICAgICAgICAgMjI4ICAgICAyNDUgICAgICsxNwphc3luY19zeW5jaHJvbml6ZV9jb29r
aWVfZG9tYWluICAgICAgICAgICAgICAyODUgICAgIDMwMiAgICAgKzE3CmpiZDJfam91cm5hbF9k
ZXN0cm95ICAgICAgICAgICAgICAgICAgICAgICAgIDc2OCAgICAgNzg0ICAgICArMTYKZGVjb21w
cmVzc190aHJlYWRmbiAgICAgICAgICAgICAgICAgICAgICAgICAgMzIzICAgICAzMzkgICAgICsx
NgpjcmMzMl90aHJlYWRmbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAzMTcgICAgIDMz
MyAgICAgKzE2CmNvbXByZXNzX3RocmVhZGZuICAgICAgICAgICAgICAgICAgICAgICAgICAgIDM0
NCAgICAgMzYwICAgICArMTYKX19wZnhfd2lsbF9yZWFkX2Jsb2NrLnBhcnQgICAgICAgICAgICAg
ICAgICAgICAtICAgICAgMTYgICAgICsxNgp3YWl0X2N1cnJlbnRfdHJhbnMgICAgICAgICAgICAg
ICAgICAgICAgICAgICAyOTYgICAgIDMxMSAgICAgKzE1CnBjaWVocF9zeXNmc19lbmFibGVfc2xv
dCAgICAgICAgICAgICAgICAgICAgIDQwMyAgICAgNDE4ICAgICArMTUKcGNpZWhwX3N5c2ZzX2Rp
c2FibGVfc2xvdCAgICAgICAgICAgICAgICAgICAgMzkyICAgICA0MDcgICAgICsxNQptb2R1bGVf
cGF0aWVudF9jaGVja19leGlzdHMuaXNyYSAgICAgICAgICAgICAzMTMgICAgIDMyOCAgICAgKzE1
CmJ0cmZzX2JhbGFuY2VfZGVsYXllZF9pdGVtcyAgICAgICAgICAgICAgICAgIDQzNiAgICAgNDUw
ICAgICArMTQKZ2VubF91bnJlZ2lzdGVyX2ZhbWlseSAgICAgICAgICAgICAgICAgICAgICAgNDgw
ICAgICA0OTMgICAgICsxMwpidHJmc19ybV9kZXZfcmVwbGFjZV9ibG9ja2VkICAgICAgICAgICAg
ICAgICAxNTkgICAgIDE3MiAgICAgKzEzCnBjaV9kcGNfcmVjb3ZlcmVkICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDIxMiAgICAgMjI0ICAgICArMTIKamJkMl9sb2dfd2FpdF9jb21taXQgICAg
ICAgICAgICAgICAgICAgICAgICAgMjY5ICAgICAyODEgICAgICsxMgpmdXNlX3N5bmNfZnMgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICA1NjkgICAgIDU4MSAgICAgKzEyCmZ1c2Vfc2V0
X25vd3JpdGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDIxMiAgICAgMjI0ICAgICArMTIK
Zmx1c2hfc2NydWJfc3RyaXBlcyAgICAgICAgICAgICAgICAgICAgICAgICAgNjE1ICAgICA2Mjcg
ICAgICsxMgpkcm1fdmJsYW5rX3dvcmtfZmx1c2hfYWxsICAgICAgICAgICAgICAgICAgICAyMTcg
ICAgIDIyOSAgICAgKzEyCmRybV9yZWFkICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDY3OCAgICAgNjkwICAgICArMTIKYmxrX21xX2ZyZWV6ZV9xdWV1ZV93YWl0ICAgICAgICAg
ICAgICAgICAgICAgMTUwICAgICAxNjIgICAgICsxMgpybXdfcmJpbyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIDI2NzMgICAgMjY4NCAgICAgKzExCnBzZXVkb19sb2NrX21lYXN1
cmVfdHJpZ2dlciAgICAgICAgICAgICAgICAgIDc0MCAgICAgNzUxICAgICArMTEKcGVyY3B1X3Jl
Zl9zd2l0Y2hfdG9fYXRvbWljX3N5bmMgICAgICAgICAgICAgMTg2ICAgICAxOTcgICAgICsxMQpm
bHVzaF9zcGFjZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDEzOTUgICAgMTQwNiAg
ICAgKzExCmJ0cmZzX2Jpb19jb3VudGVyX2luY19ibG9ja2VkICAgICAgICAgICAgICAgIDI1NiAg
ICAgMjY3ICAgICArMTEKX191c2VybW9kZWhlbHBlcl9kaXNhYmxlICAgICAgICAgICAgICAgICAg
ICAgMzA4ICAgICAzMTkgICAgICsxMQp3YWl0X3NjcnViX3N0cmlwZV9pbyAgICAgICAgICAgICAg
ICAgICAgICAgICAxMzggICAgIDE0OCAgICAgKzEwCndhaXRfZm9yX2RldmljZV9wcm9iZSAgICAg
ICAgICAgICAgICAgICAgICAgIDE0OCAgICAgMTU4ICAgICArMTAKdXNiZGV2X2lvY3RsICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICA1MjMxICAgIDUyNDEgICAgICsxMApzeW5jaHJvbml6
ZV9yY3VfZXhwZWRpdGVkICAgICAgICAgICAgICAgICAgICA0NTkgICAgIDQ2OSAgICAgKzEwCnNl
cmlhbF9jb3JlX3VucmVnaXN0ZXJfcG9ydCAgICAgICAgICAgICAgICAgIDczOSAgICAgNzQ5ICAg
ICArMTAKcGNpX2RvZV93YWl0LmNvbnN0cHJvcCAgICAgICAgICAgICAgICAgICAgICAgMTkzICAg
ICAyMDMgICAgICsxMApvb21fcmVhcGVyICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICA5NzMgICAgIDk4MyAgICAgKzEwCmtlcm5mc19kcmFpbiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIDMwNSAgICAgMzE1ICAgICArMTAKa2F1ZGl0ZF90aHJlYWQgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgNjc3ICAgICA2ODcgICAgICsxMApqYmQyX2pvdXJuYWxfbG9ja191
cGRhdGVzICAgICAgICAgICAgICAgICAgICAyMTAgICAgIDIyMCAgICAgKzEwCmpiZDJfam91cm5h
bF9sb2FkICAgICAgICAgICAgICAgICAgICAgICAgICAgIDg5MSAgICAgOTAxICAgICArMTAKaW9z
Zl9tYmlfcHVuaXRfYWNxdWlyZSAgICAgICAgICAgICAgICAgICAgICAgMTg0ICAgICAxOTQgICAg
ICsxMAppb3NmX21iaV9ibG9ja19wdW5pdF9pMmNfYWNjZXNzICAgICAgICAgICAgICA4MTggICAg
IDgyOCAgICAgKzEwCmZzbm90aWZ5X2Rlc3Ryb3lfZ3JvdXAgICAgICAgICAgICAgICAgICAgICAg
IDIxMyAgICAgMjIzICAgICArMTAKZXhwYW5kX2ZpbGVzICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgNjY3ICAgICA2NzcgICAgICsxMApleHBfZnVubmVsX2xvY2sgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICA1MDMgICAgIDUxMyAgICAgKzEwCmRtX3dhaXRfZXZlbnQgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDE1NyAgICAgMTY3ICAgICArMTAKY3B1c2V0X2hhbmRs
ZV9ob3RwbHVnICAgICAgICAgICAgICAgICAgICAgICAzMjQxICAgIDMyNTEgICAgICsxMApidHJm
c193YWl0X29uX2RlbGF5ZWRfaXB1dHMgICAgICAgICAgICAgICAgICAxNjAgICAgIDE3MCAgICAg
KzEwCmJ0cmZzX3NjcnViX2NhbmNlbF9kZXYgICAgICAgICAgICAgICAgICAgICAgIDI1NSAgICAg
MjY1ICAgICArMTAKYnRyZnNfc2NydWJfY2FuY2VsICAgICAgICAgICAgICAgICAgICAgICAgICAg
MjUyICAgICAyNjIgICAgICsxMApidHJmc19yZW1vdW50X2JlZ2luICAgICAgICAgICAgICAgICAg
ICAgICAgICAyMjEgICAgIDIzMSAgICAgKzEwCmJ0cmZzX2RyZXdfd3JpdGVfbG9jayAgICAgICAg
ICAgICAgICAgICAgICAgIDE5OSAgICAgMjA5ICAgICArMTAKX19zeW5jaHJvbml6ZV9pcnEgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgMTQ4ICAgICAxNTggICAgICsxMApfX3NjcnViX2Jsb2Nr
ZWRfaWZfbmVlZGVkICAgICAgICAgICAgICAgICAgICAxODUgICAgIDE5NSAgICAgKzEwCnZpcnRp
b19ncHVfdnJhbV9tbWFwICAgICAgICAgICAgICAgICAgICAgICAgIDQ4NCAgICAgNDkzICAgICAg
KzkKdmlydGlvX2dwdV9nZXRfY2Fwc19pb2N0bCAgICAgICAgICAgICAgICAgICAgNTU1ICAgICA1
NjQgICAgICArOQp0cnlfZmx1c2hfcWdyb3VwICAgICAgICAgICAgICAgICAgICAgICAgICAgICAy
NzUgICAgIDI4NCAgICAgICs5CnN0YXJ0X3RoaXNfaGFuZGxlICAgICAgICAgICAgICAgICAgICAg
ICAgICAgMTI0MyAgICAxMjUyICAgICAgKzkKc2NydWJfcmFpZDU2X3Bhcml0eV9zdHJpcGUgICAg
ICAgICAgICAgICAgICAxMzI4ICAgIDEzMzcgICAgICArOQpwY2llX3dhaXRfY21kICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICA1NjggICAgIDU3NyAgICAgICs5CnBjaV93YWl0X2NmZyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDE3MCAgICAgMTc5ICAgICAgKzkKbnNfcmV2
aXNpb25fcmVhZCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMzk0ICAgICA0MDMgICAgICAr
OQptbXVfaW50ZXJ2YWxfcmVhZF9iZWdpbiAgICAgICAgICAgICAgICAgICAgICAxOTAgICAgIDE5
OSAgICAgICs5CmRybV92Ymxhbmtfd29ya19mbHVzaCAgICAgICAgICAgICAgICAgICAgICAgIDE5
NSAgICAgMjA0ICAgICAgKzkKZHF1b3RfZGlzYWJsZSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAxNTk2ICAgIDE2MDUgICAgICArOQpkbV9rY29weWRfY2xpZW50X2Rlc3Ryb3kgICAgICAg
ICAgICAgICAgICAgICAzNTMgICAgIDM2MiAgICAgICs5CmNwdWZyZXFfZnJlcV90cmFuc2l0aW9u
X2JlZ2luICAgICAgICAgICAgICAgIDMzMyAgICAgMzQyICAgICAgKzkKY3BwY19zZXRfcGVyZiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgODg1ICAgICA4OTQgICAgICArOQpidHJmc19j
YW5jZWxfYmFsYW5jZSAgICAgICAgICAgICAgICAgICAgICAgICAzMzkgICAgIDM0OCAgICAgICs5
Cndha2VfdXBfYW5kX3dhaXRfZm9yX2lycV90aHJlYWRfcmVhZHkgICAgICAgIDE1NiAgICAgMTY0
ICAgICAgKzgKc3F1YXNoZnNfY2FjaGVfZ2V0ICAgICAgICAgICAgICAgICAgICAgICAgICAgNzk5
ICAgICA4MDcgICAgICArOApzY3J1Yl9yYmlvX3dvcmtfbG9ja2VkICAgICAgICAgICAgICAgICAg
ICAgIDIyNTAgICAgMjI1OCAgICAgICs4CnJkdGdyb3VwX3BzZXVkb19sb2NrX2NyZWF0ZSAgICAg
ICAgICAgICAgICAgMTcyNSAgICAxNzMzICAgICAgKzgKZHJtX3dhaXRfb25lX3ZibGFuayAgICAg
ICAgICAgICAgICAgICAgICAgICAgNDczICAgICA0ODEgICAgICArOApjbG9zZV9jdHJlZSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDEyNTggICAgMTI2NiAgICAgICs4CmJ0cmZzX3dy
aXRlX2RpcnR5X2Jsb2NrX2dyb3VwcyAgICAgICAgICAgICAgIDkxMCAgICAgOTE4ICAgICAgKzgK
YnRyZnNfc3RhcnRfb3JkZXJlZF9leHRlbnRfbm93cml0ZWJhY2sgICAgICAgMzc5ICAgICAzODcg
ICAgICArOApidHJmc19jbGVhbnVwX3RyYW5zYWN0aW9uLmlzcmEgICAgICAgICAgICAgIDEzNzMg
ICAgMTM4MSAgICAgICs4CmF1dG9mc193YWl0ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgMTc2MyAgICAxNzcxICAgICAgKzgKd2FpdF9mb3JfcmFuZG9tX2J5dGVzICAgICAgICAgICAg
ICAgICAgICAgICAgMjM1ICAgICAyNDIgICAgICArNwp2aXJ0aW9fZ3B1X2N1cnNvcl9waW5nICAg
ICAgICAgICAgICAgICAgICAgICA2NDcgICAgIDY1NCAgICAgICs3CnVzYl9wb2lzb25fdXJiICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDE3NiAgICAgMTgzICAgICAgKzcKdXNiX2tpbGxf
dXJiLnBhcnQgICAgICAgICAgICAgICAgICAgICAgICAgICAgMTQ5ICAgICAxNTYgICAgICArNwpy
Y3Vfc3luY19lbnRlciAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAyNTEgICAgIDI1OCAg
ICAgICs3CmlvX3NxZF9oYW5kbGVfZXZlbnQgICAgICAgICAgICAgICAgICAgICAgICAgIDMwNSAg
ICAgMzEyICAgICAgKzcKYnRyZnNfZHJld19yZWFkX2xvY2sgICAgICAgICAgICAgICAgICAgICAg
ICAgMTM2ICAgICAxNDMgICAgICArNwpfX3Z0X2V2ZW50X3dhaXQucGFydCAgICAgICAgICAgICAg
ICAgICAgICAgICAxMjIgICAgIDEyOSAgICAgICs3Cl9fcGVyY3B1X3JlZl9zd2l0Y2hfbW9kZSAg
ICAgICAgICAgICAgICAgICAgIDQ1OCAgICAgNDY1ICAgICAgKzcKd2Jfd2FpdF9mb3JfY29tcGxl
dGlvbiAgICAgICAgICAgICAgICAgICAgICAgMTMwICAgICAxMzYgICAgICArNgpoaWJfd2FpdF9p
byAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAxMzEgICAgIDEzNyAgICAgICs2CmRv
X2NvcmVkdW1wICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgNjY2NyAgICA2NjczICAg
ICAgKzYKeGZzX3B3b3JrX3BvbGwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMTg2ICAg
ICAxOTEgICAgICArNQp2aXJ0aW9fZ3B1X3F1ZXVlX2N0cmxfc2dzICAgICAgICAgICAgICAgICAg
ICA2NDggICAgIDY1MyAgICAgICs1CnR0eV93YWl0X3VudGlsX3NlbnQgICAgICAgICAgICAgICAg
ICAgICAgICAgIDQyOSAgICAgNDM0ICAgICAgKzUKc3VibWl0X3JlYWRfd2FpdF9iaW9fbGlzdCAg
ICAgICAgICAgICAgICAgICAgMzczICAgICAzNzcgICAgICArNAp3YWl0X2Zvcl9jb21taXQgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICA0MDEgICAgIDQwMiAgICAgICsxCnBvcnRfZm9wc19y
ZWFkICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDUwNCAgICAgNTAzICAgICAgLTEKX19w
czJfY29tbWFuZCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAxNDAyICAgIDE0MDEgICAg
ICAtMQpmY250bF9zZXRsayAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA5NjEgICAg
IDk0NyAgICAgLTE0Cl9fcGZ4X2Z1c2Vfd2FpdF9vbl9mb2xpb193cml0ZWJhY2sgICAgICAgICAg
ICAxNiAgICAgICAtICAgICAtMTYKbG9hZF9jb21wcmVzc2VkX2ltYWdlICAgICAgICAgICAgICAg
ICAgICAgICA0MDA3ICAgIDM5NzQgICAgIC0zMwp1cHJvYmVfbm90aWZ5X3Jlc3VtZSAgICAgICAg
ICAgICAgICAgICAgICAgIDMzODQgICAgMzMyMyAgICAgLTYxCmZ1c2Vfd2FpdF9vbl9mb2xpb193
cml0ZWJhY2sgICAgICAgICAgICAgICAgIDEyNCAgICAgICAtICAgIC0xMjQKVG90YWw6IEJlZm9y
ZT0yOTk0NjA5OSwgQWZ0ZXI9Mjk5NDk3MTQsIGNoZyArMC4wMSUK
--00000000000049204f062f85e341--


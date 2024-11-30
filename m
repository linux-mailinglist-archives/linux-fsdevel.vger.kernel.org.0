Return-Path: <linux-fsdevel+bounces-36179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570ED9DEF35
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 08:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02130162FBC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 07:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A166F142E6F;
	Sat, 30 Nov 2024 07:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Gv0kQ7vU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A923F9C5
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 Nov 2024 07:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732950968; cv=none; b=CigTGixojUnEuMpU0r82nx7faMDWFp/QVzbZS7z37FHBoY6tXrnXmJtdW/l26h+6nyuyhzH+2Q8GCECL6VKVYv21LwhTjPzSRc6nalgYTSqDMFShcmGH4XUdjVgCGt7uz7SCW69/DomPuz01aC5v2MWLsud9/Qo+a9YRJxF0JOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732950968; c=relaxed/simple;
	bh=ZuGzMu1cAhdhKnxWmpQYt48/+C2Q2jjl167J8oEkP9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KxOEIH5Es765MtPjZTbsLEkWuMaWFtzoPHQc9sUqBoh+yJXafUzk1IYyqvnzrP4DtutZDe3KU+UUoqqgU+kg3zA+Kw1jkYbvjPaX08CV1pMJhcfcMtiiFqX3R/hrLDHG5CisTSJ8gW3iPlXn7WYm9NKje9vT5s4ciUau02knvl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Gv0kQ7vU; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa549f2fa32so368462366b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2024 23:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732950962; x=1733555762; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SjT13Cv4AdQa2fEkQJmI8w/5/0E5OcwQAJoY5vQggB4=;
        b=Gv0kQ7vU6hmQflHVz7EP454on0ZMSTK06hYpQ5lWQiPje8cB7uKzJ/ngkJjHLmIDaz
         nqbmnZazIg4ZEDU6XCKFbPSOnGNqDgvLI0FFL+y42tLBHFiBMuOriFVEfRO4zVAcxxiw
         Q466Z+MUGIgTOW6nUGvvZntetrZ9Cjdy1XKGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732950962; x=1733555762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjT13Cv4AdQa2fEkQJmI8w/5/0E5OcwQAJoY5vQggB4=;
        b=QtEko7pG/yl8FyRr9rjeuPFUQ2pEDNQPJcAertcp7zef6joJ33UISV6zH77CMWbH0k
         9UIe1p6RMnfKKVsFJz8AssovrxIwyYLtc/GpHbJMdlEAo7WFkozMaLplR/hSMIe3ILYr
         YUdsBoLG4dVBGcnSpRycw/oWamkbuI3mZm+iZ+3MQQFl+7wm8rNSBKWG629PPXZx0mIo
         zZA/+0gCRDiMPyDERRXFcuKczX8awvQj6S9hoHB1EJCqaHRyhF6ikzgCTpKtpHE64HTx
         8R29IeDXcDce7XtRePKKTOcv01DdN1Nn0ZpNXYwqXh00d+SJ/SmbcQIfSjiV+pedrA9C
         vMSg==
X-Forwarded-Encrypted: i=1; AJvYcCUep9lt3C7cZv0Cwb5xPWuqPpqn6WAe3OQMJhQy2ZownJ73xbUkybZVXhJST4LQadW0mkEx6El6sE+0QNR7@vger.kernel.org
X-Gm-Message-State: AOJu0YwLtM49jSb81ztTva9npGE+6Sdnt4X1Z3Oox1EjalmUYXykqQZO
	IfnoyP+PtpX9+0EIj9Go6obJhq7X/d8a2k5Muxob/pMe4+4cBMKD0bTMbhqb5nZDQ2R7EOGdFBE
	7nFZIqg==
X-Gm-Gg: ASbGncu23laAR+KCrH6oppZ1+X3kTKxl8CPqQwXlHoH7ZnsTbyQqJpgPvxgNULI2Omx
	U98/EafLHRVXqZqF6P3N7lAk6SlZb4A6i7el4bgOtW9rfe3oAEC3/Pl1QxX8gV/nHL6mTGgATch
	3MUeRfip0Q1UfN5qidbR5UrvsfYynOnZuwjre+BAaCMOLL/FX1Nvq6O8FtQvgjy5vOGQPsGS4EN
	m5v+4UESe103V5saJfqnCzIYpDnT3jV8Jv07EZiEhT4V2ePhOPQtY+GCJ8hGwxmXqgYvtYnqBsB
	mD/Zzhfgs0Ilp67pwvCSmtbc
X-Google-Smtp-Source: AGHT+IEgP5y0IwSpTQtaTzuoTPIj09BOUgo+MUypOGO3HGXcyK53akP52/iYcWtNlQbUhjMZP/mE/Q==
X-Received: by 2002:a17:906:318c:b0:a99:7bc0:bca9 with SMTP id a640c23a62f3a-aa580ef0e02mr1136245666b.3.1732950962303;
        Fri, 29 Nov 2024 23:16:02 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59990a8f0sm250647566b.160.2024.11.29.23.16.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 23:16:01 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa535eed875so378475766b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2024 23:16:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWso5kmqD8UZTk66Yz3GGYWLqy0No/Ub93PILs6Rmgkej1SztJTffY8XiGERtNt8m7XIBeoDeQPjXSqrXcJ@vger.kernel.org
X-Received: by 2002:a17:907:7758:b0:aa5:3d75:f419 with SMTP id
 a640c23a62f3a-aa580f2af8bmr1208100366b.13.1732950961012; Fri, 29 Nov 2024
 23:16:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130044909.work.541-kees@kernel.org>
In-Reply-To: <20241130044909.work.541-kees@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Nov 2024 23:15:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjAmu9OBS--RwB+HQn4nhUku=7ECOnSRP8JG0oRU97-kA@mail.gmail.com>
Message-ID: <CAHk-=wjAmu9OBS--RwB+HQn4nhUku=7ECOnSRP8JG0oRU97-kA@mail.gmail.com>
Subject: Re: [PATCH] exec: Make sure task->comm is always NUL-terminated
To: Kees Cook <kees@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chen Yu <yu.c.chen@intel.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000007218e906281c16e8"

--0000000000007218e906281c16e8
Content-Type: text/plain; charset="UTF-8"

Edited down to just the end result:

On Fri, 29 Nov 2024 at 20:49, Kees Cook <kees@kernel.org> wrote:
>
>  void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
>  {
>         size_t len = min(strlen(buf), sizeof(tsk->comm) - 1);
>
>         trace_task_rename(tsk, buf);
>         memcpy(tsk->comm, buf, len);
>         memset(&tsk->comm[len], 0, sizeof(tsk->comm) - len);
>         perf_event_comm(tsk, exec);
>  }

I actually don't think that's super-safe either. Yeah, it works in
practice, and the last byte is certainly always going to be 0, but it
might not be reliably padded.

Why? It walks over the source twice. First at strlen() time, then at
memcpy. So if the source isn't stable, the end result might have odd
results with NUL characters in the middle.

And strscpy() really was *supposed* to be safe even in this case, and
I thought it was until I looked closer.

But I think strscpy() can be saved.

Something (UNTESTED!) like the attached I think does the right thing.
I added a couple of "READ_ONCE()" things to make it really super-clear
that strscpy() reads the source exactly once, and to not allow any
compiler re-materialization of the reads (although I think that when I
asked people, it turns out neither gcc nor clang rematerialize memory
accesses, so that READ_ONCE is likely more a documentation ad
theoretical thing than a real thing).

And yes, we could make the word-at-a-time case also know about masking
the last word, but it's kind of annoying and depends on byte ordering.

Hmm? I don't think your version is wrong, but I also think we'd be
better off making our 'strscpy()' infrastructure explicitly safe wrt
unstable source strings.

          Linus

--0000000000007218e906281c16e8
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_m43u8l1f0>
X-Attachment-Id: f_m43u8l1f0

IGxpYi9zdHJpbmcuYyB8IDE0ICsrKysrKystLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNl
cnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2xpYi9zdHJpbmcuYyBiL2xp
Yi9zdHJpbmcuYwppbmRleCA3NjMyN2I1MWUzNmYuLmEyYTY3OGU0NTM4OSAxMDA2NDQKLS0tIGEv
bGliL3N0cmluZy5jCisrKyBiL2xpYi9zdHJpbmcuYwpAQCAtMTM3LDcgKzEzNyw3IEBAIHNzaXpl
X3Qgc2l6ZWRfc3Ryc2NweShjaGFyICpkZXN0LCBjb25zdCBjaGFyICpzcmMsIHNpemVfdCBjb3Vu
dCkKIAlpZiAoSVNfRU5BQkxFRChDT05GSUdfS01TQU4pKQogCQltYXggPSAwOwogCi0Jd2hpbGUg
KG1heCA+PSBzaXplb2YodW5zaWduZWQgbG9uZykpIHsKKwl3aGlsZSAobWF4ID4gc2l6ZW9mKHVu
c2lnbmVkIGxvbmcpKSB7CiAJCXVuc2lnbmVkIGxvbmcgYywgZGF0YTsKIAogCQljID0gcmVhZF93
b3JkX2F0X2FfdGltZShzcmMrcmVzKTsKQEAgLTE1MywxMCArMTUzLDEwIEBAIHNzaXplX3Qgc2l6
ZWRfc3Ryc2NweShjaGFyICpkZXN0LCBjb25zdCBjaGFyICpzcmMsIHNpemVfdCBjb3VudCkKIAkJ
bWF4IC09IHNpemVvZih1bnNpZ25lZCBsb25nKTsKIAl9CiAKLQl3aGlsZSAoY291bnQpIHsKKwl3
aGlsZSAoY291bnQgPiAwKSB7CiAJCWNoYXIgYzsKIAotCQljID0gc3JjW3Jlc107CisJCWMgPSBS
RUFEX09OQ0Uoc3JjW3Jlc10pOwogCQlkZXN0W3Jlc10gPSBjOwogCQlpZiAoIWMpCiAJCQlyZXR1
cm4gcmVzOwpAQCAtMTY0LDExICsxNjQsMTEgQEAgc3NpemVfdCBzaXplZF9zdHJzY3B5KGNoYXIg
KmRlc3QsIGNvbnN0IGNoYXIgKnNyYywgc2l6ZV90IGNvdW50KQogCQljb3VudC0tOwogCX0KIAot
CS8qIEhpdCBidWZmZXIgbGVuZ3RoIHdpdGhvdXQgZmluZGluZyBhIE5VTDsgZm9yY2UgTlVMLXRl
cm1pbmF0aW9uLiAqLwotCWlmIChyZXMpCi0JCWRlc3RbcmVzLTFdID0gJ1wwJzsKKwkvKiBGaW5h
bCBieXRlIC0gZm9yY2UgTlVMIHRlcm1pbmF0aW9uICovCisJZGVzdFtyZXNdID0gMDsKIAotCXJl
dHVybiAtRTJCSUc7CisJLyogUmV0dXJuIC1FMkJJRyBpZiB0aGUgc291cmNlIGNvbnRpbnVlZC4u
ICovCisJcmV0dXJuIFJFQURfT05DRShzcmNbcmVzXSkgPyAtRTJCSUcgOiByZXM7CiB9CiBFWFBP
UlRfU1lNQk9MKHNpemVkX3N0cnNjcHkpOwogCg==
--0000000000007218e906281c16e8--


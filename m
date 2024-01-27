Return-Path: <linux-fsdevel+bounces-9191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4757083EB91
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 08:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B98283FC4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 07:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB421DFEB;
	Sat, 27 Jan 2024 07:05:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94D11429C;
	Sat, 27 Jan 2024 07:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706339110; cv=none; b=GmKhLnfuv+2jdEXyrU0prPF829TgdzTmb/QiZpg5x7uI0FeaW9gkCDgUGKGbMM7pYEBca+MpNtHjPB8vaAO/qI8Znq5INT6C2BfetH0orAtySuhLsz6BQ5jJXyKsqMXPur31+G7YwjixlEdlkYISE7Xowk+0ji3rFPQLtDPaUpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706339110; c=relaxed/simple;
	bh=0y5myr6aRHgZi0oZL3kW0LCbHr9GKeNw5wu5sr2tcKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cFd7OSY7jwXlaBhw3bVoI57Rmem0Au7USZ5KeCsaRn/f451xKbxj2++QkkK1Y5XMmcaEz2UDcSCUGN11LikgqVNiDyeIOmOLDS/TDo19zJUe5IMDAmCATZ7oqPYmrR5A+pGoqPb+wJ/CK2huO7RtwutdtNjc/mnsseQM09zcdQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 40R741nS081315;
	Sat, 27 Jan 2024 16:04:02 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Sat, 27 Jan 2024 16:04:01 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 40R741hA081308
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 27 Jan 2024 16:04:01 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b5a12ecd-468d-4b50-9f8c-17ae2a2560b4@I-love.SAKURA.ne.jp>
Date: Sat, 27 Jan 2024 16:04:01 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from
 virt-aa-helper
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore
 <paul@paul-moore.com>, Kevin Locke <kevin@kevinlocke.name>,
        Josh Triplett <josh@joshtriplett.org>,
        Mateusz Guzik <mjguzik@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        Kentaro Takeda <takedakn@nttdata.co.jp>
References: <ZbE4qn9_h14OqADK@kevinlocke.name>
 <202401240832.02940B1A@keescook>
 <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
 <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
 <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com>
 <202401240916.044E6A6A7A@keescook>
 <CAHk-=whq+Kn-_LTvu8naGqtN5iK0c48L1mroyoGYuq_DgFEC7g@mail.gmail.com>
 <CAHk-=whDAUMSPhDhMUeHNKGd-ZX8ixNeEz7FLfQasAGvi_knDg@mail.gmail.com>
 <a9210754-2f94-4075-872f-8f6a18f4af07@I-love.SAKURA.ne.jp>
 <CAHk-=wjF=zwZ88vRZe-AvexnmP1OCpKZSp_2aCfTpGeH1vLMkA@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHk-=wjF=zwZ88vRZe-AvexnmP1OCpKZSp_2aCfTpGeH1vLMkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/01/26 2:17, Linus Torvalds wrote:
> On Thu, 25 Jan 2024 at 06:17, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> On 2024/01/25 3:27, Linus Torvalds wrote:
>>> The whole cred use of current->in_execve in tomoyo should
>>> *also* be fixed, but I didn't even try to follow what it actually
>>> wanted.
>>
>> Due to TOMOYO's unique domain transition (transits to new domain before
>> execve() succeeds and returns to old domain if execve() failed), TOMOYO
>> depends on a tricky ordering shown below.
> 
> Ok, that doesn't really clarify anything for me.
> 
> I'm less interested in what the call paths are, and more like "_Why_
> is all this needed for tomoyo?"
> 
> Why doesn't tomoyo just install the new cred at "commit_creds()" time?
> 
> (The security hooks that surround that  are
> "->bprm_committing_creds()" and "->bprm_committed_creds()")

DAC checks permission for any files accessed by a new program passed to execve()
until the point of no return of execve() using the credentials of current program.
But TOMOYO checks permission for any files accessed by a new program passed to execve()
using a domain for that new program than a domain for current program.

This is because TOMOYO considers that if a new program passed to execve() requires some
file, permissions for accessing that file should be checked using the security context
for that new program.

Let's consider executing a shell script named /tmp/foo.sh from /bin/bash .

  [user@host ~]$ cat /tmp/foo.sh
  #!/bin/sh
  echo hello
  [user@host ~]$ chmod 755 /tmp/foo.sh
  [user@host ~]$ exec /tmp/foo.sh

DAC checks permissions for /tmp/foo.sh and /bin/sh using the credentials of /bin/bash
process, and checks permissions for shared libraries needed by /bin/sh using the new
credentials of /tmp/foo.sh process.

TOMOYO checks permissions for /tmp/foo.sh using the domain for /bin/bash process, and
checks permissions for /bin/sh and permissions for shared libraries needed by /bin/sh
using the domain for /tmp/foo.sh process. TOMOYO treats "/tmp/foo.sh needs to load /bin/sh"
and "/tmp/foo.sh needs to load shared libraries needed by /bin/sh" in the same manner, by
checking "open for read" permission.

Since the COW cred mechanism introduced in Linux 2.6.29 cannot support such model,
TOMOYO uses "struct task_struct"->security and does not use "struct cred"->security.

> 
> IOW, the whole "save things across two *independent* execve() calls"
> seems crazy.
> 
> Very strange and confusing.
> 
>                     Linus

Since curity_bprm_free() callback was removed in Linux 2.6.29 because COW cred mechanism
does not need it, currently I have to use such a crazy hack.

Revival of security_task_alloc()/security_task_free()/security_bprm_free() was proposed
in 2011 at https://lkml.kernel.org/r/201104202119.FAI21341.HtOJFSOVLFMOFQ@I-love.SAKURA.ne.jp
and https://lkml.kernel.org/r/201104202120.FEJ57865.MFSOFFHVOOJLQt@I-love.SAKURA.ne.jp .

security_task_alloc()/security_task_free() has been revived, but security_bprm_free() is not
revived yet.

If we can accept revival of security_bprm_free(), we can "get rid of current->in_execve flag"
and "stop saving things across two *independent* execve() calls".



Return-Path: <linux-fsdevel+bounces-24034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E29E937EAA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jul 2024 03:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0497E28247C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jul 2024 01:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98088F5D;
	Sat, 20 Jul 2024 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="hSZYFHzB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAF9BE6F
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Jul 2024 01:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721440789; cv=none; b=NmM+aTH60l6nToMk1KrndRz2iqfiZIpV70La/Oo0PtzgnxRq4CL+bJ3vP6TUrFSwynxd9r5AtO0jP8dxLwGT5O+bWTasOUy+Da0/I1TGXQ2/yMSyH2cpaytYOlxrQ1Diq/xvHZXXT2VNWXGkUjnh5KMP9kxVXhBGsG0rT2CyCxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721440789; c=relaxed/simple;
	bh=E1eLx88XHE6fDhD73HMyCsMIQaNNvWZwSr2N86ttOKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TjYmMlrAaJAVPr18T3maYOwyAey/GjYlNer19fSH3MKcA8PNt7vLSfPZqsKIAnU3ZmYyHU5abAotvXGvQsEtI4opPTVUPHv0cICjw0oAeYyxtcvorqj97VAM5tCxb8oUX3Z744azqU92B39T9prOcWaffsqyX1emLfKQf0QPPGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=hSZYFHzB; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-59f9f59b827so1800673a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 18:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1721440785; x=1722045585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hF0Wt/38bKIJqW5oK7QO5iRqmAOtacgZ7FH0L0aMp3Y=;
        b=hSZYFHzBF7OkIJOlIzzuDohVNWl640CV13N8JiFOLm53TkI1PYZRPBpJjvOjMT0JGq
         p5RBnmerPzNovwpgIYfh10WorY3KOEFhrZwb7SDJDpFipR7878sk7+mTM2mT+G3C05nr
         ESjj57iHS3FMoOMuZ0wvQ6SkGjmYkmc6kJHseJsNrpD8i4JzFM7miqTYvCR2hkqFW5L/
         zvoLkJ5i0MbL2tC5xToGcN8HEWyzkBjyBGJoW8n5mKFtxVg2Ho/olCTor8Ri5NC0I2uV
         bxCAjAsHtwBthV9JXoj63OuTxMv7kkRmBC/nh0nwVOx5d/qhe679aj4XXZdHROG8o75f
         Oifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721440785; x=1722045585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hF0Wt/38bKIJqW5oK7QO5iRqmAOtacgZ7FH0L0aMp3Y=;
        b=Ez3qBbxg0PGc524ka3GkXaBMIlQ45xQq21JqpdXznYQmSO2C8OHifCI1YKFhzln7PK
         pu6JwlNtxww0xjxIDgug0Q6NZKj7cmMQl56dLzImR8eHys2sfO1ay2S1Ke3QfCjdJUpN
         teTbM2aEt0YfvTgxx8mQizrOIhLwRkttasG3xfXXtXx/n4vI0a/WBNF+TXSaoW2jrOcI
         uG+WZGfPCE7nIEM2HeESJriWfxPk76y+811Qh40ZayUqYmxEjJ0JTuozS4gTgkCpeZ5h
         QUgw+zAIfULSrwKWlX1PhEKkwBxPKkaq5vWzJX5Uy+x2D6gqcNGeAIHEfswnKeLuYm9C
         b7KA==
X-Forwarded-Encrypted: i=1; AJvYcCVVEj5lFatp+VwPAiaw2oKpQ0K9WjXCIAHlnRAfusi5cXlcfabia5Fum6NCufGxbGVDpAsSRrD6a0nBhB/E4V/KjxGquzgBR9jJHIAsJw==
X-Gm-Message-State: AOJu0YxfFI2J/yyelIzs90jt/4s/CaL58DkY/Ob7kwOqysY8UVdy+BtD
	RX1eJwPDrIveR7S/CRGbm9DJkwCRAYXadEvm9pBHdFvWK3sZAwhKoln4EjjUcLCfTw7j85doHHQ
	hA3MsQpR8Wxz1lbywYrYJwNacrYguC0BLKdZk
X-Google-Smtp-Source: AGHT+IGPYuZjDvQfeyD4B+TT7ChrPYCBt+VlxtnMNlpScn9nrLy6yNlQv3uwy7Afge2EeZ7qAEBLsOBXVTnm/afPX2s=
X-Received: by 2002:a50:c051:0:b0:5a1:a469:4d9b with SMTP id
 4fb4d7f45d1cf-5a47967b45cmr145698a12.13.1721440785336; Fri, 19 Jul 2024
 18:59:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704190137.696169-1-mic@digikod.net> <20240704190137.696169-2-mic@digikod.net>
 <CALmYWFss7qcpR9D_r3pbP_Orxs55t3y3yXJsac1Wz=Hk9Di0Nw@mail.gmail.com>
 <a0da7702-dabe-49e4-87f4-5d6111f023a8@python.org> <20240717.AGh2shahc9ee@digikod.net>
 <CALCETrUcr3p_APNazMro7Y9FX1zLAiQESvKZ5BDgd8X3PoCdFw@mail.gmail.com> <20240718.Niexoo0ahch0@digikod.net>
In-Reply-To: <20240718.Niexoo0ahch0@digikod.net>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sat, 20 Jul 2024 09:59:33 +0800
Message-ID: <CALCETrVVq4DJZ2q9V9TMuvZ1nb+-Qf4Eu8LVBgUy3XiTa=jFCQ@mail.gmail.com>
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Steve Dower <steve.dower@python.org>, Jeff Xu <jeffxu@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Paul Moore <paul@paul-moore.com>, "Theodore Ts'o" <tytso@mit.edu>, Alejandro Colomar <alx@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, 
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Scott Shell <scottsh@microsoft.com>, 
	Shuah Khan <shuah@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Steve Grubb <sgrubb@redhat.com>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Elliott Hughes <enh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Jul 18, 2024, at 8:22=E2=80=AFPM, Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>
> =EF=BB=BFOn Thu, Jul 18, 2024 at 09:02:56AM +0800, Andy Lutomirski wrote:
>>>> On Jul 17, 2024, at 6:01=E2=80=AFPM, Micka=C3=ABl Sala=C3=BCn <mic@dig=
ikod.net> wrote:
>>>
>>> On Wed, Jul 17, 2024 at 09:26:22AM +0100, Steve Dower wrote:
>>>>> On 17/07/2024 07:33, Jeff Xu wrote:
>>>>> Consider those cases: I think:
>>>>> a> relying purely on userspace for enforcement does't seem to be
>>>>> effective,  e.g. it is trivial  to call open(), then mmap() it into
>>>>> executable memory.
>>>>
>>>> If there's a way to do this without running executable code that had t=
o pass
>>>> a previous execveat() check, then yeah, it's not effective (e.g. a Pyt=
hon
>>>> interpreter that *doesn't* enforce execveat() is a trivial way to do i=
t).
>>>>
>>>> Once arbitrary code is running, all bets are off. So long as all arbit=
rary
>>>> code is being checked itself, it's allowed to do things that would byp=
ass
>>>> later checks (and it's up to whoever audited it in the first place to
>>>> prevent this by not giving it the special mark that allows it to pass =
the
>>>> check).
>>>
>>> Exactly.  As explained in the patches, one crucial prerequisite is that
>>> the executable code is trusted, and the system must provide integrity
>>> guarantees.  We cannot do anything without that.  This patches series i=
s
>>> a building block to fix a blind spot on Linux systems to be able to
>>> fully control executability.
>>
>> Circling back to my previous comment (did that ever get noticed?), I
>
> Yes, I replied to your comments.  Did I miss something?

I missed that email in the pile, sorry. I=E2=80=99ll reply separately.

>
>> don=E2=80=99t think this is quite right:
>>
>> https://lore.kernel.org/all/CALCETrWYu=3DPYJSgyJ-vaa+3BGAry8Jo8xErZLiGR3=
U5h6+U0tA@mail.gmail.com/
>>
>> On a basic system configuration, a given path either may or may not be
>> executed. And maybe that path has some integrity check (dm-verity,
>> etc).  So the kernel should tell the interpreter/loader whether the
>> target may be executed. All fine.
>>
>> But I think the more complex cases are more interesting, and the
>> =E2=80=9Cexecute a program=E2=80=9D process IS NOT BINARY.  An attempt t=
o execute can
>> be rejected outright, or it can be allowed *with a change to creds or
>> security context*.  It would be entirely reasonable to have a policy
>> that allows execution of non-integrity-checked files but in a very
>> locked down context only.
>
> I guess you mean to transition to a sandbox when executing an untrusted
> file.  This is a good idea.  I talked about role transition in the
> patch's description:
>
> With the information that a script interpreter is about to interpret a
> script, an LSM security policy can adjust caller's access rights or log
> execution request as for native script execution (e.g. role transition).
> This is possible thanks to the call to security_bprm_creds_for_exec().

=E2=80=A6

> This patch series brings the minimal building blocks to have a
> consistent execution environment.  Role transitions for script execution
> are left to LSMs.  For instance, we could extend Landlock to
> automatically sandbox untrusted scripts.

I=E2=80=99m not really convinced.  There=E2=80=99s more to building an API =
that
enables LSM hooks than merely sticking the hook somewhere in kernel
code. It needs to be a defined API. If you call an operation =E2=80=9Ccheck=
=E2=80=9D,
then people will expect it to check, not to change the caller=E2=80=99s
credentials.  And people will mess it up in both directions (e.g.
callers will call it and then open try to load some library that they
should have loaded first, or callers will call it and forget to close
fds first.

And there should probably be some interaction with dumpable as well.
If I =E2=80=9Ccheck=E2=80=9D a file for executability, that should not sudd=
enly allow
someone to ptrace me?

And callers need to know to exit on failure, not carry on.


More concretely, a runtime that fully opts in to this may well "check"
multiple things.  For example, if I do:

$ ld.so ~/.local/bin/some_program   (i.e. I literally execve ld.so)

then ld.so will load several things:

~/.local/bin/some_program
libc.so
other random DSOs, some of which may well be in my home directory

And for all ld.so knows, some_program is actually an interpreter and
will "check" something else.  And the LSMs have absolutely no clue
what's what.  So I think for this to work right, the APIs need to be a
lot more expressive and explicit:

check_library(fd to libc.so);  <-- does not transition or otherwise drop pr=
ivs
check_transition_main_program(fd to ~/.local/bin/some_program);  <--
may drop privs

and if some_program is really an interpreter, then it will do:

check_library(fd to some thing imported by the script);
check_transition_main_program(fd to the actual script);

And maybe that takes a parameter that gets run eval-style:

check_unsafe_user_script("actual contents of snippet");

The actual spelling of all this doesn't matter so much.  But the user
code and the kernel code need to be on the same page as to what the
user program is doing and what it's asking the kernel program to do.

--Andy


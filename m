Return-Path: <linux-fsdevel+bounces-6820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2529481D3A0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 11:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C562824EB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 10:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB7FCA56;
	Sat, 23 Dec 2023 10:49:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B149C146;
	Sat, 23 Dec 2023 10:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3BNAn08D044013;
	Sat, 23 Dec 2023 19:49:00 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Sat, 23 Dec 2023 19:49:00 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3BNAmxMY044008
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 23 Dec 2023 19:48:59 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <57ce7089-37c7-44c5-a9da-5a6f02794c42@I-love.SAKURA.ne.jp>
Date: Sat, 23 Dec 2023 19:48:58 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] security: new security_file_ioctl_compat() hook
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>, Alfred Piccioni <alpic@google.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        stable@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20230906102557.3432236-1-alpic@google.com>
 <20231219090909.2827497-1-alpic@google.com>
 <CAHC9VhTpc7SD0t-5AJ49+b-FMTx1svDBQcR7j6c1rmREUNW7gg@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhTpc7SD0t-5AJ49+b-FMTx1svDBQcR7j6c1rmREUNW7gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023/12/23 10:23, Paul Moore wrote:
>> -       /* RED-PEN how should LSM module know it's handling 32bit? */
>> -       error = security_file_ioctl(f.file, cmd, arg);
>> +       error = security_file_ioctl_compat(f.file, cmd, arg);
>>         if (error)
>>                 goto out;
> 
> This is interesting ... if you look at the normal ioctl() syscall
> definition in the kernel you see 'ioctl(unsigned int fd, unsigned int
> cmd, unsigned long arg)' and if you look at the compat definition you
> see 'ioctl(unsigned int fd, unsigned int cmd, compat_ulong_t arg)'.  I
> was expecting the second parameter, @cmd, to be a long type in the
> normal definition, but it is an int type in both cases.  It looks like
> it has been that way long enough that it is correct, but I'm a little
> lost ...

Since @arg might be a pointer to some struct, @arg needs to use a long type.
But @cmd can remain 32bits for both 32bits/64bits kernels because @cmd is not
a pointer, can't it?

> I agree that it looks like Smack and TOMOYO should be fine, but I
> would like to hear from Casey and Tetsuo to confirm.

Fine for TOMOYO part, for TOMOYO treats @cmd as an integer.



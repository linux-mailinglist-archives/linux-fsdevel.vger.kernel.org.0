Return-Path: <linux-fsdevel+bounces-22043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D609B911737
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 02:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C8892831FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 00:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90755110A;
	Fri, 21 Jun 2024 00:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYeec+xV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D24A10E3;
	Fri, 21 Jun 2024 00:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718929200; cv=none; b=CGvunNhaoPI5DTkvunZN3Iq1AX2ZSU1tPmgZ5VgtEfihkcye97DsZmkK8XMRYFhAfK32xsVq4do5e5w8+Z0uZ8dKcurzhzBOaksBV9rwV0+2erRmZ+ZOIX6WpP7uXyKtbxrubfAN3OUXhNh7WvP6mJwFbjAeDAxzqg/INpDNDY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718929200; c=relaxed/simple;
	bh=iI4kwQgyg+ISbUOBOYdNYwBf/i79YdZuFSSt9bWcDCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuHFihLq0EIaRXcFKKo0NlUvsgk5CzDG2P5FKrqXziaVz+EdhuzJkOn47DeAB3SJ+HJUkUawlogKxGZH9KF4SqT3x7HuxQbM3GPNh3Aah+Sk1Ixxlkyh4NUU5xW09rcc5ul58xlGNLFAW4C/TJOtB5aSs9iM9zqnhbnJcm1FGL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYeec+xV; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-70df213542bso1038818a12.3;
        Thu, 20 Jun 2024 17:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718929197; x=1719533997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mmyzvfs2YZd9tfytvhjIOO7J1yZlWjymeFYN5lNqh4Y=;
        b=bYeec+xVyAz8q9GLwVbtdEO8GKhVUGNOg4bUY4gDZQVamc3+bU1cWYhfAOq3i0ty7z
         09cWiKgAb1yThx5VrihZi4YGCszDmeTivSQ5xkSFuhremWg7onTMF7JamSJEjtsoOYGH
         DQEJjKgYzNhs6bnMpaQp/3p04NNYlsE4B4spxISvhzsNe14TKUOVlFpdVwwU1ulgtiGb
         6JIxBqugw4U50zekxw+Af13ulDMLSSl9TQoXHNMb5Z8laogVfWD2q3XvcbmsxFIh2l9S
         cwvzR2l0K28JCGfUnc/V+ars47wtwG3zByah2ZmtrHWRQN2Ijj+U9ccwYSnceo0ZhLIX
         4/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718929197; x=1719533997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mmyzvfs2YZd9tfytvhjIOO7J1yZlWjymeFYN5lNqh4Y=;
        b=VHOchnxrPpD9tUbN/L81FMwVKPJI+Mn4ThqD/3v9l/0ki+70noKPWWN+axO03Cs0GI
         CAE3QgkYsrVwtHYfZfdez8EfM28X6pPNDgdpOF6lLP4lq6Vfkus3c+9ZpiG3PgdY3kqo
         kQ0uapSwwa8NI9gYSQEtZVEmTOvCPt0kYfyf/MhJYmd9JHVoyBsbPKMcokk8GZJ6xN/r
         jqYWVgvV3KhR0meyrsq/RBeE6EFXRYMCaEzvXNcVxRYD62ihHBoMaEqrsVSYMOBasam9
         IMkHFUL7Dy4p+L5ul31rj1JZEdy/445wr94z8ZHgQb8tXaay3skAyhey8KoU1PBaghtu
         2nKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD9NG6wz1BiJ48eQlL5SERb7a031MMkwiGRyc3z9m6PHiM6CoH1LesZ9HZDDW6eqpaUtSY+mcR+lOVsrMztC7+bUKHMHMW/uvOobXuPeernKz5oD3BdFNZsX6ccxS1yU6GdWkTahd38GFWglLPZEldvA5yzWN58w+HibUXJumFyqgV0+ySWTobnsQxrQ==
X-Gm-Message-State: AOJu0YwKGTyZY6knop3dRhjCG6iPQV6Gx+3nz5h3J2ebS0HGATxaTIEx
	q5qNSgBMV0K63hC0iri4Me6MjFmfQ9jxZ+7h7pozaLNbfqGsbIWl
X-Google-Smtp-Source: AGHT+IG/rSd+vUkEL02DpRF2yXVYcvE7LDEdA2oMiNCQz4GfaPD03BvGgAWtiAuLoEzSXMx04zoJoQ==
X-Received: by 2002:a05:6a20:12cf:b0:1b4:3f96:f1d8 with SMTP id adf61e73a8af0-1bcbb385db8mr8347462637.13.1718929197355;
        Thu, 20 Jun 2024 17:19:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e55dccbfsm2316700a91.32.2024.06.20.17.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 17:19:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 20 Jun 2024 17:19:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kees Cook <keescook@chromium.org>
Cc: Eric Biederman <ebiederm@xmission.com>,
	Justin Stitt <justinstitt@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] exec: Avoid pathological argc, envc, and bprm->p
 values
Message-ID: <fbc4e2e4-3ca2-45b7-8443-0a8372d4ba94@roeck-us.net>
References: <20240520021337.work.198-kees@kernel.org>
 <20240520021615.741800-2-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520021615.741800-2-keescook@chromium.org>

Hi,

On Sun, May 19, 2024 at 07:16:12PM -0700, Kees Cook wrote:
> Make sure nothing goes wrong with the string counters or the bprm's
> belief about the stack pointer. Add checks and matching self-tests.
> 
> For 32-bit validation, this was run under 32-bit UML:
> $ tools/testing/kunit/kunit.py run --make_options SUBARCH=i386 exec
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

With this patch in linux-next, the qemu m68k:mcf5208evb emulation
fails to boot. The error is:

Run /init as init process
Failed to execute /init (error -7)
Run /sbin/init as init process
Starting init: /sbin/init exists but couldn't execute it (error -7)
Run /etc/init as init process
Run /bin/init as init process
Run /bin/sh as init process
Starting init: /bin/sh exists but couldn't execute it (error -7)
Kernel panic - not syncing: No working init found.  Try passing init= option to kernel. See Linux Documentation/admin-guide/init.rst for guidance.
CPU: 0 UID: 0 PID: 1 Comm: swapper Not tainted 6.10.0-rc4-next-20240620 #1
Stack from 4081ff74:
        4081ff74 40387a22 40387a22 00000000 0000000a 4039db60 4031b2fe 40387a22
        40314742 00000000 00000000 4039db60 00000000 40314186 4031b494 00000000
        00000000 4031b57e 4037f784 403a3440 40020474 00000000 00000000 00000000
        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
        00000000 00002000 00000000
Call Trace: [<4031b2fe>] dump_stack+0xc/0x10
 [<40314742>] panic+0xce/0x262
 [<40314186>] try_to_run_init_process+0x0/0x38
 [<4031b494>] kernel_init+0x0/0xf0
 [<4031b57e>] kernel_init+0xea/0xf0
 [<40020474>] ret_from_kernel_thread+0xc/0x14

bisect essentially points to the merge of the for-next/execve branch;
see below. Subsequent failures are false positives. Branch analysis
then pointed to this patch. The image boots after reverting this patch
(or after reverting the entire merge).

Guenter

---
# bad: [b992b79ca8bc336fa8e2c80990b5af80ed8f36fd] Add linux-next specific files for 20240620
# good: [6ba59ff4227927d3a8530fc2973b80e94b54d58f] Linux 6.10-rc4
git bisect start 'HEAD' 'v6.10-rc4'
# good: [c02e717c5a89654b244fec58bb5cda32770966b5] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect good c02e717c5a89654b244fec58bb5cda32770966b5
# good: [29e7d78253b7ebf4b76fcf6d95e227d0b0c57dc0] Merge branch 'msm-next' of https://gitlab.freedesktop.org/drm/msm.git
git bisect good 29e7d78253b7ebf4b76fcf6d95e227d0b0c57dc0
# good: [bf8fd0d956bfcbf4fd6ff063366374c4bf87d806] Merge branch 'non-rcu/next' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
git bisect good bf8fd0d956bfcbf4fd6ff063366374c4bf87d806
# good: [1110f16317b1e0742521eaef5613eb1eb17f55ca] Merge branch 'icc-next' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git
git bisect good 1110f16317b1e0742521eaef5613eb1eb17f55ca
# good: [63f3716198e5644713748d83e6a6df3b4a6a3b10] Merge branch 'gpio/for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
git bisect good 63f3716198e5644713748d83e6a6df3b4a6a3b10
# good: [91b48d9adafddb242264ba19c0bae6e23f71b18a] Merge branch 'kunit' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
git bisect good 91b48d9adafddb242264ba19c0bae6e23f71b18a
# good: [c54c059b3c3c980c66e2a34b08724d9e529f590d] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git
git bisect good c54c059b3c3c980c66e2a34b08724d9e529f590d
# good: [de95d30c03c42225c4fad714bf657c9ebb345fe9] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git
git bisect good de95d30c03c42225c4fad714bf657c9ebb345fe9
# bad: [cb328321926903f7f54866029590abb8faf48ef6] Merge branch 'for-next/execve' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
git bisect bad cb328321926903f7f54866029590abb8faf48ef6
# bad: [aef9d25e7f5631543a0276d0532151f2c61174d6] sysctl: Remove superfluous empty allocations from sysctl internals
git bisect bad aef9d25e7f5631543a0276d0532151f2c61174d6
# bad: [c819e252c2874479b27f6a356b44f8aa73cf5a81] sysctl: Add module description to sysctl-testing
git bisect bad c819e252c2874479b27f6a356b44f8aa73cf5a81
# bad: [b5ffbd1396885f76bf87e67d590a3ef063e6d831] sysctl: move the extra1/2 boundary check of u8 to sysctl_check_table_array
git bisect bad b5ffbd1396885f76bf87e67d590a3ef063e6d831
# bad: [98ca62ba9e2be5863c7d069f84f7166b45a5b2f4] sysctl: always initialize i_uid/i_gid
git bisect bad 98ca62ba9e2be5863c7d069f84f7166b45a5b2f4
# first bad commit: [98ca62ba9e2be5863c7d069f84f7166b45a5b2f4] sysctl: always initialize i_uid/i_gid


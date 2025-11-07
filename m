Return-Path: <linux-fsdevel+bounces-67469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C3AC416CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 20:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8421D4F5F0F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 19:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372072FFDC1;
	Fri,  7 Nov 2025 19:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcAsSnxx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997C2302CDE
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 19:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762543093; cv=none; b=pgYZaJins+UGvWtMk3SzR6LEJL7Br0+3b/6TObLU8IQ+KKbe0o1/ZypcutBwEf0j/Ih5fWNQHukJ25GWNpS21XXvZIYm8rW3tjdK052lJxiu2pdseQ9zzOxD2HpfDLv9QMkAjRgi9jBN5S6QqnBA5nrKKkzlliVJEcyftK6qKZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762543093; c=relaxed/simple;
	bh=HMX+nokK9V+QGgu5vvY3CGRBUupf3RY/CVnmsPQBGss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jdROwPSaq6Fq5GhAaC+uIltAVQOCP29vApURSjWGauzfn4dXjZKKDr18i/KoePTPj15+LCeczdhpRolmKX2Ga3oeGuuGuZYCt/5bg9E2T5XypM2nbQOOQUfSIQK5hRqXesPw/GrHmJSYzEecq3gP17I0VTSMVLRWsueBhdtvh7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcAsSnxx; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-471b80b994bso12138455e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 11:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762543079; x=1763147879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoyRAxBYJ97KZHdMcvP1wI7gdZM18PW/SDBquVzm/CM=;
        b=PcAsSnxxk/vQ8EKi7S/zlpRriabJ6LStD3JjS9iMC1hHhA7ft4Ly8XN1F4KNak3nE2
         Azx3zPSFn9dNxBWGFc8Q0PGil+tYqmpuTWwYxIYcIv2G7YxmW3RVzo4tPDRmdwHnyFth
         ynrZ6laqoBE+okxBPB7YOgcbfSg224RvjW7uKp1kV2mq83jDvblTIbsCss7FkO/MeMHS
         RCPwKZblpC2N9yZs2vcU7+2qCYut6DMlTJQqMyeCk8kWoR0SyuT4q2Zn0GDbTmVagkQk
         BwFyCwwfWNcoAPNAbbVmaiVFIQmtAWK22/WHTHEAf0VvjzSO9AE7OeanDvGjh94licgb
         Tr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762543079; x=1763147879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BoyRAxBYJ97KZHdMcvP1wI7gdZM18PW/SDBquVzm/CM=;
        b=tJyOtwf/4K2uQzsZvO1NTqSgM/+saBwtJ85c0+n5VqkNyTS+UjRtmQqILZAR8nVtLQ
         JHMnZN8gJKyZo7PN8ZWSRlIKQdN9e3d9lDusx++LvtaddNSW2B22iMxJKLm15UBmlzBX
         /oOy5/Shw3We8Mjkpm30jcVsf04umkV12IJbIAdgxGKfdi7nScrgLHlEblrax8rOMZZO
         4c5uwdly9jJHh9slEeMn5ioMLMELkgIu+aq9osB2yaDXfVyAXKCL99xlQ1vvkgUfaA5b
         doCQ2VLV0gSNoSXyxvYV7VDr+NyvOfLoPHZYwtadZLoUWHWPjEkMp1neUWAg8Fbp4ZlM
         21vg==
X-Forwarded-Encrypted: i=1; AJvYcCVdNUzzU/T1zQ8ajkf0lG0TF48h7RXsxIOdeMsxg1poojbILPUSjxXL/XnJUamXyy435BCgGRbpQrUlvbPP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+x0uccFH4IHwIZrWyNJwbB/edU3tjokb/mP87B1QdwuxWBKFV
	dH47oaHe8bLc9m/WJdhkPDD4S0iGZXkhZk+nX+fXDlgcW2jbonr/hUpf
X-Gm-Gg: ASbGncv4UMefvixHbDRtc0KBXF+TWlwK3ddcH9XkMW0ZyIka8BGOIW3BdIOQsw9v4uf
	6gXbD9zp4otP6rs0WvMtUKa7OcLXsSl71IgzptGohTfdClQ73fCq0KNbMp0hf71khPLl+NfIc64
	b+lWXQwrKUgA09iuUZiZ0iRDCrbLqT/E05XvLAWrJntQTV+IDb6BlBkRNNixqlOQXg9cQEHOdqg
	vOkhQA2EwZNBo3UncL1gJ4VBeYXzKRsDJqM/6wTuithlWeZZP7mz/MuNyvGIqWjujXEhjigXLLq
	2oSrNfMtgT/elEtXwgjqd0Gzxp/5+BQvRE4mV078CJaaMtLrUE2XuxmkoWH+P0c5io7IvH4xd5r
	XVxbQWhHmGX9BzFjG3ZLEHzWBgb6Gaybp+dhpEcdvvxIwfmYNnnB7ZoNimBRodVr7KiZTlbZJEQ
	YkTnpA08+dZCCIXNN56zbJX1+98zLm5UlZ+OcjLp5NZwFqrsP3poir
X-Google-Smtp-Source: AGHT+IGwWldiHMKs6o3o24t2zUapUEv2nDiVIW1qgftMpp+s7M3k154xFpb/vMUGopieuIUWMdpZmw==
X-Received: by 2002:a05:600c:45c7:b0:477:55b6:cdd6 with SMTP id 5b1f17b1804b1-4777322f0a4mr1228445e9.10.1762543078570;
        Fri, 07 Nov 2025 11:17:58 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62b23csm6811350f8f.10.2025.11.07.11.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 11:17:58 -0800 (PST)
Date: Fri, 7 Nov 2025 19:17:53 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, kernel test robot <lkp@intel.com>, Russell
 King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Heiko
 Carstens <hca@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>, Nicolas
 Palix <nicolas.palix@imag.fr>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch V5 07/12] uaccess: Provide scoped user access regions
Message-ID: <20251107191753.7433d2dc@pumpkin>
In-Reply-To: <20251027083745.546420421@linutronix.de>
References: <20251027083700.573016505@linutronix.de>
	<20251027083745.546420421@linutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Oct 2025 09:43:55 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> User space access regions are tedious and require similar code patterns all
> over the place:
...
> There have been issues with using the wrong user_*_access_end() variant in
> the error path and other typical Copy&Pasta problems, e.g. using the wrong
> fault label in the user accessor which ends up using the wrong accesss end
> variant. 
> 
> These patterns beg for scopes with automatic cleanup. The resulting outcome
> is:
>     	scoped_user_read_access(from, Efault)
> 		unsafe_get_user(val, from, Efault);
> 	return 0;
>   Efault:
> 	return -EFAULT;
> 
> The scope guarantees the proper cleanup for the access mode is invoked both
> in the success and the failure (fault) path.
> 
...

The code doesn't work if the 'from' (above) is 'const foo __user *from'.
Due to assigning away constness.

The changes below fix the build, I suspect the code is then correct.

...
> +/* Define RW variant so the below _mode macro expansion works */
> +#define masked_user_rw_access_begin(u)	masked_user_access_begin(u)
> +#define user_rw_access_begin(u, s)	user_access_begin(u, s)
> +#define user_rw_access_end()		user_access_end()
> +
> +/* Scoped user access */
> +#define USER_ACCESS_GUARD(_mode)				\

#define USER_ACCESS_GUARD(_mode, void)
(but change all the void below to a different name...)

> +static __always_inline void __user *				\
> +class_user_##_mode##_begin(void __user *ptr)			\
> +{								\
> +	return ptr;						\
> +}								\
> +								\
> +static __always_inline void					\
> +class_user_##_mode##_end(void __user *ptr)			\
> +{								\
> +	user_##_mode##_access_end();				\
> +}								\
> +								\
> +DEFINE_CLASS(user_ ##_mode## _access, void __user *,		\
> +	     class_user_##_mode##_end(_T),			\
> +	     class_user_##_mode##_begin(ptr), void __user *ptr)	\
> +								\
> +static __always_inline class_user_##_mode##_access_t		\
> +class_user_##_mode##_access_ptr(void __user *scope)		\
> +{								\
> +	return scope;						\
> +}
> +
> +USER_ACCESS_GUARD(read)
> +USER_ACCESS_GUARD(write)
> +USER_ACCESS_GUARD(rw)

USER_ACCESS_GUARD(read, const void)
USER_ACCESS_GUARD(write, void)
USER_ACCESS_GUARD(rw, void)

> +#undef USER_ACCESS_GUARD
...
> +#define __scoped_user_access(mode, uptr, size, elbl)					\
> +for (bool done = false; !done; done = true)						\
> +	for (void __user *_tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl); \

	for (typeof(uptr) _tmpptr = ...

> +	     !done; done = true)							\
> +		for (CLASS(user_##mode##_access, scope)(_tmpptr); !done; done = true)	\
> +			/* Force modified pointer usage within the scope */		\
> +			for (const typeof(uptr) uptr = _tmpptr; !done; done = true)
> +

	David



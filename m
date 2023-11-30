Return-Path: <linux-fsdevel+bounces-4369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 459BD7FEF4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 13:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2732B20AD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 12:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A904644D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DauTORjd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3011010F3
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 04:10:16 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d064f9e2a1so13149847b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 04:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701346215; x=1701951015; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MpC0qbPCJ3yCkzqZmHvjb+j6E99/8etcnMaQGxE98xo=;
        b=DauTORjdSDyxQtj+qiiDb77b8RnHJnJIteI5c5uNh0A2d2yX3qioZQcqPjT/A9Slyg
         xItc14+OiF8pZIHGxa9AJyxGnFBF1CJhFt5EIYucVBMfd9f/ybSoYSuRe4qtpxBXTB8n
         YDg3HfBncegdPfJQcDvGdNTKT7avSitiK8qOjYtRtWDJrWsAW2JH7ZipVY4Mb7MfOdVr
         kZO4M+bzTCaHQkqSkkmbM7fViY9g8ifo7fIEEaDCr73dfNqmiyZvfpStYumXinSeYRO6
         dJ039K/GVq/whYpEtsc2ps81RMg10mSrWIIHNyCMTTTFFvPdOaQP/eIxy5B+RIZE/3RX
         pb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701346215; x=1701951015;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MpC0qbPCJ3yCkzqZmHvjb+j6E99/8etcnMaQGxE98xo=;
        b=eq4Liu7CvNmxLrPOiATziPoI8r7DzOKh7ltpfxobHLFtD8YKX/QKqGxnjbV3VkXLNg
         SxnYCBFO1JzFNTXf/EdCPnehSHezGTzvT37KCQA0FC+R+lhUMyIQoCWHNgbatNu/zLFo
         jvmvgFLPIs5JMfa/sBT8iEnAUujHgqhB2JCy5JUGC9M+drPzV25ztH6idBdB7G1Y/+p0
         viHdkOYT7j20Ibs2ebaV1Wx/O7OOQe5GJc2k7V/jCjGohlQk1ibCHfMrjOaL3RaApDlu
         hBWwl+SksId8z8qNbh570wCNO1KHPBfFGV6h3TFFBjtJTQIU/vDwqSwqHlsLlK3NKQ5O
         Uc/w==
X-Gm-Message-State: AOJu0Yznlmr6dzAaUxz1AE+U7pWZnLDBUVKKgqbmiUVjf6NAqi1ax3xA
	KewSVSYVIiINoFdwTVlRIjgXhslnEAM95Tk=
X-Google-Smtp-Source: AGHT+IHkruZpynxgNrnzwalbW6zRZDy4mTm8VClbDHLx2F8vWgb3ZReA4zvBoILLpWV35FvGD9AUBn92jc8MH9g=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:844:b0:5ca:8462:670f with SMTP
 id bz4-20020a05690c084400b005ca8462670fmr667597ywb.0.1701346215441; Thu, 30
 Nov 2023 04:10:15 -0800 (PST)
Date: Thu, 30 Nov 2023 12:10:12 +0000
In-Reply-To: <20231130-sackgasse-abdichtung-62c23edd9a9f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231130-sackgasse-abdichtung-62c23edd9a9f@brauner>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231130121013.140671-1-aliceryhl@google.com>
Subject: Re: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
From: Alice Ryhl <aliceryhl@google.com>
To: brauner@kernel.org
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, 
	arve@android.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, cmllamas@google.com, dan.j.williams@intel.com, 
	dxu@dxuuu.xyz, gary@garyguo.net, gregkh@linuxfoundation.org, 
	joel@joelfernandes.org, keescook@chromium.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org, 
	peterz@infradead.org, rust-for-linux@vger.kernel.org, surenb@google.com, 
	tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk, 
	wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="utf-8"

Christian Brauner <brauner@kernel.org> writes:
>> This is the backdoor. You use it when *you* know that the file is okay
> 
> And a huge one.
> 
>> to access, but Rust doesn't. It's unsafe because it's not checked by
>> Rust.
>> 
>> For example you could do this:
>> 
>> 	let ptr = unsafe { bindings::fdget(fd) };
>> 
>> 	// SAFETY: We just called `fdget`.
>> 	let file = unsafe { File::from_ptr(ptr) };
>> 	use_file(file);
>> 
>> 	// SAFETY: We're not using `file` after this call.
>> 	unsafe { bindings::fdput(ptr) };
>> 
>> It's used in Binder here:
>> https://github.com/Darksonn/linux/blob/dca45e6c7848e024709b165a306cdbe88e5b086a/drivers/android/rust_binder.rs#L331-L332
>> 
>> Basically, I use it to say "C code has called fdget for us so it's okay
>> to access the file", whenever userspace uses a syscall to call into the
>> driver.
> 
> Yeah, ok, because the fd you're operating on may be coming from fdget(). Iirc,
> binder is almost by default used multi-threaded with a shared file descriptor
> table? But while that means fdget() will usually bump the reference count you
> can't be sure. Hmkay.

Even if the syscall used `fget` instead of `fdget`, I would still be
using `from_ptr` here. The `ARef` type only really makes sense when *we*
have ownership of the ref-count, but in this case we don't own it. We're
just given a promise that the caller is keeping it alive for us using
some mechanism or another.

>>>> +// SAFETY: It's OK to access `File` through shared references from other threads because we're
>>>> +// either accessing properties that don't change or that are properly synchronised by C code.
>>> 
>>> Uhm, what guarantees are you talking about specifically, please?
>>> Examples would help.
>>> 
>>>> +unsafe impl Sync for File {}
>> 
>> The Sync trait defines whether a value may be accessed from several
>> threads in parallel (using shared/immutable references). In our case,
> 
> So let me put this into my own words and you correct me, please:
> 
> So, this really just means that if I have two processes both with their own
> fdtable and they happen to hold fds that refer to the same @file:
> 
> P1				P2
> struct fd fd1 = fdget(1234);
>                                  struct fd fd2 = fdget(5678);
> if (!fd1.file)                   if (!fd2.file)
> 	return -EBADF;                 return -EBADF;
> 
> // fd1.file == fd2.file
> 
> the only if the Sync trait is implemented both P1 and P2 can in parallel call
> file->f_op->poll(@file)?
> 
> So if the Sync trait isn't implemented then the compiler will prohibit that P1
> and P2 at the same time call file->f_op->poll(@file)? And that's all that's
> meant by a shared reference? It's really about sharing the pointer.

Yeah, what you're saying sounds correct. For a type that is not Sync,
you would need a lock around the call to `poll` before the compiler
would accept the call.

(Or some other mechanism to convince the compiler that no other thread
is looking at the file at the same time. Of course, a lock is just one
way to do that.)

> The thing is that "shared reference" gets a bit in our way here:
> 
> (1) If you have SCM_RIGHTs in the mix then P1 can open fd1 to @file and then
>     send that @file to P2 which now has fd2 refering to @file as well. The
>     @file->f_count is bumped in that process. So @file->f_count is now 2.
> 
>     Now both P1 and P2 call fdget(). Since they don't have a shared fdtable
>     none of them take an additional reference to @file. IOW, @file->f_count
>     may remain 2 all throughout the @file->f_op->*() operation.
> 
>     So they share a reference to that file and elide both the
>     atomic_inc_not_zero() and the atomic_dec_not_zero().
> 
> (2) io_uring has fixed files whose reference count always stays at 1.
>     So all io_uring operations on such fixed files share a single reference.
> 
> So that's why this is a bit confusing at first to read "shared reference".
> 
> Please add a comment on top of unsafe impl Sync for File {}
> explaining/clarifying this a little that it's about calling methods on the same
> file.

Yeah, I agree, the terminology gets a bit mixed up here because we both
use the word "reference" for different things.

How about this comment?

/// All methods defined on `File` that take `&self` are safe to call even if
/// other threads are concurrently accessing the same `struct file`, because
/// those methods either access immutable properties or have proper
/// synchronization to ensure that such accesses are safe.

Note: Here, I say "take &self" to refer to methods with &self in the
signature. This signature means that you pass a &File to the method when
you call it.

Alice



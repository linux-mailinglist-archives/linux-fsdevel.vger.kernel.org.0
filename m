Return-Path: <linux-fsdevel+bounces-47762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AACCDAA561B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 22:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D9F1BC1C87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 20:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644A92973CC;
	Wed, 30 Apr 2025 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJBAUA3n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126521DE891
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746046238; cv=none; b=byPv74qY3T8zNb5XwOO7ewrHbPS9q/pc+hylV+mWuSbbJ2qyLTmaO17BIoo2Cwsl3Thn/wy5fNpXuuNYRTK1ACEcE7QBfX00pqXsBIRTpw9zV+r87tfdraF1C5ST8iS+BzrLRdcklQanRQpB2fP+1t2p/XmVjHJsRWZxATzpXRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746046238; c=relaxed/simple;
	bh=ptgVXAKpGNJUlVCO7bdDUdNmcRVFFmb7W2vgY8B+D94=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=M4dfF0jA6OGo9FnttN7Hi/NQo3khbu/mSYoRFwefF8hUX5muxaDg5r2WyLSPIfkJUw/IvfFhOLBJfPPOvqllmP0HQtTp39c2u/vz9wcOvFPfkC5hc4dVpFEc9MHVsBxaeA+HYL9Cejs1tusdX+bSI7cBFP5yfaqMHeffb+z7hZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJBAUA3n; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9ebdfso519549a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 13:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746046235; x=1746651035; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2aXmwzziiCw2ejnhxsjGH+BqEAqyJ1PHKY+RdQO3/SI=;
        b=XJBAUA3n+g8sZrQt1YY7ImSIxpVrgJrINVPw+2am/OcqsrpLHe7bMQU+4QzYz2JpIf
         JF5eRSbA+GvFQxAF95fMMlmWm/atwFRUKpdlW1jCqDvawxrAm9kyy+6loa9QmPe3KaxU
         T01mQ9KyEy2CeM5Vx4nU8sNoAhSXXop8i8x4g08bGyP/gidnAcOMN5Qkt1KKyI3doujB
         Xf7B5OJPur+c2eCAfIUegxlpoo4D25sw8e8CNprvsYNCVdmFLPTeew03eB4ME890Asco
         cWYVp8XaKVj5rbESwbRsDYWRMh8w4Wx5p6m7dePjYDHU64+JRLokJom33LA6/HtahG3i
         85bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746046235; x=1746651035;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2aXmwzziiCw2ejnhxsjGH+BqEAqyJ1PHKY+RdQO3/SI=;
        b=v5TlvkQ35QkXWGNq8SvIXNfhGiIAxCBj0mREMeFeoNkdltkCYRFf4Jd0WQSGu4iJKa
         MoyAX7Qru16VSDQ6gYXLaX9E+7IB1RBjI8tyv7kWg+LDEGcMIDUdYgC6baFDJZzFCLzK
         xgmQs/gNCUYZsr57pXE9nOEPQbtz/EK6tixh7WPKsgWO3YgJv7eWjg1YQNG5oAsluRdJ
         XduaRw2qATUTXFPSuBnL9nUh8yTRqL4Lr1znYP4CpMM7exzAD7KY4Nmc47zpuROerI6V
         nYTZHJDKlhhmxgowIpthFAs4yNqPaoiIFq7+8nLVPr4+i/uPvNy8xAGQDWBwi9R+7N7j
         Xlyw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ4JlAuiykbznNsfwgPwSEy2FV6UMlLDnqMpqNOkFr2oS9krHJ5KeHE5KbHj0875Th+LNjBqK2rwK8fQXI@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+31LCn05X66Wh+OHYzWQ5Brc6ubDFGBcNnW7/OWw91cGPvPPp
	guA/iuHBJkQzI+sHDQ04BxpHr1MDZZcX1ok8Vzoxh3wtCVSBwa0WAvIGWl+u6LRIgIneCNM5q+i
	fvXXStFcX/hmCWPKmGx3VDnZeMQs=
X-Gm-Gg: ASbGnctLrz+Z5krAMqBF1OintBwG9+rAU/natAaDXjIiBq3nbGVZXRoVUq03PyVqKy9
	SV9uROXomeZcDcqSbL7qxr8t0tZrak2x4odAEUMZBFzIkmTHX5dHVYFD8PYHfHdLwSVqpb5QNu7
	i7/VvDQFwZct6jZvFekswMZFPtYOnGkw==
X-Google-Smtp-Source: AGHT+IEsJlN+YTcvfKquHTMk4Wm9ujdYCepKl9o6RlU3tiuOMQKVScgI3cM3DOAbz+lpNdy5K/MUTCYLAGgDFMozkcw=
X-Received: by 2002:a17:907:1c21:b0:acb:34b2:851 with SMTP id
 a640c23a62f3a-acef45a24bdmr69175966b.44.1746046235221; Wed, 30 Apr 2025
 13:50:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 30 Apr 2025 22:50:23 +0200
X-Gm-Features: ATxdqUHfn2xVmb5PtnWU-2nYoWtM0oW96FuP4eh--40rwyfoSlq0Ii8gQA7-PI0
Message-ID: <CAGudoHFULfaG4h-46GG2cJG9BDCKX0YoPEpQCpgefpaSBYk4hw@mail.gmail.com>
Subject: [RFF] realpathat system call
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Before I explain why the system call and how, I'm noting a significant
limitation upfront: in my proposal the system call is allowed to fail
with EAGAIN. It's not inherent, but I think it's the sane thing to do.
Why I think that's sensible and why it does not defeat the point is
explained later.

Why the system call: realpath(3) is issued a lot for example by gcc
(mostly for header files). libc implements it as a series of
readlinks(!) and it unsurprisingly looks atrocious:
[pid 1096382] readlink("/usr", 0x7fffbac84f90, 1023) = -1 EINVAL
(Invalid argument)
[pid 1096382] readlink("/usr/local", 0x7fffbac84f90, 1023) = -1 EINVAL
(Invalid argument)
[pid 1096382] readlink("/usr/local/include", 0x7fffbac84f90, 1023) =
-1 EINVAL (Invalid argument)
[pid 1096382] readlink("/usr/local/include/bits", 0x7fffbac84f90,
1023) = -1 ENOENT (No such file or directory)
[pid 1096382] readlink("/usr", 0x7fffbac84f90, 1023) = -1 EINVAL
(Invalid argument)
[pid 1096382] readlink("/usr/include", 0x7fffbac84f90, 1023) = -1
EINVAL (Invalid argument)
[pid 1096382] readlink("/usr/include/x86_64-linux-gnu",
0x7fffbac84f90, 1023) = -1 EINVAL (Invalid argument)
[pid 1096382] readlink("/usr/include/x86_64-linux-gnu/bits",
0x7fffbac84f90, 1023) = -1 EINVAL (Invalid argument)
[pid 1096382] readlink("/usr/include/x86_64-linux-gnu/bits/types",
0x7fffbac84f90, 1023) = -1 EINVAL (Invalid argument)
[pid 1096382] readlink("/usr/include/x86_64-linux-gnu/bits/types/FILE.h",
0x7fffbac84f90, 1023) = -1 EINVAL (Invalid argument)

and so on. This converts one path lookup to N (by path component). Not
only that's terrible single-threaded, you may also notice all these
lookups bounce lockref-containing cachelines for every path component
in face of gccs running at the same time (and highly parallel
compilations are not rare, are they).

One way to approach this is to construct the new path on the fly. The
problem with that is that it would require some rototoiling and more
importantly is highly error prone (notably due to symlinks). This is
the bit I'm trying to avoid.

A very pleasant way out is to instead walk the path forward, then
backward on the found dentry et voila -- all the complexity is handled
for you. There is however a catch: no forward progress guarantee.

rename seqlock is needed to guarantee correctness, otherwise if
someone renamed a dir as you were resolving the path forward, by the
time you walk it backwards you may get a path which would not be
accessible to you -- a result which is not possible with userspace
realpath.

Locking rename to stabilize it does not solve the problem as by the
time you retry, the needed dentries may be evicted and you may need to
do I/O which you can't do with that lock held. Once you drop it, you
may end up finding it has changed again and you are back to square
one. In principle this can keep happening indefinitely.

So I think the easiest way out is to in fact allow the routine to just
fail after some number of retries, just to eliminate the need for
forward progress guarantee.

This should be perfectly fine as all userspace already has its own
support for realpath. In the worst case they can just fallback to the
current code, transparently to the consumer.

There is a funny bit where the rename check may be failing a lot, to
be massaged.

Any comments?

What follows below is an ugly as sin implementation for reference,
*not* an actual thing I would submit:
/*
 * realpathat system call
 *
 * TODO: note cpu waste from redundant seq checks from lookup and prepend_path
 * TODO: note why there is EAGAIN
 * TODO: retyr without the lock a bunch of times
 */
SYSCALL_DEFINE5(realpathat, int, dfd, const char __user *, name, char
__user *, buf,
               unsigned long, size, int, flags)
{
       struct path path, root;
       struct filename *filename;
       char *page;
       unsigned f_seq, m_seq, r_seq, len;
       int error;

       if (unlikely(flags != 0))
               return -EINVAL;

       page = __getname();
       if (unlikely(!page))
               return -ENOMEM;

       /* error checked in filename_lookup() */
       filename = getname_flags(name, flags);

       f_seq = __read_seqcount_begin(&current->fs->seq);
       m_seq = __read_seqcount_begin(&mount_lock.seqcount);
       r_seq = __read_seqcount_begin(&rename_lock.seqcount);
       smp_rmb();

       /* repeated seq checks inside! */
       error = filename_lookup(dfd, filename, flags, &path, NULL);
       if (error)
               goto out_putname;

       error = -EAGAIN;

       DECLARE_BUFFER(b, page, PATH_MAX);

       rcu_read_lock();
       get_fs_root_rcu(current->fs, &root);
       prepend_char(&b, 0);
       /*
        * XXX what about unhashed entries (d_path?)
        */
       if (unlikely(prepend_path(&path, &root, &b) > 0)) {
               rcu_read_unlock();
               goto out;
       }
       rcu_read_unlock();

       smp_rmb();
       if (__read_seqcount_retry(&rename_lock.seqcount, r_seq) ||
           __read_seqcount_retry(&mount_lock.seqcount, m_seq) ||
           __read_seqcount_retry(&current->fs->seq, f_seq))
               goto out;

       /* copied verbatim from getcwd */
       len = PATH_MAX - b.len;
       if (unlikely(len > PATH_MAX))
               error = -ENAMETOOLONG;
       else if (unlikely(len > size))
               error = -ERANGE;
       else if (copy_to_user(buf, b.buf, len))
               error = -EFAULT;
       else
               error = len;

out:
       path_put(&path);
out_putname:
       putname(filename);
       __putname(page);
       return error;
}

-- 
Mateusz Guzik <mjguzik gmail.com>


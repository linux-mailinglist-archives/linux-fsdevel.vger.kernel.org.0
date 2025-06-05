Return-Path: <linux-fsdevel+bounces-50703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F53ACE8D7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 06:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C00174824
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 04:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAFB1F7580;
	Thu,  5 Jun 2025 04:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YP1uoV6T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368B5136E;
	Thu,  5 Jun 2025 04:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749096221; cv=none; b=SVmZnFR21H9HXqd2MD0xAR89fpU8aonNs/sY+snHJVT3ZFsehAKbpnzy+TaowQeWBPHE238axLE4j5vyPAXx4dPhqmXs8EFkkZ1/J6QfTcX9OQVshOsm1wGGA0v1xAAa6yysFwplo8hED0pUMXxL1xNmjJRxTJ0d8MXE0mp8AFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749096221; c=relaxed/simple;
	bh=fI8J9rG7JbSFo7ZW/8CY8BUJMXza+StESHTX68eOZkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WGoW1KwpPQxLHbf/CoZrB4VtPA04gIUWqUllY1omMUFVQTOdiWstYW+ZKjOrpoycSZEkrp9PZWSG3XrRX2IZ5w/5udKuP+5xmj72jHZD4hVr2t1qjRa+7uzThp0jzgrFeeu6SlAbgaoxHvqIiIjZW+MoIbF6iy2wZZ72Eyf+bxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YP1uoV6T; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso440136a12.3;
        Wed, 04 Jun 2025 21:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749096219; x=1749701019; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n8Cus5seLSLQKzB+xZDhAecKeXWVYO5YCmHd7YT8TtE=;
        b=YP1uoV6TYAfRTdYqISgjTYVzHjfE34tzFCrmL6DPrxrrSW7kNIWVrM+u1EPsh5BOa3
         XuiTmzlIY08zFxHQ39lQzJy6mTLt5OxiKT7ujgw6mTH/ltxCojOdG5YxjS0IUhq6A6YK
         RodOt/I218HVXBd8IdQf7tKscUpLWAcmp93pN5FHy3kH+Tq2/Juk3LeFE3WAERviVjnV
         mLWVboP3iQ4AIEZ8B9UhQrfQ1jW4Nq3s8qIwQP1OYK8Co6F0c9WkdabfVt4sMN+gKh6a
         +6OYUcWbRGXom+A/1gzqsSJzediTfbLiepudF5GtrzN5Tf91J7zcVsjwMRqRgDpQa43k
         wHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749096219; x=1749701019;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8Cus5seLSLQKzB+xZDhAecKeXWVYO5YCmHd7YT8TtE=;
        b=Q57hqznM7castmZAVusQHte2ets0/Krmlh8+hHx9uKx/QVwRQlbNyvKlLpDTs/u5ry
         HBbyj2pnGzxO7dUkQhHINkw0JFxHrB4GOhOuFwEdvFc1qKqlXtbYUNLYmYwSZOimgzuR
         khV8ArdtCQoz0eAZ+htvK1EAqXXvYVBgMf+t3lK4NaQfYHaPqMOcG5wOdvJLxmyrFacL
         JqhrwGFRSbydH6W//b+zas9ToRWzClJHnAatoFz4ds4ev+CVuD+1I7THzOeaCU4IplTT
         J9G6p1XekppJe13FOBSHve7G/lgOOpV8wGBRs/YYkYmLdPuXcegmY5iU1IJeY9rg71T4
         iqGw==
X-Forwarded-Encrypted: i=1; AJvYcCVQQA/+/xx2Nyr8TU8JgSc5fwuPlUl5d6/PzNhOxhDn9md9No4fDLCjsfqfW5vhvB71tc1PfR5HPvI6xB4=@vger.kernel.org, AJvYcCWztBBkKG1g3qao3DyZ7zt5X2E2Die2FKAc0TpgEW4nCf6ImcQFv1G1q/DEss54HgsWCR9y4kgBHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUD7xVubMRLO02PZP1hWb4OalsXQxGUrmy6X1wz/AA3g5pQtJV
	Z4MmfkaevVVwd+3yfxuQ3nqFb3uvmT6CzYDYO1uGjXb1SELLwtmRUvJr
X-Gm-Gg: ASbGncv1Jmcvrnvas6TOM2tbcPy2WK5arb4blfEsyXQ9cEAM6j0jn0DUePH9rfhdbZb
	hQnShQyqMlhgN2yC+8COU3HYUWR0nLOuKsUCAXqGtNHuR2uFsO/AxwB16av9B5j6USHrKzVbOrG
	x39YHmqv9/S893i5D/q5v7Qdjsj5vC0kBTJk08LdDdPBxnWAtc2KsHeb4q3U3aAeV2DLfBNRolj
	l1sYLKagR0FhsH7hBy05oQVpVMshnthoAQTixKMHq2SgWWLKVK+mB9FmeOMMt/OV9vq+3WIBSul
	MqfSsJiduMHmFBVSjp6Okezt3K0wGJGB5YLnX1A8Yw==
X-Google-Smtp-Source: AGHT+IFleYWpeplnyvLnUHsWZ/C1wgFh8kYYty+VwdGXtjDE7p3YQ3/FXG72/ONc4f5yHBGAVqT9CQ==
X-Received: by 2002:a17:90b:1b42:b0:312:ec3b:82c0 with SMTP id 98e67ed59e1d1-3130ce8a426mr7886836a91.29.1749096219250;
        Wed, 04 Jun 2025 21:03:39 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::9eb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3132bff65c0sm493926a91.6.2025.06.04.21.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 21:03:38 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: bug-gnulib@gnu.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Stephen
 Smalley <stephen.smalley.work@gmail.com>
Subject: Recent Linux kernel commit breaks Gnulib test suite.
Date: Wed, 04 Jun 2025 21:03:37 -0700
Message-ID: <8734ceal7q.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Using the following testdir:

    $ git clone https://git.savannah.gnu.org/git/gnulib.git && cd gnulib
    $ ./gnulib-tool --create-testdir --dir testdir1 --single-configure `./gnulib-tool --list | grep acl`

I see the following result:

    $ cd testdir1 && ./configure && make check
    [...]
    FAIL: test-copy-acl.sh
    [...]
    FAIL: test-file-has-acl.sh

This occurs with these two kernels:

    $ uname -r
    6.14.9-300.fc42.x86_64
    $ uname -r
    6.14.8-300.fc42.x86_64

But with this kernel:

    $ uname -r
    6.14.6-300.fc42.x86_64

The result is:

    $ cd testdir1 && ./configure && make check
    [...]
    PASS: test-copy-acl.sh
    [...]
    PASS: test-file-has-acl.sh

Here is the test-suite.log from 6.14.9-300.fc42.x86_64:

    FAIL: test-copy-acl.sh
    ======================
    
    /home/collin/.local/src/gnulib/testdir1/gltests/test-copy-acl: preserving permissions for 'tmpfile2': Numerical result out of range
    FAIL test-copy-acl.sh (exit status: 1)
    
    FAIL: test-file-has-acl.sh
    ==========================
    
    file_has_acl("tmpfile0") returned no, expected yes
    FAIL test-file-has-acl.sh (exit status: 1)

To investigate further, I created the testdir again after applying the
following diff:

    diff --git a/tests/test-copy-acl.sh b/tests/test-copy-acl.sh
    index 061755f124..f9457e884f 100755
    --- a/tests/test-copy-acl.sh
    +++ b/tests/test-copy-acl.sh
    @@ -209,7 +209,7 @@ cd "$builddir" ||
       {
         echo "Simple contents" > "$2"
         chmod 600 "$2"
    -    ${CHECKER} "$builddir"/test-copy-acl${EXEEXT} "$1" "$2" || exit 1
    +    ${CHECKER} strace "$builddir"/test-copy-acl${EXEEXT} "$1" "$2" || exit 1
         ${CHECKER} "$builddir"/test-sameacls${EXEEXT} "$1" "$2" || exit 1
         func_test_same_acls                           "$1" "$2" || exit 1
       }

Then running the test from inside testdir1/gltests:

    $ ./test-copy-acl.sh
    [...]
    access("/etc/selinux/config", F_OK)     = 0
    openat(AT_FDCWD, "tmpfile0", O_RDONLY)  = 3
    fstat(3, {st_mode=S_IFREG|0610, st_size=16, ...}) = 0
    openat(AT_FDCWD, "tmpfile2", O_WRONLY)  = 4
    fchmod(4, 0610)                         = 0
    flistxattr(3, NULL, 0)                  = 17
    flistxattr(3, 0x7ffda3f6c900, 17)       = -1 ERANGE (Numerical result out of range)
    write(2, "/home/collin/.local/src/gnulib/t"..., 63/home/collin/.local/src/gnulib/testdir1/gltests/test-copy-acl: ) = 63
    write(2, "preserving permissions for 'tmpf"..., 37preserving permissions for 'tmpfile2') = 37
    write(2, ": Numerical result out of range", 31: Numerical result out of range) = 31
    write(2, "\n", 1
    )                       = 1
    exit_group(1)                           = ?
    +++ exited with 1 +++

So, we get the buffer size from 'flistxattr(3, NULL, 0)' and then call
it again after allocating it 'flistxattr(3, 0x7ffda3f6c900, 17)'. This
shouldn't fail with ERANGE then.

To confirm, I replaced 'strace' with 'gdb --args'. Here is the result:

    (gdb) b qcopy_acl 
    Breakpoint 1 at 0x400a10: file qcopy-acl.c, line 84.
    (gdb) run
    Starting program: /home/collin/.local/src/gnulib/testdir1/gltests/test-copy-acl tmpfile0 tmpfile2
    [Thread debugging using libthread_db enabled]
    Using host libthread_db library "/lib64/libthread_db.so.1".
    
    Breakpoint 1, qcopy_acl (src_name=src_name@entry=0x7fffffffd7c3 "tmpfile0", source_desc=source_desc@entry=3, 
        dst_name=dst_name@entry=0x7fffffffd7cc "tmpfile2", dest_desc=dest_desc@entry=4, mode=mode@entry=392) at qcopy-acl.c:84
    84	  ret = chmod_or_fchmod (dst_name, dest_desc, mode);
    (gdb) n
    90	  if (ret == 0)
    (gdb) n
    92	      ret = source_desc <= 0 || dest_desc <= 0
    (gdb) s
    attr_copy_fd (src_path=src_path@entry=0x7fffffffd7c3 "tmpfile0", src_fd=src_fd@entry=3, dst_path=dst_path@entry=0x7fffffffd7cc "tmpfile2", 
        dst_fd=dst_fd@entry=4, check=check@entry=0x4009b0 <is_attr_permissions>, ctx=ctx@entry=0x0) at libattr/attr_copy_fd.c:73
    73		if (check == NULL)
    (gdb) n
    76		size = flistxattr (src_fd, NULL, 0);
    (gdb) n
    77		if (size < 0) {
    (gdb) print size
    $1 = 17
    (gdb) n
    86		names = (char *) my_alloc (size+1);
    (gdb) n
    92		size = flistxattr (src_fd, names, size);
    (gdb) print errno
    $2 = 0
    (gdb) n
    93		if (size < 0) {
    (gdb) print size
    $3 = -1
    (gdb) print errno
    $4 = 34

After confirming with the Fedora Kernel tags [1], I am fairly confident
that it was caused by this commit [2].

But I am not familiar enough with ACLs, SELinux, or the Kernel to know
the fix.

Adding the lists where this was discussed and some of the signers to CC,
since they will know better than me.

Collin

[1] https://gitlab.com/cki-project/kernel-ark
[2] https://github.com/torvalds/linux/commit/8b0ba61df5a1c44e2b3cf683831a4fc5e24ea99d


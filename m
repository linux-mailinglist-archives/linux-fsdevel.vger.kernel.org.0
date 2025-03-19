Return-Path: <linux-fsdevel+bounces-44384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CA0A6811F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 01:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4153E3BAA73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 00:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1FCA935;
	Wed, 19 Mar 2025 00:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="nk345Hev"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2A4A47
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 00:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343338; cv=none; b=PKaf3SMt9mmFHMKVw9q4H2FmjdnQkIJxBtprdzNXLjQDe7J0DkXcP1oODPbc7qO2D5nnoxWzoOmGZtwd4oE2DDIAgmLK//e9jyHahwadvPyOW7I4YRru6v9FJfbuJrb2OJ/h9ukdDtmDNlA+7z1cP6BnJA+y3brYdxFGhKynszU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343338; c=relaxed/simple;
	bh=pHQtgKFyhe1UEM5H1CkXAkQ9ckxP7iar9/3rqYLA8vg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GQFNh92H9PwbzOIIzWTJ7QlBEDB1JKpn9JiubtGJGSSiBjrr/AWswa0VQmeYmPwXUPui2OMNlOHoN7/1A3Pzyusaaqrp2+z0TuPJwXaL15KeNV3JOcF8+6bPx6FYUSN1/zkE8zQoi+LugnRVIJUssHf0LSbfbOxUHPr+zAbxSvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=nk345Hev; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22622ddcc35so7151715ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 17:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742343336; x=1742948136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D+sBSgchPHWEySP2bfLrt8df0wwyowAu2mvbj20TByA=;
        b=nk345HevUR7Q//BQX4OH2ApWTTxQWu7RzOO4UWTlq6Z+7yBat+zUay0hQOo3Xq9cUS
         tr5tXyf2nFLDLxF3AWvhvuxljTtoNpPXFx5wJv+rdsQUjMXb9wlz/ap314zIRJTxT0wc
         guhhaJT2dEcojI086aYopFnWAV51/HgX8zp+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343336; x=1742948136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+sBSgchPHWEySP2bfLrt8df0wwyowAu2mvbj20TByA=;
        b=X6+4u8SfC9HmVtY9oClIV3udtRf22ePQKmdbSfaWzgqoiUH63Qi4j/nbW2hIPt7Ubr
         ++OLtp9+eOX1XRvkebvjaBe609R66nqS81T5GrdWWbRHeqzjxYhHnwtDfAqJZRpLVzQa
         SY8ZAiNQ8C2Aahl7+frDwxXI4YsSIGLd917USVRfpuq5MiNCsXEFSnGnuoVk8V5wToWa
         Wz3huEYHGkudtezNojeVAXT3faKiLi9ysSPVvpNUp3rCyp6CE1h8Me7YXR6BVet2sJCf
         RSXX/7kOmGlkk0wVGZcu+bf9nmqQzr5mx1aPtRLzdf/DZi7PswVqIw/SNvEqQS2zpmg2
         wcNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGVEp+m//JIsdeYPErj8fT/sRUz7KHy/28AgbXdAm1Qru+/tKRsKw4Wx/XNwy5T/Icl8FC74GBMX4d1VvC@vger.kernel.org
X-Gm-Message-State: AOJu0YzdAXSmjVqLI0TUGaLZfcCftxUML19GN/WjdHzEayw99LOVlFM+
	pAve8aFViXrZ5h/mHe1B+9m8KoybkwiwtnY8mKpgtRDH0829oJ5Sd7NqEw1d914=
X-Gm-Gg: ASbGncsVX8QGT4LEY6yJ83HhadSLO15+pyrVLDim0g9J/Ig4LY+xwer6CGq+QDTrZvy
	I5mq8lI7ADCRdRgVkck0AnqvTNIhIHMOSqkH/KiTiFDdmo68nntZz7GPuCw71rJiVXgBMxvzjAY
	tScui+cHNMOXmuq67X9LHQ6/IsH+CkYQ4f9aQ/svr60h3gX5m0KdOe1kNzSGWZVm+xKTXA+SHjq
	vqO3MX6FV8yAp+XYj3yEjsmZa/tX0ypkcnEhqwVs0e2NELGeUPZB/oiZWO+J7n3y0QpYvkrdM3G
	AZCKP2aWw8+ifo0RuBvJCTiNhkHl8d5eZuRAW1s3F2djbrf13g6t
X-Google-Smtp-Source: AGHT+IFUgmcp5ziiDMwrHetBewK21buOCfSn83hSdnwL6/awTXwLICTCoy55xovATS5hzbKk/tpnkQ==
X-Received: by 2002:a17:902:f646:b0:223:90ec:80f0 with SMTP id d9443c01a7336-22649a3170emr9678415ad.22.1742343336040;
        Tue, 18 Mar 2025 17:15:36 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm101281375ad.70.2025.03.18.17.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:15:35 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	kuba@kernel.org,
	shuah@kernel.org,
	sdf@fomichev.me,
	mingo@redhat.com,
	arnd@arndb.de,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	jolsa@kernel.org,
	linux-kselftest@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [RFC -next 00/10] Add ZC notifications to splice and sendfile
Date: Wed, 19 Mar 2025 00:15:11 +0000
Message-ID: <20250319001521.53249-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to the RFC.

Currently, when a user app uses sendfile the user app has no way to know
if the bytes were transmit; sendfile simply returns, but it is possible
that a slow client on the other side may take time to receive and ACK
the bytes. In the meantime, the user app which called sendfile has no
way to know whether it can overwrite the data on disk that it just
sendfile'd.

One way to fix this is to add zerocopy notifications to sendfile similar
to how MSG_ZEROCOPY works with sendmsg. This is possible thanks to the
extensive work done by Pavel [1].

To support this, two important user ABI changes are proposed:

  - A new splice flag, SPLICE_F_ZC, which allows users to signal that
    splice should generate zerocopy notifications if possible.

  - A new system call, sendfile2, which is similar to sendfile64 except
    that it takes an additional argument, flags, which allows the user
    to specify either a "regular" sendfile or a sendfile with zerocopy
    notifications enabled.

In either case, user apps can read notifications from the error queue
(like they would with MSG_ZEROCOPY) to determine when their call to
sendfile has completed.

I tested this RFC using the selftest modified in the last patch and also
by using the selftest between two different physical hosts:

# server
./msg_zerocopy -4 -i eth0 -t 2 -v -r tcp

# client (does the sendfiling)
dd if=/dev/zero of=sendfile_data bs=1M count=8
./msg_zerocopy -4 -i eth0 -D $SERVER_IP -v -l 1 -t 2 -z -f sendfile_data tcp

I would love to get high level feedback from folks on a few things:

  - Is this functionality, at a high level, something that would be
    desirable / useful? I think so, but I'm of course I am biased ;)

  - Is this approach generally headed in the right direction? Are the
    proposed user ABI changes reasonable?

If the above two points are generally agreed upon then I'd welcome
feedback on the patches themselves :)

This is kind of a net thing, but also kind of a splice thing so hope I
am sending this to right places to get appropriate feedback. I based my
code on the vfs/for-next tree, but am happy to rebase on another tree if
desired. The cc-list got a little out of control, so I manually trimmed
it down quite a bit; sorry if I missed anyone I should have CC'd in the
process.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/cover.1657643355.git.asml.silence@gmail.com/

Joe Damato (10):
  splice: Add ubuf_info to prepare for ZC
  splice: Add helper that passes through splice_desc
  splice: Factor splice_socket into a helper
  splice: Add SPLICE_F_ZC and attach ubuf
  fs: Add splice_write_sd to file operations
  fs: Extend do_sendfile to take a flags argument
  fs: Add sendfile2 which accepts a flags argument
  fs: Add sendfile flags for sendfile2
  fs: Add sendfile2 syscall
  selftests: Add sendfile zerocopy notification test

 arch/alpha/kernel/syscalls/syscall.tbl      |  1 +
 arch/arm/tools/syscall.tbl                  |  1 +
 arch/arm64/tools/syscall_32.tbl             |  1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |  1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |  1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |  1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |  1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |  1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |  1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |  1 +
 arch/s390/kernel/syscalls/syscall.tbl       |  1 +
 arch/sh/kernel/syscalls/syscall.tbl         |  1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |  1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |  1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |  1 +
 fs/read_write.c                             | 40 +++++++---
 fs/splice.c                                 | 87 +++++++++++++++++----
 include/linux/fs.h                          |  2 +
 include/linux/sendfile.h                    | 10 +++
 include/linux/splice.h                      |  7 +-
 include/linux/syscalls.h                    |  2 +
 include/uapi/asm-generic/unistd.h           |  4 +-
 net/socket.c                                |  1 +
 scripts/syscall.tbl                         |  1 +
 tools/testing/selftests/net/msg_zerocopy.c  | 54 ++++++++++++-
 tools/testing/selftests/net/msg_zerocopy.sh |  5 ++
 27 files changed, 200 insertions(+), 29 deletions(-)
 create mode 100644 include/linux/sendfile.h


base-commit: 2e72b1e0aac24a12f3bf3eec620efaca7ab7d4de
-- 
2.43.0



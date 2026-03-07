Return-Path: <linux-fsdevel+bounces-79695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF7EJGoxrGn2mgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 15:08:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 068A022C0D1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 15:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FC0F303CE0E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2026 14:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD892E1C6B;
	Sat,  7 Mar 2026 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0w/g9Nx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FAF2DC791
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Mar 2026 14:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772892475; cv=none; b=I4LhLEhGJHnnK+a/N+ZVnvgS2smkezza9zGo1aK/JfblYPE6fJUNLB+YaUQow4NMqO5E+QuOWlQtwhVgbkqEc0kI2W521JTXnRsG93vPaQ+EwGh2vPPHqyQqQHr+DDFEbaJqJjh4NMLEZbBYv2SrjdAsRcaTCCC64qNsjLRexBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772892475; c=relaxed/simple;
	bh=q0HizNdLQtkBg+6I2Uwr71BFH46+Qf7XsNZYRKQhaSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gsqwAwLphLkOSr5atoGAQEJ9nmwuVicvj7vjXD7kRvg3/qUoqWNTD1RKzcESggnmSZ61DT1qBcCTq02Bv+s2l6EQlqtKe88zdZMJUIKv1ahq67cbLe9IgTgwc4JAJI93COAatIx1XdqfI6H+CU7fi/l5xDx5SEbF3SnvtULhMFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0w/g9Nx; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-827270d50d4so10399671b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Mar 2026 06:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772892474; x=1773497274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jdS9yl/p7UlIdGAR7tR/qX6v6/HUi/AMSzKRwMf8jaY=;
        b=E0w/g9NxXfrlsysae4YQT/Z4nbnodAnvGWqE08bbrpnk1Aq8YcRn0aFEoF/5vlTbWW
         WujCp1WTHP84Vu9NzWTO5cm19RDvgowO5A8HjFVs/hLEZsuKZhdoCmxRM1kaWWg6hT9c
         bEfqNF3eBHHzthgEHDGPLfvBskdeKoecQKp8je7JmxvNFEnShD+loq8YA1b8Lr504KP2
         xELbXsCVqhhCpORruuwseOoRWd68tcGotqQRIRoTxeaZu2zirMid0nJj4pJhOVtCD8Rd
         sHPN9q7TYpWWhwqC5Xs3rOMAh574q3FGNCxBTWnBEAs5nFnCCOLTUcyPs5aTqQGSpRPX
         08gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772892474; x=1773497274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdS9yl/p7UlIdGAR7tR/qX6v6/HUi/AMSzKRwMf8jaY=;
        b=ORjH/EQtWU9p0RjIjBPxL050Vm70C2aC0/rsGi2wxVUMItVgcGHFU4M+sDhYmj+/ja
         fgP4hq4XwhetyST6cxj9XSc3HEKPT3tubeQzFpt34XzgRWDihv17/6neG49tihc3SCeb
         2FqdT6wca/lVnSHJKsWZTPNls67pJClnMkDSkm048P0HO5eZsvdq3DMXdFbPZTZYl7lz
         OvfoOoh+Men1pRAYxLh/EzkOQuR820pAoISrj2e3d2lzPYj3UiwRtv+NGAWPpRPXKUhr
         tprHJMpEBpZJZgs5Z6ana5g/VAWqYdTT+BbXToXP/Vj95MgBFC5zz5Q9pDqmhWwEWoTw
         ppTQ==
X-Gm-Message-State: AOJu0YwVAJbh9e8EDW/u2gS7FfDYbhfhKmkvPzUqe/IUl05Oq/QL7i6E
	xpGWlNF818M/1pJmXvd+IHH/o1Rq/J1r4fotbpjszr84P1SAIxAWbIR7918rIENu
X-Gm-Gg: ATEYQzxSfNU3x3AwOYRovaC08m2vhm88OV1cdEG8vcHwLXLgYLf9q9DLTDRLEovZCt5
	+n0kBWMQI0HCzJ/Y3mEKzdkCzXXdhUVryhtEJgl8UDsN0zltf+SwnAmWbMbjRWlCWGJTtO5lsbq
	aBdVGJMmXFm3cCgw34DDneUdDtN5cNClypz9JNos+DcrLUPNQ5/GyksecaTIvu9EdnHM+/J9dtN
	6LkNKMAEOgzQ7001IvtBx/QizF8tAqjyZl1evdTRdW84zvNxkbKWUJL/7jLIPkojZiZ9sVdTHbX
	CXnYFiZuOm3fUz3Fl9PU8wjtiLxN9qRDWJfuQgx0WJUWDztfyi1i7+5p+pOeMNSJTm8SNXn1q5c
	HUA+eU/RJ1WTPQ3zdUkvT75bqXmaCpQqaluOEAx8RTF1IC8eXTlOZARjt3Pb0jL+Ickzlo4TcXA
	T811fW29abH9Xaj4waEb+LXuelr7v4f44dxdfv/S6MAiVmZWsrlKiZl9EVOErUuyDtdQ==
X-Received: by 2002:a05:6a00:1581:b0:827:26b0:58d6 with SMTP id d2e1a72fcca58-829a30bf515mr4247393b3a.47.1772892473854;
        Sat, 07 Mar 2026 06:07:53 -0800 (PST)
Received: from toolbx ([103.103.35.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48ddd18sm4747313b3a.56.2026.03.07.06.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 06:07:53 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	arnd@arndb.de,
	adilger@dilger.ca,
	mjguzik@gmail.com,
	smfrench@gmail.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	davem@davemloft.net,
	andreas@gaisler.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	agruenba@redhat.com,
	trondmy@kernel.org,
	anna@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	shuah@kernel.org,
	miklos@szeredi.hu,
	hansg@kernel.org
Subject: [PATCH v5 0/4] OPENAT2_REGULAR flag support for openat2
Date: Sat,  7 Mar 2026 20:06:42 +0600
Message-ID: <20260307140726.70219-1-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 068A022C0D1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,HansenPartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79695-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,uapi-group.org:url]
X-Rspamd-Action: no action

Hi,

I came upon this "Ability to only open regular files" uapi feature suggestion
from https://uapi-group.org/kernel-features/#ability-to-only-open-regular-files
and thought it would be something I could do as a first patch and get to
know the kernel code a bit better.

The following filesystems have been tested by building and booting the kernel
x86 bzImage in a Fedora 43 VM in QEMU. I have tested with OPENAT2_REGULAR that
regular files can be successfully opened and non-regular files (directory, fifo etc)
return -EFTYPE.
- btrfs
- NFS (loopback)
- SMB (loopback)

Changes in v5:
- EFTYPE is already used in BSDs mentioned in commit message
- consistently return -EFTYPE in all filesystems

Changes in v4:
- changed O_REGULAR to OPENAT2_REGULAR
- OPENAT2_REGULAR does not affect O_PATH
- atomic_open codepaths updated to work properly for OPENAT2_REGULAR
- commit message includes the uapi-group URL
- v3 is at: https://lore.kernel.org/linux-fsdevel/20260127180109.66691-1-dorjoychy111@gmail.com/T/

Changes in v3:
- included motivation about O_REGULAR flag in commit message e.g., programs not wanting to be tricked into opening device nodes
- fixed commit message wrongly referencing ENOTREGULAR instead of ENOTREG
- fixed the O_REGULAR flag in arch/parisc/include/uapi/asm/fcntl.h from 060000000 to 0100000000
- added 2 commits converting arch/{mips,sparc}/include/uapi/asm/fcntl.h O_* macros from hex to octal
- v2 is at: https://lore.kernel.org/linux-fsdevel/20260126154156.55723-1-dorjoychy111@gmail.com/T/

Changes in v2:
- rename ENOTREGULAR to ENOTREG
- define ENOTREG in uapi/asm-generic/errno.h (instead of errno-base.h) and in arch/*/include/uapi/asm/errno.h files
- override O_REGULAR in arch/{alpha,sparc,parisc}/include/uapi/asm/fcntl.h due to clash with include/uapi/asm-generic/fcntl.h
- I have kept the kselftest but now that O_REGULAR and ENOTREG can have different value on different architectures I am not sure if it's right
- v1 is at: https://lore.kernel.org/linux-fsdevel/20260125141518.59493-1-dorjoychy111@gmail.com/T/

Thanks.

Regards,
Dorjoy

Dorjoy Chowdhury (4):
  openat2: new OPENAT2_REGULAR flag support
  kselftest/openat2: test for OPENAT2_REGULAR flag
  sparc/fcntl.h: convert O_* flag macros from hex to octal
  mips/fcntl.h: convert O_* flag macros from hex to octal

 arch/alpha/include/uapi/asm/errno.h           |  2 +
 arch/alpha/include/uapi/asm/fcntl.h           |  1 +
 arch/mips/include/uapi/asm/errno.h            |  2 +
 arch/mips/include/uapi/asm/fcntl.h            | 22 +++++------
 arch/parisc/include/uapi/asm/errno.h          |  2 +
 arch/parisc/include/uapi/asm/fcntl.h          |  1 +
 arch/sparc/include/uapi/asm/errno.h           |  2 +
 arch/sparc/include/uapi/asm/fcntl.h           | 35 +++++++++---------
 fs/ceph/file.c                                |  4 ++
 fs/gfs2/inode.c                               |  6 +++
 fs/namei.c                                    |  4 ++
 fs/nfs/dir.c                                  |  4 ++
 fs/open.c                                     |  4 +-
 fs/smb/client/dir.c                           | 14 ++++++-
 include/linux/fcntl.h                         |  2 +
 include/uapi/asm-generic/errno.h              |  2 +
 include/uapi/asm-generic/fcntl.h              |  4 ++
 tools/arch/alpha/include/uapi/asm/errno.h     |  2 +
 tools/arch/mips/include/uapi/asm/errno.h      |  2 +
 tools/arch/parisc/include/uapi/asm/errno.h    |  2 +
 tools/arch/sparc/include/uapi/asm/errno.h     |  2 +
 tools/include/uapi/asm-generic/errno.h        |  2 +
 .../testing/selftests/openat2/openat2_test.c  | 37 ++++++++++++++++++-
 23 files changed, 127 insertions(+), 31 deletions(-)

-- 
2.53.0



Return-Path: <linux-fsdevel+bounces-76629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGkZGug7hmnzLAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 20:07:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC8A1026ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 20:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70D6930557E7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 19:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5309428849;
	Fri,  6 Feb 2026 19:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZW35QmN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C195428833
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 19:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770404756; cv=none; b=WqOmzxO0JnxjeoXYFcwgNX5RPFdf28Wspnaty13f7tQPDZNFIeh4miVhABvB1oJfdyAbml9RuxgfQNfcRKVyZMpjrtLJv+RpiOMMwMfJCJFrz4zMApnW/Yym0L6EsQN/NrNUj79emQjTrr7iTuuL1C0sX5LTqbcMW0noYf/aiaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770404756; c=relaxed/simple;
	bh=1f6GI93kQT/4F4ElSnX/aKYF2QjzP4szTWh1eOYbFuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l+p+6hIVhkgr4XaqG1T5Al0gMM2LIgc/qmqI+F5Rjxg+f/8XbvFYhKP3TNqpFtHmQkFqWDN3p6cgG+64eNvcs8ixhDdnAFTmFcDNnxUSKXLkDbqR9+L2uo3L6b1XjGkXbmSvhsScgAGG4MuFn1kx4PftLZoKYq4er0kS94vo3fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZW35QmN; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-823075fed75so1526181b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Feb 2026 11:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770404755; x=1771009555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oHpc71MwUHw+BmPqdaj5GyPFfKcKVIKu2SMi6s40C0c=;
        b=RZW35QmNIOu/GMzyXkB83fQY+AJ5rl8UBn5to2rZISZ0XrdgU+QkuEPON2EpHS69u3
         opU3tA/6WH3UjEqaDXgXqYrsBd5GJMhvtS6yPuiEPiAECy1X9bvlF7zHId7Nz/2Gi5gp
         OY+nrJf0AwjKthYhgxhL9tyzn0pRaCTcmVagSv6R/Hg47iLW27p+V87NUzM19/5oN4xC
         yFhpD4vpGh2KUwqirE/yOI8hwkIqTIjkm6YrND2sWcHaw+JcGC2NDZeBqVG/Fg40Gqj0
         QOD3Ff5HUUyMCsiTf00PTaQaHE58z/1EmKMaNkYlwzbC49z8lAosZBh65Dum61V5UST1
         Z6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770404755; x=1771009555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHpc71MwUHw+BmPqdaj5GyPFfKcKVIKu2SMi6s40C0c=;
        b=NsY23wLfzL7xM+toTv0qFO0dfxL7Vdmqn8PJdHbsrrov0ekezUfEaDkKpnuvREty4y
         pENKdUjkrz3PxbJIyMMPDw2htssblRUrFSzj2iqbn1oxZMfHkEsnzQogRBk6nE0sogiO
         xsru/R22HcBcpd5Q2KJG5ZIJfZipWccU6MTJ/B87clrW+vUYjpz7Mml/XuIDD4qmJGFP
         kEe/Kss5pzrVo1xyIjTfib/TOz28PSa+HqwfYilpqrPq7SkslXY42xdk4YWZADC1YrO0
         KOaeXxNYkHUshtmWQ7v/xPgrXQSXKwLutmQ+eFd+dO9C6YyPwUVOiGCKB84DhnChTIpz
         4/Bg==
X-Gm-Message-State: AOJu0Yxjj6TBzYHr981PdjB1i0n3Zngr1qytvyCsR/lpeqhyfIyPZx+H
	fb+QMlgzVgBFpZ3n9G2w/MpF3Co7WWZlp74m9jMrRW/x1q0NtK0Sz7wrFKcSYQ==
X-Gm-Gg: AZuq6aJIiyUcXst03WeofBbVz00u62Z/xfdNYYaaoaqHJABJ2aBduMEjQt9gipZfRCU
	2k0t9LL7S9nusWgB06LQm+85nsfwNa+y/Bh4mxVierPnuAUkLDglnKeJ9y2NCtZsplbBa6yPaGX
	f0zJtrjOp4GEaZ5ZJODo15W/kQpyGeALoo53vAwd85XFLuh3w2sAnTAYskoaCtd5VplSPB0C/B1
	1TyYPDHe0QMXr9/5sVqcKMeozSy9o+eU7HBJeVz59N8LbpU571SY7errHWyfr2uK666FShOZ4VM
	nJjNPWAGeZKs4ERQBGyjhlHyq8d/w7hC/C3lhZpi4zbEthiE+rBeNzMptepf3JKyM/Mfrvyd0ah
	Ffn/zdEeSD+lCgW0lEgGGz7j8fS0nf/9eqxEImE3aDsDh1Gao4CO9BQ+ybE6trbllIqz7MQh5uH
	GdvZcso+4LuF64hnZTMsmJ5IKC+p2bc8kX7tOCSOwScxc=
X-Received: by 2002:a05:6a00:12c5:b0:81e:8cde:cd0a with SMTP id d2e1a72fcca58-8242d521d42mr7123377b3a.34.1770404755360;
        Fri, 06 Feb 2026 11:05:55 -0800 (PST)
Received: from toolbx ([103.230.182.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418a70fesm2910894b3a.45.2026.02.06.11.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 11:05:54 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	arnd@arndb.de,
	adilger@dilger.ca,
	mjguzik@gmail.com,
	smfrench@gmail.com
Subject: [PATCH v4 0/4] openat2: new OPENAT2_REGULAR flag support
Date: Sat,  7 Feb 2026 01:03:35 +0600
Message-ID: <20260206190536.57289-1-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76629-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uapi-group.org:url]
X-Rspamd-Queue-Id: DCC8A1026ED
X-Rspamd-Action: no action

Note that in v4, for now, I have returned -EINVAL from the atomic_open codepaths.
I do want to make this new flag properly supported and proper api behavior, but
last time I could not quite understand what should be done for the atomic_open
codepaths. So to have a more concrete discussion, I have included the -EINVAL
changes.

Changes in v4:
- changed O_REGULAR to OPENAT2_REGULAR
- OPENAT2_REGULAR does not affect O_PATH
- OPENAT2_REGULAR with O_DIRECTORY will open path for both directory or regular file
- atomic_open codepaths updated to return -EINVAL when OPENAT2_REGULAR is set
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

Hi,

I came upon this "Ability to only open regular files" uapi feature suggestion
from https://uapi-group.org/kernel-features/#ability-to-only-open-regular-files
and thought it would be something I could do as a first patch and get to
know the kernel code a bit better.

I am not quite sure if the semantics that I baked into the code for this
O_REGULAR flag's behavior when combined with other flags like O_CREAT look
good and if there are other places that need the checks. I can fixup my
patch according to suggestions for improvement. I did some happy path testing
and the O_REGULAR flag seems to work as intended.

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
 arch/mips/include/uapi/asm/fcntl.h            | 22 ++++-----
 arch/parisc/include/uapi/asm/errno.h          |  2 +
 arch/parisc/include/uapi/asm/fcntl.h          |  1 +
 arch/sparc/include/uapi/asm/errno.h           |  2 +
 arch/sparc/include/uapi/asm/fcntl.h           | 35 +++++++-------
 fs/9p/vfs_inode.c                             |  3 ++
 fs/9p/vfs_inode_dotl.c                        |  3 ++
 fs/ceph/file.c                                |  3 ++
 fs/fuse/dir.c                                 |  3 ++
 fs/gfs2/inode.c                               |  3 ++
 fs/namei.c                                    |  9 +++-
 fs/nfs/dir.c                                  |  3 ++
 fs/nfs/file.c                                 |  3 ++
 fs/open.c                                     |  2 +-
 fs/smb/client/dir.c                           |  3 ++
 fs/vboxsf/dir.c                               |  3 ++
 include/linux/fcntl.h                         |  2 +
 include/uapi/asm-generic/errno.h              |  2 +
 include/uapi/asm-generic/fcntl.h              |  4 ++
 tools/arch/alpha/include/uapi/asm/errno.h     |  2 +
 tools/arch/mips/include/uapi/asm/errno.h      |  2 +
 tools/arch/parisc/include/uapi/asm/errno.h    |  2 +
 tools/arch/sparc/include/uapi/asm/errno.h     |  2 +
 tools/include/uapi/asm-generic/errno.h        |  2 +
 .../testing/selftests/openat2/openat2_test.c  | 46 ++++++++++++++++++-
 28 files changed, 138 insertions(+), 31 deletions(-)

-- 
2.53.0



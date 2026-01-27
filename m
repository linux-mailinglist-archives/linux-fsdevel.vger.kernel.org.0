Return-Path: <linux-fsdevel+bounces-75632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIR0Kb/9eGmOuQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 19:02:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC49098BDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 19:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54CD93045005
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 18:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C422432549A;
	Tue, 27 Jan 2026 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVOwcHkj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5822EAD15
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536892; cv=none; b=gH1Fi8WAv86O3sOwZavI8Ge7HWtIEyTSwGlP3CvqLVRNi+QH0t4CAnoux0JWHCiwDxUVGSOd6jSNLLl0yW7sQCqZMFfYPR79AJahc39ylt6zmIpnJ3lhkno5Yk3UfR0fpONHOTUCLvwai6Px2pYZzXAzuAEZN2TgEFMVhkEuMRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536892; c=relaxed/simple;
	bh=ZM2PfF7OtpvnUz9E7RLzRHHGg4FnN/x9LbgwS06hhgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ob7QstTc01ktrUg9rinQsZ6TRhViZETzvB2ZXTzDA/6pC9OqYCfbfI3CdGQHTgVO6U8B+K4jMzxWnDbC7mfEvGi3ZsvTXdZ41oqoa6ZlSJrnAe4fxlzIq+R/f9hL6uUACQsou/xHnYWC1JFf3j1T4H6AhdGQYCcFqTY7ssv5jpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVOwcHkj; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c1d98ba11so5086294a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 10:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769536890; x=1770141690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AHiQlC7luusLUwQrvl8no0ei3loryI/DAP75t23pbw0=;
        b=nVOwcHkjM9ePdK1VGXshYlSGQrysJ5p3hSEKEpX2gh3/vfdVqVjjMf9+tpw7g5eJaN
         LgO+THNzuPXg6bH5M0L4PqGD+yxdAd0uN9g67RKSUGgELCuoOLm4B1+OuwMANMx390XI
         Syj8C8TRt2RdXPjPGUWyWCN8MJ8j16g2MM9XExXx/HhSs0YhwO21bbJXcfKofbdPVVwJ
         5EI+oNw8KAUeNJ9mdd2UvWeniAbVso9sAywY2dl0SB3EBBXMNzytxDO1pnYEAsDn5evs
         5oTVvx7ooObOUMeA8b9V7l8AJTSdsyUOsRfMzUgP/RVdRum2jEg/6pPv1VfsMnWfPK3a
         sf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769536890; x=1770141690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHiQlC7luusLUwQrvl8no0ei3loryI/DAP75t23pbw0=;
        b=wu6kSemSCWiq6x70MrfTct4Xd4z29FnM7UDvgOgrbnsq/hhcJmzgegf9bC8lraE6Dg
         8IYoRaUeiWMkr6YBt1MlJ981MUSY9Z4N4X4Jr06j2W6BKHCRNIQsmg6q9jCyNYJHvs5w
         HmIvco7Ehmw6IHN6HB724rwz3VxXlos0xP72ZukdhLKVBZOT8/5VlvbuGENt/8qRK2RX
         x1dpl87ic5a7rDsiqRriauUIwdHlKGMI4YniwdT6HlhhUExKNXkJFRYmIT7ILUe2YDc3
         kdFup5/H2cZtXOi/QMbMs5q7tOUiP20rH0V8qXnkmg52jyXXOtE7FvwB97H6TfgLLNOf
         Rp3w==
X-Gm-Message-State: AOJu0YwL5BKK8zE2spdASAtXl5WAtjCRYSL5EUFJLGOCofVBYFgdyGQk
	h80n7f876uO94qIwUj4DCFjOXVlH5pfl3BXf1inQkhfLI0a6X3uXwk5mM6i50g==
X-Gm-Gg: AZuq6aICV4RoxtCGw4rKQ9+jCW/HTnyn40mqgbVqUegJPoD7Db1q8trly+ABUSWLe0F
	Kxj//1SGwrl/xxW+2l77HGVULFARnDA7zoiTQhb6Puz7auAPuCwMqb/Tw31JQsqYDo+hW+uFKnR
	BlwzTlkn4G47HFDjMKjpFYVXeG9P0TBFABOZycRZNLJP9UKYKW/wgZrmSNeLnblBhPlKAMy67Tn
	zYTLOh0ifM5pPiNqxuwLh7vMH2of8KfvknT3ctDI1jDSLOjhD0rdoxUkLUvicMl1o19Zi6wuU8a
	wkWpzXpZw/uqiIWm9Yd8Vpa3XmKc2KtD95JdZuSHYN3qqJYqyzrODC15PkKLlsa0Q4ZA9IaOvRV
	M+GyN+rXA0PA9tQ30aOGC69kNRzB6zJTdKSUGJfiJoeTKR8nFn7RdT7rKT2w8NB5O0mRo6puunU
	tUx/t9SZdJbxmPrdoyjed+ZCftZOuhCPt+jrAj+8WFSvE=
X-Received: by 2002:a17:90b:1fcc:b0:352:cd8e:3ead with SMTP id 98e67ed59e1d1-353feccd3f9mr2018770a91.10.1769536889714;
        Tue, 27 Jan 2026 10:01:29 -0800 (PST)
Received: from toolbx ([103.230.182.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b1bc68sm216891b3a.2.2026.01.27.10.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:01:29 -0800 (PST)
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
	adilger@dilger.ca
Subject: [PATCH v3 0/4] O_REGULAR flag support for open
Date: Tue, 27 Jan 2026 23:58:16 +0600
Message-ID: <20260127180109.66691-1-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.52.0
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75632-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uapi-group.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC49098BDA
X-Rspamd-Action: no action

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
  open: new O_REGULAR flag support
  kselftest/openat2: test for O_REGULAR flag
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
 fs/fcntl.c                                    |  2 +-
 fs/namei.c                                    |  6 +++
 fs/open.c                                     |  4 +-
 include/linux/fcntl.h                         |  2 +-
 include/uapi/asm-generic/errno.h              |  2 +
 include/uapi/asm-generic/fcntl.h              |  4 ++
 tools/arch/alpha/include/uapi/asm/errno.h     |  2 +
 tools/arch/mips/include/uapi/asm/errno.h      |  2 +
 tools/arch/parisc/include/uapi/asm/errno.h    |  2 +
 tools/arch/sparc/include/uapi/asm/errno.h     |  2 +
 tools/include/uapi/asm-generic/errno.h        |  2 +
 .../testing/selftests/openat2/openat2_test.c  | 37 ++++++++++++++++++-
 20 files changed, 102 insertions(+), 32 deletions(-)

-- 
2.52.0



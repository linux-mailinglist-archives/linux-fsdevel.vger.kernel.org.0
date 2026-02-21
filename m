Return-Path: <linux-fsdevel+bounces-77857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMIXCS3fmWm2XAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 17:37:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAB916D46B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 17:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3A33302CB37
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 16:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CC232573D;
	Sat, 21 Feb 2026 16:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jfi9u9wL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE3A2D12F3
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Feb 2026 16:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771691818; cv=none; b=mZyLMCBbNqzeHllWn+9rVt7qZqYrwA35hJ9qiX6ENJm2DB35UeP0SRAYiBWaucTR1i3OKA8KR4LKowjqZV3vLHCFD47SCERM198z5I7MzgUHFEIUC7GKsFJL5Lb0kE/tZ8PijOt9d8dIbmbIAFHnGXp9+ZdVoiOz7OvJbpXNcDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771691818; c=relaxed/simple;
	bh=Q8LjG5w0LfBzA+qqIJUKX9oy/FN75Vn0W7VHoH69Qv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=URVChMBbGI+pF7V8zLvYzAion2a5cOWQmTlEcSNJcsoq/LkWbQHLSKSExElaxtFV+knJeflkY561cyO5fktpesb8jJ0nd3L3AX+WIEVBJb4CdWXDE6OJXuyMzWrzVL8FRegRviX9uYsoPC9uLAdHnN6zrThC34ziPZJJGHegIpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jfi9u9wL; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5665171836cso3426042e0c.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Feb 2026 08:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771691816; x=1772296616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dchZpIBGjK9hFXqFYovVVV/bmoJVWZnsrs7zJJ1McUQ=;
        b=Jfi9u9wL46HY+yUZ/kMr+7X8yC3YSuMKl/XsIT6iTJRuIa+4guRp7h+knOvYxk8AmU
         6J9Bs/tRMet58pKM+Wj13cbbPDYIoNRf7j85Zd/76/6Q/9lcZsI6+4VJUwf74kUiTgyw
         EohUQY4Scad3224bTfE636CA5LnAv1rnt/hhoYvKs0LqfAmHUv3FN9cuMMt8nlfIqQsT
         khgXoiBHJFRko8Hs2ovUCtdoFv960xQejeJhSKCj2ujVXihmrCkENmf45uk4IDIMp/5o
         /huKauLuq0tcSYhkmtOi0Stcs/EavJVLQsiKrAJHDIHB5eY+eaC1KWYyRP3fWXpOFlnQ
         lFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771691816; x=1772296616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dchZpIBGjK9hFXqFYovVVV/bmoJVWZnsrs7zJJ1McUQ=;
        b=OabLLhxIrBOCvZBL2JVLcPRoUMG/MoIJlhG8Jb153VZ0UjL1bxzqaPVT8dcq+9Lzxn
         qCwUS//2hNTfU8FfSHJEcmm3nJXD9f9zXzBHQ4GRAq7Bv1NiiwdGmP0gzayRzY06IS14
         6ttc6EWMSQ4KMIcKJcSduYAmsdaLPShTSsYfWlaKJadhhwgWJOVM9K3/uMbGJS87SiaR
         98qOyQxx/xigrLpZLLjCw/6+5xeaF92oODEbjsqi6Ag0uZN2BYB2sbT3EKssblkuVPvI
         Dgc+W0JYfyeDZmKtgg1S1WsFS8qQ10oUGJPxBRgYzkHKo7U/y7VPmcF+PIssPRpFA/LN
         V8fw==
X-Gm-Message-State: AOJu0Yza7zkUvqvXQNV5upF3RXhDXiOZ31o9AlwsynZGJmZhn0S6z05m
	5B6PTwVaJvmCCGkk6dm8fSwbLzKFWCopr+lQS1kUDicksWsXCBMqcar5G+Lhbw==
X-Gm-Gg: AZuq6aJQJhMdd6hM1EOgY7horSH1SvMztzhBuo6em/IKtNi4VmbTm8fBT2AQ/AR+WAp
	4nAFZ5lXBCa4WKNQrGhqB/Nmnzgd5aROktOBgWfHxzjYGIDKXmV25h7o6g+P8E4zQJv6TYzyBZr
	Z7wePTzztADR9v/DSikMmYszTIJPh2do/4Jzhjt/EfR2HIR3YMMO40lhJsn2fl4SSRB47pMRJeV
	b/oFFX+tqFV3yXVBrwaCxUbRLhqSx1Yp2j3pQ6R3MJHhecyuXUnW57MZDPUsiHwkAZx7DItxZP6
	ufVMHkWcPlWoN9cljU/PAcdGI9xsz9h9YugawNZlzuntR4FkX5WnXf0B6ndiImiX87oO/rgDkUZ
	YFn9AkUJBh/clquBPj1XxxG0XJ25A3NYNYyrhXDztHhzAjLUQdJC2unqyAW3v4hTU+kQyO+0AMK
	ZPrPItFI3kU6LMVLLuxnkFl69T8Zz11B+mi6F3j4PNb3w78y1sylJo+nc=
X-Received: by 2002:a17:903:1d2:b0:295:24ab:fb06 with SMTP id d9443c01a7336-2ad74458fa3mr31285505ad.22.1771685983010;
        Sat, 21 Feb 2026 06:59:43 -0800 (PST)
Received: from toolbx ([103.230.182.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7503f4a4sm23730205ad.79.2026.02.21.06.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 06:59:42 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
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
Subject: [PATCH v4 0/4] OPENAT2_REGULAR flag support in openat2
Date: Sat, 21 Feb 2026 20:45:42 +0600
Message-ID: <20260221145915.81749-1-dorjoychy111@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[41];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,HansenPartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77857-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uapi-group.org:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ACAB916D46B
X-Rspamd-Action: no action

Hi,

I came upon this "Ability to only open regular files" uapi feature suggestion
from https://uapi-group.org/kernel-features/#ability-to-only-open-regular-files
and thought it would be something I could do as a first patch and get to
know the kernel code a bit better.

I only tested this new flag on my local system (fedora btrfs).

Note that I had submitted a v4 previously (that had -EINVAL for the atomic_open
code paths) but did not do a get_maintainers.pl. It didn't get any review and
please ignore that one anyway. In this version, I have tried to properly update
the filesystems that provide atomic_open (fs/ceph, fs/nfs, fs/smb, fs/gfs2,
fs/fuse, fs/vboxsf, fs/9p) for the new OPENAT2_REGULAR flag. Some of them
(fs/fuse, fs/vboxsf, fs/9p) didn't need any changing. As far as I see, most of
the filesystems do finish_no_open for ~O_CREAT and have file->f_mode |= FMODE_CREATED
for the O_CREAT code path which I assume means they always create new file which
is a regular file. OPENAT2_REGULAR | O_DIRECTORY returns -EINVAL (instead of working
if path is either a directory or regular file) as it was easier to reason about when
making changes in all the filesystems.

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
 fs/gfs2/inode.c                               |  2 +
 fs/namei.c                                    |  4 ++
 fs/nfs/dir.c                                  |  4 +-
 fs/open.c                                     |  4 +-
 fs/smb/client/dir.c                           | 11 +++++-
 include/linux/fcntl.h                         |  2 +
 include/uapi/asm-generic/errno.h              |  2 +
 include/uapi/asm-generic/fcntl.h              |  4 ++
 tools/arch/alpha/include/uapi/asm/errno.h     |  2 +
 tools/arch/mips/include/uapi/asm/errno.h      |  2 +
 tools/arch/parisc/include/uapi/asm/errno.h    |  2 +
 tools/arch/sparc/include/uapi/asm/errno.h     |  2 +
 tools/include/uapi/asm-generic/errno.h        |  2 +
 .../testing/selftests/openat2/openat2_test.c  | 37 ++++++++++++++++++-
 23 files changed, 119 insertions(+), 32 deletions(-)

-- 
2.53.0



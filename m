Return-Path: <linux-fsdevel+bounces-17973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E5B8B4626
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 13:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 122D6288709
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 11:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CF94F1E0;
	Sat, 27 Apr 2024 11:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="EuDIhThW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward203a.mail.yandex.net (forward203a.mail.yandex.net [178.154.239.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C5A4D5AC;
	Sat, 27 Apr 2024 11:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714217508; cv=none; b=qGrjyPYbR4K8YSd986u91+SGNAnzEYrVIEyoNjuxsm8/e2yFIG0cudbxg4GFY5+BjD01m3zzOC7EmvgJtiiyYmpj5padz3FJtV9fGE3WdUTPMML2lwg0xGA+j4xExLNnI9PPHi7Pm8zBzFyuc7Q2TCC5MrwWa3GzgYmoxy3U9P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714217508; c=relaxed/simple;
	bh=hI1bSFK6/X4iALDRDEAUD7sApxCEtoFPFoe6Z2HMYwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tDKcrr0jGCjgcLJ+K+dornbT07FlaNbMTXl63pZCMadqUaPnwH+xNT4LU0pLCwdLN+J+7HMGCxRDEYAmN4gFr4qHOAX/sNkZgQWkn0PT8kh+xqrzp0YdkX8M77pwN2b3BYy0ZptE57+MIufEQM5AUyjfHwWPp0Yle3+9o13GMzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=EuDIhThW; arc=none smtp.client-ip=178.154.239.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d100])
	by forward203a.mail.yandex.net (Yandex) with ESMTPS id 53EFA666E2;
	Sat, 27 Apr 2024 14:25:07 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:2a02:0:640:77d9:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id A48A546C9B;
	Sat, 27 Apr 2024 14:24:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id uOMFvPQXlqM0-vvZKY9q8;
	Sat, 27 Apr 2024 14:24:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1714217097; bh=XCfS/LUmhc1w0qDiOkcF2eV7jBKumbvKS05niUxy/Rs=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=EuDIhThWEd0NuT9ktrUH0zZfx5d+4ZSJ5kNqdgYliEsonvmrnVqEdod08AwZZZ75k
	 1MyPi99TC0t+mZIAUhdQTqzDeLVnWso6EXI60hlPeO8NJ/fqjjmcxQX7bV6QCFVaWT
	 EfxPiWRmGCF6CCPWsbWhT1APTCdkjpxLURpHUAuo=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Stas Sergeev <stsp2@yandex.ru>
To: linux-kernel@vger.kernel.org
Cc: Stas Sergeev <stsp2@yandex.ru>,
	Stefan Metzmacher <metze@samba.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andy Lutomirski <luto@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	David Laight <David.Laight@ACULAB.COM>,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v6 0/3] implement OA2_CRED_INHERIT flag for openat2()
Date: Sat, 27 Apr 2024 14:24:48 +0300
Message-ID: <20240427112451.1609471-1-stsp2@yandex.ru>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch-set implements the OA2_CRED_INHERIT flag for openat2() syscall.
It is needed to perform an open operation with the creds that were in
effect when the dir_fd was opened, if the dir was opened with O_CRED_ALLOW
flag. This allows the process to pre-open some dirs and switch eUID
(and other UIDs/GIDs) to the less-privileged user, while still retaining
the possibility to open/create files within the pre-opened directory set.

The sand-boxing is security-oriented: symlinks leading outside of a
sand-box are rejected. /proc magic links are rejected. fds opened with
O_CRED_ALLOW are always closed on exec() and cannot be passed via unix
socket.
The more detailed description (including security considerations)
is available in the log messages of individual patches.

Changes in v6:
- it appears open flags bit 23 is already taken on parisc, and bit 24
  is taken on alpha. Move O_CRED_ALLOW to bit 25.
- added selftests for both O_CRED_ALLOW and O_CRED_INHERIT additions

Changes in v5:
- rename OA2_INHERIT_CRED to OA2_CRED_INHERIT
- add an "opt-in" flag O_CRED_ALLOW as was suggested by many reviewers
- stop using 64bit types, as suggested by
  Christian Brauner <brauner@kernel.org>
- add BUILD_BUG_ON() for VALID_OPENAT2_FLAGS, based on Christian Brauner's
  comments
- fixed problems reported by patch-testing bot
- made O_CRED_ALLOW fds not passable via unix sockets and exec(),
  based on Christian Brauner's comments

Changes in v4:
- add optimizations suggested by David Laight <David.Laight@ACULAB.COM>
- move security checks to build_open_flags()
- force RESOLVE_NO_MAGICLINKS as suggested by Andy Lutomirski <luto@kernel.org>

Changes in v3:
- partially revert v2 changes to avoid overriding capabilities.
  Only the bare minimum is overridden: fsuid, fsgid and group_info.
  Document the fact the full cred override is unwanted, as it may
  represent an unneeded security risk.

Changes in v2:
- capture full struct cred instead of just fsuid/fsgid.
  Suggested by Stefan Metzmacher <metze@samba.org>

CC: Stefan Metzmacher <metze@samba.org>
CC: Eric Biederman <ebiederm@xmission.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: Andy Lutomirski <luto@kernel.org>
CC: Christian Brauner <brauner@kernel.org>
CC: Jan Kara <jack@suse.cz>
CC: Jeff Layton <jlayton@kernel.org>
CC: Chuck Lever <chuck.lever@oracle.com>
CC: Alexander Aring <alex.aring@gmail.com>
CC: David Laight <David.Laight@ACULAB.COM>
CC: linux-fsdevel@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-api@vger.kernel.org
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Christian Göttsche <cgzones@googlemail.com>

-- 
2.44.0



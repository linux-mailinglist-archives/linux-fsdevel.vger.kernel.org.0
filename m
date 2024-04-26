Return-Path: <linux-fsdevel+bounces-17901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 545D88B38A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 15:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096681F23868
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 13:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D6E1482E7;
	Fri, 26 Apr 2024 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="vt9xLVEP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward206a.mail.yandex.net (forward206a.mail.yandex.net [178.154.239.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449EA1474CA;
	Fri, 26 Apr 2024 13:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714138769; cv=none; b=INIEnX/7F83jKb8EUv1wE7YhcU+Svvxei4lJY2BFak0VldCt27l1oo8vdi6J0ES047P/+wfllAcxR/U9W0o/lUx7xRPGpg+mJvLaB/+Z0DQpdWzMSEiJ5s6IKAS6MXqbpftDeTYbdiB+BgyJr9R1kRJgiCJJ66XXEMtZoy+HMrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714138769; c=relaxed/simple;
	bh=Ud4bj59xe7FFvd86owQCtAKt6fi+lWLRuVzs9/4jMsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G93GwIvCr8GpKBevpvYU03jn/RI5vJAIHsFUFpLf0BPA+1WFTek7icrTsTE2twMmnLz5psL2xvCx6pro253y7zysvj0D4xfYzUzPrAzVCw+eeXM2exbcgTUf3WUHqVQV0CHrdBR1kCfJNGyTJY2Ev7IjIDJY4UI/W+lPfaP9Rng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=vt9xLVEP; arc=none smtp.client-ip=178.154.239.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d101])
	by forward206a.mail.yandex.net (Yandex) with ESMTPS id 4229E669DE;
	Fri, 26 Apr 2024 16:34:12 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:230c:0:640:f8e:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id EC7E060B62;
	Fri, 26 Apr 2024 16:34:03 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 2YN3P0DXnmI0-C8aWD0Fy;
	Fri, 26 Apr 2024 16:34:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1714138443; bh=+yY0DYJlOGkiuHYMe8mvayuLQSZwCYa0RIUgNaua8b8=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=vt9xLVEPGm014UZZsQwL78282PrqfastPLSt9CWkWMauPJGuvzTGJkqVWNhoxdY6j
	 Epk7BedZlJj3LitYbAGgP2trSfDLnYjL9YSYnFY5PaJySqJctsv3mqTlOSLgjBzadb
	 qXOXbYORw+zs1JfVbikDf4oRAAsni33Nr3BCVXNk=
Authentication-Results: mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
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
Subject: [PATCH v5 0/3] implement OA2_CRED_INHERIT flag for openat2()
Date: Fri, 26 Apr 2024 16:33:07 +0300
Message-ID: <20240426133310.1159976-1-stsp2@yandex.ru>
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



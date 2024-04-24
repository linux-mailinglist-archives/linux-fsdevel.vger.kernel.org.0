Return-Path: <linux-fsdevel+bounces-17620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6578B07B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 12:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6A31C23058
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 10:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648BA159908;
	Wed, 24 Apr 2024 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="j1VFol8S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDE1152E0B;
	Wed, 24 Apr 2024 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955979; cv=none; b=aZfH8pVJwQoiaewmspk8bZyXRV7rm5D1c8sBj+sWkbXOwPaLdAuroDFbuGE3FBTRT38wI6+tPjlFp2jXls+B7/KpQCARqEMMr8JhHRj5oLD1IDrW64TqFVCmfOXn4W3vS89gd8LAoTgbYXrTWewvCOUHIZ56vFWvoDkQYZr1AlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955979; c=relaxed/simple;
	bh=L0epqGXxk7Y1goLxRCUaOh13/IhVDFxLBC49Fb1LUg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qSbcs1Vw0JjvkfFCn3dKp2OA8H6GJUgp3TcBnTOWQwMxlURpII3/bd3I8gYZgK1FRHQ2iDQoxoq4M/fDPsRt8eUZFjHPRln8+Es4FWyDI7rQTG+0ziJc4ZtVJAN+Lvyir5BP7nakynLw1VYi1xBDObhb3Djkx+SJ5GtA9rPGvs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=j1VFol8S; arc=none smtp.client-ip=178.154.239.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net [IPv6:2a02:6b8:c27:19c8:0:640:13a7:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id C9C04608F6;
	Wed, 24 Apr 2024 13:52:52 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id oqIZBt9V0a60-pBN4Yn02;
	Wed, 24 Apr 2024 13:52:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1713955971; bh=L9K7NSg4GSdlDGrx4jZlc4qr0J7nDmsYr3JBthzxWlc=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=j1VFol8SgrdZ702ku4CutZHzj+ey3OaBvfEyCtO0/69Oo4eJOBDc8Qii4R20GMYnU
	 b1eHYmh0jfvW4YtmStLnGGbeLKqtkG9aVICNifMAaWkJkOecqGpbrNJE4mj6824LM6
	 K8MAaNc69RNR4u+17LdGD+xtIWNoibiPR+O5yz3w=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
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
Subject: [PATCH v4 0/2] implement OA2_INHERIT_CRED flag for openat2()
Date: Wed, 24 Apr 2024 13:52:46 +0300
Message-ID: <20240424105248.189032-1-stsp2@yandex.ru>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch-set implements the OA2_INHERIT_CRED flag for openat2() syscall.
It is needed to perform an open operation with the creds that were in
effect when the dir_fd was opened. This allows the process to pre-open
some dirs and switch eUID (and other UIDs/GIDs) to the less-privileged
user, while still retaining the possibility to open/create files within
the pre-opened directory set.

The sand-boxing is security-oriented: symlinks leading outside of a
sand-box are rejected. /proc magic links are rejected.
The more detailed description (including security considerations)
is available in the log messages of individual patches.

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



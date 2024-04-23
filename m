Return-Path: <linux-fsdevel+bounces-17558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E788AFC2F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 00:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82021F23D34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 22:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65462E633;
	Tue, 23 Apr 2024 22:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="nV/7DAky"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward201b.mail.yandex.net (forward201b.mail.yandex.net [178.154.239.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9373037171;
	Tue, 23 Apr 2024 22:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713912475; cv=none; b=HfnmoqPtEH/tTuSEYmyz92CfrgVAJyZpGZ4CwPnMWRMeVZZ7TZAsqqkz3TY2sC28sD4ISmS+uuPVqslw+GIIds/PNb3gP+QlXD22w6tQBx5aNbAl2lZ/bZVnb0SEFSGk0mrRb1i9pD/KZgX3sTohswr23QCcB5quqH48cK0CiOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713912475; c=relaxed/simple;
	bh=kGO8taly3zjYFLJkCPrWOp2pJAZjOIXOxrX3rQi33GI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ba+otHCpY1zi7O0BoaZcbcv9MCQ4xqlty8jRwmz+nhAIQENaKbs4LOAChS9U2BEhkruA1wkew5I5L4BiLisbf+9LdwCd0HAUV0QUUDFZq/RN46JosGDE1yt9+3lUd/CUJXofhbxu2snFzgReh251m30mrwK5Adif5MI3wYLA4Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=nV/7DAky; arc=none smtp.client-ip=178.154.239.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102c.mail.yandex.net (forward102c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d102])
	by forward201b.mail.yandex.net (Yandex) with ESMTPS id 375686735E;
	Wed, 24 Apr 2024 01:47:50 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3624:0:640:caf8:0])
	by forward102c.mail.yandex.net (Yandex) with ESMTPS id 6FDB86003C;
	Wed, 24 Apr 2024 01:47:41 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id dlTUXjFh6mI0-nkyakC7O;
	Wed, 24 Apr 2024 01:47:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1713912460; bh=cacnpBEsGFJi0JFbY7VQqOugKerOzw77/aAnDNnT0yk=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=nV/7DAkyNizRFyyXlCjwZVzVaf2NdYbBFqhl9r6VL4hNCHCv1LFM4CcKgGMwSz3z5
	 mfo217WNDAsAdklkuN8o5sC/jlr94agFvSIZM+89/XuSs+B3CzFTiLLitnFdZ9DAvo
	 IKKiiNhiDLC9BIHbdLjgzW7kizNbg04iATZYNFEE=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
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
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v3 0/2] implement OA2_INHERIT_CRED flag for openat2()
Date: Wed, 24 Apr 2024 01:46:13 +0300
Message-ID: <20240423224615.298045-1-stsp2@yandex.ru>
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

The more detailed description (including security considerations)
is available in the log messages of individual patches.

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
CC: linux-fsdevel@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-api@vger.kernel.org
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Christian Göttsche <cgzones@googlemail.com>

-- 
2.44.0



Return-Path: <linux-fsdevel+bounces-17493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E688AE327
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 12:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9175B28B96B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 10:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5561D63099;
	Tue, 23 Apr 2024 10:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="T4yzQXio"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward201b.mail.yandex.net (forward201b.mail.yandex.net [178.154.239.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145AD60B9C;
	Tue, 23 Apr 2024 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713869707; cv=none; b=L/Vgrs2u8QBqMRNbSfX7EgagmL/LgEJ13l7Ao+jK+xhGF6rs8HhyMQsdMMbtSSGhHEPOOzlQe3txU+zYe54NEl9hZIqGgSlLIZBG4KQSFaHnPFhAQ7s7HE7Hsyb0HDizuJeIlcFD+h5djNtZDkkc2NG7VDbU7r0ENbz5o0RcSWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713869707; c=relaxed/simple;
	bh=kpU+YvKsOPGG4l8EOerUYySk9apiWG5KGfFDI79DrpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ockvQMesRvjr6VtLRdF0nnaCptMP6+TqeUSwA4qsQuXTNe6PmG+WQPLk0UHQmRfEIT9kvf6ZsP+9viPtLji1Vpot0t2L7p2TIiuBNPZY7sdd9khvc+M3P7oZTnNnWZpxeRvGKqbZ1IE44DM/xcz6CWjRJQeLB9v0se8WxzECvuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=T4yzQXio; arc=none smtp.client-ip=178.154.239.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
	by forward201b.mail.yandex.net (Yandex) with ESMTPS id E187B64BF5;
	Tue, 23 Apr 2024 13:49:39 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:b1a0:0:640:e983:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id 9CD7B60AD7;
	Tue, 23 Apr 2024 13:49:31 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id TnHoiCGOm4Y0-ubiPgIUO;
	Tue, 23 Apr 2024 13:49:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1713869370; bh=rcVAqztPFXwxu1IVvlYKhQ3ApGxSCP39aIlJfSgJu/g=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=T4yzQXio8HLOtjYRtsiEmElOXSaMHqlXCxvZbHdLDSbLMBuEaXvznLM7Vdf/1aweh
	 IUYyflegoE4dmPV09i9jfk2lnVLH9iFaYx+eQowRfDpTWuO0YfA2r14688gIqnuLeR
	 BVFSKDQcK24iiqMVCgVXay0GZ7NOVtIK58J7tzSM=
Authentication-Results: mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
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
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 0/2] implement OA2_INHERIT_CRED flag for openat2()
Date: Tue, 23 Apr 2024 13:48:22 +0300
Message-ID: <20240423104824.10464-1-stsp2@yandex.ru>
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
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Christian Göttsche <cgzones@googlemail.com>

Stas Sergeev (2):
  fs: reorganize path_openat()
  openat2: add OA2_INHERIT_CRED flag

 fs/internal.h                |  2 +-
 fs/namei.c                   | 52 +++++++++++++++++++++++++++++-------
 fs/open.c                    |  2 +-
 include/linux/fcntl.h        |  2 ++
 include/uapi/linux/openat2.h |  3 +++
 5 files changed, 50 insertions(+), 11 deletions(-)

-- 
2.44.0



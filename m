Return-Path: <linux-fsdevel+bounces-17495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3808AE33F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 13:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311341F22019
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 11:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA52745E2;
	Tue, 23 Apr 2024 11:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="lnoPPGqT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E9C18645;
	Tue, 23 Apr 2024 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870131; cv=none; b=JpiKVjh479nt6GRcCO782nqcztw7TKirR89EbQghY4+Tk0T/HuQlzzFEqDOxdWyD1cm5hzchQpS5kn9upEVYFwbywhohmqcnXOhAXNb8ptBp6cjVCyyxVkf2VW+eXcsgGetXEQjYQa/Kxr3kVYgdHFzaG2P+qzyeol/SP4wCZ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870131; c=relaxed/simple;
	bh=dWMYgl5bt4WqkIJy1ceIMBjSNQzKYDGhm53JaH26Lws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q0tVPVnLSPbu/iIq7zzui8olOIDYb4KLo9MCJYnfoO2RK7gG+4FwzVaaAsHuA9NzlowEt1+hTyjMSudWdXtzd2WjqIX3/Ydio9GyZWQTWZ3al8ah8vcyoBMNKuPi3dPzq3DHuYUV/8vqassmKOAn8u7d/NfKh1QVNIeAoSNvSa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=lnoPPGqT; arc=none smtp.client-ip=178.154.239.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:141d:0:640:ccff:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id 23DA460AD4;
	Tue, 23 Apr 2024 14:02:04 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 22IG0mHOiCg0-x3jtm1mn;
	Tue, 23 Apr 2024 14:02:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1713870123; bh=mSa2L/gvUjyMbfUcKWg0w7NoP0HQhg8yvcY14pMGA/8=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=lnoPPGqTNrRLb/QaMW3ZXdTjL9CHUkEAZqN5K8MjQZkq8CkDQci7BZBDjGfSkLX2N
	 WB4K+9iUPAkWoCjL21dJE7VijI8eCjyEY7j+Uh1DYvTtRg4xYkfKu/q78+38Do58Ax
	 wA/dAuewPoYrdOAPadoxdhBwaB6ed0eheRNM/Z+M=
Authentication-Results: mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
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
Subject: [PATCH v2 0/2] implement OA2_INHERIT_CRED flag for openat2()
Date: Tue, 23 Apr 2024 14:01:46 +0300
Message-ID: <20240423110148.13114-1-stsp2@yandex.ru>
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
CC: linux-api@vger.kernel.org
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



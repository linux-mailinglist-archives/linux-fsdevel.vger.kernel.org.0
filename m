Return-Path: <linux-fsdevel+bounces-77365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HV6NVxslGmqDgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 14:25:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A4714C8D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 14:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F0CB3036EFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 13:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2B236AB77;
	Tue, 17 Feb 2026 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHj9NiLe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EBE36AB64
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771334730; cv=none; b=qtUiahb3IGIzivXvgzp5hlpBtvrOdOMmbIw+kol7CCl4EHMLenaF9mkLDSjdTCTK+vjKNt7pPNMdIOF5hOGUL5EGBuMzM7ZjQCc89I03KMSk2jm77/FOHHjgG1LgRCDVrHP0FxuaFLa7BmJelX4DTPIiUvMaglEX8ktuFZp5ycs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771334730; c=relaxed/simple;
	bh=y3A+hPugdQy/aMZ17xCeJhJKVKDBVbOjH8vc5PGYIwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EUsips7bW9jt7MDGMSVIgX7hr/cXVuIkvPML1N3MtIGuQkj58dfsHE+OfF0hrKWYG8zgY8qxKgoRJr20Y+NJF6C0zMAKMfrys4u2FvMequ94z3YGJc9Jh0e2VPbwxta7RQeCznDCQIHbil7qGeyq3upyLb28kWZ5DN8TWuq5f20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHj9NiLe; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-480706554beso41190275e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 05:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771334726; x=1771939526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+YJwnWVkIxYK1DSRWlkzfvTcjMJVZh4C48PXVKLFwOE=;
        b=iHj9NiLeEcpiqtKj0vpIUVWYDd97vCLmMs0cFgmwQiTae/7coIcYUJZnMQZ7nsF0Hm
         kYhxOdr2h2RO2i5pFlKLrkr73Otyq8Yh3hJgvbraPXrE4hML8kI60CB7l1SOMMQoTmll
         VdHNQI4BUbVequhKOT82PA5gzK3X1npjJNaX6SnhfxUFBMDuyCMmr2qEDssuMauvCPfK
         cdfn2b3XIA2cSpClxDeuP+CvjsxEaUonPTmFt0MSAPGfEhU+o+T5UfhnbiZTmpklSsVx
         MaJEqSxp4xMpDEc2yNqtKTgvK9ShwlFbGyoAFMZPIgOUKg11M6xFCURXhZJ/6L/nzRqZ
         1EiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771334726; x=1771939526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YJwnWVkIxYK1DSRWlkzfvTcjMJVZh4C48PXVKLFwOE=;
        b=JgAY4de2fTvJ0maaVVVszsdMtL0txygxFZeHFfAAW+N3Ffi20NuBRvwAckiWpmJrGy
         9JIoJccpyaf/516Vrdm5BLFz7UYKnqm0UhvClEfbBqq/n5CF2r9Bvq/vmlSa6Yl8u8vc
         +EDEwwD57bF+bAhDGLwbBPaXa36LF6TBoYQ6Q/8ctIHrM9W1deGBg2EXnefTIhqSddbv
         6lQ7ZidyCwXT3z8uEzUOs8NQeiIw2hxZDts4+O8/9GtCTx8CCJkW5BqQJK4jDnW6JWAx
         371fxN8ONcDZyVSuAOcC+j8EV8JGMjbfQ7XMAXHTDSEXLJBjxTmjRECRhuSYT/yv5Ubi
         uMyw==
X-Forwarded-Encrypted: i=1; AJvYcCXn3QDml5bvV9rbuXNf+bDBHUWi0peSsho3cR4c25cjBt/2v0PsgpnmodIhiHdiWnD4HScbZweiQXRTf8WQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz31kWawm8t0GnliWG1c3W0CRrVSCrPwJmCcNXC198n8FlxhDi
	f18U86DAhea1n49kMpgVMLiJAlnc3dFm80MMaqiTZ8aiZqhqoalflrML
X-Gm-Gg: AZuq6aImAM2Ja73QAvXLNqSPRsTJX0FD8CquoCER5V33t6/EMAQR2SMoQaKXe6p7UKQ
	U6ayOSCe78tRPh8jTffwY/g9t2WYLSdOj7YXD2Fh/zX2wCQUlOH1l9DpaILRnT0isgYIpqTBh9u
	Cgd8z9pa2LF83WdE8B48kWAljA6VyLG9MkF8q5QINaNt1RH/Lbkm6vWQ+53xHLMfjfVLyLbUSh3
	YVXWcoWv2365Wyaj184aOtJR+7Czq8zcCQMYe9ubkvkbyRrgusSO/sf+iWwlf6Cxie+VtG1tXsS
	y04pOMEAIXLEO79tiz3F0FssoLGlKQyqfy65PhppaWnCSoy3akCDd5uiQ9goCliE4+ky6vS+SIT
	cIdljk3WmYnHYhcF0SM6GxyBB0VylPA8wCj3n6Mxhmgr2ijxFmlI2qS5Xk7gnsl0aosSCqxBT+d
	pqZeyl8LlUNnx0cK5nyd1CGTuEmu24/R8PWzWCbTPEjn7FLI40MGFe2MQ=
X-Received: by 2002:a05:600c:83c6:b0:477:639d:bca2 with SMTP id 5b1f17b1804b1-48379b93357mr158975845e9.4.1771334726065;
        Tue, 17 Feb 2026 05:25:26 -0800 (PST)
Received: from localhost (109-186-143-15.bb.netvision.net.il. [109.186.143.15])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4837b68e5adsm319859315e9.9.2026.02.17.05.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 05:25:25 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs updates for 7.0
Date: Tue, 17 Feb 2026 15:25:24 +0200
Message-ID: <20260217132524.681374-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
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
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-77365-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59A4714C8D9
X-Rspamd-Action: no action

Hi Linus,

Please pull overlayfs updates for 7.0 with a single functional
change.

This branch has been sitting in linux-next for a while and
it has gone through the usual overlayfs test routines.

The branch merges cleanly with master branch of the moment.

Thanks,
Amir.

----------------------------------------------------------------
The following changes since commit fcb70a56f4d81450114034b2c61f48ce7444a0e2:

  Merge tag 'vfs-6.19-rc8.fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs (2026-01-26 09:30:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-update-7.0

for you to fetch changes up to 869056dbbd636f8f256b695f39c102eb3ce2edd0:

  ovl: relax requirement for uuid=off,index=on (2026-02-06 13:48:23 +0100)

----------------------------------------------------------------
overlayfs updates for 7.0:

  The semantics of uuid=off were relaxed to cater a use case of overlayfs
  lower layers on btrfs clones, whose UUID are ephemeral and an upper layer
  on a different filesystem.

----------------------------------------------------------------
Amir Goldstein (1):
      ovl: relax requirement for uuid=off,index=on

 Documentation/filesystems/overlayfs.rst |  6 +++---
 fs/overlayfs/namei.c                    | 21 +++++++++++++--------
 fs/overlayfs/overlayfs.h                |  2 ++
 fs/overlayfs/super.c                    | 15 ++++++---------
 4 files changed, 24 insertions(+), 20 deletions(-)


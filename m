Return-Path: <linux-fsdevel+bounces-78950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAJ6Jf/YpWmuHQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 19:37:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA6C1DE6E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 19:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12F6C30210FF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 18:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DF6340282;
	Mon,  2 Mar 2026 18:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBsw8GxX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F1733B951
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 18:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772476665; cv=none; b=OCIcWxq4woV/pNWEg6uVur76CIFB+TLDep2VraumrtdZu4NlE5dp3W5sAyWseBm0tCcMGEG4jWu26k+EOo8HnlWUHvEGfnmFu+mvvmDTkaFMh18yje1jnmQvFvkgY634x/ixKBNIJT5xgeDK4u33+dZnwtd8jQLC+axGylA40bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772476665; c=relaxed/simple;
	bh=TTUvc1mWVYgW+kwq1PikmwiCXLizG3upacpm/97f6Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JYnpTQrWJqQWybB/rLTI6SOdrObF9DnOHL71NBclN5koT99P2TtOssTr6Cfg3BUZUdwTuxVgTpx2Y+5NchUDhBspV3d/y697ZU1Z3/pBANrU0+2GtbOcCij+yQCZFBz8oV2jVhkS+mWya5qPLNEA0C6uzCSvQKBEuVVDK8QUmmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBsw8GxX; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8f9568e074so876281766b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 10:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772476663; x=1773081463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eeo1R+v6Bv2MwXmFAWju127SK93P7acP3plyrDB2rlM=;
        b=hBsw8GxXUsrcwRnWhvXJcpgxBpiOrUX/tnIIaJK9sSsUka9XGneJOo/YXFiVGRAZi/
         qZJQEP2ESDXAX1C13PXl8ww5lv7AJ0vqxIkoAg/V1fjA73GtiuKzprOeQnE695wn55Ux
         ShJOoZ9hipoV1US98PaPMRlLHAAAPjv5rUeZ60XN+czsfezKfYZ2DQ8xz/p4rTen0mTd
         leqcjyvstbaUYTrsf+VfrPRxAfqXbK+tuOfTzMElRVhTkQ/XHeGXmA8kFI4cbDJ0W7YO
         bwx1fREGbF91r4RKaR9yxB2QwRubd+7YkKdQMYj6/ZlvwStmcVEgWiky5bV1sjEpT4d6
         zlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772476663; x=1773081463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeo1R+v6Bv2MwXmFAWju127SK93P7acP3plyrDB2rlM=;
        b=wHaR6kpg1CiNrOBzThbNzgQR0EfOJZhPA1usFg5EqsG/uxi3MagicD77FlVHdGYZXc
         TGl3D/LXlQA7llKLyNdxwnna6e8oloYKf6dh78DonGY/iYJHaT92fjqmp9AJbRWrZ6m1
         f3aKVrs0mqiJfntrmPpSZrvrl4hv/XXr7CDaBUhISIMQut1q522GMyyO1ccgY6NDhQls
         xNSPGS4estl6A+U9MgaOaWO7Cu/zjIxdumPRY5lCE6GBQp2PAAZ9XtwNQ+0R6DL0/Afo
         JhNhq0XywiJ9U11IXHBl4RAzeiPbY0Jn8kKfIH0CwuCNuTUy2NXKZlB2JJq40S9zRw4S
         nG4g==
X-Forwarded-Encrypted: i=1; AJvYcCVDwh8TxTactEjamS/Fv0EkP8glLWwF7DZcTvs18ikDLn0vj+cVNAFtlEZXh+iCI+1S3OFhrpzAAOJODGFr@vger.kernel.org
X-Gm-Message-State: AOJu0YwxeMElSkpWKG4b+7H6FL72Qt+6OaCj/LYPitgfGMdCESxGeHek
	57YWKRJA3gHGeTOABWok1plbO/iqEaUm4l3sMkdAldfdv8AqGwEH3QUaIi6uzvbc
X-Gm-Gg: ATEYQzywh6ejt1m2v5h7mQSMNhgyhMz/u1LcYW058EzYdthaRM0mXzLgk3hBaNdMeSP
	SguiojlOUZslmR1riKsfLNT44cjcf627CJ/p97O23Db0YNrVzlUvEfMpgGNnuB8MheiuwXF3Gl9
	1FmlgqjYRK9cdO72lOJzab5K3BWgBxx2u7VkptFCgf4+BPp050QcfQnar/PcJknVqnDPWIME0tx
	FekrLaeTuzcxfTofX6oE4dYhpIollJ/jFCKd6GQVBW2o9SjGPP6Cyb9Uh0HuN6mNoLBxrzG/vpp
	TOFFNTimH7ZC72002Jm4mxdMTHfZZXiTsdCNsa0S0XgsUebQDNekYA+s3R7+OuPGBClB59MvxbZ
	HY9U+zOTmAJrPgCcxjVz/GfDrNkLKUEPeCN3naoSQLc0fD9MC2L+jSe5efwogMGLSHSm6qqJyJQ
	aIE/jGMurJbZDZ9j2TqG4iUfHukwJDy13OpJcZ6iF90G3js1mxo65WHAX3zAJtrAz798VxZi36D
	YBksxXxqgYMiOHV4+kxLbftfAk=
X-Received: by 2002:a17:907:26c9:b0:b87:701d:341a with SMTP id a640c23a62f3a-b93763d9f58mr885224966b.25.1772476662456;
        Mon, 02 Mar 2026 10:37:42 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-11a2-6710-0774-33c0.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:11a2:6710:774:33c0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ab1552csm492373566b.13.2026.03.02.10.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 10:37:41 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] fsnotify hooks consolidation
Date: Mon,  2 Mar 2026 19:37:39 +0100
Message-ID: <20260302183741.1308767-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1AA6C1DE6E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-78950-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Jan,

I've found this opportunity to reduce the amount of sprinkled
fsnotify hooks.

There are still a few fsnotify hooks sprinkled in some pseudo fs,
but all those removed by this series are obvious boiler plate code
and for most of these fs, this removes all of the custom hooks.

I could send a series to convert each fs with its own patch,
but to me that seems a bit unnecessary.

WDYT?
Amir.

Amir Goldstein (2):
  fsnotify: make fsnotify_create() agnostic to file/dir
  fs: use simple_end_creating helper to consolidate fsnotify hooks

 drivers/android/binder/rust_binderfs.c | 11 +++--------
 drivers/android/binderfs.c             | 10 +++-------
 fs/debugfs/inode.c                     |  5 +----
 fs/libfs.c                             | 14 ++++++++++++++
 fs/nfsd/nfsctl.c                       | 11 +++--------
 fs/tracefs/event_inode.c               |  2 --
 fs/tracefs/inode.c                     |  5 +----
 include/linux/fs.h                     |  1 +
 include/linux/fsnotify.h               |  8 +++++++-
 net/sunrpc/rpc_pipe.c                  | 10 +++-------
 10 files changed, 36 insertions(+), 41 deletions(-)

-- 
2.53.0



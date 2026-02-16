Return-Path: <linux-fsdevel+bounces-77315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YYdUOHBmk2mE4QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 19:48:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE92147124
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 19:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FA2A301F17F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 18:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD22A2DAFD7;
	Mon, 16 Feb 2026 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="YBNXluAt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC8118A6CF
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 18:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771267694; cv=none; b=oYojCPS0lrWO7wdRuHd3NQq0C3z6HaTgL1i426czwSwryBao+mdg1vlP3H7u9Sqxr6ZWPt8vb74p5PIPyGycY5RrVeQvnno+gyOrR0L+FhoQJL3Mw+0RCuNTSeKiBu0CUoyQUcmlv5ZpKuSBTn3itW8SQX1E2lVVZZ8B4usOiFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771267694; c=relaxed/simple;
	bh=R9XIUq+16s3/HVcu+HRUUpSONjGH4Rt0wYtbsZSX3VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MovQK6L/grgPHbuvt4JBs0yyAFSv7paOuW5yKIgJ1638RRkJ2/amh1EgmvAvuhKys8op4CZ1rsmQ8kBfzHrhZ6Yt1OlBsA1GAQ5ED4PM03eiQJ0XHAsJsSsNRZo1FM351iSBoawAenf4T7HfQJ1KvMLZRjTg6NIzkKaZEiki4N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=YBNXluAt; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cb420f7500so346089885a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 10:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1771267692; x=1771872492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uOZahYaMxzCkxJXKQxovGMQB/KdJvq85hhaguWuE60s=;
        b=YBNXluAtA2p9mfYx4lEcFrhiJkF00+M5ROZP1UaZY71dsf68uuOQ6MVYfU8j0hq/np
         FI2udMCHVYGcLlI2PpfDbdartSQwUXacL7C0GqhNjVfPzXcoTIUlQWIQ0f/7Jug/aQTc
         5jj22ThlZ92NWzggejEvdg/1PRs1k675xoQFtP/yAtZDHa8WzxT4NzaY87XDbJ2FCiEP
         hXfoIQgK6EHK0Pb+mpsa7GyzC1vHFNXTLP4biJf6kTo9umio5oTlTR26Btb+aYb+Ozu5
         fD805PLCxYZlKqxUCaEJPaDWhc99HMvcBcbS54DjkGs3LUSl6zs3aQjUMNIHXjRefbIF
         wC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771267692; x=1771872492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOZahYaMxzCkxJXKQxovGMQB/KdJvq85hhaguWuE60s=;
        b=qOla+xkl5P39Dz/rBPyCWqv2xvZgPOCYJM+H/G8DzRaEW8N8w1P5ltZrY9sUO/04wf
         D+6pMHAoa+YwvAM7Jlvn/4cnVXdR9gmcat+l9SRCufzGCBhJI3MIGKsFdx6eD1ixgts1
         zl5VqoCYJ5PK9xTgo54I23xQGPfLqgbkzgc/S46LbcxJhmpenYSAFmOXEBDsi2k9dN83
         UNkmbYppKvJeuqpWBndHywCuC3iMAV+XcHm/CPs8QWCnGIv2KB/9J/CMDNtJypCJcl2Y
         HKupxd/WMI9DerXMVD1SxfElaGCALHO5rn84LcnhMzO0cvIZPdXpUFwxsNyg0UG1TfPR
         FyLw==
X-Gm-Message-State: AOJu0YwOHmj6g61fSMxpdJZTFhXh/P/wuDtz9RwBTI4ZEAoyt7nSJZIG
	cgRBoA283di2grYFmM+xCf9juqO2HzABKIjT0AuNnejf/VhBWDHvKT0QyTAl5fuyIVk=
X-Gm-Gg: AZuq6aLMC1CWNRoHDd7tMHyusjYHTF1d8MmLu1IZWhMWxBxjdiAPXU6BV3j9hxkw/sH
	Lxx/6NEGEa87jQ/Q6Ft9wYqZm4t7ymQfPyETeITqqPUbni8xuwcmdCLyTj+nNIo2YuMwcRhxlEd
	N/YZCpCsC2dwUqB6jdPAoQo0nK8UiMPETrlBgktTe/euROX/DDoNcYHKlFv87DGoEnNLrvlvcIQ
	cv39P/+olF+7IUx1TJ6kS1QRzaIap4G3lD4wO69DrXMAclMumkxtBv9nOoulSki0TYq2LDp9BUQ
	6IMa4ohXiwuEFBs6ZLNccCxt3B8Gq0cwpx4hpw/tbW2pjh+tgpsL4lf8jx0i2h8cqkEBpSH+lR+
	miHyG+8x7kFLLV1fp4DZdNvlifGLfCJUkSddkyXRXTbhV7iz0BppipGeUTcw3nY4I0/H5D3FEUj
	5HLH2eFlyxzqIYHcgFdrrI8GxA9Fn3NmfgQ5yYiB0Akdy34Eb6QQP8gogHIJcBvny+u36OyO3bz
	hFD
X-Received: by 2002:a05:620a:7016:b0:8c7:d2b:b5ab with SMTP id af79cd13be357-8cb4bfb6b33mr1154937185a.37.1771267692155;
        Mon, 16 Feb 2026 10:48:12 -0800 (PST)
Received: from warpstation.incus (243.69.21.34.bc.googleusercontent.com. [34.21.69.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb3e89dc23sm1027650185a.20.2026.02.16.10.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 10:48:11 -0800 (PST)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: luisbg@kernel.org,
	salah.triki@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH v2 0/2] befs: Add FS_IOC_GETFSLABEL / FS_IOC_SETFSLABEL ioctls
Date: Mon, 16 Feb 2026 13:47:53 -0500
Message-ID: <20260216184755.48549-1-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[zetier.com,quarantine];
	R_DKIM_ALLOW(-0.20)[zetier.com:s=gm];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77315-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethan.ferguson@zetier.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[zetier.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,zetier.com:mid,zetier.com:dkim]
X-Rspamd-Queue-Id: 7DE92147124
X-Rspamd-Action: no action

Hi all, apologies for the email misfire previously. I forgot to add a "v2"
to all of the patch subject lines. This is the corrected email.

Add the ability to read / write to the befs filesystem label through the
FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls.

v2:
Added an include for <linux/compat.h> for x86-32 compat ioctls

Ethan Ferguson (2):
  befs: Add FS_IOC_GETFSLABEL ioctl
  befs: Add FS_IOC_SETFSLABEL ioctl

 fs/befs/befs.h     |   1 +
 fs/befs/linuxvfs.c | 111 +++++++++++++++++++++++++++++++++++++++------
 fs/befs/super.c    |   1 +
 3 files changed, 100 insertions(+), 13 deletions(-)

base-commit: 541c43310e85dbf35368b43b720c6724bc8ad8ec
-- 
2.43.0



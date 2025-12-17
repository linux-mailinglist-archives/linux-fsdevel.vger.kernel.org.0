Return-Path: <linux-fsdevel+bounces-71531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C526CC67A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 09:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03FD33058A63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 08:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C21D338596;
	Wed, 17 Dec 2025 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/H8yZfm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5460288D6;
	Wed, 17 Dec 2025 08:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765958738; cv=none; b=MWeE12gnKkvlOi7nKZv+QUMfycOmTQmEb9j24mxEwh1K+OqSrE+F3sqpU5L2eYPXhPvHc0R3aUWZXgBfA+pF4i9WJnNoeZssep9BCeFXxBtzaixfBuB7FlDS7DFQXuFrUh48qDb5s7wEVFQC15PZgTkFIv5Ea0lv3R1xF7vi1No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765958738; c=relaxed/simple;
	bh=grgbd7Roh/N0T9UiQSsIvroaXuc9Ova9XMV/cH1yCQQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DvHqHIsPfZZOZ/uwaU3jQV+LSLZkSh9XSyZ70HdC18TQ1/O/yAwbZzienSjLje4mkzyXH5rMNLGhpxHzMTGCGm2LYaQDoce6R0bG0dvBxyBWH5PCXS3aIs4QDudp2L+wUJZBo/fEub3JPn3kUj0oI/30iFRYjPKBF4H+mO+YDBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/H8yZfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DC68C4CEF5;
	Wed, 17 Dec 2025 08:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765958737;
	bh=grgbd7Roh/N0T9UiQSsIvroaXuc9Ova9XMV/cH1yCQQ=;
	h=From:Subject:Date:To:Cc:From;
	b=K/H8yZfmDOJD3QKRwVewmNV5JEuNnzrpj4lFH+VojlYYiKfeYWoA6Sl3NFyQHTFd0
	 f2FsPouIqv6TgNwWbqEuul1RAL8UZCSrIvqnV77FDN/Yf0CJGvjY/4JDJtiT6GqK8U
	 Auz1MGgmvjZ19U9jXVgcG4i4/KrpPMAxSd06IjR+rTIMElfffpMRBJy8lgTP5uR29M
	 UbuIYOFdmnkHvoNeYt7cg/Dn6zDOA8beY7D28VYAo9byuueFrdNOwF1qlQcPcybz7u
	 lx7FphLCx7Chv0DzBidrj/hlhFbR/6zIpXMYky4ABTU1+pPfbVsYnnfQueXwiyKOhe
	 e9Gv7Bf9kH83w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B253D637A5;
	Wed, 17 Dec 2025 08:05:37 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Subject: [PATCH 0/7] sysctl: Replace the converter macros with functions
Date: Wed, 17 Dec 2025 09:04:38 +0100
Message-Id: <20251217-jag-no-macro-conv-v1-0-6e4252687915@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABZkQmkC/x3MQQqAIBBA0avErBtIQ6muEi1knGyCNBQiiO6et
 HyL/x8onIULTM0DmS8pkmKFahugzcXAKL4adKeN0sri7gLGhIejnJBSvLB3xrAdicgPULsz8yr
 3/5yX9/0A1qOb+WMAAAA=
X-Change-ID: 20251216-jag-no-macro-conv-3a55e69cccd8
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1787;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=grgbd7Roh/N0T9UiQSsIvroaXuc9Ova9XMV/cH1yCQQ=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGlCZDUV3DIaQ0HKM5Fzs252AlZ+Ze2h/ZP9D
 qZsX8b4ZzxMUokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJpQmQ1AAoJELqXzVK3
 lkFPkGYL/jyQWWbgPXVTr+kyOhXzgSI6vRsLEMatWZxSHaVps5SqjIE+XgVyQz2GWGV9CfJqtJt
 QKwBff1YPXc6hZjJR6k0LOsbZl5AeVZwAsnB/ssYZHFJ6DR/isBuZejx5cmYQdpoNmKdRk2ipwr
 oRxJi/PnbcRPtV9+sutvKXEI3kpRJNwinrMjQvW9SOKwPKzBRVbKO2a4dSQDDcDXjWL0b2iemej
 XsvhrlIgP/wfDho02lor1xZm0tmr4GbG03oVQyWzBdWL+o/uGED6L3Dv3EG9lF/ZP+ff5NUJMdZ
 n0balmLvlIxEQkKfRbvxlttR6zTn1oMmtQq0iqVeoszqMqcjoqV7e+FLWPyElhaNUsbtJnspK3i
 nH9mvGIQImeZl25UxT7GwVOn1/geEVIBzXen76o22O4ZfIrVZIDwUMsP31WYWyRnDvH7wG5lr5P
 YM8j88wCxyMlUOwv6z3xf+03k7x/+WJ88MP9mKoKWe6jYDrEyDV8Y+scaFFCKAfHl/Ja8+TRXB5
 KU=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Remove all the macros that were created to get jiffies out of sysctl.c.
In [1] we leaned a bit too hard on macros to generate the converter
functions needed in jiffies.c, pipe.c and sysctl.c. In this series we
replace the macros with regular functions to help in debugging and to
better align with coding-style.rst. This series has been tested with
sysctl self tests (x86_64) and with 0-day.

A note about checkpatch: It really dislikes the use of -ENOSYS and
unused arguments in the no-op versions of the functions. These are all
false positives IMO as -ENOSYS should be returned to the syscall that is
reading or writing the proc file.

Comments are greatly appreciated

Best

[1] https://lore.kernel.org/all/tqz52ig2b5jas3qqt6jqqek7uwyg64ny5qnwy6gclhgjcy4ltb@s7jiay5vyomg/

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
Joel Granados (7):
      sysctl: Return -ENOSYS from proc_douintvec_conv when CONFIG_PROC_SYSCTL=n
      sysctl: clarify proc_douintvec_minmax doc
      sysctl: Add CONFIG_PROC_SYSCTL guards for converter macros
      sysctl: Replace UINT converter macros with functions
      sysctl: Add kernel doc to proc_douintvec_conv
      sysctl: Replace unidirectional INT converter macros with functions
      sysctl: replace SYSCTL_INT_CONV_CUSTOM macro with functions

 fs/pipe.c              |  22 +++-
 include/linux/sysctl.h | 120 +++-------------------
 kernel/sysctl.c        | 274 +++++++++++++++++++++++++++++++++++++++++++++----
 kernel/time/jiffies.c  | 134 ++++++++++++++++++++----
 4 files changed, 403 insertions(+), 147 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251216-jag-no-macro-conv-3a55e69cccd8

Best regards,
-- 
Joel Granados <joel.granados@kernel.org>




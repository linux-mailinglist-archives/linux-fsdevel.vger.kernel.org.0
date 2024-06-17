Return-Path: <linux-fsdevel+bounces-21855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C1290BFDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 01:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FA01282579
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 23:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858B3199EAD;
	Mon, 17 Jun 2024 23:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dAZNhDmI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE34DDA6;
	Mon, 17 Jun 2024 23:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718667704; cv=none; b=ZoEpvHPhW+gW3gMiKJZpBbMItfpgnAtNhTuoCxw9jqQRHQ2iIlh/x4mZeaVbsfcLE+0qtjFX+kdMX6oohfD+yUVRK8M6EISacneSvdm6hqXZIuYbdt/qa0S1FrjaaYUdSfEsBTyumlONuw/1QwGLwsI8kahhv5hsTGjuNNVb2J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718667704; c=relaxed/simple;
	bh=f2R+FOxAGsbyhxd/B3V6jyfBE6bsH+VbB6Fghha9rNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cCxwG2cOZxdUgMi6xNUM76xrvA3J5gObiywLoCluy50DjdcEETnTDtud2yIwp9RFVvkjmafVBgW/z35r7wBUwwaTbO7FLj1ikQtIFwXv72clMkGIS0NVqHm5tttImhtPGmY/6X+fBoebSiW6sXLCPPJYOIntJlRpK9fkckeQmdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dAZNhDmI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from xps-8930.corp.microsoft.com (unknown [131.107.160.48])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0D2F020B7004;
	Mon, 17 Jun 2024 16:41:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0D2F020B7004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1718667702;
	bh=nZB/8MvG+rNCUxJrks2r9bqbVls1mBuRzWaQspLUyk4=;
	h=From:To:Cc:Subject:Date:From;
	b=dAZNhDmIbBYjrTXyn6sgmodSXglG3n1mk8O9BVi2TVfQNq/SJfXQ2trs+5eSHDtPl
	 HNjenNbUDzHU7hl8FGCK449hAlyxpsI14He5qUtw1cQKIu8bX7DK4i12qblGnKozAL
	 9b27g2g0LuPbG3nAD8d2gpf4IPvZljnCnMglNwNc=
From: Roman Kisel <romank@linux.microsoft.com>
To: akpm@linux-foundation.org,
	apais@linux.microsoft.com,
	ardb@kernel.org,
	bigeasy@linutronix.de,
	brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	keescook@chromium.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	nagvijay@microsoft.com,
	oleg@redhat.com,
	tandersen@netflix.com,
	vincent.whitchurch@axis.com,
	viro@zeniv.linux.org.uk
Cc: apais@microsoft.com,
	ssengar@microsoft.com,
	sunilmut@microsoft.com,
	vdso@hexbites.dev
Subject: [PATCH 0/1] binfmt_elf, coredump: Log the reason of the failed core dumps
Date: Mon, 17 Jun 2024 16:41:29 -0700
Message-ID: <20240617234133.1167523-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A powerful way to diagnose crashes is to analyze the core dump produced upon
the failure. Missing or malformed core dump files hinder these investigations.
I'd like to propose changes that add logging as to why the kernel would not
finish writing out the core dump file.

These changes don't attempt to turn the code into a state machine with the numerical
error codes. This is just the next step to not logging which is logging :).

Please let me know what is good, bad and ugly with these changes!

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>

Roman Kisel (1):
  binfmt_elf, coredump: Log the reason of the failed core dumps

 fs/binfmt_elf.c          | 48 +++++++++++++++++++++-------
 fs/coredump.c            | 69 +++++++++++++++++++++++++++++++---------
 include/linux/coredump.h |  4 +--
 kernel/signal.c          |  5 ++-
 4 files changed, 96 insertions(+), 30 deletions(-)


base-commit: 831bcbcead6668ebf20b64fdb27518f1362ace3a
-- 
2.45.2



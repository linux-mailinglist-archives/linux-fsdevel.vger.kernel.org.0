Return-Path: <linux-fsdevel+bounces-39610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A24A1625C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 16:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD1218858AE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 15:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9391DF260;
	Sun, 19 Jan 2025 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="LhAqA1nf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCB363CB;
	Sun, 19 Jan 2025 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737298798; cv=none; b=k5ke0dEeN3TBiM3GoPYljHSDBrw/HB867x/BK13RH3Q0+WApdPY+fVosWOtjNWKm4miYWE9ltTEUJ5qHpGyvkWF4/cGNx3Uo02hgNFmYZScQPd/g1M5lpR5VncRPDXcX6uWlKYrCQKGZ4efHIxs4Uywsn3H8dqrtYkXkqn3/SSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737298798; c=relaxed/simple;
	bh=qA8z1i5/ezT5bVBXkJPF+Ww+BmN67p+YBTX+vhXCIb8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PGC9nUmew5Lwn+H+o5xN5N7QbDlSuruXM5l/WPVPCwbUgfaU2fk8250FhZDZzBSV2zK+F/U5qD43UrvE+vL5wYmdUObE/cRF2P5bzJSZ0z5kwzU4uhbdq0RNXb94L5Yv7Qo7m9WLjNICXZuB+/6GuIX2meZUO1k5tDNIMDLL0vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=LhAqA1nf; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737298795;
	bh=qA8z1i5/ezT5bVBXkJPF+Ww+BmN67p+YBTX+vhXCIb8=;
	h=From:To:Subject:Date:Message-Id:From;
	b=LhAqA1nfd2IhFJ8XXNAki7K4fXkAIL/Ai5OhrIuSnY5wXoncJF0Cp+m78znABb3qE
	 tBF7CbVgIBlRGOiWa30BqOFjdKz6cExrER/5WIJjUGEgvirl7UVVBV3edaVRafBh+k
	 9ay00k4Dm+uWHp3CnGD409MqAtv3r8HgjEjeKQJ8=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5CCFA128651F;
	Sun, 19 Jan 2025 09:59:55 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id tfkDej_KaC4N; Sun, 19 Jan 2025 09:59:55 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 363AA128651D;
	Sun, 19 Jan 2025 09:59:54 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org,
	linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 0/2] efivarfs: fix ability to mimic uncommitted variables
Date: Sun, 19 Jan 2025 09:59:39 -0500
Message-Id: <20250119145941.22094-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of simple_setattr in efivarfs means that anyone who can write
to the variable (which is usually only root) can set the cached inode
size to an arbitrary value (including truncating it to zero).  This
value, while not transmitted on to the underlying variable, does show
up on stat and means that anyone who can write to the variable file
can also make any variable mimic an uncommitted one (a variable with
zero size) which is checked by certain programmes that use EFI
variables, like systemd.  This problem can be fixed by not allowing
anything except a successful variable update to change the inode size.

I also added a regression test to make sure the problem behaviour
isn't reintroduced.

James

---

James Bottomley (2):
  efivarfs: prevent setting of zero size on the inodes in the cache
  selftests/efivarfs: add check for disallowing file truncation

 fs/efivarfs/inode.c                          | 17 +++++++++++++++
 tools/testing/selftests/efivarfs/efivarfs.sh | 23 ++++++++++++++++++++
 2 files changed, 40 insertions(+)

-- 
2.35.3



Return-Path: <linux-fsdevel+bounces-34825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FCF9C8FD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 17:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 145E3B36C31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 16:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD8A18A6AD;
	Thu, 14 Nov 2024 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="IgS52+AN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA8013BADF;
	Thu, 14 Nov 2024 16:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601632; cv=none; b=MNwc0YBuRmwsNK+rp9oWRo3PkgxhgB8ogB/llg57XNmmXblP20SgBLUFDNxPLt0LQz1qtPTj36Bcu6TRocpAiZFdA1QDH4fXHTcrFzaP2JtQ16mZRnPPoZF0jOGQjToaw3H7ayvqqaFJjAnpmLiIDA9Cz6Kr4AbrJzVyJ27uie8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601632; c=relaxed/simple;
	bh=5sM5zg0zpVfi+J3lb+l4bH+4Zb6/G3bsLIPOwXZXFbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mH6WBuRGxEgr+K5QZeSMufc3g9jGqhWDsnkS7NbKdth+HGmCJQWoefDWZLstpLtca8YmXii/CwqnL1qqD4DOYV7cI1sGyLHBdS7tQB1XJ0aQXx+p6twfHRsAsPSkxnyNzbc2anB9aLWkTZeGBs15Zbvebz8eE4F3ZksV71dWgFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=IgS52+AN; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 59FCD1C000F;
	Thu, 14 Nov 2024 16:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1731601622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lMV5K+Nh8hskjAIM4DO+OIpJFCxU0CMsVV1XBncejjE=;
	b=IgS52+AN089cnvKcY1uMF0vzv5ppmPMR6B9K+K8jTGSYTL6mMBkFEBbnQgO6XaQghamd59
	+kxo/WNJ6j5Pz7KSBNxykOw9pddWOKbJvypEiZemW67iZUzpH8j+Rfx/yVWXAU1mowiKkS
	244ZWiZnJ5XL/n5rzVSE/HPwDUJ+l7KDFs96boMSXiStLVtSqq1J+59/XzFnKjw3EfTJRw
	SmGHRWqnopAhlQ/exh7KbgNv6z/BazqZemN+vWCN1wglSKrFYnkzoZtPdB0EvbzMzIf9Zu
	JB4rq+QVD4DrFtcsiHbI73zV8HmNSMldYRXyqIfgroPedkgjOTGggtC2JvElIw==
From: nicolas.bouchinet@clip-os.org
To: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: nicolas.bouchinet@clip-os.org,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <j.granados@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Neil Horman <nhorman@tuxdriver.com>,
	Lin Feng <linf@wangsu.com>,
	"Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH v2 0/3] Fixes multiple sysctl proc_handler usage error
Date: Thu, 14 Nov 2024 17:25:49 +0100
Message-ID: <20241114162638.57392-1-nicolas.bouchinet@clip-os.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: nicolas.bouchinet@clip-os.org

From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>

Second iteration of the patchset to take into account Lin Feng review on
patch 1/3.

No changes for 2/3 and 3/3.

Version 1:
https://lore.kernel.org/all/20241112131357.49582-1-nicolas.bouchinet@clip-os.org/

Nicolas Bouchinet (3):
  coredump: Fixes core_pipe_limit sysctl proc_handler
  sysctl: Fix underflow value setting risk in vm_table
  tty: ldsic: fix tty_ldisc_autoload sysctl's proc_handler

 drivers/tty/tty_io.c | 2 +-
 fs/coredump.c        | 4 +++-
 kernel/sysctl.c      | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.47.0



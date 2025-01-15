Return-Path: <linux-fsdevel+bounces-39292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE955A1249F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 14:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A99188A628
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 13:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF402419F1;
	Wed, 15 Jan 2025 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="ZlzfXryy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09AF23F27F;
	Wed, 15 Jan 2025 13:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736947348; cv=none; b=n+5UAGaKgXEV3ezvnzxvnY/YmFVPVNluqdmGl+LEXtRULh/gV2ycXYEKjgC7kaPt4pxrWMU/KdPvcsPHoHJ1Woz/HIjjO3Tup5Jzmp19Hbpe8WxXZVGGcDGv+PICOVPbtKkWalJGOYmvylrRafDu2DsDoTx4+RS6XSUomxJXBAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736947348; c=relaxed/simple;
	bh=FUQNAiHSVC52GJ8CJwE7e+3ydo/xkZ1P5fJwnc7AL5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Akme3BIEOhH6Gk9qXkp/6yy7JfxxTilY3kvP4sQOdSBMSbui1mM58rC9KZLW2TRynOq88wIb/4O3LR5FaLqQgYdeTZYrbUH3JNdTCTmsCwYyGwnORGo0SrpnOfk/61OA915zWYV9mJ3MG4jpehZLsg4ofL4sDQgOpKgbyw/1pM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=ZlzfXryy; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1F2251C0005;
	Wed, 15 Jan 2025 13:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1736947337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Xyil3Q+9vYZwK/eKmQ7a1Fylg92ySCw0EXCrIO9+Yes=;
	b=ZlzfXryyYnMxhwkZpff8jyOfkVD+xKwS/Uu5bFo4j8SRKkO0DVlXwbEfFTxWibDWRNkUXG
	YRWYtjy6o0zLRxXPIjUxosmzDcvitGEyHdKcah1wRUD7Oj8zqlOGmf+YpaOv8N8onFVL8j
	dCv5QRAklQkM1oe/XTbhMTuyT80maFcJcPkXU4j0sLnqGFq0gIhFjJOLY6ZxQzNPJ6oyFX
	Lr4Rnb8gUBTCuUo+XrRodUVef5VU2BoYcLAK5m4tvdFC5NhqjxfVJDgaPy3Su1Nyrwx3Wl
	jozyR+TcSoYFj7mp8iqWHX5/Pub8ZoxRuyoBvYM7UqxfAtvHqnijrBx4ORHk8g==
From: nicolas.bouchinet@clip-os.org
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
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
Subject: [PATCH v4 0/2]  Fixes multiple sysctl proc_handler usage error
Date: Wed, 15 Jan 2025 14:22:07 +0100
Message-ID: <20250115132211.25400-1-nicolas.bouchinet@clip-os.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: nicolas.bouchinet@clip-os.org

From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>

Hi, while reading sysctl code I encountered two sysctl proc_handler
parameters common errors.

The first one is to declare .data as a different type thant the return of
the used .proc_handler, i.e. using proch_dointvec, thats convert a char
string to signed integers, and storing the result in a .data that is backed
by an unsigned int. User can then write "-1" string, which results in a
different value stored in the .data variable. This can lead to type
conversion errors in branches and thus to potential security issues.

From a quick search using regex and only for proc_dointvec, this seems to
be a pretty common mistake.

The second one is to declare .extra1 or .extra2 values with a .proc_handler
that don't uses them. i.e, declaring .extra1 or .extra2 using proc_dointvec
in order to declare conversion bounds do not work as do_proc_dointvec don't
uses those variables if not explicitly asked.

This patchset corrects three sysctl declaration that are buggy as an
example and is not exhaustive.

Nicolas

---

Changes since v3:
https://lore.kernel.org/all/20241217132908.38096-1-nicolas.bouchinet@clip-os.org/

* Fixed patch 2/2 extra* parameter typo detected by Joel Granados.
* Reworded patch 2/2 as suggested by Joel Granados.


Changes since v2:
https://lore.kernel.org/all/20241114162638.57392-1-nicolas.bouchinet@clip-os.org/

* Bound vdso_enabled to 0 and 1 as suggested by Joel Granados.
* Remove patch 3/3 since Greg Kroah-Hartman merged it.

Changes since v1:
https://lore.kernel.org/all/20241112131357.49582-1-nicolas.bouchinet@clip-os.org/

* Take Lin Feng review into account.

---

Nicolas Bouchinet (2):
  coredump: Fixes core_pipe_limit sysctl proc_handler
  sysctl: Fix underflow value setting risk in vm_table

 arch/sh/kernel/vsyscall/vsyscall.c | 3 ++-
 fs/coredump.c                      | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.48.1



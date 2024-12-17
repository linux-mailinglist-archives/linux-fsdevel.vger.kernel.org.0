Return-Path: <linux-fsdevel+bounces-37630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 911349F4C74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 14:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E4C1897F60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 13:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0361F3D57;
	Tue, 17 Dec 2024 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="CQBVNZH5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD6620311;
	Tue, 17 Dec 2024 13:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734442268; cv=none; b=A7/Oz7QobXevwzk2yCesV7KDeExYdkF1COyWoGYNHbHV1SRYUEAM67e1IEeVmyH8yzKfCkVcFRzaTkm51HzAQd3O06B8m9zs1waVKgCz9JvSpGetdeGHar/AhxmTiAyDKcJUO3ZQGRxVV8OqeO8lzzwGSwNHqF5mBPKHwdDI8lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734442268; c=relaxed/simple;
	bh=B614uid6ySomuNZOD01U+chfK6joROqy0wsx5sPN75I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UhkeXOoF6i+tGef8pUb90z7pASWl7Gcb7bCmFE61ZJyrG5kAQF6ukEeM5bYH4I3l9z96iFYzC4e7tuS8V3Y924oHyPpkTh1o+0hC6bGvrmnG7J5Y8T48Ad/kH1lLtxmFg9nUvSvWi8gUAR7Ht2qCG/bvM0p/H9WkCpH1KdsBEK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=CQBVNZH5; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id E6364C0002;
	Tue, 17 Dec 2024 13:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1734442260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VsCJ2oWyZtMrmVXTJ7VpPyY6o3qZiccUyJI/oEMSJcw=;
	b=CQBVNZH5yvO1L5CenPMzpe6d/M9c1M1H+zizhiNRKcGIXX1PvuP6/WOUfeFuyY89ModFjF
	vb0oFk7Nc5lWRQFs3U/N0BNqqffEtM2efl/K1la80KgdJYHr9IePS/keClXy7kpMxt+k1m
	+OHmD8CEDIgSA2ObyPGLouXoViI/ZXF56QhWkbwzJgeoZ3XaBoX3Yv0cBs/uegOvG2nRKa
	ETs2apzAtY/50pWtS7l5w/owPx1Fm/1OGLbVG1rDl6QskK4miX5+ny1IYOVgZDWtk75zIy
	FGePul25PrtSqfCZLuA9j3sreXDvKzGruo7MSg9EGrpD+ZBtwoFbe86Z/YDT+Q==
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
Subject: [PATCH v3 0/2]  Fixes multiple sysctl proc_handler usage error
Date: Tue, 17 Dec 2024 14:29:05 +0100
Message-ID: <20241217132908.38096-1-nicolas.bouchinet@clip-os.org>
X-Mailer: git-send-email 2.47.1
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

 fs/coredump.c   | 4 +++-
 kernel/sysctl.c | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.47.1



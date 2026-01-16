Return-Path: <linux-fsdevel+bounces-74230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCC8D3859A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 20:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A950302B9A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 19:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A06B3A0B3F;
	Fri, 16 Jan 2026 19:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="YIGHPf9r";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Lt2ATqK6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a8-156.smtp-out.amazonses.com (a8-156.smtp-out.amazonses.com [54.240.8.156])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394EF306B02;
	Fri, 16 Jan 2026 19:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.8.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768590781; cv=none; b=Wrs3Vv5UXXBqb3OMRcsE9i30P1k6EZudRtqGdO//NS5HkFS/bVueqk4Hx6XYgem43TPXjh0zulQONnBaTjUGPE/A2zLTEAVaa0WO9xbNyPYHhqMwujNUhZl01drqyJh/luU/snzFFbVcitozVfYeIUiBKHr88I1eshRFvYZQyXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768590781; c=relaxed/simple;
	bh=m6dad8fYggJLQITgAem24WJlFatXltUXSChSpZ3X6QA=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=pzNroJ6GMbCkZW3yT318yvPnaURosarEpDXNzTPFfpilWaplmqWYPZawpPU29TFicpbGMjt5/TPHiG+2C57NsG9OItPDSiHmafMDb/Sg30dTevITrmmEuOl7TRrDgugOSnkhr9Mq5VOMaZOMrq5n0sjHsB97hem2oTKK/EC5QfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=YIGHPf9r; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=Lt2ATqK6; arc=none smtp.client-ip=54.240.8.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768590779;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=m6dad8fYggJLQITgAem24WJlFatXltUXSChSpZ3X6QA=;
	b=YIGHPf9rCfyTMUIeVl9+4Xwx+aGSdIQ0Qe1vrwRTsqe4oi8T1LedwGJ/5IHuDOxt
	LCagxQoZEzkWG2Li3/85UvSY3CKy+ESRtpvgEZP1GHkKCVcGAwkUn1odGlJEO870JTr
	0sSZmVFgO40JjTlySTLh/+G4gnBUhxeSXuTUyeBg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768590779;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=m6dad8fYggJLQITgAem24WJlFatXltUXSChSpZ3X6QA=;
	b=Lt2ATqK6l8f9SYxnP9ueAK0OP+xWUQQH51yqNUHfUygJecQbQy3dW4W92vVvuXTM
	NRJG4/nFr5xAhZRdHGoa39OnKt2lFj4Z2Z5AirsEUSSy/k3Hv2XPUmGIz0+/x+NhTnM
	oJf1h7130/cSnL6PKKXqCzZzSORXtSIijJMcYM24=
Subject: [PATCH V3 0/2] ndctl: Add daxctl support for the new "famfs" mode of
 devdax
From: =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To: =?UTF-8?Q?John_Groves?= <John@Groves.net>, 
	=?UTF-8?Q?Miklos_Szeredi?= <miklos@szeredi.hu>, 
	=?UTF-8?Q?Dan_Williams?= <dan.j.williams@intel.com>, 
	=?UTF-8?Q?Bernd_Schubert?= <bschubert@ddn.com>, 
	=?UTF-8?Q?Alison_Schofiel?= =?UTF-8?Q?d?= <alison.schofield@intel.com>
Cc: =?UTF-8?Q?John_Groves?= <jgroves@micron.com>, 
	=?UTF-8?Q?John_Groves?= <jgroves@fastmail.com>, 
	=?UTF-8?Q?Jonathan_Corbet?= <corbet@lwn.net>, 
	=?UTF-8?Q?Vishal_Verma?= <vishal.l.verma@intel.com>, 
	=?UTF-8?Q?Dave_Jiang?= <dave.jiang@intel.com>, 
	=?UTF-8?Q?Matthew_Wilcox?= <willy@infradead.org>, 
	=?UTF-8?Q?Jan_Kara?= <jack@suse.cz>, 
	=?UTF-8?Q?Alexander_Viro?= <viro@zeniv.linux.org.uk>, 
	=?UTF-8?Q?David_Hildenbrand?= <david@kernel.org>, 
	=?UTF-8?Q?Christian_Bra?= =?UTF-8?Q?uner?= <brauner@kernel.org>, 
	=?UTF-8?Q?Darrick_J_=2E_Wong?= <djwong@kernel.org>, 
	=?UTF-8?Q?Randy_Dunlap?= <rdunlap@infradead.org>, 
	=?UTF-8?Q?Jeff_Layton?= <jlayton@kernel.org>, 
	=?UTF-8?Q?Amir_Goldstein?= <amir73il@gmail.com>, 
	=?UTF-8?Q?Jonathan_Cameron?= <Jonathan.Cameron@huawei.com>, 
	=?UTF-8?Q?Stefan_Hajnoczi?= <shajnocz@redhat.com>, 
	=?UTF-8?Q?Joanne_Koong?= <joannelkoong@gmail.com>, 
	=?UTF-8?Q?Josef_Bacik?= <josef@toxicpanda.com>, 
	=?UTF-8?Q?Bagas_Sanjaya?= <bagasdotme@gmail.com>, 
	=?UTF-8?Q?James_Morse?= <james.morse@arm.com>, 
	=?UTF-8?Q?Fuad_Tabba?= <tabba@google.com>, 
	=?UTF-8?Q?Sean_Christopherson?= <seanjc@google.com>, 
	=?UTF-8?Q?Shivank_Garg?= <shivankg@amd.com>, 
	=?UTF-8?Q?Ackerley_Tng?= <ackerleytng@google.com>, 
	=?UTF-8?Q?Gregory_Pric?= =?UTF-8?Q?e?= <gourry@gourry.net>, 
	=?UTF-8?Q?Aravind_Ramesh?= <arramesh@micron.com>, 
	=?UTF-8?Q?Ajay_Joshi?= <ajayjoshi@micron.com>, 
	=?UTF-8?Q?venkataravis=40micron=2Ecom?= <venkataravis@micron.com>, 
	=?UTF-8?Q?linux-doc=40vger=2Ekernel=2Eorg?= <linux-doc@vger.kernel.org>, 
	=?UTF-8?Q?linux-kernel=40vger=2Ekernel=2Eorg?= <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?nvdimm=40lists=2Elinux=2Edev?= <nvdimm@lists.linux.dev>, 
	=?UTF-8?Q?linux-cxl=40vger=2Ekernel=2Eorg?= <linux-cxl@vger.kernel.org>, 
	=?UTF-8?Q?linux-fsdevel=40vger=2Ekernel=2Eorg?= <linux-fsdevel@vger.kernel.org>
Date: Fri, 16 Jan 2026 19:12:59 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
In-Reply-To: <20260116125831.953.compound@groves.net>
References: <20260116125831.953.compound@groves.net> 
 <20260116191253.1559-1-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHchxoe1VAe00deR0Sw2d725QhurgAAgGyV
Thread-Topic: [PATCH V3 0/2] ndctl: Add daxctl support for the new "famfs"
 mode of devdax
X-Wm-Sent-Timestamp: 1768590778
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bc839a307-8e2830e2-27de-403d-a938-0d4649b7d55c-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.16-54.240.8.156

From: John Groves <john@groves.net>

No change since V2 - gmail dropped some messages in that bundle.

No change since V1 - reposting as v2 to keep this with the related
kernel (dax and fuse) patches and libfuse patches.

This short series adds support and tests to daxctl for famfs[1]. The
famfs kernel patch series, under the same "compound cover" as this
series, adds a new 'fsdev_dax' driver for devdax. When that driver
is bound (instead of device_dax), the device is in 'famfs' mode rather
than 'devdax' mode.

References

[1] - https://famfs.org


John Groves (2):
  daxctl: Add support for famfs mode
  Add test/daxctl-famfs.sh to test famfs mode transitions:

 daxctl/device.c                | 126 ++++++++++++++--
 daxctl/json.c                  |   6 +-
 daxctl/lib/libdaxctl-private.h |   2 +
 daxctl/lib/libdaxctl.c         |  77 ++++++++++
 daxctl/lib/libdaxctl.sym       |   7 +
 daxctl/libdaxctl.h             |   3 +
 test/daxctl-famfs.sh           | 253 +++++++++++++++++++++++++++++++++
 test/meson.build               |   2 +
 8 files changed, 465 insertions(+), 11 deletions(-)
 create mode 100755 test/daxctl-famfs.sh


base-commit: 4f7a1c63b3305c97013d3c46daa6c0f76feff10d
-- 
2.49.0



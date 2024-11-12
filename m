Return-Path: <linux-fsdevel+bounces-34447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DF69C5A45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 15:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FD7DB32BF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 13:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7DA14F114;
	Tue, 12 Nov 2024 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="e9n8VG5o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FE814387B;
	Tue, 12 Nov 2024 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731417319; cv=none; b=UbO0vMEsoZOtN7QrB/uo3gdUBBk4wg4zdbSPoAnHHZHSaEzguCgGt0PpJSF/5PyenxcK3uvufCGfaNcn7R90gtmV0Fi6gu9kIqEIr4fCBiFt0XKeuAr1iGvqvSCpj/gWWaCoTP5mGEDGjCypwat7YXkK24s6k04Vi4ERoBn8JYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731417319; c=relaxed/simple;
	bh=gx2w3bDrETbsUTrM9BzaaKKf4gNeCmSzjIrCsPufNMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dy6qu9itq317DMVRMdrnD9ROCVoLR8ewX3CeJvSaHLTFdbnt1rEGnhGY5jlXv2aMcVB2GiGvFokp46vqS1YXx4J32rYrYoYXRz21Sv4qsHVhuEIYrJW+ULSr50f/1Mp97hUMR1SOH8sVLkBjt0v4m7HPLNFMxesATUPFt+lqZVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=e9n8VG5o; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6CF0C40007;
	Tue, 12 Nov 2024 13:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1731417308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zffqBsQL1sFkEx1vliZCfC5+XT4irPn76PQB9/6unyI=;
	b=e9n8VG5oA2GdKHSoRtSQQM/KVAmgSIcepY6lS2WxLoQn3HeOzYDvkIzw0zQitAqFu9uJ74
	WrI9WZjSuW4qmQv54Ov3Tcfwgy1hQckCloWhpaL8srukS2XEw1EC8zIbUWHE3/lPwNxsK3
	hKidjOrbEet2yc+hKWsQgcDFjhxef2+M4Q5guunx6Ab/HFr/F3XuTqHUnducE6jqEctx+g
	9wCtWfc8T+IRQ1pcnY3Dk52mRt7w6JmqSkogQpTzmqr9wgeS2QGTSEW5eNbNix/k8DpuwR
	HH5XD/EtTU1WOrWjlIGWqYp3GxgpngngRyREFeCWXYST1IEXxm8L0NAzJm4mzw==
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
	Neil Horman <nhorman@tuxdriver.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lin Feng <linf@wangsu.com>,
	"Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 0/3] Fixes multiple sysctl proc_handler usage error
Date: Tue, 12 Nov 2024 14:13:28 +0100
Message-ID: <20241112131357.49582-1-nicolas.bouchinet@clip-os.org>
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

Nicolas Bouchinet (3):
  coredump: Fixes core_pipe_limit sysctl proc_handler
  sysctl: Fix underflow value setting risk in vm_table
  tty: ldsic: fix tty_ldisc_autoload sysctl's proc_handler

 drivers/tty/tty_io.c | 2 +-
 fs/coredump.c        | 7 +++++--
 kernel/sysctl.c      | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.47.0



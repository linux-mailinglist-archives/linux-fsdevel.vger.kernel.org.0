Return-Path: <linux-fsdevel+bounces-50948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1753FAD160B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 01:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6737D188B56D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 23:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9681267AFD;
	Sun,  8 Jun 2025 23:48:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9354220E6EB;
	Sun,  8 Jun 2025 23:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749426529; cv=none; b=b9M6m+DQ5S3TFx+2cdlCLcJEf07Zw64jIdTbwEOTErNqnz1bsiu9iJKay2j+C9c5JccxpGASwxslsNcUuAitkLSxkDCpXCaGEsgkqETX0iT22RoqTZmJetrORmCZRAkio+TSM02Bpjtp4h9nmpQ/W8OI+lM/a6HPkWy9wLMZRQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749426529; c=relaxed/simple;
	bh=9/DdTCyKYZE+kM6yV5SFSUmqNwarhro5a9t+8xRTfak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sDIf6m5IWjZO0J4Y9HXb/6H19BTXL2aHxai1Gj8GDFk+a6k3i6X7eIlBu/YKe2lOc0VFxbfPigSK4FuuKZbX37mWtBGulDzdFNPmVbs9/9kXzO9a1rFFflO+4UNOJBJYmARnMn3H3IJylUCN6CF8gpItCcxt3RA2J1z3PhUIfGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uOPko-005xqi-CE;
	Sun, 08 Jun 2025 23:48:42 +0000
From: NeilBrown <neil@brown.name>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] smb/server: various clean-ups
Date: Mon,  9 Jun 2025 09:35:06 +1000
Message-ID: <20250608234108.30250-1-neil@brown.name>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I am working towards making some changes to how locking is managed for
directory operations.  Prior to attempting to land these changes I am
reviewing code that requests directory operations and cleaning up things
that might cause me problems later.

These 4 patches are the result of my review of smb/server.  Note that
patch 3 fixes what appears to be a real deadlock that should be trivial
to hit if the client can actually set the flag which, as mentioned in
the patch, can trigger the deadlock.

Patch 1 is trivial but the others deserve careful review by someone who
knows the code.  I think they are correct, but I've been wrong before.

Thanks,
NeilBrown

 [PATCH 1/4] smb/server: use lookup_one_unlocked()
 [PATCH 2/4] smb/server: simplify ksmbd_vfs_kern_path_locked()
 [PATCH 3/4] smb/server: avoid deadlock when linking with
 [PATCH 4/4] smb/server: add ksmbd_vfs_kern_path()


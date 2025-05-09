Return-Path: <linux-fsdevel+bounces-48534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAF9AB0AA5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 08:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97DE24E77FF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 06:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA9126B958;
	Fri,  9 May 2025 06:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9ny6bHb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E12238D3A;
	Fri,  9 May 2025 06:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746772456; cv=none; b=SqAYwrVfe6nnsWYeEcXtvSOfOWdVYt7sIaA9MovsZukriwrihajlx+LL3eo1VjfiCJ+8T9lpg0ZW0IfsQ6/jFDPujix+yihmK2XnFHMoXX+bB6+1uox1t8CU9/fi/Kx8k1yehqFmED13D+mNFAcGZQkV2m48fayzsb8zd+SLYcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746772456; c=relaxed/simple;
	bh=WL7UUCkIaxd70i0yTLn1OxmFS6Mp12a6aWHS71LWZB4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QOZvUovbPlPBerPAaHrEKfXpNrARwHV/JaEfRPdFKklkf9xuYPbIsfdbGIDIffmi81l/seXoQnC5zXcIsNrsfluzMBut28TAf/nMCbXZKngEak74hqVMm675SsjOg1ng9Cml4pOu345Cg5giiMQbC5VxEVbHrywrxkxE/qz2Z80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9ny6bHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CF52C4CEE4;
	Fri,  9 May 2025 06:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746772455;
	bh=WL7UUCkIaxd70i0yTLn1OxmFS6Mp12a6aWHS71LWZB4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=S9ny6bHbziB3c2KJb4BK/SHl1cX6cEoQSCh44WPmSKoLLbtkEpu6d6sEQYotQL28r
	 9Wq1n5MBGFzp+EMbw4uByh6DaYG1U+arHnMXsf33s5Lm3nIiel5KyomBl7/5TxBzZp
	 xE40gRNA+jYH/ePH0E3BZix1XNpnQvwV2NnzoJjoivpEAiuW9Fqn27Uc1VKoogIvq6
	 CxUljyoc+qqvM1ILWIgML4SgPh0cVVnC2l+QvGtzc+EURpwkHmV/WJKu1iJPkCPt/N
	 Hsdp3sMNiGdkYWyhHe7VH2b7kLbp71H6T1QjgU5blcfUvqpm5Ph89Om9WzSdEcJBSE
	 LGi0i8QyHlbgw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594C9C3ABBC;
	Fri,  9 May 2025 06:34:15 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+chenlinxuan.uniontech.com@kernel.org>
Subject: [PATCH v3 0/3] fuse: Expose more information of fuse backing files
 to userspace
Date: Fri, 09 May 2025 14:33:52 +0800
Message-Id: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANChHWgC/3WOwQqDMBBEf0Vy7kq6aqI99T9KDzauutTGkqhYx
 H9vFAql0OMbmDezCE+OyYtTtAhHE3vubYDkEAnTlrYh4CqwQImZzGQO9ejJDB3cSnNn20DNHXl
 Q+VFWWEjSRS5C9+mo5nn3Xq6BW/ZD7177zHTc0o9RywQLVHGitdQKEExLtmM7j6U9jzbcGci0s
 ekfYhNN+F3+d2dCkKCwzlRKWhV5+mta1/UN8btUiPsAAAA=
X-Change-ID: 20250508-fusectl-backing-files-6810d290e798
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chen Linxuan <chenlinxuan@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1622;
 i=chenlinxuan@uniontech.com; h=from:subject:message-id;
 bh=WL7UUCkIaxd70i0yTLn1OxmFS6Mp12a6aWHS71LWZB4=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBoHaHUhMz/8CHmcC875sPKOKvdbx/+8a0mE3ntX
 1uteYpfm5yJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCaB2h1AAKCRB2HuYUOZmu
 i/C/EADTYfQ+L1ZHVLSWskQ/sieLfZTnqYIWmvIOSqOhKQzWQvaW+K2CZLab/QjBK7UUhWSC6JH
 IT98ORN1w2VAZLjFMdArsvwbTCNyn6kJROHMFxAe1SwVe0c7NKZiQQFUQHisw2N7BaAoolS1cOt
 +fAEPhvVs2aqbHKMohmURiUiZsWpMKROSd/T/eoNHILalLOXdxv4ijNASBMY6iAEPfBxvVgHgU2
 icv/BoeA9FgqTgqTZsVcBc1NpXRLG5EVdKYun3fHbBCpQEQgTdMYkQ+6kby7kS9rRrEF+oKhtNp
 860gNFycZnK8mCSfkHysaZZWc4wH5ajPsun2mnlxJdzF2mGEWchzyliVfSe/dCjuYreYaJEAshz
 BdkcK2y6FfOEHokUholgBcmAv71+vq8iGgSW2JnQ2RT4/frvqHPvSd9g7qbEMl1TZSTjqC1MVM0
 TB8X+ED7B3BCmcobwCB4aUkOQrs+nJCjY//taqJlySG+fmB04UlexH3ku/8QqfVg3c9AFxofBtj
 8KwjBQQiWXO5iT0dsarZhebRnAJ3KrSMDL19lJsWjhcE7ihOAj75nuAF9X1MP2eazbIBFCo7vKV
 XLofIUeFyzw3SnPalN+TJ2jlwIL+gxFiZ3x2RpvsJ+WgmwfqW5hqarXGb0f/HgO5Ec06jxacPuN
 NJ4PofMv4UWA5pA==
X-Developer-Key: i=chenlinxuan@uniontech.com; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for chenlinxuan@uniontech.com/default with
 auth_id=380
X-Original-From: Chen Linxuan <chenlinxuan@uniontech.com>
Reply-To: chenlinxuan@uniontech.com

Please review this patch series carefully. I am new to kernel
development and I am not quite sure if I have followed the best
practices, especially in terms of seq_file, error handling and locking.
I would appreciate any feedback.

I have do some simply testing using libfuse example [1]. It seems to
work well.

[1]: https://github.com/libfuse/libfuse/blob/master/example/passthrough_hp.cc

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
Changes in v3:
- Apply some suggestions from Amir Goldstein
- Link to v2: https://lore.kernel.org/r/20250508-fusectl-backing-files-v2-0-62f564e76984@uniontech.com

Changes in v2:
- Void using seq_file private field as it seems that we can just simply
  returning fuse_backing_files_seq_state in start() and next()
- Apply some suggestions from Amir Goldstein:
  - Use idr_get_next() for iteration
  - Do fuse_backing_get/put(fb) around dereferencing fb->file
- Update fdinfo of fuse files
- Link to v1: https://lore.kernel.org/r/20250507032926.377076-2-chenlinxuan@uniontech.com

---
Chen Linxuan (3):
      fs: fuse: add const qualifier to fuse_ctl_file_conn_get()
      fs: fuse: add backing_files control file
      fs: fuse: add more information to fdinfo

 fs/fuse/control.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 fs/fuse/file.c    |  20 +++++++
 fs/fuse/fuse_i.h  |   2 +-
 3 files changed, 165 insertions(+), 14 deletions(-)
---
base-commit: d76bb1ebb5587f66b0f8b8099bfbb44722bc08b3
change-id: 20250508-fusectl-backing-files-6810d290e798

Best regards,
-- 
Chen Linxuan <chenlinxuan@uniontech.com>




Return-Path: <linux-fsdevel+bounces-33823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B13E9BF79B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 20:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD53B1C20DB5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 19:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DE3208204;
	Wed,  6 Nov 2024 19:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afaK5eGB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECA4185B58;
	Wed,  6 Nov 2024 19:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730922789; cv=none; b=pvqdbyG4/svRb9UGb3Mz2+r7U2knIVV4qpZT3zNuE6Mg/rP9Xw+FM0+tfapRfUpwHl6w/nwFTHlCu6xZTiMNjoSWJOPJidzBQL0hSwjKSNafbPPgYgqZ6e4J/3vND3RCuERpb27i5hIT6M0qSphqlB/bA0EX8+gNjXsdQBAehSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730922789; c=relaxed/simple;
	bh=aRV+zYHZNL6BsleDNQCsdcsSHq4ogvv1pZeA3ZWuVJ0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DQdWSrRFJk7ciLE5uuM4A/ee3zckx7Kr3XqIWLGk/ilRTkuQXWYJLMDUC7JHq+Q0Lk6FVh2mZO8TjvWqCcalLklnu+jUDwr5MkpOvLVonnvPOgoGkpzcaizY6Fh1QklpS5FfklQ9su+9DpQ91HJHHr6oH7S2Vtr3htQuLRu3wRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afaK5eGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940DBC4CECD;
	Wed,  6 Nov 2024 19:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730922789;
	bh=aRV+zYHZNL6BsleDNQCsdcsSHq4ogvv1pZeA3ZWuVJ0=;
	h=From:Subject:Date:To:Cc:From;
	b=afaK5eGBVQvlGAxaxPVC/cOGQOg0KTPNFmWS8kXg43UlU4ohuwYT8eaXk37p4KnkW
	 moyq90x02RseP4ruhIVPdiVWm53Q1I1TNnSLMLRV/Rx9inlpzcY29D8bbRmVJ0no6B
	 Vmom9co04wRbduN2zbIIaXTcrv/NVkVwk4Ef7DHWyFrnoGJcRFfdUOz/ngOW1m7X1p
	 sggAkB3ON0zkP9MrKpnMI5s2QFtL4jElF9z6giN+No436r64y7GfdIVuFl2cJ1dz1N
	 UXJ7h6EJc54FUjPTGlFTnB9zLf7qaJgHh3H1lHaZt80/X8XnZKy653xZw3nizgahs6
	 ZMsW2fhhznrYQ==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 0/2] fs: allow statmount to fetch the sb->s_subtype
 field
Date: Wed, 06 Nov 2024 14:53:04 -0500
Message-Id: <20241106-statmount-v2-0-93ba2aad38d1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACDJK2cC/23MQQ7CIBCF4as0sxbToVpSV97DdEFlaCcqGECia
 bi72LXL/+XlWyFSYIpwalYIlDmydzXkroHrot1Mgk1tkK08ILa9iEmnh3+5JDo7oFZk1NFqqP9
 nIMvvzbqMtReOyYfPRmf8rf+UjALFNHSTtmZQvcTzjYKj+96HGcZSyheablnHowAAAA==
X-Change-ID: 20241106-statmount-3f91a7ed75fa
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1031; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=aRV+zYHZNL6BsleDNQCsdcsSHq4ogvv1pZeA3ZWuVJ0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnK8kjbquladGixdtofMN6DLiE3amZxe3VFmUEi
 KoRGvbxjqOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZyvJIwAKCRAADmhBGVaC
 FcgkEACFOyOvBuWa+BVmY6sQLP3smPn9hHwZToSU0lk5D1BKThU+2NOnJFxqRFCiL6HB2gXM5dg
 tSG4HWSMoLdufFu16iS7iv3LmN5fBNPOPymf1y0M//GO7oJQWxBU/zH67W9WsUGKGs03aUObGn8
 UzAj7jiMKIL9eQXDReiUj082uZCMFI8xc7TJH6lJJS1+32S1sZ2FwQKe7BJINMmXGnY3yRSGXz2
 910y3arr7C3d8K4PgWKMb4cbxJKyZVlK2qumu8mImihJOjvPZdsP0IFgFTji0uoRENo1/oL/vrt
 7mcx5topetO3c3D5Lt1rfEJUgILsDbbipfPWw+h/8Zs0Oo20o5DQvKsS1w36qpQ53RhOt9BPQCv
 xiFTvgJtM7X6UkJzJiam3h25UwdCV9K6wmLVGYz4cVbQnZMANEjZ1A275386EeVKj8uyQDiw5F2
 OoJsgvKyOhK+hBjfrR4+rZJTuTpInAZK/h78CmpksqcRhbszkPOZOe0eJHzrz3mjZ172O5rP8Rd
 BF/zFVSFODlLTEH4HzM+mhBg72EPRtlw8pFXSINt//VamUKOoMWlLwPANKIV6dIh+m15TpOKq2g
 9IETyRnXIJT8lwhkTqo4tYpJctXrxBnXbqnS3eGdbEan6PY6BMeDi//r1JrAYZL+B975TS/4BX4
 ittTuzwTwYruIdg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Meta has some internal logging that scrapes /proc/self/mountinfo today.
I'd like to convert it to use listmount()/statmount(), so we can do a
better job of monitoring with containers. We're missing some fields
though. This patchset adds them.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- make statmount_fs_subtype
- return fast if no subtype is emitted
- new patch to allow statmount() to return devicename
- Link to v1: https://lore.kernel.org/r/20241106-statmount-v1-1-b93bafd97621@kernel.org

---
Jeff Layton (2):
      fs: add the ability for statmount() to report the fs_subtype
      fs: add the ability for statmount() to report the mount devicename

 fs/namespace.c             | 42 +++++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/mount.h |  6 +++++-
 2 files changed, 46 insertions(+), 2 deletions(-)
---
base-commit: 26213e1a6caa5a7f508b919059b0122b451f4dfe
change-id: 20241106-statmount-3f91a7ed75fa

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>



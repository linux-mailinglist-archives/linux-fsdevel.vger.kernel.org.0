Return-Path: <linux-fsdevel+bounces-46250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62334A85ECF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 15:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 057401B8200A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 13:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC2413E02D;
	Fri, 11 Apr 2025 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ziyk9fec"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6744964E;
	Fri, 11 Apr 2025 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377773; cv=none; b=kkrk9/SG2Uh3JoRUGNROlce0kgYp9eyxb7UFoVpj1nC4rMbARCX5hxp8ozgAr0LdcQUVeE/KmhoSUC2WPbeuDSzQFo3AmfhWrhqA4acaziTb70hEvm/fPL8meytJUhXv/esFE4rFuFZzqufW4pwsHONqUZ3MRnhk0zuvP8VbDd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377773; c=relaxed/simple;
	bh=ly6rpIyPaDRJfWGU1MeNR1JLAEhIsdS0hC/xHmLN0+A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SZCt1L74rDuYqCiWSVACga/ZNGyuFQWrARN1vdtyC/2oihyMQwA2/qT7AynEWouk4Rd6Ye3fgk1mmu75oSpRjyICVCy91JFKiuMbRT7GJGrBC4EBqjauEiIs4JS0taIfnaPTWDcvPspTd4sRDRn61C/Kwvo/nBMWoZNp5DqGpfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ziyk9fec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89274C4CEE2;
	Fri, 11 Apr 2025 13:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744377772;
	bh=ly6rpIyPaDRJfWGU1MeNR1JLAEhIsdS0hC/xHmLN0+A=;
	h=From:Subject:Date:To:Cc:From;
	b=Ziyk9fecgjkeEfcj+/L5o69uJjmjr4ZuqM70FwcN42IAD1QBDh/e4UYEZCcREGYjB
	 9/P6pdodGdMbOWdH5O0oeaStONBNqpR6Zd6Sb8rZtNrKnBS53kb9biBQHGvZrOlcUQ
	 e0+tgaPrkQUm+kwAPKMBF1QEENh78MtvHe8xipPWV0SafP5EeGyBJX6u4cbiuRba49
	 Tcx/itOFAP1ipUORlDw5zmeGW9L3Su4xaRvW49c2h4Q6p9BQjVLEmiLQ3GwoCZwkXU
	 06M1J8be9u8e77KDzeBdHoo0GLYavGQGyOi4HemUwhHN5PITOCKPIQdua6Jsct5Yh1
	 swU0PXSu9uVUQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 0/2] pidfs: ensure consistent ENOENT/ESRCH reporting
Date: Fri, 11 Apr 2025 15:22:43 +0200
Message-Id: <20250411-work-pidfs-enoent-v2-0-60b2d3bb545f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKMX+WcC/yXMQQqDMBCF4avIrDuSBG3aXqW4iHGsQ2EiE6kF8
 e6NdvnDe98GmZQpw6PaQOnDmZOUcJcK4hTkRchDaXDGtaaxFtekb5x5GDOSJJIFfeNbf7dXE28
 Rym9WGvl7ms+udB8yYa9B4nRIB1CfQP2f7fsP6ktxsIYAAAA=
X-Change-ID: 20250411-work-pidfs-enoent-747579160c8c
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 linux-kernel@vger.kernel.org, Peter Ziljstra <peterz@infradead.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ly6rpIyPaDRJfWGU1MeNR1JLAEhIsdS0hC/xHmLN0+A=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/FF81da06o8yljJApy5g0trYc/xeQUnP+47siNS/TG
 yK9NwMkOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbipMfIcFyyqpcvwnKblMX7
 sNl/P8+e5Ljw25as7PKXW88s5shf2sXwVyb1wKm4bQ4Czc9XvHp6mmWr3lzpvRa/X+2O89r358Z
 KUW4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

In a prior patch series we tried to cleanly differentiate between:

(1) The task has already been reaped.
(2) The caller requested a pidfd for a thread-group leader but the pid
actually references a struct pid that isn't used as a thread-group
leader.

as this was causing issues for non-threaded workloads.

But there's cases where the current simple logic is wrong. Specifically,
if the pid was a leader pid and the check races with __unhash_process().
Stabilize this by using the pidfd waitqueue lock.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (2):
      exit: move wake_up_all() pidfd waiters into __unhash_process()
      pidfs: ensure consistent ENOENT/ESRCH reporting

 kernel/exit.c |  5 +++++
 kernel/fork.c | 31 +++++++++++++------------------
 kernel/pid.c  |  5 -----
 3 files changed, 18 insertions(+), 23 deletions(-)
---
base-commit: 1e940fff94374d04b6c34f896ed9fbad3d2fb706
change-id: 20250411-work-pidfs-enoent-747579160c8c



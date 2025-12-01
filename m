Return-Path: <linux-fsdevel+bounces-70345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B339C97F6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 16:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CBBE3A3F6C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 15:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8314531B817;
	Mon,  1 Dec 2025 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkqLQ26y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B4D244663;
	Mon,  1 Dec 2025 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764601727; cv=none; b=Z78yYfDgIvZsKJrvRro+Iv4vjrQGeg9rGsb/YvJWkORH98anHg5H1snsLx1/OQ4YV4b8KV+P2jytT+Ngl1L5BEdqkuLrzTDWUXCcwzNadoSRT1gGzSwm89o9TYv8zVkyZSjQEItOzQqcRz8/OQNawmCtRdHZ7hiHtYTBCmLeXdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764601727; c=relaxed/simple;
	bh=WfZJCJKVDl23byfst3/HKmyZtpRv5tSipW9daQ7T2pM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L2kO5VjuYg0j4SMueYu1tCxzeInKdTElxp5GrDeg6AgiScUelH3XZW/yRS5nH5y1kJYb1z1CXSx7r1cEY6orp4joXFdcQvxQuicFrgrb7JUzV+t8FFXWM4vFkRi4LKzdwrYm8WpbxTI854dMa6zJs1e2OujgEHL7eA0MZDB/69s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkqLQ26y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26196C4CEF1;
	Mon,  1 Dec 2025 15:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764601726;
	bh=WfZJCJKVDl23byfst3/HKmyZtpRv5tSipW9daQ7T2pM=;
	h=From:Subject:Date:To:Cc:From;
	b=nkqLQ26yAkvhfbQmBLwCWLXWExFF7J5RJJ2oY9krORKjmEuofYQtLxRhWptDGWkJG
	 QKNWmJJ6ow1R4AF0jCAUvJwgNWtvDeklLzzivBRXWtopAqga4OSHRx7VkUrWfl7MWd
	 OkJtlAPIpQAP8A6P08oZwjQmy18g8DFNL25373nHnzupRBrqOmp2lQyhSsfQZR+kqL
	 bEVWoKE3FFwanbq+W89OLFXjmffbXwHoTyp8iSVBnIB2x/GBX4+CgrPmCp6mBCt+B2
	 LyaFQRONCExAyJNM27QNrT2Z7AB5zoUzh98QC4MZIpEcaK6ZiuWL7bdiwu5i171DNe
	 crRtbCGUm2lSw==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/2] filelock: fix conflict detection with userland file
 delegations
Date: Mon, 01 Dec 2025 10:08:18 -0500
Message-Id: <20251201-dir-deleg-ro-v1-0-2e32cf2df9b7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqAMAwA0atI1gaa+EG8irjQNtaAqKQggnh3i
 8u3mHkgiakk6IsHTC5NeuwZVBbg12mPghqygR03xI4wqGGQTSLagTVN1M6euas6yMlpsuj974b
 xfT8Ghw/xXgAAAA==
X-Change-ID: 20251201-dir-deleg-ro-41a16bc22838
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Jonathan Corbet <corbet@lwn.net>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=998; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=WfZJCJKVDl23byfst3/HKmyZtpRv5tSipW9daQ7T2pM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpLa91jGi6RUd52+oFo9VkTJRCh5HJabFJd9QDF
 9D3q+uYwfOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaS2vdQAKCRAADmhBGVaC
 FYdPD/4gMXnTG0acrN4qtNFZILgw+T45t4X42Kq9EfFsJxKYWIAA31x3P1QOFXBQ4RWHyooBiC8
 8KL/EHXoH23zsDje961F/pUnqL1KTk4/CKLbHhMIJIWP0K9JSQ7nJKnZOo5nhLmGuTzfUE1cso4
 NF6E5x1ZGhm2+G+1hZ4WDusKIxsx5DPvuLqYtmG3IB9/vus5BilmoNZqFnNp+ma2cDX47rzS5h9
 jwt1T2LBOnRGFY/RMFo7+RAxM1Z0RGBoxO6Ydo8RGOx7mbjKV6gfk+Xz2FTjRJaH4Ycv7ekSR8P
 XmGxxtMHXGHfnU9SWUTjajgNweV/80ATEEa+21Q/i1EJz9zFvy3D0WuEZLZ2qmDWp9lIuMMgUtA
 4daJqcWg5qVnkmy31FuXaIjjucIft8QbnrIYXBGxntxZ491cVRYz39VTeG4s12vMdtMFHFOhr6T
 L3MXk9Ysrs5V752352VrigL2WMuvI097Jaj/db2nG/ZpxMnkhOmlBPBlCmfo8Nbu07qcthCCLVs
 132N146Q4EPu59GZwvWRN+lhc8rwTKGcjcGBkBsZHYaCcHC+NzGLcc4dYeo6PucvXBteHnYcQ+R
 qP1XYXwqCiLfyR2MCIJ8xKYQ0FOXhljV8WF+QYgFIx3/lPNFs7ig1nSZefUZ79yIGFoiwCGg2lu
 otwD4O9LCGbqkXw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This patchset fixes the way that conflicts are detected when userland
requests file delegations. The problem is due to a hack that was added
long ago which worked up until userland could request a file delegation.

This fixes the bug and makes things a bit less hacky. Please consider
for v6.19.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (2):
      filelock: add lease_dispose_list() helper
      filelock: allow lease_managers to dictate what qualifies as a conflict

 Documentation/filesystems/locking.rst |   1 +
 fs/locks.c                            | 119 +++++++++++++++++-----------------
 fs/nfsd/nfs4layouts.c                 |  11 +++-
 fs/nfsd/nfs4state.c                   |   7 ++
 include/linux/filelock.h              |   1 +
 5 files changed, 79 insertions(+), 60 deletions(-)
---
base-commit: 76c63ff12e067e1ff77b19a83c24774899ed01fc
change-id: 20251201-dir-deleg-ro-41a16bc22838

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>



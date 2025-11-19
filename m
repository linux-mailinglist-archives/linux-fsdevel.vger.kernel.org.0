Return-Path: <linux-fsdevel+bounces-69094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89356C6F251
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 15:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B133C5000BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 13:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B384D3612D0;
	Wed, 19 Nov 2025 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSkXHuKu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0739835A151;
	Wed, 19 Nov 2025 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763559762; cv=none; b=SX15h+AAMfMlJHbwBor4XbV0HiBa0vO503yD0mh6rkA7qtWednUxdb4xKIExjKMb6JUwm0ubreLi7EIdzWstGELXxBOvj1YVy792Fm3ES4icEKxjSpOt+f/xSfcNkOiYH5i7TevOv3iFggIHD6o+kp9aSHIEyFqwFOIr70RuAWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763559762; c=relaxed/simple;
	bh=lIATXqczS2S/5ru6b8lNhYDwW0smj3pArVa7xKT4H+U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QMMYQxCKqaWgKfgRzI+EsNffwC7UdcebOOWOevq4p1M3+ieo6jTaNp7tBNr7seRZz9e73pSuPvEeguGEkL0QceH5Jt5AmJav1oBCWVACEPE8GD9yBI6ZIgdSAVBmhI9nIN8shAe2HvTasTyuripBZ5qXF7glZWMv+VDT/iNr1II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSkXHuKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BEBC4AF17;
	Wed, 19 Nov 2025 13:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763559761;
	bh=lIATXqczS2S/5ru6b8lNhYDwW0smj3pArVa7xKT4H+U=;
	h=From:Subject:Date:To:Cc:From;
	b=rSkXHuKuj5y81013DBOjwJj9reIpfHBnHrP1MPFQgsB+ukUxPoeua9jAP8cXKAnUv
	 mZsiRGpgoKpSVED63CoFZKdcMhE/vriiNLWu6yLO7Mqr5zPj/wSXN/M/Z/oBE30TH5
	 2GHO0csonDGKJfwF3bV1l472rBWvK5upzr2PCxvKedzRDm/i3S+hLQPiEQIbRofGQL
	 g+rajwrkDLrIfZT5hm5stJqe37xjOSnPxE6yLQyykwWLbnblryv03ZF2DiK+D06ZNg
	 oKrONsQHGD65gMU0g2YY1872UT5Fm2O5FS6IQk6ZE8DaUqNS/DiJbAt9SIQhrHWB3a
	 RlT79nl+YV7AA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v8 0/3] vfs: expose delegation support to userland
Date: Wed, 19 Nov 2025 08:42:17 -0500
Message-Id: <20251119-dir-deleg-ro-v8-0-81b6cf5485c6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMQQ6CMBCF4auQWTuGKWrBlfcwLKqdwkRCzdQQD
 endrexd/i953wqJVTjBuVpBeZEkcS7R7iq4j24eGMWXBlObIxFZ9KLoeeIBNaLhkzlYR652HZT
 LUznIe+OufelR0ivqZ9MX+1v/QItFwtDegqfGNbajy4N15mkfdYA+5/wFK8XaZqkAAAA=
X-Change-ID: 20251117-dir-deleg-ro-2e6247a1a0a9
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1965; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=lIATXqczS2S/5ru6b8lNhYDwW0smj3pArVa7xKT4H+U=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpHclJEdWcxA9JE6/PF9sWo1m1teb249LmuWAKa
 kwYM8RH7geJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaR3JSQAKCRAADmhBGVaC
 FfusD/wM/Tnn5DpA3SnA/VAo1+TyqvAFbgTBnz9R96t6mYGexrvCyUD+5NcUaUfKaxXQkHo6bCn
 lEl8vK4/h+l+AEWc/xFAjUn73xIhScSU4tDkr6uSmoMlGUez7dbP/sh3QT6sOKgbVb25OllVBPp
 6hBq02N/7J0L26PzeTn2Sd9qXfdHFFFD/692wVq7wfJ8FHJ17m6vjmRaDETbHng+u3pk+eOsD4i
 6YDQXNeAma6ktswawqWv3cXoJJa78OWLzcBq5/SWgvI7DAnoC6KOVXw3giQ59TTJ3hzTchFzb9B
 d17G1Q/5Rk+9JX42m9lDIMOw/iy/H462VbIAeJRBXDs8K11GDatpF2iYFsE4QR4F1ZCMp8k2QAW
 tYE1JXiYkDlFhXvLI5HjS+UFJHEucHzqDnwoTGCFACCy81DzVwCoYY6pNdQn8Sjk3Z/M8dkbhrD
 joMEXuy2bvpGH64EwFB4l52qHEjuS46IMsUtw/nFHeDasakRYb9ed3xpasNSukCdTO/DwMsV/uS
 BUzNgPrraVWssrRNU/9PJ2jQfNzSAaitHAGkxikHYhGS0CzBWk6+/SYB4TbXDMeU1eaz1G5izwO
 Zyz7+LXpoFhmkxqldIrUJZz6at6wNmG5f1+Y7yypui21PY1XdTGRkY3ZsXaLyj0V98UDNmal3cQ
 ARYEL4/MVs9KVBg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Stephen hit a couple of problems while merging the last patch in the
directory delegation series, and I found some problems while testing
userland delegations (more fstests forthcoming).

Christian, could you drop the last patch in
vfs-6.19.directory.delegations, and pick up these patches? They should
address all of the problems Stephen reported and make userland
delegation support on files work properly. Let me know if you'd rather I
resend a whole new directory delegation series instead.

To: Alexander Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
To: Chuck Lever <chuck.lever@oracle.com>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Jeff Layton <jlayton@kernel.org>

Changes in v8:
- split out lease_dispose_list() helper
- add new ->lm_open_conflict() lease_manager_operation
- Link to v7: https://lore.kernel.org/r/20251117-dir-deleg-ro-v7-1-f8bfd13a3791@kernel.org

Changes in v7:
- have fcntl.h include proper headers for stdint.h integers
- move comment above fcntl_getlease() to the proper place
- add a kerneldoc comment over fcntl_getdeleg()

---
Jeff Layton (3):
      vfs: expose delegation support to userland
      filelock: add lease_dispose_list() helper
      filelock: allow lease_managers to dictate what qualifies as a conflict

 fs/fcntl.c                 |  13 +++
 fs/locks.c                 | 199 ++++++++++++++++++++++++++++-----------------
 fs/nfsd/nfs4layouts.c      |  11 ++-
 fs/nfsd/nfs4state.c        |   7 ++
 include/linux/filelock.h   |  13 +++
 include/uapi/linux/fcntl.h |  16 ++++
 6 files changed, 181 insertions(+), 78 deletions(-)
---
base-commit: 5c4a3c4961067120fbf6d35622c2e839f9ceba12
change-id: 20251117-dir-deleg-ro-2e6247a1a0a9

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>



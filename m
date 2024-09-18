Return-Path: <linux-fsdevel+bounces-29651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A6597BDC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 16:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426631F21F31
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 14:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A3A18C918;
	Wed, 18 Sep 2024 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYdPTlg3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C519E18B472;
	Wed, 18 Sep 2024 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668651; cv=none; b=SshLx9QQdmGJyyskgzsvSA7WQSUg/+H6JtkKW4udegsiGwgovfH4RNJD0sqsFjFmBh+vozZskeEpMCYeVrOJcmu1nEkc06S2UIcjNpeXA+/0TJKVNrU0VRZCCmj1d4daDUpxg6/7hnY6HcE6tOSiOvCqk88trdR6x9J5EnqPYbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668651; c=relaxed/simple;
	bh=dkeHweZOsjkx3Ag5GOp8+zbO/oMVxglgz9oAsbZuWfw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OQtzWW1yJvk2hwtDEOspoyyo8YL1koa5GFzg+BeJQg8IHMwxPOXG0d5dLmHzlzgWnEDFW2KQk3XitZI3m9S90Bbsj0VsL+PmviSkm4sys6NkvVobjbr0ck1dVb4rCT940QsvpGLE00312NyRBjmqWGjeHTjTKVzOamsac5Dy9C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYdPTlg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 590E4C4CEC2;
	Wed, 18 Sep 2024 14:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726668651;
	bh=dkeHweZOsjkx3Ag5GOp8+zbO/oMVxglgz9oAsbZuWfw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=cYdPTlg3ffygWcgCxyBPlCZ9Bt7oZKTvffdXiXkqdMRUlalCxoVwJNqoy7UWqr8Z/
	 cB0PvRYAYNCuwAPA4w/GefAWog7iPRS6imqxflPqErW3qq/YrFNolVT95/7ktAjJfT
	 U7/+OLHSAtFlO97oWUfSvrJlE4b3Zac/O6QwMYyHW+DjDJiQuqBJSehVETt/GVn2Wf
	 7bK6EchdYX4NtVgD32lDWPpUlcXd5At/x9dFUNRQt6RkQ1UPgRkx0sDRuVpllWQ4rS
	 ppUjmpf0+McRx9aMu2S/YNWHg4Mn+4WmRJ47KeE6CVOF7PSwxD8phXfzsupH5ObObF
	 dQn8LGmDvTa7A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A06CCD1AB;
	Wed, 18 Sep 2024 14:10:51 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Subject: [PATCH 0/4] Backport statx(..., NULL, AT_EMPTY_PATH, ...)
Date: Wed, 18 Sep 2024 22:10:36 +0800
Message-Id: <20240918-statx-stable-linux-5-15-y-v1-0-5afb4401ddbe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFzf6mYC/x2Myw5AMBBFf0VmbaRF4/ErYlEMJpGSFqmIf1c2J
 znJPfcGR5bJQR3dYOlkx6sJIuMI+lmbiZCH4JCKNBeVLNHtevcfu4VwYXN4VCgVXljpTGSq1MW
 QFxD6zdLI/v9u4FRJGH0U0D7PC/8LDll4AAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>, Mateusz Guzik <mjguzik@gmail.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
 stable@vger.kernel.org, Miao Wang <shankerwangmiao@gmail.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2178;
 i=shankerwangmiao@gmail.com; h=from:subject:message-id;
 bh=dkeHweZOsjkx3Ag5GOp8+zbO/oMVxglgz9oAsbZuWfw=;
 b=kA0DAAoBsDHjynv+2W4ByyZiAGbq32iiclsVGevsH3fdEUaojZ1rU7KBcrzo1/cYK142hpS/N
 YkCMwQAAQoAHRYhBESo9Y+A8kHGW57ME7Ax48p7/tluBQJm6t9oAAoJELAx48p7/tlu87gQANBX
 CdjnQ6MdfZkdWU82SRd8+3aRBEBWeQpcHyEmSxMxBWS/pXs21wtcl85ssdEtjpOnf8Ebfsz56R/
 VWbGkZFIsSpWJ42/34sAEBjK/g8wiZqNU1LSmyW9ZIq68P0qd6deZ4lTbAddNxIJLtugjEMw/9y
 LdevRi9NV66yNGF3saB/1poT0JjMuhA8kCiQiqrhfUEBnpgdaH3u4r08AwNWFXRyyIhtw9g4nOd
 J+bVssMyWn99MZ9kEfOgxxuxEjKR4j9MMcAWd2vIHVyCposnIneEOWVwDG26Fv2GRFwZE7AFEfZ
 D+MQui4jhJlXW04XcL2jC8mrThujD7DVxoWwCytqMAFXhpFNWV2a+hVPmLdjV9IuwSAVQ+g+P/A
 yjodgqh6fzEOrgwW3Ejm9SZEkTnztE0LoAP6uXLaPPxEJ8ze9t5iAru+32RElbfIhJqJz3XJ191
 /a1sgN9nlnHmf41EmybQ1EkRpzHrFJ2T4ob4wSTLUlWwewyGH97Swkl0J2fOSIr+e4VY6o3NmAC
 iA2SlvqYvtBHWYz2SMWJW52zrkB30LfAKslHWp5JG9rsaSDmDT4y//D+TA6lGUc3k9ha+mW3aje
 LnbwovzKdaMbwI1q1iJ4udI5yjYl/yPobc74u3l1jh34TvaZ1p+U2DHxW7yIGYhKE4nyMHoZE1g
 ZWRK+
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/default with
 auth_id=189
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Reply-To: shankerwangmiao@gmail.com

Commit 0ef625bba6fb ("vfs: support statx(..., NULL, AT_EMPTY_PATH,
...)") added support for passing in NULL when AT_EMPTY_PATH is given,
improving performance when statx is used for fetching stat informantion
from a given fd, which is especially important for 32-bit platforms.
This commit also improved the performance when an empty string is given
by short-circuiting the handling of such paths.

This series is based on the commits in the Linus’ tree. Modifications
are applied to vfs_statx_path(). In the original patch, vfs_statx_path()
was created to warp around the call to vfs_getattr() after
filename_lookup() in vfs_statx(). Since the coresponding code is
different in 5.15 and 5.10, the content of vfs_statx_path() is modified
to match this. The original patch also moved path_mounted() from
namespace.c to internal.h, which is not applicable for 5.15 and 5.10
since it has not been introduced before 6.5. The original patch also
used CLASS(fd_raw, ) to convert a file descriptor number provided from
the user space in to a struct and automatically release it afterwards.
Since CLASS mechanism is only available since 6.1.79, obtaining and
releasing fd struct is done manually. do_statx() was directly handling
filename string instead of a struct filename * before 5.18, as a result
short-circuiting is implemented in do_statx() instead of sys_statx,
without the need of introducing do_statx_fd().

Tested-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
---
Christian Brauner (2):
      fs: new helper vfs_empty_path()
      stat: use vfs_empty_path() helper

Linus Torvalds (1):
      vfs: mostly undo glibc turning 'fstat()' into 'fstatat(AT_EMPTY_PATH)'

Mateusz Guzik (1):
      vfs: support statx(..., NULL, AT_EMPTY_PATH, ...)

 fs/stat.c          | 73 +++++++++++++++++++++++++++++++++++++++++++++---------
 include/linux/fs.h | 17 +++++++++++++
 2 files changed, 78 insertions(+), 12 deletions(-)
---
base-commit: 3a5928702e7120f83f703fd566082bfb59f1a57e
change-id: 20240918-statx-stable-linux-5-15-y-9a30358a7d47

Best regards,
-- 
Miao Wang <shankerwangmiao@gmail.com>




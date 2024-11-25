Return-Path: <linux-fsdevel+bounces-35797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 916BF9D8768
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB35284B5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B511AF0B7;
	Mon, 25 Nov 2024 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYkJpU4f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8969A192B7F;
	Mon, 25 Nov 2024 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543821; cv=none; b=f/F/1A4x+rcVSXuMieDsoUYISazkXG68E0nilqkuLFR+s64IQRpy9mDXNi4MvukrPQhNtcPZqY9jp1Jg/1eRoyaXFBdk0S+2EuF/ab9oCiUjZCFQIC2UKVzDXyQWqIPcyvqKY1XJmQnkNIebp0aBJ0OZ3P0NXMrs+c9to6ksVx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543821; c=relaxed/simple;
	bh=lZvVNtEbq/joGnuPDT54Ur4lHMroM/AsKH4ca1Rb2jw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rsw0qYolE/TmOFk996JrfxfpTKhnkrOljJpnOhodR4+peJDwPkxlhsmsziRCiJlLanD6uQ9J1GEARdHSTL6KHo9tAacBOu6O49Bq3cWuWFl12B0WEaH0n2aZYg095Qzcel9mR29nF0sApilI8Dc9Q2XASWPNryT2Ek/S0Awn9RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYkJpU4f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5948CC4CECE;
	Mon, 25 Nov 2024 14:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543821;
	bh=lZvVNtEbq/joGnuPDT54Ur4lHMroM/AsKH4ca1Rb2jw=;
	h=From:Subject:Date:To:Cc:From;
	b=WYkJpU4fOMfXxXSpHo5HCdil8kw2CZEmFPGhTEAAaLw1C8fXHLRRvukJaUGoX+77l
	 oN2GpxyCMKa49aRTX6G6e8zTUk4QsEIOf6YedP20ytgtgkSUS+Ms/ZOwgNnZGkgUQ/
	 FItudqn+mTJRjmQ29/FMvTorM2rtu3szyWSV4jm2sZT69R675NmS5kzd7X6IIoCzfr
	 LyfFTGeofohlgCumrA+1ZzEY+uK6MTpRFzSlJVRzwzYbxGia3qkwnPqtguRxLFJye9
	 ezhxbta/JurORZJKwMwchhzWMqvsnyYW2N8ytXTbrfj7VvkNc5Pr8UHDUIgWSfENBD
	 ZONEWmZg45+UA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 00/29] cred: rework {override,revert}_creds()
Date: Mon, 25 Nov 2024 15:09:56 +0100
Message-Id: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADWFRGcC/22NwQ6CMBBEf8X07JJ2KSqe/A/DoZQFGrQ1W4Iaw
 r/bcvb4MjNvVhGJHUVxPayCaXHRBZ8AjwdhR+MHAtclFihRK4Ua3oEnsEwdlLpuT5WupLygSP0
 XU+8+u+veJG5NJGjZeDtmw9PEmbjIIlAKUOfN6OIc+LvfLyov/z0tCiT0ZYUpsWV9lreJ2NOjC
 DyIZtu2H2SUPNDHAAAA
X-Change-ID: 20241124-work-cred-349b65450082
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3601; i=brauner@kernel.org;
 h=from:subject:message-id; bh=lZvVNtEbq/joGnuPDT54Ur4lHMroM/AsKH4ca1Rb2jw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7tHqwli0uDjK8fPNkYxGflf1nO9nJt2+LaH7dFPFif
 8nXvZuvdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykYTojw8RLFXN8mTIt7+RP
 N77u+2myZu+e8ob6nazCJ5+f++09+xrDP3uFrKB38ZovVs1cWaTnWa+vOO0r04uaP+73e5odHbW
 6GAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

For the v6.13 cycle we switched overlayfs to a variant of
override_creds() that doesn't take an extra reference. To this end I
suggested introducing {override,revert}_creds_light() which overlayfs
could use.

This seems to work rather well. This series follow Linus advice and
unifies the separate helpers and simply makes {override,revert}_creds()
do what {override,revert}_creds_light() currently does. Caller's that
really need the extra reference count can take it manually.

---
Changes in v2:
- Remove confusion around dangling pointer.
- Use the revert_creds(old) + put_cred(new) pattern instead of
  put_cred(revert_creds(old)).
- Fill in missing justifications in various commit message why not using
  a separate reference count is safe.
- Make get_new_cred() argument const to easily use it during the
  conversion.
- Get rid of get_new_cred() completely at the end of the series.
- Link to v1: https://lore.kernel.org/r/20241124-work-cred-v1-0-f352241c3970@kernel.org

---
Christian Brauner (29):
      tree-wide: s/override_creds()/override_creds_light(get_new_cred())/g
      cred: return old creds from revert_creds_light()
      tree-wide: s/revert_creds()/put_cred(revert_creds_light())/g
      cred: remove old {override,revert}_creds() helpers
      tree-wide: s/override_creds_light()/override_creds()/g
      tree-wide: s/revert_creds_light()/revert_creds()/g
      firmware: avoid pointless reference count bump
      sev-dev: avoid pointless cred reference count bump
      target_core_configfs: avoid pointless cred reference count bump
      aio: avoid pointless cred reference count bump
      binfmt_misc: avoid pointless cred reference count bump
      coredump: avoid pointless cred reference count bump
      nfs/localio: avoid pointless cred reference count bumps
      nfs/nfs4idmap: avoid pointless reference count bump
      nfs/nfs4recover: avoid pointless cred reference count bump
      nfsfh: avoid pointless cred reference count bump
      open: avoid pointless cred reference count bump
      ovl: avoid pointless cred reference count bump
      cifs: avoid pointless cred reference count bump
      cifs: avoid pointless cred reference count bump
      smb: avoid pointless cred reference count bump
      io_uring: avoid pointless cred reference count bump
      acct: avoid pointless reference count bump
      cgroup: avoid pointless cred reference count bump
      trace: avoid pointless cred reference count bump
      dns_resolver: avoid pointless cred reference count bump
      cachefiles: avoid pointless cred reference count bump
      nfsd: avoid pointless cred reference count bump
      cred: remove unused get_new_cred()

 Documentation/security/credentials.rst |  5 ----
 drivers/crypto/ccp/sev-dev.c           |  2 +-
 fs/backing-file.c                      | 20 +++++++-------
 fs/nfsd/auth.c                         |  3 +-
 fs/nfsd/filecache.c                    |  2 +-
 fs/nfsd/nfs4recover.c                  |  3 +-
 fs/nfsd/nfsfh.c                        |  1 -
 fs/open.c                              | 11 ++------
 fs/overlayfs/dir.c                     |  4 +--
 fs/overlayfs/util.c                    |  4 +--
 fs/smb/server/smb_common.c             | 10 ++-----
 include/linux/cred.h                   | 26 ++++--------------
 kernel/cred.c                          | 50 ----------------------------------
 13 files changed, 27 insertions(+), 114 deletions(-)
---
base-commit: e7675238b9bf4db0b872d5dbcd53efa31914c98f
change-id: 20241124-work-cred-349b65450082



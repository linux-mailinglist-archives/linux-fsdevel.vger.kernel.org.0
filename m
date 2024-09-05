Return-Path: <linux-fsdevel+bounces-28725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3053496D8EF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 14:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD0B28CCD3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 12:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F70419D082;
	Thu,  5 Sep 2024 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfSQySjM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40B119B5B4;
	Thu,  5 Sep 2024 12:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540119; cv=none; b=aRxXVtxmtca6cBY1XLHgjrFtjqYk3zYYtfC7znk7LBaMGu/1G69X/jz+lFWdYwfS7kntL7F4mOiLYDIWVnMZudDWN2yIaYg41Q6+l2cu/pIiwaf6EC9T5zuxMeCjQPZj+FxiP2zalDzI2QFQYaJW/0q+5uhdwkea4DLvQWnotUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540119; c=relaxed/simple;
	bh=WOMPM4a6cFQUhOu0UuUBlXpQMEvZe7jPE4ipDUDHdio=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jiUjjxYDHcZYPkKzHcJJpZ5xIXCkGtezZC+u1c/4VwjPfihlIP7EM5i/BeLVGLVjN2XFFqDmjlwl8pNmx18GhJhZ/tAnvb6Gflq1pJEtLbhRXx0n6EdqBbFTWiUD/xLg1GMaUykQIW+cUXcMEyj4arQo0/iEEYiTzUriz+mkPn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfSQySjM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDE9C4CEC3;
	Thu,  5 Sep 2024 12:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725540119;
	bh=WOMPM4a6cFQUhOu0UuUBlXpQMEvZe7jPE4ipDUDHdio=;
	h=From:Subject:Date:To:Cc:From;
	b=AfSQySjMMqxvkfA4RHKY7VpISPW4Gd8Eb/1gLYyXYKY/zLpmHH+dnNae6wCqipbVK
	 TqyvfL/97pznEmkXU0ohgZZgOKB3rwOJJX7SbNe3SchFYBN+eY7bXPlBnhGH4j3Hhq
	 b83Q92gHKf8gIfkRDnZNJt+mYbtpvD9tcwgBHO9RiUzLrM60xZ+JLxqofcsfdCHWuq
	 2U8gUSrOMm9NRiHvdL/pMmxdetYwC4fdKmPEg+kPL7zMX+yRHQo1uw5qHke1/QKSCF
	 FUlGkcuz7phRZFM7KqCzS0nv2oiK1+9yoW0tEbXI563JFKau/E4PlkOIj0AKG0RBcU
	 jNSsaWGOZaigg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v4 00/11] nfsd: implement the "delstid" draft
Date: Thu, 05 Sep 2024 08:41:44 -0400
Message-Id: <20240905-delstid-v4-0-d3e5fd34d107@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAin2WYC/2XNQQ6CMBCF4auYrq3pTAGpK+9hXOB0hEYCpiWNh
 nB3C4mKcfkm/f6OIrB3HMRhMwrP0QXXd2lk242gpupqls6mLVBhpkrIpeU2DM5Ko9GowkBlAUR
 6ffd8dY+ldDqn3bgw9P65hCPM13ej+DQiSCUJEUhbgozs8ca+43bX+1rMkYgriCuICXJZXXJSr
 A3RH9RraL5QJ4h7oEKVqqD898dpml4y4gBEEQEAAA==
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3453; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=WOMPM4a6cFQUhOu0UuUBlXpQMEvZe7jPE4ipDUDHdio=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm2acNs8R8E6M66FIHRLbLZiujzfupJXyFbUvLz
 xzBODJNYUSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZtmnDQAKCRAADmhBGVaC
 FaqrEACh4TwDS6buQftt4M0YLMY/fErr7N0hlcZWn7yDrUi1D6zKIc5+U2i3AhKWXQ9yXmdac9u
 Ec2ucSUSzjgv0gZStj5abQbd5PvADzAheZqFPpMhlR7uyfnuxshmv3DNn/5wVJbxTe38DHruHuJ
 U9ExWsOLLXAJORJ4XdJUkWMHfM5n9g3vCaQTzUNAkO3Xi9wsF8sOisWGO7xTFR6Qe9AT0apJzCg
 uVfAJ2BZIs0+0QRqu5q2u4Sd0sZbrHF3BUOoDW4H+31RfyDtAtWzSPhSk3tkkTLkfMX8ppHC5A4
 fwBn4Q82cNFTW9RKvPhKz5tIQYW8rHFOohSU2PDBM7YbEiu3Xr2IpJ3//xGd6YjWJ4o032vP+aZ
 V4Jb9UnEs/dGAfTo8DiwHRxLXwMjtO5WCGY1JoPpOtBT6apFVaMuG+6mya+5WdlhEvvRG78zeyg
 EAexGbR3dnBVnlSnQtOQ8XQJla1oXS2wrTW0L5u6pcWHt9hk5p/fsLQ1GIILxY9mYR0wc+wATHI
 yeTNaariVjEj3jfwv/WJyq17VgSSL7D73ABFhqjxLtUwBrn6lx+W3bZW74tmVnPpcgoE9p+soYR
 w5S1DopD0uKjXn/8HDAxhBhz6YzG/HAb0a5ZrQLftY42gSCIs6hyCaFHxJ4iuhWpoMYEime+ZIh
 vbm8atLM4B1OdVg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Sorry this has taken me a bit to re-post. I've been working on some
pynfs testcases for CB_GETATTR, and have found more bugs in our
implementation.

This repost is based on top of Chuck's nfsd-next branch. The first two
patches fix a couple of different bugs in how we handle the change attr.

I also dropped one of the patches from the last series that tried to
correct how we were handling the change attr.  After going over RFC8881
section 10.4.3 a few times, I think the existing code in this respect is
actually correct. We advance the change attr in the inode on every
CB_GETATTR, which follows the guidance in the spec.

The rest of the series is more or less the same as the last one.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v4:
- get attrs from correct inode when issuing write deleg
- dropped some change attr handling patches that were incorrect
- only request FATTR4_CHANGE in CB_GETATTR if the file isn't modified
- Link to v3: https://lore.kernel.org/r/20240829-delstid-v3-0-271c60806c5d@kernel.org

Changes in v3:
- fix includes in nfs4xdr_gen.c
- drop ATTR_CTIME_DLG flag (just use ATTR_DELEG instead)
- proper handling for SETATTR (maybe? Outstanding q about stateid here)
- incorporate Neil's patches for handling non-delegation leases
- always return times from CB_GETATTR instead of from local vfs_getattr
- fix potential races vs. mgtimes by moving ctime handling into VFS layer
- Link to v2: https://lore.kernel.org/r/20240826-delstid-v2-0-e8ab5c0e39cc@kernel.org

Changes in v2:
- rebase onto Chuck's lkxdrgen branch, and reworked how autogenerated
  code is included
- declare nfsd_open_arguments as a global, so it doesn't have to be
  set up on the stack each time
- delegated timestamp support has been added
- Link to v1: https://lore.kernel.org/r/20240816-delstid-v1-0-c221c3dc14cd@kernel.org

---
Jeff Layton (11):
      nfsd: fix initial getattr on write delegation
      nfsd: drop the ncf_cb_bmap field
      nfsd: don't request change attr in CB_GETATTR once file is modified
      nfsd: drop the nfsd4_fattr_args "size" field
      nfsd: have nfsd4_deleg_getattr_conflict pass back write deleg pointer
      nfs_common: make include/linux/nfs4.h include generated nfs4.h
      nfsd: add support for FATTR4_OPEN_ARGUMENTS
      nfsd: implement OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION
      fs: handle delegated timestamps in setattr_copy_mgtime
      nfsd: add support for delegated timestamps
      nfsd: handle delegated timestamps in SETATTR

 fs/attr.c                 |  28 +++++---
 fs/inode.c                |  74 ++++++++++++++++++++++
 fs/nfsd/Makefile          |   2 +-
 fs/nfsd/nfs4callback.c    |  50 +++++++++++++--
 fs/nfsd/nfs4proc.c        |  29 ++++++++-
 fs/nfsd/nfs4state.c       | 158 ++++++++++++++++++++++++++++++++++++++--------
 fs/nfsd/nfs4xdr.c         | 108 +++++++++++++++++++++++++++----
 fs/nfsd/nfsd.h            |   5 +-
 fs/nfsd/state.h           |   6 +-
 fs/nfsd/xdr4cb.h          |  10 ++-
 include/linux/fs.h        |   2 +
 include/linux/nfs4.h      |   7 +-
 include/linux/nfs_xdr.h   |   5 --
 include/linux/time64.h    |   5 ++
 include/uapi/linux/nfs4.h |   7 +-
 15 files changed, 416 insertions(+), 80 deletions(-)
---
base-commit: 5cd183a621de1d76daeb58379d7a2c2f8dc1143f
change-id: 20240815-delstid-93290691ad11

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>



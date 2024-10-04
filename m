Return-Path: <linux-fsdevel+bounces-30982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1584F9903B9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 15:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79706B21768
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 13:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D856321019F;
	Fri,  4 Oct 2024 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I54AeIML"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D687156872;
	Fri,  4 Oct 2024 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728047888; cv=none; b=gYhu4H+2oK+CPK6C8d1BQsWuRMfZu3PfK7z9LKnXAGZDFRxZx1qdPVtoT6JyDx/qE5SW/osMyFsI0AR7eyxLbyY30r4n+DvW7sr+DDBwmaYhjuFHcW+oxdiIjFT5SBR7KuEOGceHabrq7txLfLtv/tBY2jEPS24TWKgdqSZCzsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728047888; c=relaxed/simple;
	bh=zk0sqIY5OluLPKYhsiNWMSMyFrgQ2eX7jUxEqlfe/00=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JZ8OTDWe2nCfIVr+Zv9X1R8pEC4NMpad59wevBegLViNzGXjxqW+NVsyZRaTEh98zrJwyRAwLz8/PMoDUPpqBYq7wWpCqCRwg5/8GM3uf+hdY2eTJgGFXvSr1+YkeRQJgdq7ykSZwJdXwV3A75J0j0MiLqmvUVhcudKNmaxPzfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I54AeIML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A001BC4CEC6;
	Fri,  4 Oct 2024 13:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728047888;
	bh=zk0sqIY5OluLPKYhsiNWMSMyFrgQ2eX7jUxEqlfe/00=;
	h=From:Subject:Date:To:Cc:From;
	b=I54AeIMLwY4rHMWwlf2hbrmzGuKIS6gRoz1qdltR+GDrgZo4MQAG7XNpkJifOqsrd
	 j5vN4lZthbf2/EyH6ldmo8+A8fJF+3y/BHxJLCdqqszP3G0dOv35ZvZx3R+JR09ugW
	 0vLIDLzIlKLJ5w2cmmnAyxFUBImOZvX3wtN3PpoFkwcJF99/1LZZh0g995MBFDXDGh
	 ESIzd4hfxI9IlZWoo9uBffwjS8lRoA3qxzsHIgsGU5qMh61h5DezUUu2ouB3d49ABe
	 nstVFTnziaH+g9htWSkpBUlZE4PCF79rS928ysWsnmX+2YydgbR7Wj+pB60vBriqHC
	 TFwFUtfh5oUTA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v4 0/9] nfsd: implement the "delstid" draft
Date: Fri, 04 Oct 2024 09:16:43 -0400
Message-Id: <20241004-delstid-v4-0-62ac29c49c2e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALvq/2YC/2XNQQ6CMBCF4auYrq3pTAGpK+9hXOB0hEYCpiWNh
 nB3C4mKcfkm/f6OIrB3HMRhMwrP0QXXd2lk242gpupqls6mLVBhpkrIpeU2DM5Ko9GowkBlAUR
 6ffd8dY+ldDqn3bgw9P65hCPM13ej+DQiSCUJEUhbgozs8ca+43bX+1rMkYgriCuICXJZXXJSr
 A3RH9RraL5QJ4h7oEKVqqD898dpml4y4gBEEQEAAA==
X-Change-ID: 20240815-delstid-93290691ad11
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Tom Haynes <loghyr@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3756; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=zk0sqIY5OluLPKYhsiNWMSMyFrgQ2eX7jUxEqlfe/00=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/+sIzwnRwYfzvWyffxIFQXm1qWIlg+0eKFMEb
 WBZGf4I3q6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv/rCAAKCRAADmhBGVaC
 FSRlEACtHuVd9Fi3i2SoVuDu5l8v9VmqPn9rEUCP/AOxN5rEKsA2N2ZLXIknrvJQuh9FClYGlPY
 yya00Nt0y09ZX00Zg1o0I189Nb6TsIiWFH8msAucDbaDdJvPTj0InY7S2TBlwISPW54ZJxPtGy9
 rmEcVNssDPnADiRI9zxlnIddy/IteQYnpp0AWzuHiK2JsNPpnUQmQpeOUnfY4vJZdcZYuHeRgcL
 GbV6CoXWyrGP2kdDq6D30cXEKLo4AOQjHjTRvUP6TaeKjaFpvmxhnKrI8no8P57m2VnRglgIipd
 lApkl3b98omlJqLr/Rh7scmPw8jjjBRYl98ACxCkqb4mebmxHunLRi+tWetiCAZWrC2CEOhxdEa
 MZjGQfxYvxK5Ha/zlb8kLGN2+8PBvG9S3dJDxY43SeDYrsbG0cJEae8AAl21I/J+GDjZSM5+G81
 SZXMhh9vcwZTuE6PjjtDf9LSCOzMsuBnorEFg1TuGyHqMuUA34ll7nojbjtYHQCpotlTM3vkfYG
 xA7zfI8ffIf8EcdaY0vJltlrgI9sY/pJEkUI5/ERs9feyel1wmxePqq2TLNx1gE8PcG3ZO/9nc7
 Mo//TCBY0sl5IJfP+DhRXgMWr6YCRBrv/OLeArpwApWaJ4JSKVm7ouKoV6MYFEZPrNhoMSMIMSD
 GojLlfp9BMz8jtQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

We had to pull this series from v6.11 due to a report of a fs_mark file
creation performance regression from the kernel test robot [1]. I tried to
reproduce this and couldn't. I've asked Oliver to see if this is still
reproducible there but haven't heard back yet.

During this, we realized that not handing out an updated open stateid
when there is an existing one is problematic [2], so this also fixes the
server to only respect WANT_OPEN_XOR_DELEGATION if the open stateid
is brand new.

At this point, I think we ought to put this in nfsd-next again and see
whether this peformance regression manifests again. If it does, it's not
clear whether this is a client or server problem, since enabling that
support affects how the client behaves as well.

[1]: https://lore.kernel.org/linux-nfs/202409161645.d44bced5-oliver.sang@intel.com/
[2]: https://mailarchive.ietf.org/arch/msg/nfsv4/3TPw2DEVAv3oe7_D8mxkoFl57h4/

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v4:
- rebase onto Chuck's latest xdrgen patches
- ignore WANT_OPEN_XOR_DELEGATION flag if there is an extant open stateid
- consolidate patches that fix handling of delegated change attr
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
Jeff Layton (9):
      nfsd: drop the ncf_cb_bmap field
      nfsd: drop the nfsd4_fattr_args "size" field
      nfsd: have nfsd4_deleg_getattr_conflict pass back write deleg pointer
      nfsd: fix handling of delegated change attr in CB_GETATTR
      nfs_common: make include/linux/nfs4.h include generated nfs4_1.h
      nfsd: add support for FATTR4_OPEN_ARGUMENTS
      nfsd: implement OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION
      nfsd: add support for delegated timestamps
      nfsd: handle delegated timestamps in SETATTR

 Documentation/sunrpc/xdr/nfs4_1.x    | 166 ++++++++++++++++++++++++
 fs/nfsd/Makefile                     |  17 ++-
 fs/nfsd/nfs4callback.c               |  51 +++++++-
 fs/nfsd/nfs4proc.c                   |  29 ++++-
 fs/nfsd/nfs4state.c                  | 132 ++++++++++++++++---
 fs/nfsd/nfs4xdr.c                    | 119 ++++++++++++++---
 fs/nfsd/nfs4xdr_gen.c                | 239 +++++++++++++++++++++++++++++++++++
 fs/nfsd/nfs4xdr_gen.h                |  25 ++++
 fs/nfsd/nfsd.h                       |   5 +-
 fs/nfsd/state.h                      |   6 +-
 fs/nfsd/xdr4cb.h                     |  10 +-
 include/linux/nfs4.h                 |   7 +-
 include/linux/nfs_xdr.h              |   5 -
 include/linux/sunrpc/xdrgen/nfs4_1.h | 124 ++++++++++++++++++
 include/linux/time64.h               |   5 +
 include/uapi/linux/nfs4.h            |   7 +-
 16 files changed, 881 insertions(+), 66 deletions(-)
---
base-commit: 5653776cd85de4823ec954ec5830909e073dacce
change-id: 20240815-delstid-93290691ad11

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>



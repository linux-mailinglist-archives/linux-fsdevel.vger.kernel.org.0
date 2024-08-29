Return-Path: <linux-fsdevel+bounces-27831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F6C96466A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB0B1F228F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569781AAE1E;
	Thu, 29 Aug 2024 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dukqpTLw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB92D446D1;
	Thu, 29 Aug 2024 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938010; cv=none; b=WvD5KUPM13GLL+uBhRQggvfuXvOqU2RGt1lUForAMI72NUO6ZShdarjZPBUPTpk6OilrB7nD9oFGh5sJ1Z1ggxDN/OsUA+yZsBAVHpttS2F+VRjAgHxpDvqC09KQzFrSHWpfZh/ExoLVbRmI8rtL5Wwone/iMIAAq9O+4KtiA1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938010; c=relaxed/simple;
	bh=+mHl9ArgxM2tIFp0DloJtxCG50oMRZe3Ta3hKO0rY6o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NJnXXtj3YWI2WzTa/Lj3Aa4TV8jeMFZKAMz8OEmOLJQ6yHNTCuikQzvAR8op9Xz/mjQGq5Mj2Ot4idFiH+Kw/Wxi3FPxxCswd9jHhQOUEw2XYEOPEJStf/rkHm91ibxzzauK/grv4RvLSCDZDlUbDwviB9cPzfPNJJ2E8GbRcbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dukqpTLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0034C4CEC1;
	Thu, 29 Aug 2024 13:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724938010;
	bh=+mHl9ArgxM2tIFp0DloJtxCG50oMRZe3Ta3hKO0rY6o=;
	h=From:Subject:Date:To:Cc:From;
	b=dukqpTLwxypLzpR03ubtrJ2JSZfTTvjxkzqs26GWfSwGtxRXfo2HHBaMPgHKeTH8p
	 oZK3I3LO+3q9cJbYnxCY+wa+Ymley+XmtbnPGdcLkpwEpDgkvnjRcdxfvnTCviTCPZ
	 V8adp0hgm9YItl+ufj/c1yXhlOvBqmptgTezO8uBkNaUpz9KMAFslV2Rmpm+7p+49D
	 2uPO0QMvFeKrzdZw8O5XT+q7i8QM38tyjrw8MeqPy5XdHfoSMq/huAqQTfrXKCwUKo
	 OW7lYLlv4unvINmW2h6cBbPCjB7Jn9L6MPzxdf0qe0u/4/jClaAm0tooPT6mIVDhwj
	 i6j4dTADyq3jQ==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 00/13] nfsd: implement the "delstid" draft
Date: Thu, 29 Aug 2024 09:26:38 -0400
Message-Id: <20240829-delstid-v3-0-271c60806c5d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA530GYC/1WMQQ6CMBBFr0K6tqYzBUJdeQ/jok5HaCRgWtJoC
 He3kGhw+X7+e7OIHDxHcSpmETj56Mchgz4Ugjo7tCy9yyxQYakaqKTjPk7eSaPRqNqAdQAiv5+
 B7/61lS7XzJ2P0xjeWzjBun4b9a+RQCpJiEDaEZTkzg8OA/fHMbRijSTcibgTMYvc2FtFirUh+
 hOXZfkARtoEV9gAAAA=
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
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3818; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=+mHl9ArgxM2tIFp0DloJtxCG50oMRZe3Ta3hKO0rY6o=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm0HcSS9PQ3BborrNALBRZf62j2hkBYPTAjow+R
 B3wUBfLluCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZtB3EgAKCRAADmhBGVaC
 FfZ0EACaFwp7Sr56f/PkvkhWpccCIzN8zgZyQqpMPKlE2ll/qZSB9tBXtUZEtcNMPoRkB437Nke
 FxTHayXGvj/mgV0wQHOaWQRUFYyOMYVMID4NdlnFgaivy9UrZxNCiWmTT1tpoReaV73rdJwcbE3
 iT8l3AMb/83E3NpJb/6jEdNHGQKJNQZ8P2r1S50rxMJYtyJpHl0rhU4+iv3IHD3uqFYawwqe7+X
 6BhuKhBmY605BrFGCmjjai1YN0F8moC4oQjTtoNSxNFj/t5creW8Z2oN8CpAFd346EJAUFrUs/o
 A9KZlejrmorYd9DfXmnjRxmLboEPOWy5/HdRxKSUEzFc0Z6BNujg4hcpUgjSV6DPbdsxg8RHd3T
 RlEvG23n9PfVG6A3HXErMYrBHq/f9wKnZJxeIfTG9GHCJfwihp562vpZfnqqat63rnEh/vepGs+
 qEE++TXU776BV9CC9VaeyEmvpKA+2U3C/Uj1n2beJ/KRSJV2XjHFGe/pt70YVI5ZgExwD/0PBiy
 YQzaQPoBrxnFjxPWeoskSaFDUnFbfLyF4OnunNiXFQyPgi1KcE8fmtR/4L0a5SuNUCmWYRzr9Yf
 Mchf4WOteaWGF6hQDoLOSxxDUcOVBpEV8NgBZ0H6HXrQdcA4p+dEn6k1lMZJNSK/KWrPkFmAL6k
 tK+osl/Iaac0lHA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The first couple of patches are prep patches from Neil, with some small
cleanups. The first patch should probably go to mainline for v6.11
since it fixes a bug.

The OPEN_ARGUMENTS and OPEN_XOR_DELEG patches are pretty straightforward
and have survived some local testing. The delegated timestamp patches
took a few tries to get right, but seem to work. That part is hard to
test since it requires 2 clients. It would be nice to have pynfs tests
for that.

The main question I have about this series is the change to make nfs4.h
include the autogenerated headers. Does anyone have issues with that?
I'd especially appreciate feedback on the basic scheme from Chuck, Trond
and Anna.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
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
      nfsd: drop the ncf_cb_bmap field
      nfsd: drop the nfsd4_fattr_args "size" field
      nfsd: have nfsd4_deleg_getattr_conflict pass back write deleg pointer
      nfsd: add pragma public to delegated timestamp types
      nfsd: fix reported change attr on a write delegation
      nfs_common: make nfs4.h include generated nfs4_1.h
      nfsd: add support for FATTR4_OPEN_ARGUMENTS
      nfsd: implement OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION
      fs: handle delegated timestamps in setattr_copy_mgtime
      nfsd: add support for delegated timestamps
      nfsd: handle delegated timestamps in SETATTR

NeilBrown (2):
      nfsd: fix nfsd4_deleg_getattr_conflict in presence of third party lease
      nfsd: untangle code in nfsd4_deleg_getattr_conflict()

 {fs/nfsd => Documentation/sunrpc/xdr}/nfs4_1.x     |   2 +
 MAINTAINERS                                        |   1 +
 fs/attr.c                                          |  28 ++-
 fs/inode.c                                         |  74 +++++++
 fs/nfsd/Makefile                                   |   2 +-
 fs/nfsd/nfs4callback.c                             |  43 +++-
 fs/nfsd/nfs4proc.c                                 |  29 ++-
 fs/nfsd/nfs4state.c                                | 241 ++++++++++++++-------
 fs/nfsd/nfs4xdr.c                                  | 117 ++++++++--
 fs/nfsd/nfs4xdr_gen.c                              |  12 +-
 fs/nfsd/nfsd.h                                     |   5 +-
 fs/nfsd/state.h                                    |   6 +-
 fs/nfsd/xdr4cb.h                                   |  10 +-
 include/linux/fs.h                                 |   2 +
 include/linux/nfs4.h                               |   7 +-
 include/linux/nfs_xdr.h                            |   5 -
 .../linux/sunrpc/xdrgen/nfs4_1.h                   |  14 +-
 include/linux/time64.h                             |   5 +
 include/uapi/linux/nfs4.h                          |   7 +-
 19 files changed, 469 insertions(+), 141 deletions(-)
---
base-commit: 30e4927dc0506504ddbfed51698bc5f37b17343a
change-id: 20240815-delstid-93290691ad11

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>



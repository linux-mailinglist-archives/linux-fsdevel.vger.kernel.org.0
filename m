Return-Path: <linux-fsdevel+bounces-27163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E22A95F1D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 14:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333AE1C22766
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5558E19412F;
	Mon, 26 Aug 2024 12:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ps9uclU9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CCE17C990;
	Mon, 26 Aug 2024 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676397; cv=none; b=QmluDQH011bZLCVHDFcKm8QEJYWzu74ZFC3FuQmNwK7jX9f/22Uo9EwHIIhwUJuUuUsXLyHg2vjyDVY0+RhBdefE5yc71b2TrVo7GFVECBUAhMt/XqY9mSWRq0XIEDDqiURy2hmb2d2z+Ugm2MLXQ1n3weiOo4BFJOD/oHevWJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676397; c=relaxed/simple;
	bh=Mqa5mLhpZY/ltSyNSZZhMBfJFukWo5ccxg5oGNVYVKs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HrJ3YQFVeIVnyvEE76cfblOg4g1AT/Qjtp8Rv8S/cEJ9LeFdAmdYcmgsord4BQoB6aYcj7sXKysCbt1kK4vDRRXjQeATLNzzDgE6CmXtYUVZjHOzWGAR8xxnllJ8zBnSAw7GsD31OQ63R3rXo5f+z4GD1gPmr3lfLD7dPn17EmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ps9uclU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7364C581A8;
	Mon, 26 Aug 2024 12:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724676397;
	bh=Mqa5mLhpZY/ltSyNSZZhMBfJFukWo5ccxg5oGNVYVKs=;
	h=From:Subject:Date:To:Cc:From;
	b=Ps9uclU9vmsyZRIuCMx9HeJBP1eF4frm1kuhfPPZ1IxtxVt9nnjT2IhsEq19cguZS
	 z6f+FGwT4lP1di7aHYi+K80lJCxRnXa6vVEdwKHEilIcKpZ+CTrFhl7dlf5VxpEi7c
	 TclzY5HPwAHrmIkJ4KI1be6ykI+kHGeNa0ynzfrgkiuYOeRNfp+UKPUSgpCCTbAcxO
	 /aHjxi3ja6EieBSZbNPwtgjQXYnOVrKbsB7cHC58PWJ9Vc4LCMEKKmgeszAT63IVOE
	 EoPYZRXbhgy+RIOCGuSGRXv/rivgsB94HyBOFJNXriO+EwopeUluHpMVj8WJ1llBF7
	 p7u+R7T5tK6mg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 0/7] nfsd: implement the "delstid" draft
Date: Mon, 26 Aug 2024 08:46:10 -0400
Message-Id: <20240826-delstid-v2-0-e8ab5c0e39cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABJ5zGYC/z3MQQrCMBCF4auUWRvJTGsxrryHdFGSsR0siSQlK
 CV3NxZ0+T8e3waJo3CCS7NB5CxJgq9BhwbsPPqJlbjaQJo6fcaTcrykVZwyLRndGxwdItT3M/J
 dXrt0G2rPktYQ3zuc8bv+jP5vZFRaWSK0rbPYWXd9cPS8HEOcYCilfAAUqwsInwAAAA==
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
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4176; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Mqa5mLhpZY/ltSyNSZZhMBfJFukWo5ccxg5oGNVYVKs=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmzHklNB/3H06JSbOJk7KWW01IPnZ3Ngolievad
 ZKp6iEEYB2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZsx5JQAKCRAADmhBGVaC
 FeqfD/9/LZnJu/iWR1fcTiBn4raT4I6PpMydkZ64EwU6NnAUGAz/14Cp1ja9MkUrT/M7+RoKkXv
 uHNkyiqHdYozP9mhZadUmy7rFhS/If6y8qVP78JjobU3ghzpvq9pgFBCGCrFErWDC02IYaKdGbV
 EOWuFo0CIIBhADLdnsD2/O9rH0GxvGwJJutog25GZN9AqzciSOzsOs/GZndWKCFaxnmztBYDY8n
 SdzyV/hCTinE3ANhB8aJrowKfnvZkjcJKF71kIeUxDRIZoO+gQnctagtLRfBFxgiq4PCTx6EELc
 OVW9eVhvrbn3GlpjKOMCV3f1QF/W4gXkvE5Tlyc9gnKifIA5yjxSqVnGTXPfybcGajMIeL/sCVe
 s/xqsx+Jg47166qsHhHnOwODivVqs84KjLv5MW4hpG/PG8Igiqeah7qpPK+NLxtysUseg7fsmdF
 rsfN9D18daTBBytJHBBDz2HohjmXuP1etBwl5kfTDyBhTjK5uPfD3DiIgfZt3XFzzjlLQ5j9v5U
 5kY2YnXQS1QDCXNrJomIJnlymuWHYXBDX7K2W6pmICV6EYXuYFmDtTdwUCNO5xEpNCsjnmmoPFN
 3wWzBhvOT88hRV4zWOsXDkrLVwGZE4czesL8l674F+glKSLfUHjf5fvg4SDOE1/2igzVac6HVNl
 LkseKZHxMrjs+8g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This adds support for most of the "delstid" draft:

    https://datatracker.ietf.org/doc/draft-ietf-nfsv4-delstid/06/

This includes a number of new features around the OPEN call:

- support for FATTR4_OPEN_ARGUMENTS: A new way for clients to discover
  what OPEN features the server supports at mount time.

- support for OPEN_XOR_DELEGATION: The server can send only a delegation
  stateid in response to an OPEN (avoiding the useless open stateid in
  that case).

- support for delegated timestamps: when the client holds a write
  delegation, it can send an updated atime and mtime in the CB_GETATTR
  response

FATTR4_OFFLINE is not implemented, since we don't have a way to
designate that under Linux. [1]

This patchset depends on a number of patchsets still in flight:
- the multigrain timestamp series [2] (in Christian's vfs.mgtime branch)
- the nfsd CB_GETATTR fixes [3][4] (in Chuck's nfsd-fixes branch)
- Chuck's xdrgen patches [5] (in Chuck's lkxdrgen branch)

If you want to test this functionality, you'll also need client-side
patches that went into v6.11-rc5 [6][7].

I should make special mention of patch #2, which starts integrating the
xdrgenerated header. That will affect both the client and server, so I
want to make sure everyone (Trond and Anna, in particular) is on board
with this scheme before we merge it.

For now, that patch just moves the header from where it was in Chuck's
tree, but it'd probably be better to add a new "make xdrgen" target for
that, long term.

[1]: We could add a STATX_ATTR_OFFLINE flag for this, but the userland
     use-cases are not 100% clear to me.
[2]: https://lore.kernel.org/linux-fsdevel/20240715-mgtime-v6-0-48e5d34bd2ba@kernel.org/
[3]: https://lore.kernel.org/linux-nfs/Zsoe%2FD24xvLfKClT@tissot.1015granger.net/T/#t
[4]: https://lore.kernel.org/linux-nfs/ZsofUUJeB1wbONyi@tissot.1015granger.net/T/#t
[5]: https://lore.kernel.org/linux-nfs/20240820144600.189744-1-cel@kernel.org/T/#me0207d0b18c19ddbf1cf698acff7e591bb4b100c
[6]: https://lore.kernel.org/linux-nfs/20240815141841.29620-1-jlayton@kernel.org/
[7]: https://lore.kernel.org/linux-nfs/20240821-nfs-6-11-v2-1-44478efe1650@kernel.org/

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- rebase onto Chuck's lkxdrgen branch, and reworked how autogenerated
  code is included
- declare nfsd_open_arguments as a global, so it doesn't have to be
  set up on the stack each time
- delegated timestamp support has been added
- Link to v1: https://lore.kernel.org/r/20240816-delstid-v1-0-c221c3dc14cd@kernel.org

---
Jeff Layton (7):
      nfsd: add pragma public to delegated timestamp types
      nfs_common: make nfs4.h include generated nfs4_1.h
      nfsd: add support for FATTR4_OPEN_ARGUMENTS
      nfsd: implement OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION
      fs: add an ATTR_CTIME_DLG flag
      nfsd: drop the ncf_cb_bmap field
      nfsd: add support for delegated timestamps

 {fs/nfsd => Documentation/sunrpc/xdr}/nfs4_1.x     |   2 +
 fs/attr.c                                          |  10 +-
 fs/nfsd/Makefile                                   |   2 +-
 fs/nfsd/nfs4callback.c                             |  43 +++++++-
 fs/nfsd/nfs4state.c                                | 115 +++++++++++++++++++--
 fs/nfsd/nfs4xdr.c                                  |  53 +++++++++-
 fs/nfsd/nfs4xdr_gen.c                              |  12 +--
 fs/nfsd/nfsd.h                                     |   6 +-
 fs/nfsd/state.h                                    |   4 +-
 fs/nfsd/xdr4cb.h                                   |  10 +-
 include/linux/fs.h                                 |   1 +
 include/linux/nfs4.h                               |   7 +-
 include/linux/nfs_xdr.h                            |   5 -
 .../linux/sunrpc/xdrgen/nfs4_1.h                   |  14 ++-
 include/uapi/linux/nfs4.h                          |   7 +-
 15 files changed, 244 insertions(+), 47 deletions(-)
---
base-commit: 55f9aa30de14b6ec52940adeb4790c15247fed40
change-id: 20240815-delstid-93290691ad11

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>



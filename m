Return-Path: <linux-fsdevel+bounces-72621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10977CFE5F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 15:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0BFC5300E400
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 14:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98D232827A;
	Wed,  7 Jan 2026 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYLEvJyC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2C61DED42;
	Wed,  7 Jan 2026 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795632; cv=none; b=io1xBoFB5Q3d5U2Yl+DqsubRAnWafxlSPriUZZB1sym31dpJBp825IV9GVkRwuTcw7G9SiVUWMhxvUQDsi6CKtGkEyRMAxggCwrJ569Lwph5ZCQyZuVxu3vBpwkL7XIPJ31YEOfshfJuEpbhfU6kCn4aBAzhXgO4X783b4QmnyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795632; c=relaxed/simple;
	bh=01i4PcQIyZNEKL5dnGjZ3BeIzI5aRHisNJ+n2qZAaaI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Dbrtzk07VPBHX0tPrTsNHWUP5SF0bQlrlQtRGEJQwb7XSLEWxmsyRsVctk2RCbF5Y18glxS6zjzYDqoif0uxTonAeccbHAEqhSMu8GQOeCppduG8s+Q+jcqF1g+cLLLJxckAaKZR/tj0epFsSMmwCXsBVFYL7a+/vmRd4jrK5IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYLEvJyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C873AC4CEF7;
	Wed,  7 Jan 2026 14:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767795632;
	bh=01i4PcQIyZNEKL5dnGjZ3BeIzI5aRHisNJ+n2qZAaaI=;
	h=From:Subject:Date:To:Cc:From;
	b=rYLEvJyCyZAtJUnWrAjuM7ELo8ynjkvDesXkPEQHUU2+ZAFUtBeLcjGIHB4mzmedl
	 6Tuc8C6G+wPsAaIB+xb+1ndvwfGNY9d97n5/PTK+x8Tt6TcFEqKhuvSZOFbJnVxKfY
	 q+e/E7E7aWOpraV4AmrqRtZuYNLFqTF4DCg3vm93EeZvf+qao2oy160s8fx06W7562
	 oKiki+0bc8m+2Ix48DziKQcw2GHtVidmlVf7zqjpp0eWes/Z3KBC5I5Kv2n6x8VAtK
	 QSdlpGwSdJT3W0RSUiKs/zgJNOSDTUmDlG1f7lvgL0AH5AcD+J7h7npBg4OzUx+4Qn
	 YJckYxHiP8eIw==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/6] vfs: properly deny directory leases on filesystems
 with special lease handling
Date: Wed, 07 Jan 2026 09:20:08 -0500
Message-Id: <20260107-setlease-6-19-v1-0-85f034abcc57@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBvQRKOuEi3MphoICyciCO+et
 HyL/18QSkwCffVCopuFj1ig6wrC5uNKyHMxNKpxSqsWha6dvBA61B0aP7XezkYFq6E0Z6KFn/8
 3jDl/yHF0Jl8AAAA=
X-Change-ID: 20260107-setlease-6-19-3ab7a5d30c51
To: Christian Brauner <brauner@kernel.org>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Andreas Gruenbacher <agruenba@redhat.com>, Xiubo Li <xiubli@redhat.com>, 
 Ilya Dryomov <idryomov@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 NeilBrown <neil@brown.name>
Cc: Christoph Hellwig <hch@infradead.org>, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, gfs2@lists.linux.dev, 
 ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1845; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=01i4PcQIyZNEKL5dnGjZ3BeIzI5aRHisNJ+n2qZAaaI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpXmuifTbkqt+ZOrvgDQRwzfOoI08t58vlX62jN
 WYGuxH12bGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV5rogAKCRAADmhBGVaC
 FbVmD/9VkhtBy64WYZM/vE1bLRtTONQcJjUhRSw9Tneh6sbfwAd+eM5oqOPvGn0GHjhJ6CSNHus
 k7SJy68/c1G27gmxHO108IMZwMt8rEBqlxm8c9lagraQFBt57AAMGWEBGwtdi+P/AIXsNJe+0g4
 6f4tXPC77qc+M2+MbH+Iyku4WDT1u5XFkluyFymfw0tlY8EGgMfkU1rea2yIDaEr8mwtUi6QvF2
 RWnOtApZPcfhtJuGfVbiVU/RnXe3BvP2MrEgyvjgyXZm8uNyoH8LwwqiaQelzsyhCH1ESLz3tU5
 Jm9MzDYu7g3ZRsGS9BWxQ+NZ68fWzDVi0dUS89L+toWsXkbMKa5XN6DEwo/5w5vHGN8r9xQHGv5
 VxY3g/f4fuMY3BOzG5Ain+x6Civsd/Rcx95xm4rP0Y8pYMuuxL6qP0Fdimx+HyVfkK65emJlp/l
 NDxZ7klS+oHVegAp8z2EYKlguAvOCduo+nQ36z91gBsAyWrSOKnVl8EGN7uCwiO0ZwUtMnaNfaO
 n4wCVRl55B1l76zxjfCZKn/c0FLPL08SXz7gOvuwAo+XrizlwUfhk4wxLnbOJtrXBDCMRB6X40l
 R6PxnGnG7l65AYNss70s34L9b9JAxSZUM5axw4J2pIDM1FB/23UX0vlVbTnXKUNwUzAD7Cn+Nzv
 FmXYssKm9gwAYow==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Filesystems currently have to set the ->setlease() method explicitly in
order to deny attempts to set a lease or delegation. With the advent of
directory delegations, we now need to set ->setlease on the directory
file_operations for several filesystems to simple_nosetlease() to ensure
this.

This patchset does that. There should be no noticeable change in
behavior, other than fixing the support detection in xfstests, allowing
lease/delegation tests to be properly skipped on these filesystems.

It's probably simplest to merge these all at once via Christian's tree
if he's amenable, but Acks would be welcome. Ideally these would go in
for v6.19.

Long term, I think it would be best to change leases/delegations to be
an opt-in thing, such that leases are always denied by default if the
method isn't set. That's a larger patchset though as we'd need to audit
all of the file_operations that currently have ->setlease() as NULL.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (6):
      nfs: properly disallow delegation requests on directories
      smb/client: properly disallow delegations on directories
      9p: don't allow delegations to be set on directories
      gfs2: don't allow delegations to be set on directories
      ceph: don't allow delegations to be set on directories
      vboxsf: don't allow delegations to be set on directories

 fs/9p/vfs_dir.c        | 2 ++
 fs/ceph/dir.c          | 2 ++
 fs/gfs2/file.c         | 1 +
 fs/nfs/dir.c           | 1 +
 fs/nfs/nfs4file.c      | 2 --
 fs/smb/client/cifsfs.c | 4 +---
 fs/vboxsf/dir.c        | 1 +
 7 files changed, 8 insertions(+), 5 deletions(-)
---
base-commit: 7f98ab9da046865d57c102fd3ca9669a29845f67
change-id: 20260107-setlease-6-19-3ab7a5d30c51

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>



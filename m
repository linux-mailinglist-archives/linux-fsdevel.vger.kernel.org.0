Return-Path: <linux-fsdevel+bounces-73205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5583DD11A2D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 10:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C2BB300A7BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 09:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6951B27FB34;
	Mon, 12 Jan 2026 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+uagZVv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407162765FF;
	Mon, 12 Jan 2026 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768211730; cv=none; b=QHs9KmdbIVKwUqyggfgrxAeSgIpDzTpIZgdtPQxYIBHiuWia/rpWrQKP/A4FpNnoJ0LIV4w2l2e8okca0uVBdQfuDeE3IqME3zeARMlv/iVRVHfYbiImcAqdnWtDPmkX1wCssKW/7iOgwgJcqsEFTyDtfW8cRYXAkba55M2nRXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768211730; c=relaxed/simple;
	bh=4bp36ojJgGhKBVRhIAabYjFMdm3vSThXm3DLw3qOeSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/UUNovGW/GYrJYGvPInjKJzSlb7rS2bVo4tAnfHSPCSn6PXYahRmRojI6Emd+TDixM6ldDNOm/OD1Uj23MlkEpl0hevEbj03pNFF4L6+31YC6NJ2k9hSga4acMY6oc5z7dJTtFP/tLz3qhs2eTA74a9CD2Za1f7HJckjXgnFq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+uagZVv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D07CC116D0;
	Mon, 12 Jan 2026 09:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768211729;
	bh=4bp36ojJgGhKBVRhIAabYjFMdm3vSThXm3DLw3qOeSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P+uagZVv1NTzDK9BUp047oPdigp7J3OYYpHYXayqFRH3L3GmoGyPHGADksyvztoeW
	 lFS0BZv8qWGrz8SNg2e5mNq2UEjiCDQtf5OrcRervu37+hk5d8jDQEVz03q66w50De
	 17uWlIfBRsmxGD37PrZ4iLTkJRS1Cg4hma6vY8vzNO+mQOvZjkTP/HKPRyOYm2BT5j
	 nxZNMCGx3iSr+TVTTmjxXAf0JeiOSuuIEwB5x0hiStVarXggngpWxb4EGxNH8o4Lz3
	 cIndS7I20tBjKk8nUTkhqkPpp70mRLJkkrT3QQfYvNDvvSK+J6NnkuPFxVFDG+6EuP
	 cpOy7mlXHbHnw==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	v9fs@lists.linux.dev,
	gfs2@lists.linux.dev,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	NeilBrown <neil@brown.name>
Subject: Re: [PATCH 0/6] vfs: properly deny directory leases on filesystems with special lease handling
Date: Mon, 12 Jan 2026 10:55:13 +0100
Message-ID: <20260112-blicken-handtaschen-1d0c5e6adc55@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260107-setlease-6-19-v1-0-85f034abcc57@kernel.org>
References: <20260107-setlease-6-19-v1-0-85f034abcc57@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1944; i=brauner@kernel.org; h=from:subject:message-id; bh=4bp36ojJgGhKBVRhIAabYjFMdm3vSThXm3DLw3qOeSI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSmHOWwa43I+/yGw9zT57P/2g3aLKzrusvVPnkdMj7uv VLo4t2WjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIncWMbIcGTLk4lPV3nOFJuX GSC/uj5k/ifBFRpZcgc/Hrw69Uxc9x+Gf0ZVhVxVc6tZjWtmmRbcMW3reF/z5/5zp9oT1vH6E/Z 08QMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 07 Jan 2026 09:20:08 -0500, Jeff Layton wrote:
> Filesystems currently have to set the ->setlease() method explicitly in
> order to deny attempts to set a lease or delegation. With the advent of
> directory delegations, we now need to set ->setlease on the directory
> file_operations for several filesystems to simple_nosetlease() to ensure
> this.
> 
> This patchset does that. There should be no noticeable change in
> behavior, other than fixing the support detection in xfstests, allowing
> lease/delegation tests to be properly skipped on these filesystems.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/6] nfs: properly disallow delegation requests on directories
      https://git.kernel.org/vfs/vfs/c/10dcd5110678
[2/6] smb/client: properly disallow delegations on directories
      https://git.kernel.org/vfs/vfs/c/b9a9be4d3557
[3/6] 9p: don't allow delegations to be set on directories
      https://git.kernel.org/vfs/vfs/c/5d65a70bd043
[4/6] gfs2: don't allow delegations to be set on directories
      https://git.kernel.org/vfs/vfs/c/ce946c4fb98c
[5/6] ceph: don't allow delegations to be set on directories
      https://git.kernel.org/vfs/vfs/c/ffb321045b0f
[6/6] vboxsf: don't allow delegations to be set on directories
      https://git.kernel.org/vfs/vfs/c/8a5511eeaa5c


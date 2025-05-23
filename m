Return-Path: <linux-fsdevel+bounces-49748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8D3AC1EC8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 10:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DD4E7B019E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 08:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5078FA923;
	Fri, 23 May 2025 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcRl5Kfk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88592143748;
	Fri, 23 May 2025 08:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747989330; cv=none; b=ECG2GLzMGIYgI/0R4y4ASJo0c46ZY/d7NvsYRcQMVG8CjXlwG9vGqPWQKtQ7cPEVQe6q3zQ4nftoTyIa98jQuqOy5uiNlm6GtuiizoKmqpzDNaEOGOYdoiDp/t+yOJR1hld7UGsx65KOHPXEcTvM46DPhC+HZ+/MYJqTYNHfAB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747989330; c=relaxed/simple;
	bh=aaYZ1roJQALwLOCDStlA1iSIFgYsVkGtdj7Sg7WhRg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LNGbd0sJe6Jxm+7jeyQKc9YFcrztnYLp6BSPsAa3SQoAoVahZMdVJxPYlovXfs19iB8PrlkAsTT+LARL93sAV1k7Slr9s7J6d/3TnmL+SXup25Ssaz1SwB3ZJ8E6b99cKcfVi+WuuT7J8HTLmevBpEji4lbquH480xzPCBjIJsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcRl5Kfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2820AC4CEE9;
	Fri, 23 May 2025 08:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747989330;
	bh=aaYZ1roJQALwLOCDStlA1iSIFgYsVkGtdj7Sg7WhRg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XcRl5Kfk0LErS6d8DWAJDv0260N7QeO09U2nEFy+/POSGuCKNcjXuTRL0y6iQAms+
	 gufkd6wsGs2pwGAfTTTeqykAQJSG3C9QMqDlczk12XUK8b+gnUv39dzAs+z+h0L9KU
	 dFmNH9hN4SUxUnrSmfRCxsKQPdLr6cCcoy656aBC1W/wE/N9u+bAtp071aSh5VFXrz
	 WJtXbFOeZWq0QZdlLbFa8iWq98vVMUNbRD5mf5u12jUsRXe1g45rdOeEwXKTllwLpA
	 3PSQLEBw3ZwbknFRHyf2d/jwQlcLoLv/+KHFE3+7KsGGW2+zCXKKLsn6xXRMvWEl13
	 YalaMnrvpCNlg==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Steve French <sfrench@samba.org>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	netfs@lists.linux.dev,
	v9fs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix undifferentiation of DIO reads from unbuffered reads
Date: Fri, 23 May 2025 10:35:21 +0200
Message-ID: <20250523-audienz-brotkrumen-039bac60ea9c@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <3444961.1747987072@warthog.procyon.org.uk>
References: <3444961.1747987072@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1377; i=brauner@kernel.org; h=from:subject:message-id; bh=aaYZ1roJQALwLOCDStlA1iSIFgYsVkGtdj7Sg7WhRg0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQYGHu/SDHY357Z8Vnt0kvnnd5Pl3f7Mby3s230lQmyW iYw5/2CjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIks38vwT0H9fHuqkaemTEaT jfn5xW8rPt7zu6F+QEBTKqFnj+vLKQz/C9Xiw1OmmKf0fDXx/Lpto3rrw5Pspt38p9YeZml/+/0 cNwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 23 May 2025 08:57:52 +0100, David Howells wrote:
> On cifs, "DIO reads" (specified by O_DIRECT) need to be differentiated from
> "unbuffered reads" (specified by cache=none in the mount parameters).  The
> difference is flagged in the protocol and the server may behave
> differently: Windows Server will, for example, mandate that DIO reads are
> block aligned.
> 
> Fix this by adding a NETFS_UNBUFFERED_READ to differentiate this from
> NETFS_DIO_READ, parallelling the write differentiation that already exists.
> cifs will then do the right thing.
> 
> [...]

Applied to the vfs-6.16.netfs branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.netfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.netfs

[1/1] netfs: Fix undifferentiation of DIO reads from unbuffered reads
      https://git.kernel.org/vfs/vfs/c/db26d62d79e4


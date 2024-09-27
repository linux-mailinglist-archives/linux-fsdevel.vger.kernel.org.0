Return-Path: <linux-fsdevel+bounces-30227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AC9987FFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 10:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96C42829E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 08:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C8D1898F7;
	Fri, 27 Sep 2024 08:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaAIXMic"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A4F188CB7;
	Fri, 27 Sep 2024 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727424365; cv=none; b=qPCl7zYfDTxdMNqYt5TiXbxOnhNiU1leP+L5ANK9L0RnhVhpFIgZMM+0aBnuzO4KndZ4baX+B5d4Blz3agLsNofS6ywPaI8j10TSVtG7FZJlGSdE0ES3mE8c6yfqD3kAxYT3SxTa1xCxcxp7qJwDsFfZzy1NPxavpu4BQMnGxlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727424365; c=relaxed/simple;
	bh=KjsjOpufVwVtvtG9C4bCus2/XmKmDXOmFJWmSRq/BY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sVECCzO6ZT6P5v8TGkhZAg9Lv4sJKFjSsN6wTrxv98//XX39N3/DR6pvlNvDxzDea0KVrkjtrDZM+qDlf9hw0F1HXCXjOWVh2JfEVbu6YNLZJjEf5KmUNs93NwGgLiy+pzb2+v1gzNm9x9eBcUIEJrgsQpfkJ1fcJ0RObzps/iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaAIXMic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8945C4CEC4;
	Fri, 27 Sep 2024 08:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727424364;
	bh=KjsjOpufVwVtvtG9C4bCus2/XmKmDXOmFJWmSRq/BY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HaAIXMict1VrTe7i8TwVZ5W3EQ/WTegi8/OHOEkwPr173UnrLezn4mPejbmDGj2Va
	 JzClZWAAEFXfx5vFVFkjx+3Bkn30tc+SssdrENLR5FslHOsVouXCdLzMO+adoH9tnc
	 zkXNylEWRwKw5LUIOdH0peE5GHb2oq7StB/T/R1ZqX2rjLg3gyt73TQdT9CGlK1e1y
	 +0R1PmoplUYpYy45bYv/DHBqbVebHLvqJ+Zj3yrLJO2EGsPMgBdMR6uK6DZ+/mXWG2
	 BnuUyJDVL64zGvygjtGlvBwmLB3O/DZn15DHVuse1YXw/gPPN/DLf8Erpw19GuMUJ6
	 BIWbB7FwYdy7Q==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Markus Suvanto <markus.suvanto@gmail.com>,
	Steve French <sfrench@samba.org>,
	Marc Dionne <marc.dionne@auristor.com>
Subject: Re: (subset) [PATCH 5/8] afs: Fix possible infinite loop with unresponsive servers
Date: Fri, 27 Sep 2024 10:05:44 +0200
Message-ID: <20240927-raunt-gekrochen-aa4fd2c2e59b@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240923150756.902363-6-dhowells@redhat.com>
References: <20240923150756.902363-1-dhowells@redhat.com> <20240923150756.902363-6-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1319; i=brauner@kernel.org; h=from:subject:message-id; bh=KjsjOpufVwVtvtG9C4bCus2/XmKmDXOmFJWmSRq/BY0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR9S0+55/AnN86X/6qh8Jnw2/fN3txs/vdb88Csxor51 h0HFWpKOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbCv4SR4f4hM23PS4ZOM4SW /uIJzdp91vHK3XmrQzc7J2s8lPYT0GT4Z2t0NERa9/mHUpZlb9KM7mza0TV9pafR+8KMuYvUDR4 GMAEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 23 Sep 2024 16:07:49 +0100, David Howells wrote:
> A return code of 0 from afs_wait_for_one_fs_probe is an indication
> that the endpoint state attached to the operation is stale and has
> been superseded.  In that case the iteration needs to be restarted
> so that the newer probe result state gets used.
> 
> Failure to do so can result in an tight infinite loop around the
> iterate_address label, where all addresses are thought to be responsive
> and have been tried, with nothing to refresh the endpoint state.
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

[5/8] afs: Fix possible infinite loop with unresponsive servers
      https://git.kernel.org/vfs/vfs/c/6e45740867ee


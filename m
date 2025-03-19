Return-Path: <linux-fsdevel+bounces-44429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45994A6876A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 10:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A8DB7A756D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 09:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CEE2517AE;
	Wed, 19 Mar 2025 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8EMGTVC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA107E1;
	Wed, 19 Mar 2025 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742375121; cv=none; b=jeAVRkwdn/j6Vl9SPOTpZygT2HgzPEDErGMsCN4Vjk4wVq85skSmkLx+4ca89nZGoWOFOryLL95kgP0sAb5oUgcj3IWf0xQan+qmv04xjKiF4raocJ9HQri5z3RTmrZJCkh6mtT/gsUwYIBpAXOMiwqaLcpdtBOaRactqG87sfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742375121; c=relaxed/simple;
	bh=bXnZjD1d8BpnpSDGZ7PXRYoYUW3sSnyhUDxMEY8RcMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AB3QChx5kPlHuKrrPrhcAonDohryQvaDV9AuLZn3NxO4OVBjMp9mgc2MWHH7iZycpcopZLn07X/rZQarYpOrNI21Cm3j3O3kZfeDQp28kCPAQGiPVDsc/gES6IWHG+2oVdJAvvnoIblthFsMGs2fwK4ggHeztJeOd0g26RryUVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8EMGTVC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8005FC4CEE9;
	Wed, 19 Mar 2025 09:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742375121;
	bh=bXnZjD1d8BpnpSDGZ7PXRYoYUW3sSnyhUDxMEY8RcMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U8EMGTVCsGmA9E/Y5ffsQX1MF8qRe7eL8phI40mmyONzvr7y+0BbZmEiDT7101YMQ
	 f8rqbAKl8zvKKIeeiNogKW7QLtDELJIXxGXpNYiiC0FGBOR2nRzgaHYD2Q4xlcatWG
	 c4/BbTx1YKxbtdVZlwy/yAlKlx74V1NEiDTReGKrS9GFZUQjpyUFWjrLHDVV+fqiTr
	 qEAc/BhEQgEYH5xspvF29NvbHZfC6CkLHPYg5MiXb2lkf/MsExQi+yjFkTcYsY1hd3
	 ARxKhcB85BL/kKB8egQYAJLcPjF06lGeB2xiZt5smlDP/2e2VnyYIcwK74USB/x1Hf
	 ajyZH01AMWVsg==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Max Kellermann <max.kellermann@ionos.com>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] netfs: Miscellaneous fixes
Date: Wed, 19 Mar 2025 10:04:58 +0100
Message-ID: <20250319-umgerechnet-adrenalin-25ba75043ee2@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250314164201.1993231-1-dhowells@redhat.com>
References: <20250314164201.1993231-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1441; i=brauner@kernel.org; h=from:subject:message-id; bh=bXnZjD1d8BpnpSDGZ7PXRYoYUW3sSnyhUDxMEY8RcMo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTf6jg5u6tQLtg+4ozetYraLxLM83bNvJgvYnO2pKikX lsp2n1DRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwET4uBkZWmZZWedKHNcUlF8+ /RRHV5tzwtcfD35ufbytQ8zdXZx7EsN/t3Sh1UxXxMQC3upNt7999V6OTXRN+hTj9PMnHkXsZef mBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 14 Mar 2025 16:41:55 +0000, David Howells wrote:
> Here are some miscellaneous fixes and changes for netfslib, if you could
> pull them:
> 
>  (1) Fix the collection of results during a pause in transmission.
> 
>  (2) Call ->invalidate_cache() only if provided.
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

[1/4] netfs: Fix collection of results during pause when collection offloaded
      https://git.kernel.org/vfs/vfs/c/f298e3765528
[2/4] netfs: Call `invalidate_cache` only if implemented
      https://git.kernel.org/vfs/vfs/c/344b7ef248f4
[3/4] netfs: Fix rolling_buffer_load_from_ra() to not clear mark bits
      https://git.kernel.org/vfs/vfs/c/15e9aaf9fc49
[4/4] netfs: Fix netfs_unbuffered_read() to return ssize_t rather than int
      https://git.kernel.org/vfs/vfs/c/07c574eb53d4


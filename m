Return-Path: <linux-fsdevel+bounces-49496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE3AABD6EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 13:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B672F4A036A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 11:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E23127B50C;
	Tue, 20 May 2025 11:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaTkhuZS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13C01CAA6E;
	Tue, 20 May 2025 11:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747740865; cv=none; b=eGiYyY54LQAE2yUixQIamJF2KnlUmoZyeVw/DRbaEmsFcQa8sV3eKU+tztiePti0QBbauGeeYbqf9dJ66mwojFJ/uNiocl67q/TWkDTzOKIkfmjcUR5a3Ra2KwNJAVGKQV+N8hxcZ9kTR8Hi7RwCkW5Zk3xogUbQlk+Fq70fe2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747740865; c=relaxed/simple;
	bh=inUwVojIjuaaR/waOD+9jgxuZtOW6VGmFPF1U3mZQho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yjo8c4qq87a+KmKfENySHho8N+Q5bMikvPhIWTxq1JabH0IHEND2uXybKXTAQ6GFWPYanHvB28LDLkgNSqoJTT2s2UEKPFwtD3ICmlYg36967FsDOdIARrNIH94S3GjEhylxHMKZmw01+NQiTr4Nm3AkqtQdDdmo47S8vl9yfuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaTkhuZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997E2C4CEEB;
	Tue, 20 May 2025 11:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747740865;
	bh=inUwVojIjuaaR/waOD+9jgxuZtOW6VGmFPF1U3mZQho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aaTkhuZSB/VGl0THmklOnEs/u31dbRa8IL0K3B8GYNVYUIbcJ6ZseKNMQ/9Zb/53p
	 1iGH/Y4SNy4C72N2ckVrQ+qXLPDYirKLGGX7lWeZJIGwsci46j7AJlFfeAgV6fPq3q
	 7ljb9q0BqPzD6UG1fWgRRrObefiE4RR0NUwpwoSygNWB3sIFEl5lV/ghjUgtsL1PTE
	 mPkI5Nm3Va/6rmsjBUdqIdx4ZNesigxFxZrHvPHmg2n3fl5KlsdwZ8Kfw/dO12OqId
	 H2vmjr//R8gNYRZyEXyzhiQ9t5s2zrjcowrZq+f97uxAliMJioMAo76D4miD5rHCMc
	 xNRwkJmoT2rsA==
From: Christian Brauner <brauner@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] netfs: Miscellaneous fixes
Date: Tue, 20 May 2025 13:34:14 +0200
Message-ID: <20250520-aufnimmt-abgemacht-9b1ddff0e6af@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250519090707.2848510-1-dhowells@redhat.com>
References: <20250519090707.2848510-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1470; i=brauner@kernel.org; h=from:subject:message-id; bh=inUwVojIjuaaR/waOD+9jgxuZtOW6VGmFPF1U3mZQho=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWToZOyqfCYUVsH8OenSk2WP2NI2s+jltz9Im/CCYdvfV d5mcS+iO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSxMrIcOa3rs5nf6PDhXpb c3fFhMn/8pD7yl44+/T0f+/9tx5blsTIcJLbwrDd2maBxbwvSSpGKy0cvzyed+h15ptXx/Zb209 czQQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 19 May 2025 10:07:00 +0100, David Howells wrote:
> Here are some miscellaneous fixes and changes for netfslib, if you could
> pull them:
> 
>  (1) Fix an oops in write-retry due to mis-resetting the I/O iterator.
> 
>  (2) Fix the recording of transferred bytes for short DIO reads.
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

[1/4] netfs: Fix oops in write-retry from mis-resetting the subreq iterator
      https://git.kernel.org/vfs/vfs/c/cd084c7184ce
[2/4] netfs: Fix setting of transferred bytes with short DIO reads
      https://git.kernel.org/vfs/vfs/c/2973904c9b79
[3/4] netfs: Fix the request's work item to not require a ref
      https://git.kernel.org/vfs/vfs/c/537b296114cc
[4/4] netfs: Fix wait/wake to be consistent about the waitqueue used
      https://git.kernel.org/vfs/vfs/c/2a6d0284a4a3


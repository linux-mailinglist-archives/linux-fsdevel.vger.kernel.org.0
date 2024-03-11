Return-Path: <linux-fsdevel+bounces-14129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE82C87809D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 14:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6201C209E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 13:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CFB3FBB2;
	Mon, 11 Mar 2024 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAYxTOtj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3793FBA0
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710163694; cv=none; b=XU3flT1HK0fchg8SwJIBvt8yeJuvDlH6cO0QB/CHFkrP864ubsmwv30MSnTLI9mHsW6815ONZM8O9b/l7zWH8OMyPOARhSrcSuSfKgcSBIkEqJVzrrTFv2WiVTkQ2G+e1PMudU79OXEDAgTiAfn0QDdI2QQKrdOW3aX81za3a6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710163694; c=relaxed/simple;
	bh=S69p+l2pZV/hlWQEMdu73NY17nbWs6YF8Tgw7ygTWv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R2QwbwCbztrT5aYnJGRAxjoPteg60Lg8pR9mNdCCpjGqOJoNVC7tM71Z42p/bmFIULjH1/iuOh1IRVopnbThS6pXiZUlKje6ROrPjk2UmwOZ4fGIcazrY8nGfJN9eROOn7sey4rhfWX6LOXO+iFAoZ4HJXt5B1cenLhhrAx9w94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAYxTOtj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E30C43390;
	Mon, 11 Mar 2024 13:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710163694;
	bh=S69p+l2pZV/hlWQEMdu73NY17nbWs6YF8Tgw7ygTWv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TAYxTOtjHu8C34cxmWEza1VW2mFQykZgde3xnF3LDCeVUgBFstSMNQR69E9Wf+OM/
	 blOATUMSauZ3XcdPHF753DZHbbJSC+XoCkPZljMuQRHcGQ47/6eJYOXPjTcq6J8rwN
	 fgwl3jmGNMO32SEbKFWKaKzRbdsiG7cLqwzmKpoaLxoJfLoIhzu2k3c94MEWYJEMWi
	 oB180U7F/yn05TYkMLrU0VknDGQe8CqwZS8DE8StSTNavjsk0F6/dSnwDzvdxsHdnN
	 4060RsfYutoYYNbNhS+fSrGUEnI9SYEazEWp2Ds8OyDu11JEPDdHkaOcep1dcISXFB
	 GZ0RNhupSfC7w==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Bill O'Donnell <bodonnel@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	sandeen@redhat.com
Subject: Re: [PATCH v2] minix: convert minix to use the new mount api
Date: Mon, 11 Mar 2024 14:28:03 +0100
Message-ID: <20240311-entdecken-beiwerk-074e38c3cea4@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240307163325.998723-1-bodonnel@redhat.com>
References: <20240307163325.998723-1-bodonnel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=952; i=brauner@kernel.org; h=from:subject:message-id; bh=S69p+l2pZV/hlWQEMdu73NY17nbWs6YF8Tgw7ygTWv0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS+Z3ueXbTC4dkSza371qtPuPrFjF/pz5OHjpXZm/+ef TVn8/sTtzpKWRjEuBhkxRRZHNpNwuWW81RsNsrUgJnDygQyhIGLUwAmkhXK8IfXav9s9zlfJ0m9 0ryWnvmk6VzGv+hbCudPTrVIrGMPrhNlZHi81GFVdElmS+D983s3f2/ZFCKxMVj8/Dy3+9ufay3 6+ZIRAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 07 Mar 2024 10:29:18 -0600, Bill O'Donnell wrote:
> Convert the minix filesystem to use the new mount API.
> 
> Tested using mount and remount on minix device.
> 
> 

Applied to the vfs.mount.api branch of the vfs/vfs.git tree.
Patches in the vfs.mount.api branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.mount.api

[1/1] minix: convert minix to use the new mount api
      https://git.kernel.org/vfs/vfs/c/f1e4cac59dc6


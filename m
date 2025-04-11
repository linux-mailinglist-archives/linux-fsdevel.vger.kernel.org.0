Return-Path: <linux-fsdevel+bounces-46267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 528D8A86034
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 16:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE2E188E3CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 14:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA53A1F3BAA;
	Fri, 11 Apr 2025 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jh3XHA50"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4340B73176;
	Fri, 11 Apr 2025 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380678; cv=none; b=WV+0UL/thZu497l0Tq5w3hgWbzSzdsGxA4eF/ZjJy5i8aHYjsdEp3DjMfJVJWfc4ouoIcQCy0fcVE7EWiSO7TqcjVainmGidLhWqzyzYvoibGGakaK7qGktWxy8BMu1E2uDYVOPFOyCOx5UpKVp1WSsZKHf3rBUuaBdGLxFmGyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380678; c=relaxed/simple;
	bh=utYbBrYPoRUDvsbORVJKE/czl807hlT3LrLfbDGlSa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TugM4W85hCfHP4sLpXJlThiDBQ3LoX0AF3ftrxN6gEk7ITkX0UBbjsSdtHL1WWdjrej6UPoK4AKlB48ydjzJ8h4PAhoEggbXhA9CPjCUo3SB64bEQg2Ff3CXj4rTDxrfDgnmHc2cb+rHjGMiAO+z9JiooMen/LYkpCu2i4d3Fq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jh3XHA50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26543C4CEE2;
	Fri, 11 Apr 2025 14:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744380678;
	bh=utYbBrYPoRUDvsbORVJKE/czl807hlT3LrLfbDGlSa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jh3XHA50/lDICnVreaMYYiyo8FsZpvMcKDkfworAzN4DqOTXlqbDO5Y2uPTbUiijQ
	 SEGPdnIQGsmDWs+YlzWSqN9W+tPjW3zSkJTxHyT+guqnOxVALno9U/+H1tKlniByHV
	 4xFZxd0TP23uABdrn5UFWV35DPUj9RN4DsG3dKsE+qFfc5rgV/vOAP4vjQTRtxdYnN
	 BxuPQJ0V2X2qEgy9GbUp24sE8HAejNEtFtH2pXOzRGM9kKZaeD3/NrJKdKVRuZrWuK
	 CWw1BvRgKZqF+M377cHSbzk7rTsoXl68KgAmhUDhuYTPjyfIbyPAk5KYC/x/HcvXCt
	 nJsYzSlCWhFxw==
From: Christian Brauner <brauner@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH RFC] fs/fs_context: Use KERN_INFO for infof()|info_plog()|infofc()
Date: Fri, 11 Apr 2025 16:11:05 +0200
Message-ID: <20250411-addition-preis-020bf25053e4@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250410-rfc_fix_fs-v1-1-406e13b3608e@quicinc.com>
References: <20250410-rfc_fix_fs-v1-1-406e13b3608e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=967; i=brauner@kernel.org; h=from:subject:message-id; bh=utYbBrYPoRUDvsbORVJKE/czl807hlT3LrLfbDGlSa0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/VGZo8b4kuu9/iJJXTP3cMK/9iy6rP1B/6s7VcXrXD ulIi3lzOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYiLcnwP5nhrqCn9T0r5d05 LJ2/jaRZ5Jt2XwxhU//ZarBP8lehKiPDblZ+Y41TFbf2Hk0vYNmuf+1ppf7yjwf32T2/cy/k8+V KNgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 10 Apr 2025 19:53:03 +0800, Zijun Hu wrote:
> Use KERN_INFO instead of default KERN_NOTICE for
> infof()|info_plog()|infofc() to printk informational messages.
> 
> 

Applied to the vfs-6.16.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.misc

[1/1] fs/fs_context: Use KERN_INFO for infof()|info_plog()|infofc()
      https://git.kernel.org/vfs/vfs/c/916148d24d77


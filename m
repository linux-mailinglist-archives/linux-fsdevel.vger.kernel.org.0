Return-Path: <linux-fsdevel+bounces-44023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DC9A60F4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 11:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26461B62B0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 10:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E641FCFDA;
	Fri, 14 Mar 2025 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwCSIds0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16F21779AE;
	Fri, 14 Mar 2025 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741949339; cv=none; b=XnTAlj2gJPbcnQ01Sp0Gc6X3kDEGlw+39nE887o/Ep3P8XCTP/J4HEECXceKsX4/rNwrLzJu3vbzGuYFWxpm4QBLC5TsmD7Xqef3kbh9GcHQE/42YaraSgMCn89OFwSsm+Rg7lpKckwXjC34bJ7ACbUAJsgQdtdofrHiSWPmF0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741949339; c=relaxed/simple;
	bh=JOk+dEIMoSjVo3h/2SUUZvXP2LmkSz9zYVu9tCFFN6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o0Ift+9PP0uiKffdH0mVXD+mIa+dQ/1MY4o6juhBekPLKgUfT7XJ4edruu7XpH/uc0XQlWLPsVLHaxdkwI1haytLGBoqzCUwtYCjOpMQSlfRVTJQ/0NKddjJwkrv8anp7ut3sc23zI9Z9bWaQ/RiplkN6wLuuGxUKKvj4hGCsYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwCSIds0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF573C4CEE3;
	Fri, 14 Mar 2025 10:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741949339;
	bh=JOk+dEIMoSjVo3h/2SUUZvXP2LmkSz9zYVu9tCFFN6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cwCSIds0hgEEksiBn6lWyQW+siayQ6WFS4K3dIH+xyqVYyybCIY36ghaoIuf9kpJU
	 F8ubrxRN/Ftse8pw1FbeeR7d/goBH4uUaoCktLul4tSML5eWhecb+jmvxbsuAfsR9s
	 ZR+0qomCHAmK7hFkkbYZDZVS5sltKe+1yKrQbXY3oDThJQsCvq6pVp4gP+b6qBX1H3
	 q6rtJcmrAGGTfJGWDWKx8O6l4u2IFfoNf3++SbIhkvAL3egxwp9g+7dtQ5IYs/suCE
	 cFPL+Rr7iyzeCAnGWKkUB2nNrubv3ylxYr2gBTf3LgSJvU/skTdgi9qmaqfUbNSDJJ
	 /+ypp/3csbjFg==
From: Christian Brauner <brauner@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Ruiwu Chen <rwchen404@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] drop_caches: Allow re-enabling message after disabling
Date: Fri, 14 Mar 2025 11:48:43 +0100
Message-ID: <20250314-tilgen-dissident-05705fca5e00@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313-jag-drop_caches_msg-v1-1-c2e4e7874b72@kernel.org>
References: <20250313-jag-drop_caches_msg-v1-1-c2e4e7874b72@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1162; i=brauner@kernel.org; h=from:subject:message-id; bh=JOk+dEIMoSjVo3h/2SUUZvXP2LmkSz9zYVu9tCFFN6c=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRf4ZzaOPU2x+U06zXiBzyjQg2q1qxwnOR6fKVH0lnGS KfF7KXHOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACay2ZeRobVD7KRR/JdD3ZJc jK9kPvo+23mvtyD8wROp7V58O27NSWL4yaijKDfP9+gprdiPaXsWnGpPvaKlx7VR7WjEhu0vsnw C+AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 13 Mar 2025 16:46:36 +0100, Joel Granados wrote:
> After writing "4" to /proc/sys/vm/drop_caches there was no way to
> re-enable the drop_caches kernel message. By removing the "or" logic for
> the stfu variable in drop_cache_sysctl_handler, it is now possible to
> toggle the message on and off by setting the 4th bit in
> /proc/sys/vm/drop_caches.
> 
> 
> [...]

Applied to the vfs-6.15.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.misc

[1/1] drop_caches: Allow re-enabling message after disabling
      https://git.kernel.org/vfs/vfs/c/66c4cbae77e2


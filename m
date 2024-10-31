Return-Path: <linux-fsdevel+bounces-33341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E579B7A3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 13:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739EA1C21C69
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 12:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7BA19B3DD;
	Thu, 31 Oct 2024 12:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glHh6Ihs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94621BC20
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730376369; cv=none; b=nsRry5mIahdXjtjAwt3GUbtCAG17qQBrZJ94pke/sZ9jcSFOvNFcfDuxPugKNyKdFkwQ17fF1Fw0V5VUcSToJLgmEPRzPvGLL0I5taULNalgyQgQ5oPmuk+BmKqoiTeRtQ08mry76qM7KI7Ol8Nc4TJs7g8o3ATF3bi/3WK3G7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730376369; c=relaxed/simple;
	bh=vyN8krpSONVdqVq9MHCuKX0WybNPWRVAc+4ewwQruxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SlViHXOfRyt69ZEcDdzdutxft61UOFS5qG8OqYgKyYjjRvXSXwddZwlMoetWv/bp3hibVeeLvsbEq9sgx4dZNCeuJBeVCeFsMtV1Y5F2Kw5bSQREPH0ZtZDtdHmaOgKxqcQIPdHRD13XOcL01l8n3D+1Il9fdiJcwtA9qASvREc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glHh6Ihs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CB5C4DE0E;
	Thu, 31 Oct 2024 12:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730376369;
	bh=vyN8krpSONVdqVq9MHCuKX0WybNPWRVAc+4ewwQruxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=glHh6IhsrVU/PwXp6gQngSLU/JQCtJ6vrccCpTJ3Em1slgPVkIexDbeWEJRjXIObb
	 wtyBy32tRJxwzHLbJSL3l7ilb9z1w4BA15T8ShWnrOn3PyjCY6Rng9uD67NwNCx1rK
	 oPVF6TbeErzgAfla0WhoejBSSYjqBosVOHrdiwN14QKjvDwH0Ksg9DxD6M+xJNZwr5
	 6fzAeF1cx8FG86pvUU2p2i3N9zkl3vCjO1C9il+o486fhXkdwVHr1RPVC7lH2uk7JC
	 w3GMQtVinFAy2OV1VWYuRvLKuLi5IITtbHxEbY3P7Jdv7g0B3fhu+t5c8jlBaQk6DA
	 cMGD46eW1zYIQ==
From: Christian Brauner <brauner@kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] initramfs: avoid filename buffer overrun
Date: Thu, 31 Oct 2024 13:05:55 +0100
Message-ID: <20241031-liedchen-plenarsaal-63d3831b335f@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241030035509.20194-2-ddiss@suse.de>
References: <20241030035509.20194-2-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292; i=brauner@kernel.org; h=from:subject:message-id; bh=vyN8krpSONVdqVq9MHCuKX0WybNPWRVAc+4ewwQruxk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQrF61+J6b15HTQQtuu5C/c7JznhGVPzkn5Jih0N0P6z KZJSvbdHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOxNmT4H9biln/EbN0jF8W1 ggw2rt5N7876fxXnevXYkuu4jfSTE4wMex/1303+9vn6G/lHBf7zbKQOxO0R2BE268TCPHfJuHd /+QE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 30 Oct 2024 03:55:10 +0000, David Disseldorp wrote:
> The initramfs filename field is defined in
> Documentation/driver-api/early-userspace/buffer-format.rst as:
> 
>  37 cpio_file := ALGN(4) + cpio_header + filename + "\0" + ALGN(4) + data
> ...
>  55 ============= ================== =========================
>  56 Field name    Field size         Meaning
>  57 ============= ================== =========================
> ...
>  70 c_namesize    8 bytes            Length of filename, including final \0
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] initramfs: avoid filename buffer overrun
      https://git.kernel.org/vfs/vfs/c/e017671f534d


Return-Path: <linux-fsdevel+bounces-44445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2870CA68D70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 14:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE66E3B0A78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 13:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD6F2561B6;
	Wed, 19 Mar 2025 13:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZzwQrDA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D902D254AFC;
	Wed, 19 Mar 2025 13:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742389818; cv=none; b=IS2WxuXQtf4U0wqZie7l7GkRvEkeADyoL7DRz4ayd1qEEQTh9I3eGAo7GkpOyNoIaT2XHcNm+UQabJfhVQvVY2tbP3LABOq+RncYD/UGG0emYltlAwDWdhrDCrYaE10TtT71zh663I3eF31KTauvknLagBeWwIHm9gtyZ7jjJ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742389818; c=relaxed/simple;
	bh=1acjoPdq3APWoUJFvyURxB9csh9fWJcNR4vyB3gYHQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=juMX0Og1o9CAZWk7iPD7KiRu8Nvjthh5j7pYtS6EdCVcnC4dXZerzBZVa7h5rNWDvobQTd6sZBOVok+41Zl8zLWXXBmaMh2eREjMpWjHTRMW8ZyXrz+28kwXVZHtfCAeHqTweg9QLnrUqWCjfNcoc/Pxs/t1+Ta8Zf17rjwPFGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZzwQrDA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA0AC4CEE9;
	Wed, 19 Mar 2025 13:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742389817;
	bh=1acjoPdq3APWoUJFvyURxB9csh9fWJcNR4vyB3gYHQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rZzwQrDA79sMsXcMGNIelNRH7KP18HvKYV2h6DWg8VPAUI43GmWQIm9m3KukeTXL+
	 LXMMMvx+fXj5UI+bGO2aBiaUY7QHmRHqQk9lYU7IqPhJIPiBdy/nhI9pIDFP9qt6K1
	 bzdSLSqQtK5iT6PKemnljv5iF8shsxj0zf4mC023WPb/OhuVyYZHyOsSufiKMVbZ7n
	 OaMVLNhaJLrP/YuUVnsV2rx0GuMh34koT/Qg2y4Sn/h5BceU7QvEoFhYcTXI+ISeWh
	 1gUbUWQJcySPHcEE+T0ORFbIsmqzaI+1ZWKjklKmqkIt3bPWHRs853XZ26J0MhXamb
	 NNYuXMS++DG/g==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: predict not reaching the limit in alloc_empty_file()
Date: Wed, 19 Mar 2025 14:10:10 +0100
Message-ID: <20250319-eierkuchen-entworfen-46cef225a298@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250319124923.1838719-1-mjguzik@gmail.com>
References: <20250319124923.1838719-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1174; i=brauner@kernel.org; h=from:subject:message-id; bh=1acjoPdq3APWoUJFvyURxB9csh9fWJcNR4vyB3gYHQ0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTfOmRycKPZZYugk68kD/As5HDd1vj4UZuSbGxri1r2p xcLNbhUO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaiz8LIsER8Q9+//2U3dbI1 57VdNSwQM51aLOc730ZrffDuBZs0fjH8T2xcUaH59sbKXWvnff5YcipWizP+ZdwJvj/rTH3dT4W V8QIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 19 Mar 2025 13:49:23 +0100, Mateusz Guzik wrote:
> Eliminates a jump over a call to capable() in the common case.
> 
> By default the limit is not even set, in which case the check can't even
> fail to begin with. It remains unset at least on Debian and Ubuntu.
> For this cases this can probably become a static branch instead.
> 
> In the meantime tidy it up.
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

[1/1] fs: predict not reaching the limit in alloc_empty_file()
      https://git.kernel.org/vfs/vfs/c/9ae7e5a1cd17


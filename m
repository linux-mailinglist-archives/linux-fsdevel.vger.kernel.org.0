Return-Path: <linux-fsdevel+bounces-66142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 775FCC17DE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E084265DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2622DC78F;
	Wed, 29 Oct 2025 01:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beC2hefu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FFA17A310;
	Wed, 29 Oct 2025 01:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700889; cv=none; b=SM4QGJLQgdlk+ATHzj4ZDXTQyCCSTzz5NxyY3g5X5jk4a6kNPf/loHD4P5w/qg9axres/5+nHutBbGB6VofpoNDI0HjHuGkCPad1nN8WbjKIymaVwCA6dSwNw6bBSH9I+ACsQCsIhdRKvSE6aWIgL36IuyWPhhjOaHmlAcdNR8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700889; c=relaxed/simple;
	bh=ZT7VHykUE9fHgQIgd7r8OqmbBY0Ngy6nPm9moquinYU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fV5vn1dvfN5wU5RYAJ0WXHstCUvyHk6n35yfOCZWi79LKCyOOewDZx28cqwrTAVQX2WjrkBEVl+9NjsjswZQGZQvxx3an6GRDDxxJYu3KWN6z+GvXaRz/sRF4B/tZ2mgnyht26T3a4dHfH3B2M1JFliGkH9HRS+PstSyiPomFbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beC2hefu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE584C4CEE7;
	Wed, 29 Oct 2025 01:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700889;
	bh=ZT7VHykUE9fHgQIgd7r8OqmbBY0Ngy6nPm9moquinYU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=beC2hefuL3Bze+Vog/oEevdOe8oVzTiJoOnQSbyaNoW0yJ1YZ4vbbSX7PoAiJf35D
	 JQ5rlEX6P3OT5u2GVgBGtTougqw4kLFSJ38tAqD+DsSmooKzBL3Z2nHBvPU/GmRx8R
	 GPi7SSRU18l43xJirdpxVVxT7UV0s9Bu2NVkW/KQcdkke4XOxGMf7v+05dZP7f2LtY
	 T4Ae5fjjPwy1ez7X88Tm0xqvF0XnGqbC3P86PHKlUEPlnBdggqbnB6DV6jamJurQ87
	 KaWxOEOiAZB+ULiaT5ts35oVObkoVymJZSin9SFnmD39Rmo1MioG72Bcxsh3aktHju
	 v/J12nt2VlQoQ==
Date: Tue, 28 Oct 2025 18:21:28 -0700
Subject: [PATCH 04/33] common/rc: skip test if swapon doesn't work
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820051.1433624.4158113392739761085.stgit@frogsfrogsfrogs>
In-Reply-To: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

In _require_scratch_swapfile, skip the test if swapon fails for whatever
reason, just like all the other filesystems.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 common/rc |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/common/rc b/common/rc
index 18d11e2c5cad3a..98609cb6e7a058 100644
--- a/common/rc
+++ b/common/rc
@@ -3278,7 +3278,7 @@ _require_scratch_swapfile()
 				_notrun "swapfiles are not supported"
 			else
 				_scratch_unmount
-				_fail "swapon failed for $FSTYP"
+				_notrun "swapon failed for $FSTYP"
 			fi
 		fi
 		;;



Return-Path: <linux-fsdevel+bounces-70634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC92CA2E41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 10:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C36C3091A05
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 09:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759F5333727;
	Thu,  4 Dec 2025 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giWTfCRN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF5531329D;
	Thu,  4 Dec 2025 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764838943; cv=none; b=SKo3pQknqNGD0d+o7BkmyEVnsZ0x9+iphHQ9aE1vx43DfqwI+43E+GX5tdbMeLg0aI0DT5DbDHzFC7nyPgiZP+SVIixNvMJ6Pl1lRHbp31YvQ9zu5uq/RUa3wv1d/J8JKCFD+Eo7v7H/7++rWij4C9TVatCcHPBbNAhoRLInr5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764838943; c=relaxed/simple;
	bh=tlijTN0WqVPKyE8pAOoAFPBzxnjWCiVy/N6C14hSgGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KtQ+1ci2rWl2wlz75w2FwNY41ZJJrR3OJqS8uB3hv5y4gmL+OKcyAPx429HG0VuAZZJD4wrMZTolcFJI+4jLb6+Ii2toFUtEUdBzOAnYf/Fb+AXJaKFKYT5fWOKwrNmK3BmfW0uGoj07pJvACrUWGFHvX8YgXWBzL0deIwn0Pfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giWTfCRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4917DC4CEFB;
	Thu,  4 Dec 2025 09:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764838943;
	bh=tlijTN0WqVPKyE8pAOoAFPBzxnjWCiVy/N6C14hSgGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=giWTfCRNw3OXIrYyH6ZBuYfuUBwLl5Q2dxgIZ6Sf2QelZvfpIEPyeTXgsb7YCajuZ
	 xBNOaI8X+FJyWsCsN9+c46Bczuf7GnMHBV9/QfaQuhQ/Uen3yjcwNGtn9G6S7dgHO2
	 Bya7eDNN2WsUjUctomo3fkGLnIPKYSF2TDb8//TMg1YAEsnY/wXKV22yGetCW5DXXy
	 AdXpqE0Wxz+Dh0xwzKPkvRjszDY0OIUN2zQhXtn2Pny9W3M8pB9m3Ta6GRdmE+qbQG
	 OBk8B8YtlMsSWKNjFJgnYDZcU8QlU6O9+9CpO74l7UOvUWPYpijTtNAavm3kBx+eK9
	 k5RN4SO9Av9dA==
From: Christian Brauner <brauner@kernel.org>
To: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] vfs: use UAPI types for new struct delegation definition
Date: Thu,  4 Dec 2025 10:02:05 +0100
Message-ID: <20251204-haargenau-hauen-6d778614c295@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251203-uapi-fcntl-v1-1-490c67bf3425@linutronix.de>
References: <20251203-uapi-fcntl-v1-1-490c67bf3425@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057; i=brauner@kernel.org; h=from:subject:message-id; bh=tlijTN0WqVPKyE8pAOoAFPBzxnjWCiVy/N6C14hSgGc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQa+onUSrd+i07ncKrbymywf0rXy2l+DsfPs3Dbv2D6U h/+8nJcRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwE02Yvjv/mjC3yAPE83TNswT +myMO9f4HFx67aeN4Jq3GxkcvONzGf4psnu0sX5dcX5T5e4ZGRn9poeqSnV4eLhf+/SkR8w6p8c GAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 03 Dec 2025 14:57:57 +0100, Thomas Weißschuh wrote:
> Using libc types and headers from the UAPI headers is problematic as it
> introduces a dependency on a full C toolchain.
> 
> Use the fixed-width integer types provided by the UAPI headers instead.
> 
> 

Applied to the vfs-6.20.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.20.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.20.misc

[1/1] vfs: use UAPI types for new struct delegation definition
      https://git.kernel.org/vfs/vfs/c/b496744de0d0


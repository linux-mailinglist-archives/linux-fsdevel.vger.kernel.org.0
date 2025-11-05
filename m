Return-Path: <linux-fsdevel+bounces-67101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1637C35585
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 12:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C52565167
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 11:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC45F30FC18;
	Wed,  5 Nov 2025 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9wA70+o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE6F30E0D2;
	Wed,  5 Nov 2025 11:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341664; cv=none; b=pwtujotaGSOqu1n/bUiGEQapnRfmOj/j0mUeh3h4NT2SynfyMypHIYb+q77d19z5d4GrsJ90S4/Xm1GwBcXW4mgjXZl89A5by9P5Yf3y1Ka1CS4cSC2m4NL3yUXUUjd2c6m7oTAwBi0K+JxhlSzzPL27oKXva7wVVzWQccGe8ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341664; c=relaxed/simple;
	bh=CAwYmkeOieQkv+szkWs9PYf5w7cmslTwZe5LoVeS/0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PNZN3sIOk7hTMhAFWVj3kYUWOF41o+EE+Ta508RyMgVG53gi+obTSTV2+TkJ2lfRAeyFjlscPQ0pm+WyvWSzf7UkIwPyPIBkBgoLKULDRdduubil/vQ7mr2qrqsty77mhPSE3ALi7feH2fIPrFtJy/zXahZjtUQc2c3nJkDFmC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9wA70+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9EBC4CEFB;
	Wed,  5 Nov 2025 11:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762341662;
	bh=CAwYmkeOieQkv+szkWs9PYf5w7cmslTwZe5LoVeS/0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u9wA70+orkIQDWnEfQjnFGJqn1hbDsX5tU4EqoIf0YxGnAtjV8nsAzIH/L2jiQXU0
	 xp+s309fP+sCYai+heF2ZYCH1yjUrmsd1zPfohOwlkY0Ogb8lErcvq/cl3xOkg843c
	 mOIs1uDBWEPjcDYf1WTBeXoXa7vI+Bsk510fFyzayjvYkpWoHbweToqwX5GaU5WgFP
	 epWcYchtp0wDZUMu3g2Ly4R0gc2KnULfwXlmzeiosbaRllEpHhMhbZoZkZ3FsXngKe
	 WZPQEQeOVaqo4X7++sjheXKVMF6vHT/MDh1qZQlDytvrI/TJTAj0XxZrGmLWoBIYOV
	 9ZeiEaVAQDIjA==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: inline current_umask() and move it to fs_struct.h
Date: Wed,  5 Nov 2025 12:20:56 +0100
Message-ID: <20251105-strafen-campieren-852dab82e139@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251104170448.630414-1-mjguzik@gmail.com>
References: <20251104170448.630414-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=983; i=brauner@kernel.org; h=from:subject:message-id; bh=CAwYmkeOieQkv+szkWs9PYf5w7cmslTwZe5LoVeS/0Q=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyG0vmfp6s4cf63bdYuUjxE//K/VM5XJY+YDCY72D5Z 2nhs4DIjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIn0ujAyrAp9zW881evJQpEH AY+dfvT8zXkhN1P2g0vAkbPL7v49e4mRYb5P5x6zg8+27F/MXbAtfNLhxHd7QruY9j+WET27Pc1 OjQcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 04 Nov 2025 18:04:48 +0100, Mateusz Guzik wrote:
> There is no good reason to have this as a func call, other than avoiding
> the churn of adding fs_struct.h as needed.
> 
> 

Applied to the vfs-6.19.fs_header branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.fs_header branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.fs_header

[1/1] fs: inline current_umask() and move it to fs_struct.h
      https://git.kernel.org/vfs/vfs/c/1943722fbbe6


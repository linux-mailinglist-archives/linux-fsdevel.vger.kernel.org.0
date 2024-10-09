Return-Path: <linux-fsdevel+bounces-31451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7A7996E8D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 16:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E8571C2175E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 14:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A16F196455;
	Wed,  9 Oct 2024 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAiHaSiy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668407346D;
	Wed,  9 Oct 2024 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485218; cv=none; b=qudEh9tP1MCpw04n46dtiraM170yas34uIPIqNsnnu/Qn62YQ2dsI3T0M5yvJ8Q/3mNhqhojbOcCCM3BfkjIfZR4jSg5xsYQxOsRqGidzXrOVMfZHuKIBw7adSQwozL/lvHeqa2YXY8kDj9B4CCeXJIXeunrNcd7Ckfg1B3wpKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485218; c=relaxed/simple;
	bh=KZCqM5ViVz8c4Xl0XFB1buLYn1CJbT7DVnsOS5GRbl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ECAx3L63qP2dAn2I6PxrjGr8MRIsQRPmlianRqQtTOsva8zgU7bsezCZGXNNtaFdvx8yEZMnUrG+RU5gpBswzxxEQcVVYOCn0PuqFtJfALmvnrf+xk2zpM/MhzuNQmW+IZW/SAV9WKfEOUfUxrNZ+uOg05bu7ZHfpQjUl6Z2H1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAiHaSiy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145DDC4CEC3;
	Wed,  9 Oct 2024 14:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728485218;
	bh=KZCqM5ViVz8c4Xl0XFB1buLYn1CJbT7DVnsOS5GRbl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JAiHaSiyCo+jmMzFVIZa0N6fQnLoZHvHOpZt0gZJM/LjhbaHEs2QiQW83MVCQ0kLf
	 655O2ln7NVO2z4NMwc0kSYAfemH+Q+081g4JoRAz4TXkjXoW9sxyDEp1uqU23hjFpB
	 eWMw0QIoO82FrtEwbl0gtL8T8PvzeiwdD6y+hJ9eoOdtnCgBK7qxMfyMHXNYPCq+m5
	 MsUtjtZ1eUg15wXm5ZJ/bXkz/1mQ8JpqAUkanPUohR/YHOxx/UmchMliMlRTnKU1V7
	 jP0QcqDi3nuzUUfTiWT6GgSzOBs18VYOINhz+Yrv/vNhdVMMBe8e1ZeaxTQRmrTu5G
	 Y71zTXcSzR+fA==
From: Christian Brauner <brauner@kernel.org>
To: jack@suse.cz,
	hch@infradead.org,
	akpm@linux-foundation.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Cleanup some writeback codes
Date: Wed,  9 Oct 2024 16:46:48 +0200
Message-ID: <20241009-chancenreich-fenster-011642f7729e@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241009151728.300477-1-yizhou.tang@shopee.com>
References: <20241009151728.300477-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1150; i=brauner@kernel.org; h=from:subject:message-id; bh=KZCqM5ViVz8c4Xl0XFB1buLYn1CJbT7DVnsOS5GRbl0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSzTY9gm8nEtiTsd5/2YzuBZ/fbsraXbzr4XEfTc1e+6 6na7B31HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNpXc7IcPqASpveOo9VAleU Sh0lp507JX1oX/7ytu+eAZM8p8T9bmVk+FC37Jbldz5b4d7TVhInF+3J4Wq5sNBT98eX23bzeE5 NYwUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 09 Oct 2024 23:17:26 +0800, Tang Yizhou wrote:
> From: Tang Yizhou <yizhou.tang@shopee.com>
> 
> v3:
> PATCH #1: We haven't found an ideal name for BANDWIDTH_INTERVAL, so update
> the comment only.
> 
> Remove PATCH #3 about XFS.
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

[1/2] mm/page-writeback.c: Update comment for BANDWIDTH_INTERVAL
      https://git.kernel.org/vfs/vfs/c/d91c6efe8161
[2/2] mm/page-writeback.c: Fix comment of wb_domain_writeout_add()
      https://git.kernel.org/vfs/vfs/c/3cb5827bfa43


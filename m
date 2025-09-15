Return-Path: <linux-fsdevel+bounces-61374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2447BB57B7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3AEA203FEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24ADD30E0CE;
	Mon, 15 Sep 2025 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1ftWi6k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7256A307AF4;
	Mon, 15 Sep 2025 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940203; cv=none; b=SujbbonHYS+2fwEdlBDdHK0uzjCprqcJ40A4ICHBT31myYvv1RseEBrLHkYrhHHYpHcDphwfgppJcFMm8J1NoWNbzyGrgtQP64BpTFovu398/HfK7XgZjGm2jBoZHlTz/K3ap3vAoYogtECAwSNtQnUUYxRIgD69B6pTPLzpcXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940203; c=relaxed/simple;
	bh=EpR4L1+r0EbGqy6E24gn+GEiHfesttpKcPKjh4BguKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HMdLfF1tFAF0JzxPhAkuIwpcNyAGmT3XrAiWrzVuOp/MjnBvq8XS+HH/MKYxYcl/cYrD+hkgQLp7vaZ2LnOxD6tFejL6ZLUJAbzLkc+e/4dUfHK6OtKCPuHmRLeTPHJC0B84JSep5LaWOd5F/q5xduRw7SerBf/fJZmyY0kvLKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1ftWi6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E316C4CEF1;
	Mon, 15 Sep 2025 12:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757940203;
	bh=EpR4L1+r0EbGqy6E24gn+GEiHfesttpKcPKjh4BguKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M1ftWi6khfg1i7uUgLg6SIaQ5pbaEDwzohOTDKHiDpj/UJ+I5hbHrdu8zjg3gGJ3x
	 2Gc6m7LfuABywko10No84EbcJtLcyjgvoQ+3m5k2WXsw+G8Fl+C+I7NprbtCNKwC5B
	 CrEh/+/h6gV3moTWKtDX5QKe3lHIWldlp26eUEzebzNKmX8qv5PaVijzFH7aVD2y09
	 DXasaSWmEkYznM+AjX+JQ/++DIh78YKD0y01cRCxSk6TCWLSz6v6WkZmQLUcljeqYH
	 GoW1S8Tn0rb9PwUAyUxYL/CwDq4ocpM7sI4nCBlc/AK8JMqy1NXqQjXaL/7Wdv8CkZ
	 HiC0ACIX0vtLA==
From: Christian Brauner <brauner@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] initramfs: Use struct_size() helper to improve dir_add()
Date: Mon, 15 Sep 2025 14:43:13 +0200
Message-ID: <20250915-pilzbefall-fugen-08095f161708@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250912065256.1486112-3-thorsten.blum@linux.dev>
References: <20250912065256.1486112-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=969; i=brauner@kernel.org; h=from:subject:message-id; bh=EpR4L1+r0EbGqy6E24gn+GEiHfesttpKcPKjh4BguKA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSc4HwWeGdXalWP+M2DNlk9bHtWL/0bsfSKZ0vYzt3TJ mQv8P6s21HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAROydGhvani8+v7ntSO9P3 woaViUfynzxSlOn5ecn2X9tBjsh9EYYM/wvX1Ab1zkpObHHQv/HGpOWRfDc7q+19l+7GjWoOfkf 3MQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 12 Sep 2025 08:52:57 +0200, Thorsten Blum wrote:
> Use struct_size() to calculate the number of bytes to allocate for a new
> directory entry.  No functional changes.
> 
> 

Applied to the vfs-6.18.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.misc

[1/1] initramfs: Use struct_size() helper to improve dir_add()
      https://git.kernel.org/vfs/vfs/c/e60625e7ce10


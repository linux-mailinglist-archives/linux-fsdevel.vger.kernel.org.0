Return-Path: <linux-fsdevel+bounces-51455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C672AD7084
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 14:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C000D3A7A0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 12:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D497F22F16C;
	Thu, 12 Jun 2025 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muoewxoJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3300E26ADD;
	Thu, 12 Jun 2025 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749731617; cv=none; b=Lz13SIbDVju0sRWhmg3Mx6eHNE1CrCSCY+62TRZRTBMMz0bVWC38SuAXVhydtaJy7o7BIhVScu3GJxn0XTKhh6ZXHrQCxPWz0WbMF+XXvbIl3MM1Mgi4mjxYVfd+QqB4nvUXvaqeIctKAXMJzqnidwSpkFEXj+VYdHiDtFzHcAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749731617; c=relaxed/simple;
	bh=JGn1f3INBhXvJVWCD4krHYMnfnWE70gK4tzg9KrrWrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tYtJcoOuri7VGxWJI4qMSCxQFSW/+/FnQP91U92KPhgHkgj9oTsHZq5TFUDlZTDzex954Z9ApD0D8heLuJKKubCnVIjTo7WM0tZcoLhgXK05kaY8nwFkAXwJhbOSFVe2hpKoObtDlEOkSRNViC9fTih1R1RYXZ6f+8OIRJs6ysQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muoewxoJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325DCC4CEED;
	Thu, 12 Jun 2025 12:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749731615;
	bh=JGn1f3INBhXvJVWCD4krHYMnfnWE70gK4tzg9KrrWrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=muoewxoJqLW27Eaf12Vt4fcbP3MdN9kNANIwCDfUAcswz/Cz/ze78R4YkbDKHgxB8
	 7c2/9mn1D9Yw5nmnka+FncRcKr8uAlW5RadhvvO7msB8AwjdnVsUnFAkfns6+sHAXS
	 x6iTxPRFCvg9porI+CHUxiZD4awF4+cW6mos1w2kMbHgU9fCmlJ6r/n0cuVWJsv0Ww
	 kg13XBziNJHg8mIxD/EDZY6ygdWgKsFAUnLR14gI7MSEl+edX5D/6URTwUz4qVhppn
	 3QXuaFmBgbD3H7OjgvCK0UUuD25v6AGU5BnMbO0eJyQIci2VPvDx14wh8b8W0PS48P
	 uyIdfHTmlmI/w==
From: Christian Brauner <brauner@kernel.org>
To: Luis Henriques <luis@igalia.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: drop assert in file_seek_cur_needs_f_lock
Date: Thu, 12 Jun 2025 14:33:14 +0200
Message-ID: <20250612-dickdarm-wachsen-bd0814d01811@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250612094101.6003-1-luis@igalia.com>
References: <87tt4u4p4h.fsf@igalia.com> <20250612094101.6003-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1024; i=brauner@kernel.org; h=from:subject:message-id; bh=JGn1f3INBhXvJVWCD4krHYMnfnWE70gK4tzg9KrrWrQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR4nRR3/1jTn/f205GgozL6G7a+Mfl2vV+nOmjp3VUHm 9uddO9xd5SwMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykfCPDb9bu0yv9S7iqmvfc t1+cl7+vQpTtVLRx/J8Hl7fsmS0p95fhR38+a6ZwiYpfWqt0ywvlyb4S6qtinsxQzXhsXHHtMyM PAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 12 Jun 2025 10:41:01 +0100, Luis Henriques wrote:
> The assert in function file_seek_cur_needs_f_lock() can be triggered very
> easily because, as Jan Kara suggested, the file reference may get
> incremented after checking it with fdget_pos().
> 
> 

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] fs: drop assert in file_seek_cur_needs_f_lock
      https://git.kernel.org/vfs/vfs/c/ec86bba684b1


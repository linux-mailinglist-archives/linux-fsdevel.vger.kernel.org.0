Return-Path: <linux-fsdevel+bounces-50311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F80ACABC8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 11:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13FB117AFD1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 09:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DBF1531E1;
	Mon,  2 Jun 2025 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwlCEp3Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE657E0FF
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748857521; cv=none; b=iV4Wxl+SpEmdCssx1pnfeAsB6xn9H5HRIY76BzAFOgS0FgjcqOCPcpHM3gpj+3KseG6/B9CqU98BtprjKdQBC0EPXQnDAAdy40GLBmNO8sBw4eXynYQbGCehySsr+NzUAG2jUDo7BEPvvMazB3axfShw7iMazdwY0EcljklCrIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748857521; c=relaxed/simple;
	bh=NJJQks0WllsKLL7T3EcuS/tamvoyrOvsZ9eweXG9SH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DR2j32ipjFn++GiHIGnPWbY/o/jxMlHKhKP3Td/uaaNjuSR5UJNpUoL59Sj2stH8hGkguEgAkKse5OKwFiUuJaq3HTEIxyg63qSTSA3OtWPIIO6g9hYHATL10e1o0hkrv4FipXXRkwuN4gHvjvh095Tr5+XAkflHcW5wrRVCUTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwlCEp3Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4300C4CEEB;
	Mon,  2 Jun 2025 09:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748857520;
	bh=NJJQks0WllsKLL7T3EcuS/tamvoyrOvsZ9eweXG9SH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cwlCEp3YnQEIWh+J5kEbPLqxmcyLqRW+DdPLpGi56Diwx9yt8fiEHn/+hNHFC08cS
	 vdCe7bguwGuB+EdM7FWJq763x11fUfKgW0YZs1/l/Kx8dumRFjHveQkw2g5BwsI80Y
	 bSFRVgb+tPDkokrtxzA4nJFOizr0Bim6MPu2ZWdwVGt2TpjPR2dc+t9tDk0CK6+sj8
	 jNgdfu76hocqM978sL6CpviIT3LxRw4EMJkn5ZYDp+UPNhvl/fhxZ+AaGp/LwnW/RN
	 +M886IBTWQx37lizRcV+wiJXsKHeiAcHQwC10zwKrPHUVM+jH/xNC3S6kmhv3OBh5V
	 JF+oYTmiI4WjA==
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/pipe: set FMODE_NOWAIT in create_pipe_files()
Date: Mon,  2 Jun 2025 11:45:16 +0200
Message-ID: <20250602-ausziehen-aspekt-ba8b2233035e@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <1f0473f8-69f3-4eb1-aa77-3334c6a71d24@kernel.dk>
References: <1f0473f8-69f3-4eb1-aa77-3334c6a71d24@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1183; i=brauner@kernel.org; h=from:subject:message-id; bh=NJJQks0WllsKLL7T3EcuS/tamvoyrOvsZ9eweXG9SH0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTYFq35m/ilO7Tf+Y3MKx6R092VcwVmLeU/KRf/MHGHp 1647QanjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInI3GX4pyP951j0JYkLUTce TnuyKrM1hf++45mY43s4jieEX/T8e4Lhr/Dhg7qG3TdjdyrFVRfe3+KhKZmZ6HtkwimHeZkSjnM z+AE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 30 May 2025 05:25:35 -0600, Jens Axboe wrote:
> Rather than have the caller set the FMODE_NOWAIT flags for both output
> files, move it to create_pipe_files() where other f_mode flags are set
> anyway with stream_open(). With that, both __do_pipe_flags() and
> io_pipe() can remove the manual setting of the NOWAIT flags.
> 
> No intended functional changes, just a code cleanup.
> 
> [...]

Applied to the vfs-6.17.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.misc

[1/1] fs/pipe: set FMODE_NOWAIT in create_pipe_files()
      https://git.kernel.org/vfs/vfs/c/80c17f7374cf


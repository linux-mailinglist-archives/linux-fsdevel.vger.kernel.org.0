Return-Path: <linux-fsdevel+bounces-39131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB28AA10421
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 11:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE10F1689CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 10:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62A722963B;
	Tue, 14 Jan 2025 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1CLQOFD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC611D63DE;
	Tue, 14 Jan 2025 10:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736850634; cv=none; b=dqmiynZid8U8JjFetmof+6o/YQjRL9/SaTP6Ro76smpO8Cak6pSd9MRbzFhx3yKnDUTvn9pv9AyKHaQf45D4KvxVdLl9kp3dT69bZrlmJRUpNyEzSO6ZbdwTuuBCShLBcEcUsr/inr9micsXJZmJMB9fWSEAcI2njI94bruIIzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736850634; c=relaxed/simple;
	bh=xfe0lAPETPZ1MDXACK93w5zhd9JfVNZH2vFJEQiwFts=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M2pHae97vAk7YhSerpQSwBFT5k5/aFndqNz9VL2DSpX23uwOWHtJG0Bg9SG2ol2uXBuUOMRrr7ncTChQbGAu0ux5TaC8xXcgoivknbEtJtazcMTks3C3ghKgT8paMZI8hRW16N0gqLTLl3yZay6lCJR2YNlyGvZBokLJ0iQXddE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1CLQOFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39ECC4CEE0;
	Tue, 14 Jan 2025 10:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736850633;
	bh=xfe0lAPETPZ1MDXACK93w5zhd9JfVNZH2vFJEQiwFts=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=d1CLQOFDoFw3YViut1S7bQc5BdtxfeYBdwuV0vFZ5xMigSGx6KBVchLwWbiJIdPLf
	 YOx+vppHQsYr6XTai/+KQ6sjfLa6U54MGHWJZqpD2CLU0d/NF1JAu2aOGr/fv7QM2O
	 t6wLd48CgJzNn+uwduk121zVZBuVMHhKnng9R0FaPUEC2VlsAPqm+jpzGhsGSxjH79
	 wYsirTkNt9v3TEtoofWkUT0ad+R1zz0n3tU/uxW1jjg4Yo9oO9Ob7w8IRXNrFQSLcB
	 XfrCdVa3SFb8XHlvtjDVwas6Ze3UgAYXDmJnfnTdevrZn1EeFKXZVEiKaxm8wF/LBw
	 vXe0ZH+KDR2Kg==
From: Carlos Maiolino <cem@kernel.org>
To: brauner@kernel.org, djwong@kernel.org, Long Li <leo.lilong@huawei.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com
In-Reply-To: <20241209114241.3725722-4-leo.lilong@huawei.com>
References: <20241209114241.3725722-1-leo.lilong@huawei.com>
 <20241209114241.3725722-4-leo.lilong@huawei.com>
Subject: Re: [PATCH v6 3/3] xfs: clean up xfs_end_ioend() to reuse local
 variables
Message-Id: <173685063148.121209.6460263181808009123.b4-ty@kernel.org>
Date: Tue, 14 Jan 2025 11:30:31 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 09 Dec 2024 19:42:41 +0800, Long Li wrote:
> Use already initialized local variables 'offset' and 'size' instead
> of accessing ioend members directly in xfs_setfilesize() call.
> 
> This is just a code cleanup with no functional changes.
> 
> 

Applied to for-next, thanks!

[3/3] xfs: clean up xfs_end_ioend() to reuse local variables
      commit: 99fc33d16b2405cbc753fd30f93cd413d7d1b5fd

Best regards,
-- 
Carlos Maiolino <cem@kernel.org>



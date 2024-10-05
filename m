Return-Path: <linux-fsdevel+bounces-31045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8331B99137B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 02:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4309F2828AA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 00:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25965672;
	Sat,  5 Oct 2024 00:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cV5eoI6y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58547196;
	Sat,  5 Oct 2024 00:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728087774; cv=none; b=OtPFauln4UGIQcM0LDlt2wQPxg8FT43E0ciba+/A8f+EF6RZOSwnrcwGIK/imJRa04gXvdIiA/Lafb4K586oIgaKsFAHJOhD43XI/2ndvV7cMMJc9Gn/ue3C9CKuz5kNyYChh/CKGPg5P1LekdlRdS7kb5hRq6xRh3OFCyb1qBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728087774; c=relaxed/simple;
	bh=HJMZ6PnZCoTT1n9NH76YDRZ9HwK8UlBnG0DS9nj4p5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/AoXGa4apYdYgGGQIRDr4o8YAbmm+CmVBlkyWp7uc3mj1B5xoqQdwHkQzHRlUKhWqu1PtlUTrGoy3oiGivmXmG2+f2DgCjOtvip/wSLohY9mJ88D5pRrdrvMmWDgFIaYRcxSazzAEu0itKde/hUKFVy1stTb+pOwS8bpxcXZ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cV5eoI6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4D4C4CEC6;
	Sat,  5 Oct 2024 00:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728087773;
	bh=HJMZ6PnZCoTT1n9NH76YDRZ9HwK8UlBnG0DS9nj4p5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cV5eoI6yCYT+WisILZ4zH0tSjWDryYKEanlWryrvyvNsi5OseFkccxCuwlUdhWmcv
	 cY1UzTOj3CYuD1I2VmdX7t6fbUAkz8h9b20bGufUAY4ggjIwrOWtc7dKkKJ5XqFSMi
	 k5w9KznpMI/LAlWImgcNTs25uVLJ/OzTc/KhrLHFs4qWGZepd3VlAWx/qLcPSNnrOy
	 ex9v22GPUwskvjXcMjW8wH6fdIiUPEmS8OLOhu6a9YzEBVDl+tpY86RcT5Z/IfhbgI
	 7MhAA8geXkqkdAuoZtePxY1hdz3Gcnmm/h7GA6uY78a6X8FoKdFF9sGbFc2VnbV58p
	 lPToIz7dNIN3w==
Date: Fri, 4 Oct 2024 17:22:50 -0700
From: Kees Cook <kees@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/2] binfmt_elf: Wire up AT_HWCAP3 at AT_HWCAP4
Message-ID: <202410041721.0B633082@keescook>
References: <20241004-arm64-elf-hwcap3-v2-0-799d1daad8b0@kernel.org>
 <20241004-arm64-elf-hwcap3-v2-1-799d1daad8b0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004-arm64-elf-hwcap3-v2-1-799d1daad8b0@kernel.org>

On Fri, Oct 04, 2024 at 09:26:29PM +0100, Mark Brown wrote:
> AT_HWCAP3 and AT_HWCAP4 were recently defined for use on PowerPC in commit
> 3281366a8e79 ("uapi/auxvec: Define AT_HWCAP3 and AT_HWCAP4 aux vector,
> entries"). Since we want to start using AT_HWCAP3 on arm64 add support for

(Side note: I wonder what auxvec 29 and 30 used to be?)

> exposing both these new hwcaps via binfmt_elf.

This seems fine to me, feel free to carry this via the arm64 tree.

Acked-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook


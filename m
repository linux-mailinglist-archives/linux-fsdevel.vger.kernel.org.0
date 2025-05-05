Return-Path: <linux-fsdevel+bounces-48124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AEDAA9CB0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 21:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C7067A95DE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 19:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788E81FFC50;
	Mon,  5 May 2025 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMWv89U6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C105D1C6FF6;
	Mon,  5 May 2025 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746473721; cv=none; b=fTRM9U5YOlWwF7Be7JTXGwQ87Zti484yKipezBtVAMozPaX1V0zJBWjoO2poo1+3k9WYYpxChwNvHd0RrreeKQDf8S6rR4fTG2+jbN90GPGH/iZNvuMIZLu4wNngaPGiZGjs2vCYN0PFVCBYrAoqcNWX/dSXRQjCV1BK6TJAGkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746473721; c=relaxed/simple;
	bh=kkVGLS5k8ofegIDhfT5iFiahxbKTEbpN7507mhzkw3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhVfD8A5WFoFg4FEgXXsKHvWxKtnYAwgneAvnp1P+0Rx3LCOcmHagWsN9sC55cW7aTUr4id6Y2nwGK+dMlYOHTK1PQaWx+fr8gX4azoVMR8Lphy9I9y0mJGzVGMmVw4TWrkcnofXexglvsFA5ARnXz/icTiCu4A9cirBz5SCnLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMWv89U6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE68C4CEE4;
	Mon,  5 May 2025 19:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746473721;
	bh=kkVGLS5k8ofegIDhfT5iFiahxbKTEbpN7507mhzkw3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WMWv89U6riQOg0Z7sRsgfFg/QNM6QL8JKKlbKGR9I/ualu31CVxgMhqjNat+xeidx
	 vI7vJ5QeO2CBwinrGlGSc/S5FIW9A4qrtPWbPzcBX5QlxEHlVjHY7AT+PgM9iMrr3X
	 51Z8YyBZ68t/1GuxeZD2ghFHd+AuZCcj1+HF1A+XqHSXiHloGCSADphdQ4SCszwYAx
	 /pg6hf0Ftjclu36skX8o/ORuzqwep//Xa/lNbjQF8TpzcCF48rhFmvygMhNjxpNow2
	 0bHUuCdMtSIdOGrg8fBLbntRGHTCggDRBz1UedOQEALdvYVKwK5OzEA5ZP0RnMbQPy
	 XJp7go4YHbFAw==
Date: Mon, 5 May 2025 12:35:19 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com
Subject: [PATCH v2] swapfile: disable swapon for bs > ps devices
Message-ID: <aBkS926thy9zvdZb@bombadil.infradead.org>
References: <20250502231309.766016-1-mcgrof@kernel.org>
 <20250505-schildern-wolfsrudel-6d867c48f9db@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505-schildern-wolfsrudel-6d867c48f9db@brauner>

Devices which have a requirement for bs > ps cannot be supported for
swap as swap still needs work. Now that the block device cache sets the
min order for block devices we need this stop gap otherwise all
swap operations are rejected.

Without this you'll end up with errors on these devices as the swap
code still needs much love to support min order.

With this we at least now put a stop gap of its use, until the
swap subsystem completes its major overhaul:

mkswap: /dev/nvme3n1: warning: wiping old swap signature.
Setting up swapspace version 1, size = 100 GiB (107374178304 bytes)
no label, UUID=6af76b5c-7e7b-4902-b7f7-4c24dde6fa36
swapon: /dev/nvme3n1: swapon failed: Invalid argument

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/swapfile.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2eff8b51a945..9e49875ca1fd 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3322,6 +3322,15 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		goto bad_swap_unlock_inode;
 	}
 
+	/*
+	 * The swap subsystem needs a major overhaul to support this.
+	 * It doesn't work yet so just disable it for now.
+	 */
+	if (mapping_min_folio_order(mapping) > 0) {
+		error = -EINVAL;
+		goto bad_swap_unlock_inode;
+	}
+
 	/*
 	 * Read the swap header.
 	 */
-- 
2.47.2



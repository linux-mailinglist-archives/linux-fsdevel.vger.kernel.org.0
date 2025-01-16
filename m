Return-Path: <linux-fsdevel+bounces-39344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4EFA13000
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 01:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44DC18888D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 00:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE1A35948;
	Thu, 16 Jan 2025 00:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4da6rT9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39BAF4FA;
	Thu, 16 Jan 2025 00:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987557; cv=none; b=V+hIxpo+H5VZHR4theTOTWCaqWNuFx0cUOYSf8NLIXy6Uwq/Ex48Jo+4zPsZgbbS15Opb5D7128KsIpprQi0u+kMhAF1cT2XrX8QxIv7CAxEuVGBL4vbmb7dlJ3kJ+WLFwkdXDjEwh1tRj4yeisUNDdzIrr87eazDB+yaNiuLAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987557; c=relaxed/simple;
	bh=6TTx0wpAi7kUWyp0Rss3eAQfXm2E+k0piVuztBlUEcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCiwINy3Xl86FbUQHJq40T+VMi99LSnkekS8a10TjIoPuzk7VUOTXgd8K1uCC77Lkexj/fOEigiyNYnqUVw3GhFhXM/a8mFAXceNll02fZ2RMvCfpwgCISOfJ6REYeMDYt3GFpX+cN5tBlk305KE0s8AdQlpbPOOZIyhj2lV2VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4da6rT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6288CC4CED1;
	Thu, 16 Jan 2025 00:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736987556;
	bh=6TTx0wpAi7kUWyp0Rss3eAQfXm2E+k0piVuztBlUEcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P4da6rT9SAvWRo+CwJ3/Upc7ML9tO0cmig/y0bOv/WnIaHvfxBv4c5fLmKYzQywWH
	 slysmeIRkt06rMi8qATYs9uXl9Rbl9C3Ei2QPd4h75YL5kTNpI9GwIdgrEJTSMgA1g
	 Led0VeML+2EJEAb4+G5NTNX/0rTTNlo6KITeDIAKWY/oD5txL8IMCx0fGvsUrbhmiv
	 I8q1B6emPNd9DwnP/a7Qg8cFoDB1mcUziCa5UR/ovAcz8WBdRFksoG5tRGkeUuPqSZ
	 3QiKb+GNlGvhB4z+1e3gSfXyKKtNmPDPmGsUe5NUvgb+YnftlXVMLlXON8uTylEYES
	 Y3ZtuDFZmGZuw==
Date: Wed, 15 Jan 2025 16:32:33 -0800
From: Kees Cook <kees@kernel.org>
To: nicolas.bouchinet@clip-os.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Joel Granados <j.granados@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Neil Horman <nhorman@tuxdriver.com>, Lin Feng <linf@wangsu.com>,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v4 2/2] sysctl: Fix underflow value setting risk in
 vm_table
Message-ID: <202501151632.9FF3FF0@keescook>
References: <20250115132211.25400-1-nicolas.bouchinet@clip-os.org>
 <20250115132211.25400-3-nicolas.bouchinet@clip-os.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115132211.25400-3-nicolas.bouchinet@clip-os.org>

On Wed, Jan 15, 2025 at 02:22:09PM +0100, nicolas.bouchinet@clip-os.org wrote:
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> 
> Commit 3b3376f222e3 ("sysctl.c: fix underflow value setting risk in vm_table")
> fixes underflow value setting risk in vm_table but misses vdso_enabled
> sysctl.
> 
> vdso_enabled sysctl is initialized with .extra1 value as SYSCTL_ZERO to
> avoid negative value writes but the proc_handler is proc_dointvec and
> not proc_dointvec_minmax and thus do not uses .extra1 and .extra2.
> 
> The following command thus works :
> 
> `# echo -1 > /proc/sys/vm/vdso_enabled`
> 
> This patch properly sets the proc_handler to proc_dointvec_minmax.
> In addition to .extra1, .extra2 is set to SYSCTL_ONE. The sysctl is
> thus bounded between 0 and 1.
> 
> Fixes: 3b3376f222e3 ("sysctl.c: fix underflow value setting risk in vm_table")
> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook


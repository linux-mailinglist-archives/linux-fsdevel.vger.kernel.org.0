Return-Path: <linux-fsdevel+bounces-4844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6193D804A3C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 07:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA4E1F21449
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 06:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C0212E5A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 06:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ta23N3NM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE58AD26E;
	Tue,  5 Dec 2023 05:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB05C433C8;
	Tue,  5 Dec 2023 05:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701755098;
	bh=nnB2GVEF0qg3/xmo5rtiPkE3svlhXBgxG8n8uFlrfUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ta23N3NMrvWc9O+41tVSxC1Y/Oz5+P9w5DNF78MudxDYIoucVkAnfiq1epuhOUbr9
	 DNhp8IlUk5nGN4vvQINkgy8cZZhY/LFqCmSow7n5KdTOE+xb6xeDafWmGDvEGE6Pj9
	 ALjkp+udzerHIpncUtSCmiz7C0Qpy4jyHBnS7hGWoYaGiaD0RSkWVFtfLSM1snAFjY
	 7nQxHo9RtgUaNY972G2VqLkylLVipnRVEpKX2ioVcQrQVnCs+AOqZEhPRudhSoW6xs
	 7ze6AvlrCJjSPITI/KySf1ML5EssT6xU3raWdiC++YDXvEvA8MipFHQ7sM61yspuRW
	 Id6k3ulY5jkTA==
Date: Mon, 4 Dec 2023 21:44:56 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 26/46] btrfs: keep track of fscrypt info and
 orig_start for dio reads
Message-ID: <20231205054456.GN1168@sol.localdomain>
References: <cover.1701468305.git.josef@toxicpanda.com>
 <5e74c0395e4f58082b9446fb0105c0cb99e8338d.1701468306.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e74c0395e4f58082b9446fb0105c0cb99e8338d.1701468306.git.josef@toxicpanda.com>

On Fri, Dec 01, 2023 at 05:11:23PM -0500, Josef Bacik wrote:
> We keep track of this information in the ordered extent for writes, but
> we need it for reads as well.  Add fscrypt_extent_info and orig_start to
> the dio_data so we can populate this on reads.  This will be used later
> when we attach the fscrypt context to the bios.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Does this mean that btrfs will support direct I/O on encrypted files from the
beginning?  Are you enforcing FS block alignment, as is required for encrypted
direct I/O?

- Eric


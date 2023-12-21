Return-Path: <linux-fsdevel+bounces-6693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB02481B70B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 14:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18F291C24300
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 13:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAAF73195;
	Thu, 21 Dec 2023 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwkLYjtV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AED73167;
	Thu, 21 Dec 2023 13:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B01C433C7;
	Thu, 21 Dec 2023 13:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703164246;
	bh=rzFo0jSO9CzuyB8ix+OkdqFGjkSimTSdDUnDSEMYue8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qwkLYjtVC+xfXIKkdMFnG648mPirjE4pb5d2ZnBWyDDrs7vbGpcDGS7hmF8af7/pY
	 Esml36M7iH0b1KBnZCfp1ZYjVIFNr5tuLg/ZripucJW6+MglUy84JfRwj16pDvI764
	 Ze2FFq04KMpIGJhZ4WcmoPagoozzMxKYcbqEqGSCBThx9kjdKRHcMuvIYhwmryfH7E
	 1D6yJm4R/Qd7mgNd8l8NXdrtS3owIKAg/WY/vq+r9+Ad/YFA3HxLB27Fz2D91ZJfHk
	 xnDOQnVBupJN7ovtL977daN4OgkUGlt+m7Na+SafFt9osnogCUHLvsnLzC17dA3c9Y
	 ZqwCqR/2TZthw==
Date: Thu, 21 Dec 2023 14:10:42 +0100
From: Christian Brauner <brauner@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, Jie Jiang <jiejiang@chromium.org>,
	Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Re-support uid and gid when mounting bpffs
Message-ID: <20231221-aufhob-optimal-f8dbd598e9fc@brauner>
References: <20231220133805.20953-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231220133805.20953-1-daniel@iogearbox.net>

On Wed, Dec 20, 2023 at 02:38:05PM +0100, Daniel Borkmann wrote:
> For a clean, conflict-free revert of the token-related patches in commit
> d17aff807f84 ("Revert BPF token-related functionality"), the bpf fs commit
> 750e785796bb ("bpf: Support uid and gid when mounting bpffs") was undone
> temporarily as well.
> 
> This patch manually re-adds the functionality from the original one back
> in 750e785796bb, no other functional changes intended.
> 
> Testing:
> 
>   # mount -t bpf -o uid=65534,gid=65534 bpffs ./foo
>   # ls -la . | grep foo
>   drwxrwxrwt   2 nobody nogroup          0 Dec 20 13:16 foo
>   # mount -t bpf
>   bpffs on /root/foo type bpf (rw,relatime,uid=65534,gid=65534)
> 
> Also, passing invalid arguments for uid/gid are properly rejected as expected.
> 
> Fixes: d17aff807f84 ("Revert BPF token-related functionality")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jie Jiang <jiejiang@chromium.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>


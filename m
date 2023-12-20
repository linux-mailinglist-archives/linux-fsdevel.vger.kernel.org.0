Return-Path: <linux-fsdevel+bounces-6583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBAB819EAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 13:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C136328709D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 12:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D423B22310;
	Wed, 20 Dec 2023 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/WHOWsR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C49022305;
	Wed, 20 Dec 2023 12:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37CAC433C8;
	Wed, 20 Dec 2023 12:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703074215;
	bh=uUmL12oIsK0mMjJGAEOsDm5UE+qL53PZkLmI3v9dvQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s/WHOWsRZqX8unNmgZ5uXAWhl3uz1R0Qdz55YeXQUrVXwcgcz4OjdYW2PcnbglSGB
	 xtWp95lEgURSMrSUqjXgFNAwENN3+5XXI5dIR0Aok/ui1hJA/S3NLM467kzrClszTQ
	 UAxMKZHxH9SDT/FYiTUjEQS0VdX9+GiaU+fr8AuwC4JC2sW3yHmpLvtHo6kxuSdjMe
	 +CROvvcUcTpoYTAa4kVklBUG9UzvHJ2Rb0ayYu90k3JokkyID4Gl1v3vzVkZmIrg5j
	 q4GU5qFSRYuFGlb6xWWRqNxsLN4XFL7zB6dBMJrTaE8y7KZC4n0sXdvuzqkkaHtKVy
	 UJfjmUqOhftKA==
Date: Wed, 20 Dec 2023 13:10:10 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	torvalds@linuxfoundation.org, ast@kernel.org, daniel@iogearbox.net,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next] bpf: add BPF_F_TOKEN_FD flag to pass with BPF
 token FD
Message-ID: <20231220-drillen-obskur-a310578e99bb@brauner>
References: <20231219053150.336991-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231219053150.336991-1-andrii@kernel.org>

On Mon, Dec 18, 2023 at 09:31:50PM -0800, Andrii Nakryiko wrote:
> Add BPF_F_TOKEN_FD flag to be used across bpf() syscall commands
> that accept BPF token FD: BPF_PROG_LOAD, BPF_MAP_CREATE, and
> BPF_BTF_LOAD. This flag has to be set whenever token FD is provided.
> 
> BPF_BTF_LOAD command didn't have a flags field, so add it as well.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  /* Get path from provided FD in BPF_OBJ_PIN/BPF_OBJ_GET commands */
>  	BPF_F_PATH_FD		= (1U << 14),
> +
> +/* BPF token FD is passed in a corresponding command's token_fd field */
> +	BPF_F_TOKEN_FD		= (1U << 15),

The placement of the new flag right after the BPF_F_PATH_FD flag alone
does tell us everything about the "we didn't know" claims wrt to the
token fd stuff. Literally the same review and the same solution I
requested back then.


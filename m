Return-Path: <linux-fsdevel+bounces-7532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B4B826D18
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 12:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040851C22180
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 11:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD3D2554A;
	Mon,  8 Jan 2024 11:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rksq/Uuv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A612025757;
	Mon,  8 Jan 2024 11:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4560C433C7;
	Mon,  8 Jan 2024 11:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704714253;
	bh=eJI4l8jtZqM3nYbOqwB0pA6ofLKxWpu7awa7LowCuBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rksq/Uuv9peB+F33azrjNhjFMpbm5zS80ZSS8jkSDHg0Dssc0t0yHw6rw6caHs3DP
	 zgqTv2yr25nc4EVVk0e0A6b4XJfIcW4/qno+Vs5vhveZ42kvfU1jTODhkjCm5KSE8C
	 VpGDfRPJchfDiz/DZcHt83fcP+37Kt1VtIzbL+4vCzD5riT8njpfa7CDAeKYJaX/Vq
	 F9cS2YDZho6+WVTY1jO2mArenAlq9dQ36iwsajuj4Qk8gw1dvK9g3Nk7oum4kHYHtR
	 6WVRwMP30Pfnb6+/y5wkdMlxeT/ui0kEHc8WImZR7E3XR3tMBIGNtmeSQ1gK3o5n4Q
	 W4tqPl4+4bOcg==
Date: Mon, 8 Jan 2024 12:44:07 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com, 
	torvalds@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
Message-ID: <20240108-zirkulation-farbfernseher-dfe21ee1ba2c@brauner>
References: <20240103222034.2582628-1-andrii@kernel.org>
 <20240103222034.2582628-4-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240103222034.2582628-4-andrii@kernel.org>

On Wed, Jan 03, 2024 at 02:20:08PM -0800, Andrii Nakryiko wrote:
> Add new kind of BPF kernel object, BPF token. BPF token is meant to
> allow delegating privileged BPF functionality, like loading a BPF
> program or creating a BPF map, from privileged process to a *trusted*
> unprivileged process, all while having a good amount of control over which
> privileged operations could be performed using provided BPF token.
> 
> This is achieved through mounting BPF FS instance with extra delegation
> mount options, which determine what operations are delegatable, and also
> constraining it to the owning user namespace (as mentioned in the
> previous patch).
> 
> BPF token itself is just a derivative from BPF FS and can be created
> through a new bpf() syscall command, BPF_TOKEN_CREATE, which accepts BPF
> FS FD, which can be attained through open() API by opening BPF FS mount
> point. Currently, BPF token "inherits" delegated command, map types,
> prog type, and attach type bit sets from BPF FS as is. In the future,
> having an BPF token as a separate object with its own FD, we can allow
> to further restrict BPF token's allowable set of things either at the
> creation time or after the fact, allowing the process to guard itself
> further from unintentionally trying to load undesired kind of BPF
> programs. But for now we keep things simple and just copy bit sets as is.
> 
> When BPF token is created from BPF FS mount, we take reference to the
> BPF super block's owning user namespace, and then use that namespace for
> checking all the {CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_ADMIN}
> capabilities that are normally only checked against init userns (using
> capable()), but now we check them using ns_capable() instead (if BPF
> token is provided). See bpf_token_capable() for details.
> 
> Such setup means that BPF token in itself is not sufficient to grant BPF
> functionality. User namespaced process has to *also* have necessary
> combination of capabilities inside that user namespace. So while
> previously CAP_BPF was useless when granted within user namespace, now
> it gains a meaning and allows container managers and sys admins to have
> a flexible control over which processes can and need to use BPF
> functionality within the user namespace (i.e., container in practice).
> And BPF FS delegation mount options and derived BPF tokens serve as
> a per-container "flag" to grant overall ability to use bpf() (plus further
> restrict on which parts of bpf() syscalls are treated as namespaced).
> 
> Note also, BPF_TOKEN_CREATE command itself requires ns_capable(CAP_BPF)
> within the BPF FS owning user namespace, rounding up the ns_capable()
> story of BPF token.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Christian Brauner <brauner@kernel.org>


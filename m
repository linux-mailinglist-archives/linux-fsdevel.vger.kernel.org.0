Return-Path: <linux-fsdevel+bounces-5379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C74280AEFA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 22:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23314B20BA6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 21:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BB658ABD;
	Fri,  8 Dec 2023 21:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0t2abm7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0C41D55F;
	Fri,  8 Dec 2023 21:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CE0C433C8;
	Fri,  8 Dec 2023 21:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702072196;
	bh=2geTlzNIQvnDuvetND6PbZo/Nwh+PxQP+TyMxBqwuXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I0t2abm72f6TjOZXmTKNkRzt0WyoscypTIx7RlxP5tnxwRb92R7TZv1//AbmHwtcB
	 oN3tRfdO37CKKfLxsYRD8+QltH1hSqC/S5vXlYb4W3b/LAZFr8CzALTQSFpJXyhvdJ
	 KFdOF4DyKEbjqxbSV2S+EuNuP+1U/8J66iJsvD/aIuerse7i8hmumzhuS6v6LxPT/H
	 6Q7A8bsPtvl//ycxyX6YcFtYOiKVFEYdyutPY4rAz0gX+whxv13L14EXktkjsbz1DY
	 pLPn8FItUpDQurs/RdcoLU6TUzaEGW7DmXAxu0FivwGmM1l9qLFc0ayuirP4SIwtyU
	 4OL+J/eHU0yJQ==
Date: Fri, 8 Dec 2023 22:49:52 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, keescook@chromium.org,
	kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH bpf-next 1/8] bpf: fail BPF_TOKEN_CREATE if no delegation
 option was set on BPF FS
Message-ID: <20231208-pocken-flugverbindung-0e4b956cd089@brauner>
References: <20231207185443.2297160-1-andrii@kernel.org>
 <20231207185443.2297160-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231207185443.2297160-2-andrii@kernel.org>

On Thu, Dec 07, 2023 at 10:54:36AM -0800, Andrii Nakryiko wrote:
> It's quite confusing in practice when it's possible to successfully
> create a BPF token from BPF FS that didn't have any of delegate_xxx
> mount options set up. While it's not wrong, it's actually more
> meaningful to reject BPF_TOKEN_CREATE with specific error code (-ENOENT)
> to let user-space know that no token delegation is setup up.
> 
> So, instead of creating empty BPF token that will be always ignored
> because it doesn't have any of the allow_xxx bits set, reject it with
> -ENOENT. If we ever need empty BPF token to be possible, we can support
> that with extra flag passed into BPF_TOKEN_CREATE.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Might consider EOPNOTSUPP (or whatever the correct way of spelling this
is). Otherwise,
Acked-by: Christian Brauner <brauner@kernel.org>


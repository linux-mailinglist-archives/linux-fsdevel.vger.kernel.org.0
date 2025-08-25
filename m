Return-Path: <linux-fsdevel+bounces-59106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2683DB3477D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 18:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD13201CC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 16:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3F33002C7;
	Mon, 25 Aug 2025 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJmGmFSf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD612FDC27;
	Mon, 25 Aug 2025 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756139649; cv=none; b=g8t8LZZ63pa8bODBUgDyn30qwAD+LbUUXherm5jrJbcfl3Wso9gX1mKk2qyRUNvD+YHp9acYKuzZGPqg2NaneJJ01AxJtXkmud4Ec+IIK+4wui7aInBYtak4IK2Y1UPkeqor2rX73jgngv7PL+wUudAvpzFYW/DFC8utOGmwFG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756139649; c=relaxed/simple;
	bh=zu8SPfBerugkmDtJidWjfcjeeP42SIXM1xJk+/uNh1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lfSktLGQ0IcTHS8QqFzl1SBQwczK1FZrWkblLGP+c5NFovQyqAP36I/pFfkKreQHxElb1q01Nj8uefeYbaibN2LUFh4Veb4hh3LlSya796p+e/0vWa8iUKL7i8pyPSVQtoIMgaTlavJSzv5M9pNwhJDufWOAwmsk3zI/xex3ZjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJmGmFSf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6487C4CEED;
	Mon, 25 Aug 2025 16:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756139648;
	bh=zu8SPfBerugkmDtJidWjfcjeeP42SIXM1xJk+/uNh1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AJmGmFSftbFswP7vXw79bS5ADxT9fQR0UJ/SMXBMrJzdD/I9h1x1tFXvKihlcevSg
	 IjzWX4509+rRBljotULcr7T9GSzjAEIotwK+wkNea6fxrlOPDqWbPIvNj7BJFfQPwP
	 2KCXt/Zo8T4+pj4+p6GLieTyd2uft1wYpjeVNJ9DA03JIBlYZlwhUC/L6+9gKoSoN5
	 B9YG9J8Wg2M42FaEQ66FvlmlxcJW3mSG4sCqOoIUT7hLJnW+3XTVwnJgHLA6L0Pu5O
	 Q6tDK/afK8v94nntgvrOjYC/ZQhaQSxrdL9yiGotHFOwjDNu8Aok15ITKTfREu0QzA
	 5IKxG74piNDYg==
From: Kees Cook <kees@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Cc: Kees Cook <kees@kernel.org>,
	jack@suse.cz,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: Fix incorrect type for ret
Date: Mon, 25 Aug 2025 09:34:07 -0700
Message-Id: <175613964617.2086956.9956215220581274792.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825073609.219855-1-zhao.xichao@vivo.com>
References: <20250825073609.219855-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 25 Aug 2025 15:36:09 +0800, Xichao Zhao wrote:
> In the setup_arg_pages(), ret is declared as an unsigned long.
> The ret might take a negative value. Therefore, its type should
> be changed to int.
> 
> 

Applied to for-next/execve, thanks!

[1/1] exec: Fix incorrect type for ret
      https://git.kernel.org/kees/c/5e088248375d

Take care,

-- 
Kees Cook



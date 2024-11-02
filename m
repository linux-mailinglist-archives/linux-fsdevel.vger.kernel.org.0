Return-Path: <linux-fsdevel+bounces-33567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525B49BA255
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 20:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882941C222A9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 19:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2031ABEDF;
	Sat,  2 Nov 2024 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bo0as462"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929D714F12F;
	Sat,  2 Nov 2024 19:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730577484; cv=none; b=IjwYwSfynBiPB6BXX0kpyM25sdgIPLVRd4Vx2sByZ2fj7gUQImX4ocIFK8j4e1LTwav0QfmIRDbT9kYj31hC22+ZhkvZHSl+wEt88/23QKakNuoDuFmSkZQZENJvlbygri1+l6u4Sy092bt8Tl3Ea3FM2yNHXMzRyEsgzQlcea8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730577484; c=relaxed/simple;
	bh=R1xUKfbTQ9Fj33YTxe1JXPAuf1O3HXqBTQGulBGQa0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2Rh2qoWC8xQkUe85EyOQbvQrw4/u2b7OOH+iOiZU25W8W5PsbTiRCMvBBrI6WNeK9KSJcDtXdDovhMWvoS9FlgUnKHv5iTdLiRzmM+x0GJjZVXyLLoPLxV5bmSQHsy3Dkx15Rmkv3fD5isN6VvUNCds9nOS7gwvmPN8kQoAe6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bo0as462; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D52C4CEC3;
	Sat,  2 Nov 2024 19:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730577484;
	bh=R1xUKfbTQ9Fj33YTxe1JXPAuf1O3HXqBTQGulBGQa0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bo0as462ZJAU3ux5c70cbRrXavhlsHmyvUUAszob4E8j+/Q7ZZV/R3tsDWu8vi3Ah
	 6GwCMPId7qpCcgvQhtdZ0RYEdWNuSoiPFvJiNqRmCw9VkJQ7AaAENwal3EuqNz4e4e
	 RkGk3HxAPk1zW4UGIut+NVimiaqjCFcX8P7EHFyRNjwP5DDPb7tJrAuaovQMvuu6cI
	 3tHFOxKzMf8kFNtsorY0MrbYwVLQnN2K/fIr0G/+8qOTsjlZdPD3xSw4NiSScOBAQo
	 BTT/7jQ7idFoAmoLUYP7+tCIlOIc14lZD19uLvh4POZVhqd38Nc7OuURZdD/UgwQTo
	 NNfffy3UhL/MQ==
From: Kees Cook <kees@kernel.org>
To: Tycho Andersen <tandersen@netflix.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Kees Cook <kees@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] exec: Fix a NULL vs IS_ERR() test in bprm_add_fixup_comm()
Date: Sat,  2 Nov 2024 12:57:58 -0700
Message-Id: <173057747484.2382073.5760107237712372637.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <18f60cb9-f0f7-484c-8828-77bd5e6aac59@stanley.mountain>
References: <18f60cb9-f0f7-484c-8828-77bd5e6aac59@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 02 Nov 2024 12:31:14 +0300, Dan Carpenter wrote:
> The strndup_user() function doesn't return NULL, it returns error
> pointers.  Fix the check to match.
> 
> 

Applied to for-next/execve, thanks!

[1/1] exec: Fix a NULL vs IS_ERR() test in bprm_add_fixup_comm()
      https://git.kernel.org/kees/c/05e60502723d

Take care,

-- 
Kees Cook



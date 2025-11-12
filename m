Return-Path: <linux-fsdevel+bounces-68054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB51BC521CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 12:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16AD93BE427
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 11:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F30313268;
	Wed, 12 Nov 2025 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyXu+/73"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A8D31327B;
	Wed, 12 Nov 2025 11:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762947890; cv=none; b=A3oL05t0KSgXVrRBX6iIP8h+3j9uPYI1FCvwt2/H88pqBHnm3TIJApixTpXg2KbQM3R/IfluhM9zBksD9kQ2WvrFuJqZRXGShKJ0W5Sccr5IHeTMOiihMIBTyA7flLGTBnAn6m/Giwyu+W8AQJhsKFj0Znu10zGFMPTPp6J4LbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762947890; c=relaxed/simple;
	bh=Wj/4q1C1ArnQ7Q4ixJ7EiiawvGxLIH7JDw3b8s+7UQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K7Npz7JKzpHA4H4gXuWKPMuCtC6FZqsFbwFaSg17tqZxZuiVvAbbz71+oK0fOaDrtFfTeqJkbnFaOdx1WszoFqR4M37uVFJZTis/690OdsFafnwfISmILbGFMCApRjg7n8fXIaZDmR+mXyI//IrwOoCSr3pKP/y55U2wfTrfsMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyXu+/73; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69803C4CEF7;
	Wed, 12 Nov 2025 11:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762947890;
	bh=Wj/4q1C1ArnQ7Q4ixJ7EiiawvGxLIH7JDw3b8s+7UQk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FyXu+/73fldy/N9aF3u1xUDUGJiObxFLxZZGQhuJ7inI7zDlB+KnAcT4c2tZlz9sC
	 UKPZDozEAjr1L6hpJF+xTP8CKVu7qTZH2UHes9izH5opdFzdciysPSWizGXeeQ+mej
	 MEPSu1l20VwPcnP75gh82oftOZZvJfc42pUMu0ZOzsv2iqfiwdqkTsm06PShgbY+VX
	 MH23jxelP4g06YyGWqLJJQoeO0oNfOQnO6GELdouoJDl94E2Eq+0JbBM/M7YxoD/rg
	 dZ4K5lVyLs0s9vo04NQf5U250KVefbpOjIdtwl5L8IUVUWS8rq3ok9s3+UpREtyhJs
	 TcUGKdtezFBVA==
Message-ID: <9c4cac95-adbf-4236-a872-5213a2a797da@kernel.org>
Date: Wed, 12 Nov 2025 12:44:46 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] shmem: fix tmpfs reconfiguration (remount) when noswap is
 set
To: Mike Yuan <me@yhndnzj.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Hugh Dickins <hughd@google.com>,
 stable@vger.kernel.org
References: <20251108190930.440685-1-me@yhndnzj.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251108190930.440685-1-me@yhndnzj.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.11.25 20:09, Mike Yuan wrote:
> In systemd we're trying to switch the internal credentials setup logic
> to new mount API [1], and I noticed fsconfig(FSCONFIG_CMD_RECONFIGURE)
> consistently fails on tmpfs with noswap option. This can be trivially
> reproduced with the following:
> 
> ```
> int fs_fd = fsopen("tmpfs", 0);
> fsconfig(fs_fd, FSCONFIG_SET_FLAG, "noswap", NULL, 0);
> fsconfig(fs_fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
> fsmount(fs_fd, 0, 0);
> fsconfig(fs_fd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0);  <------ EINVAL
> ```
> 
> After some digging the culprit is shmem_reconfigure() rejecting
> !(ctx->seen & SHMEM_SEEN_NOSWAP) && sbinfo->noswap, which is bogus
> as ctx->seen serves as a mask for whether certain options are touched
> at all. On top of that, noswap option doesn't use fsparam_flag_no,
> hence it's not really possible to "reenable" swap to begin with.
> Drop the check and redundant SHMEM_SEEN_NOSWAP flag.
> 
> [1] https://github.com/systemd/systemd/pull/39637
> 
> Fixes: 2c6efe9cf2d7 ("shmem: add support to ignore swap")
> Signed-off-by: Mike Yuan <me@yhndnzj.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>
> ---

Makes sense to me

Reviewed-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David


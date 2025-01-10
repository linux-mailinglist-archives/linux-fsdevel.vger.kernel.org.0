Return-Path: <linux-fsdevel+bounces-38891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 549F7A097D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 17:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59FEE1679CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 16:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6AF213249;
	Fri, 10 Jan 2025 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLO9DXzI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C40210F6D;
	Fri, 10 Jan 2025 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736527792; cv=none; b=p/w/YJIC+TBRU+/Qe5u+GNeshQbpkHP8G6koaYZxthT92FgpF1TtD/KOJZ0mvnBhyiAeK2RubwDwAKKklKEPGOo/bbdeDXT5NhhakPRP/LwMwgz1cdciQk2N7JBefqnhTkR2yzkdlND7hfsFnkTTUqL4g+NJj9009QBQmIZVY5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736527792; c=relaxed/simple;
	bh=+yDQ+vJqHznaDyos9xjW00xrBMEHb0ruggMNJ4oZado=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FFRITKTtjwuxTUcR0nqJp7VwW4BiHdqhg6L2TDurffso2h5XNhPZ1Au1q7rtnroTidWUpfs+pTiUG3W+odYYn8mEPJ/PPeg3TlcQ8/AKvvUVOuyJkKq1c3IM+eHwEvJbbFDj5XacW2LZG8Lg7dTjDJ1NGwVjXvm8jhp8sXW0BH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLO9DXzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CDAC4CED6;
	Fri, 10 Jan 2025 16:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736527791;
	bh=+yDQ+vJqHznaDyos9xjW00xrBMEHb0ruggMNJ4oZado=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gLO9DXzIlngQ9OUW3zqrNtoKR/H74kAqGYSNWAScFW40NQZJn2QqcvV6+MG3gNXgI
	 my5endsWAut9pMhmvwxsvzquT3VC1mKv5BjgbGhotQIzW3OogWmpYsEn3+uqWcd38m
	 5G0gI2C7eH443UZFOqee6loc3CoWD8/K57KY0OSpObvFjG9HE9v6GQin6VK8AExl88
	 rHmm3X45mMJjtDM9spQ8s8VL9MGJWWsVLwjqBmk7qHUoyGiFDPYTa+AFZV1/R2TMF4
	 1IG+OfL3s3hZDWmsgCw1MQ8Rm+HNhXbgkQ6f8B7oaD9tHFy7Qew4SpzdVm0r6qIXbo
	 cD2Vklyl/aqPA==
From: Kees Cook <kees@kernel.org>
To: Nicolas Pitre <npitre@baylibre.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] binfmt_flat: Fix integer overflow bug on 32 bit systems
Date: Fri, 10 Jan 2025 08:49:47 -0800
Message-Id: <173652778610.3103415.15796406713093643015.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5be17f6c-5338-43be-91ef-650153b975cb@stanley.mountain>
References: <5be17f6c-5338-43be-91ef-650153b975cb@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 04 Dec 2024 15:07:15 +0300, Dan Carpenter wrote:
> Most of these sizes and counts are capped at 256MB so the math doesn't
> result in an integer overflow.  The "relocs" count needs to be checked
> as well.  Otherwise on 32bit systems the calculation of "full_data"
> could be wrong.
> 
> 	full_data = data_len + relocs * sizeof(unsigned long);
> 
> [...]

Applied to for-next/topic/execve/core, thanks!

[1/1] binfmt_flat: Fix integer overflow bug on 32 bit systems
      https://git.kernel.org/kees/c/55cf2f4b945f

Take care,

-- 
Kees Cook



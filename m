Return-Path: <linux-fsdevel+bounces-70979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27932CAE0B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 08 Dec 2025 20:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ECB93072AEF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Dec 2025 19:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C27188713;
	Mon,  8 Dec 2025 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QACm7OBe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ACF28CF42;
	Mon,  8 Dec 2025 19:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765220738; cv=none; b=lheo7sON50qh5ixXExKF0GHrfMDpJBr3+3sP3y1Xp4u/W8ntwfScgQv4luwB4c666b0TP4eOPvC4m5PPL6yZGU6oww/PSWa6vBgFslD6IrYIPq8X4rTCxDMR59gLDq/dEBjvzymHKadd06E57ZEovMCHckNYiNtnXXNpfaCA+ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765220738; c=relaxed/simple;
	bh=XpRjNn1mmaqAw8tIi+jFZhf0YM5j0DVMLFx3PKlmFl8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Ys35eYeQ7xchHg0+jiwWqn0YOTgIX9jglOG6NVety+cTchBQQ3C4WYt/AxNrBmghURlY5mOMhSJYJapz10z5K54QveL6JdV9jGdUP+dK0VaZPGqmcJ9RId1Emnl0jGKXZs+garD9ZZCKpaCZSlUNMqIOdafJbynUqZOxg6xVjbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QACm7OBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2207FC4CEF1;
	Mon,  8 Dec 2025 19:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765220737;
	bh=XpRjNn1mmaqAw8tIi+jFZhf0YM5j0DVMLFx3PKlmFl8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QACm7OBevOVV4m0vcaLsyRIJY497hfCEdAtXJ9Hw9tpy7nt611ZGd6Y+jdYcjYhmD
	 fQRyagdHpRPobnSD0EwwwxJdMM3xSr4Bd5jDRBz9qyRcac5De/rV6cOn2mngL66dSJ
	 MpHi/OUL3ajC3l3R0RvuPeIcUBSdAXW9/6KsSHHRcGx5zY1AzGkDe5Vj9wBqP2wQ4S
	 TlSlnf4PQ69MrImqRM+vFJx1ptef7oJSWE7DAejN0GkpcjzIrZ59p4z681oMUdhjSm
	 kaCTpELiotFu57HQwfV2tbPPj+dL6ohrqGy2CCogoQYjgwp2ytRlmipwmeBGYK10Jb
	 kiuhs9LhCdsRQ==
Date: Mon, 08 Dec 2025 09:05:36 -1000
Message-ID: <258843c66b112a2d3015f0a74e09bd60@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, mkoutny@suse.com,
 akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cgroup: switch to css_is_online() helper
In-Reply-To: <20251202025747.1658159-1-chenridong@huaweicloud.com>
References: <20251202025747.1658159-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Applied to cgroup/for-6.20.

Thanks.
--
tejun


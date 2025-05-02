Return-Path: <linux-fsdevel+bounces-47911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8704CAA71AE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 14:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CCE83B472B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 12:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C139252904;
	Fri,  2 May 2025 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFtS0zkr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6204926ACD;
	Fri,  2 May 2025 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188600; cv=none; b=AclsBKHu7hnTt0LAJchm5K8c8c7WMvkKY7BF4ukDEN5KTnnYFXpF9P1Qlnk8vLVoRZkCtbszP8rQqfCXLlt+rUyJak4+kZrFmMnPUz8rU/TNSzGmVkxtVPUdmsWczrpoQmw0HVRroznUYZRkSFQhxwQt+pJxAhQGoYMJX3pS1U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188600; c=relaxed/simple;
	bh=uoD6t+xSncOXPND7SdJCqz7ylBLgqUWXuLMSQgfYQkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VUj8+1VRVOx/u2FutwJOUOiG4CNxruZzNj0XNiiODfgJDGmZJGgp/G3fSvwlmncP57IKtmodxUeGKzZvz4us59FH5dlZsYFpItYggWyQKcw+mUgvaEPiwzpzbaamBt6a2R2zCMVamf7LELLK3GE7wUgIm3ikr/c3il+aOIcCyms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFtS0zkr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DE5C4CEE4;
	Fri,  2 May 2025 12:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746188599;
	bh=uoD6t+xSncOXPND7SdJCqz7ylBLgqUWXuLMSQgfYQkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nFtS0zkrIJQJTniM+JOv0gxqdgx6KvbV5OIOTVoqEqjZxevrkxkuIV1yk+mRDvpV6
	 iS2490aAU5BtrlsyKIDkXQ7zEl4hpfEvu9jw/mJnyolDnF53/QqrOm/nYdZV8vvXpr
	 PdGRawT5Ll2RQpg3hH87X/oUuTXxW7GTRvT2QDklXGj7D0MVwGvjzM2zglcgIsvjwi
	 hJL60EY2z3RkiKLNz8c262GhkI3jJtj/w7JW/frvXLjIoM3SnEA9o6qxfuKkRApQrI
	 AxxgGZpYa1R5WVGm0Q5F5j8v1ZUNSp60C/7KnVH11WS49Yp2n9VNMfkEU1bENU+BC1
	 Whtmtat0VYXEg==
From: Christian Brauner <brauner@kernel.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Joe Damato <jdamato@fastly.com>,
	stable@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/eventpoll: fix endless busy loop after timeout has expired
Date: Fri,  2 May 2025 14:22:45 +0200
Message-ID: <20250502-exzellent-hingucken-53c88d2917a1@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429185827.3564438-1-max.kellermann@ionos.com>
References: <20250429185827.3564438-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1399; i=brauner@kernel.org; h=from:subject:message-id; bh=uoD6t+xSncOXPND7SdJCqz7ylBLgqUWXuLMSQgfYQkk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSI7DSawGjp7NLa93D/iUWKVbKtv7jb4xOlTjC6OnQwG v8+sNCio5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLdBxj+F6VcK+Ys5tYuFvM3 9Jy5N9aQp8h89tldnx8xvpv2cvXaBkaGN7ZLkvqy+Oe08MgvO7/s2+qzcex9XzdO5fq4PGp72Xt DfgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 29 Apr 2025 20:58:27 +0200, Max Kellermann wrote:
> After commit 0a65bc27bd64 ("eventpoll: Set epoll timeout if it's in
> the future"), the following program would immediately enter a busy
> loop in the kernel:
> 
> ```
> int main() {
>   int e = epoll_create1(0);
>   struct epoll_event event = {.events = EPOLLIN};
>   epoll_ctl(e, EPOLL_CTL_ADD, 0, &event);
>   const struct timespec timeout = {.tv_nsec = 1};
>   epoll_pwait2(e, &event, 1, &timeout, 0);
> }
> ```
> 
> [...]

I've taken this version but also credited/mentioned Joe in the commit message,
noting that I added that info

---

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] fs/eventpoll: fix endless busy loop after timeout has expired
      https://git.kernel.org/vfs/vfs/c/d9ec73301099


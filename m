Return-Path: <linux-fsdevel+bounces-66328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 296A9C1C10B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 17:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4A29583525
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 15:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1303358D8;
	Wed, 29 Oct 2025 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CealNYV8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C6628C5DE;
	Wed, 29 Oct 2025 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752234; cv=none; b=p8+NKokJpsa02Gm8QEG1TyKSSCra9B3zT8o2lHSdbiYRbSu3nhijFqv2Mv8RB92GAWcN6kxNfl6dv0e0hF9Mg8KuxBuR4Xyp+N6opiIJC3C1CYori5hLwP9STVtVXJ37UVxUPAWIkoBihxrLhTQra3Fd5NOH4uYLlbJpjCAXufY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752234; c=relaxed/simple;
	bh=5xGs4Lpbs834Yu9/rAPJv80pu7NVshSPDP3oVVoetk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vBGJaezGITU+nGEME++AbQqP5MowbyWszHqBshA1/ih1+UaKKcaLgrwK0zPUyQA3foTQ1/cH0R8T8Ef1roxPKzQh6wqlKlv4qYMQwLW1RnFhrZaqOEym6ULXGxiwMKgt5uzP+rCXHT65T2nlqylQjdJxUm4Z2PhExpl/g2EiUso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CealNYV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389A1C4CEF7;
	Wed, 29 Oct 2025 15:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761752234;
	bh=5xGs4Lpbs834Yu9/rAPJv80pu7NVshSPDP3oVVoetk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CealNYV8GjcCj4BOaYTScfX/KZEN/b2dPLS90INlexCJt98XrN/XpYua3bCqU47Pz
	 CevmUWl0VuRyQthGpF1+zux+pcdFkBC3ApdhhBHprYCdFrcirODL0wW0PIDbR7GCxt
	 RS25oH1wEBhXtI9i2BpbvTrONwjdyvVSdcIM93SnHmHbyxS7liWmHRvUjmsIe7i05e
	 ZV0FNShH4hUPHzDflgasVUSDdGYb7znRvK9G8VWQJHFP7U+m1+zqv50B5uQ7q1A7wq
	 JoaOmoHpz87MmP+09s/n+ZcT6oLdYu2xAqan1UHWApbBDOShTB7wh9xbGbQp6Q/BGm
	 aP2vbY7PveDFA==
From: Christian Brauner <brauner@kernel.org>
To: akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	wangzijie1@honor.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	albin_yang@163.com
Cc: Christian Brauner <brauner@kernel.org>,
	albinwyang@tencent.com
Subject: Re: [PATCH] fs/proc: fix uaf in proc_readdir_de()
Date: Wed, 29 Oct 2025 16:37:07 +0100
Message-ID: <20251029-klammheimlich-gemein-801074b07089@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251025024233.158363-1-albin_yang@163.com>
References: <20251025024233.158363-1-albin_yang@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1627; i=brauner@kernel.org; h=from:subject:message-id; bh=5xGs4Lpbs834Yu9/rAPJv80pu7NVshSPDP3oVVoetk0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQymSwV6szg2iG9dtOd/1YBj2q+su9MneK82PtYwbLN9 vbfjifIdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkL4aRYcv5+S/ObL6nnc6Y Yu1dUr6nfHLVBp1Jt6qM5A9Ynd4sf5uR4XdZ02pNk6fmP0JmMD3ftm9qSVqvyXE5wQ1lVjs+STK vYgEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 25 Oct 2025 10:42:33 +0800, albin_yang@163.com wrote:
> Pde is erased from subdir rbtree through rb_erase(), but not set the node to EMPTY,
> which may result in uaf access. We should use RB_CLEAR_NODE() set the erased node
> to EMPTY, then pde_subdir_next() will return NULL to avoid uaf access.
> 
> We found an uaf issue while using stree-ng testing, need to run testcase getdent and
> tun in the same time. The steps of the issue is as follows:
> 1) use getdent to traverse dir /proc/pid/net/dev_snmp6/, and current pde is tun3;
> 2) in the [time windows] unregister netdevice tun3 and tun2, and erase them from
>    rbtree. erase tun3 first, and then erase tun2. the pde(tun2) will be released
>    to slab;
> 3) continue to getdent process, then pde_subdir_next() will return pde(tun2) which
>    is released, it will case uaf access.
> 
> [...]

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

[1/1] fs/proc: fix uaf in proc_readdir_de()
      https://git.kernel.org/vfs/vfs/c/60a7b9983b80


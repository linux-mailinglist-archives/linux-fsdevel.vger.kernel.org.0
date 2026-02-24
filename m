Return-Path: <linux-fsdevel+bounces-78231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIfDG8JtnWk9QAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 10:22:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD5B1847BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 10:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB58E30A54F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 09:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380DC36AB60;
	Tue, 24 Feb 2026 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUxd6dFR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B804718C933;
	Tue, 24 Feb 2026 09:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924917; cv=none; b=V16HcvLEsl1kd8OGA9h7fb7Rfy+atO6ocfS1zXpZ1Kgvesg269hDm5O8guTkcLx+J7Wie0Yrn2Vo3RbH5MPVaz/5EaMf4VF6aF/bvvaRWlJhyXDGOa11MBUsswC0Gvxt9PJucl1VihEyy4xLWbkYZl1tt6K/Qn79Opa6awh1qmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924917; c=relaxed/simple;
	bh=+ZgRL78h59vYKmP3VyntioFtrGYkFQJZf4vOZNcd73Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mq8Hw6R79NGtWJp+M86WKiI7iPp9wUZ4pnHUVc+0SM11e7xgOjTgDkRV3lPoKt7cH7hZvDnf1vl0p74SfxzBFLWMKHcO8jsfa4xmL3HMY4BbUAPus7S2xLDYGZ/OwAMyHbeKa4RcQvnbSLKfXRNcmnJGguVujrrd4AQ+Mc8OL9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUxd6dFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D05AC116D0;
	Tue, 24 Feb 2026 09:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771924917;
	bh=+ZgRL78h59vYKmP3VyntioFtrGYkFQJZf4vOZNcd73Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bUxd6dFRYF5CjDz33X1r/UnQKXjKmMF9dEuf62vIwFLdnNkcY0OyWYHxXbXD54A/F
	 vTh3dnkEceRvQUFpvZOjTh5DW4S+lpZOjtNfCA3+jrdIX9aMT+rlcXZxQy7oXuHFku
	 NSJ3BAYqLoSiZaCXJoOxiMkJRv1fhK1V2F++TLbemTHMxfN3gsEQTMH8GlokVIYkBc
	 eIKTmX1tuKPFWX/kB+ot2Cq6oFrjXVonHmwylG0cRCHj2Q5LpQym3QdW1b/7ChBosW
	 vk/vHOwrp8rL+nEoTlulg8VWi3v7fg/GKnskb0x5tTt2ir0In5D25MduK33aCMTev3
	 zRtbD92kfWgxQ==
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	stable@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] eventpoll: Fix integer overflow in ep_loop_check_proc()
Date: Tue, 24 Feb 2026 10:21:45 +0100
Message-ID: <20260224-flutwelle-gelernt-a94c18edb860@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223-epoll-int-overflow-v1-1-452f35132224@google.com>
References: <20260223-epoll-int-overflow-v1-1-452f35132224@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187; i=brauner@kernel.org; h=from:subject:message-id; bh=+ZgRL78h59vYKmP3VyntioFtrGYkFQJZf4vOZNcd73Y=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTOzd2wKiDhzaHSZ7cuMcs/fCq04fuzlbUzztZ5zV1ro bVBvvuYZEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE9t9hZGj0XxpzxPWh/PkO s1t9zHNnLrBvXXdm0rP1abm6bAt2yOxlZHhWbrrj367u36v8bTUeOajX25S5SmqwTNl//1imyw4 bVT4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78231-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DCD5B1847BD
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 20:59:33 +0100, Jann Horn wrote:
> If a recursive call to ep_loop_check_proc() hits the `result = INT_MAX`,
> an integer overflow will occur in the calling ep_loop_check_proc() at
> `result = max(result, ep_loop_check_proc(ep_tovisit, depth + 1) + 1)`,
> breaking the recursion depth check.
> 
> Fix it by using a different placeholder value that can't lead to an
> overflow.
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

[1/1] eventpoll: Fix integer overflow in ep_loop_check_proc()
      https://git.kernel.org/vfs/vfs/c/fdcfce93073d


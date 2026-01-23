Return-Path: <linux-fsdevel+bounces-75259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GASYHndNc2lDugAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 11:29:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB09D74559
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 11:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B55D302F380
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 10:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9751E34C155;
	Fri, 23 Jan 2026 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsRpqVkr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257D92777EA;
	Fri, 23 Jan 2026 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769163993; cv=none; b=abqRxo20iWia0JDIkZAUH2/DePp1j2FWHDTCGDQUtO7cb/gJk3Ub5NTnQB0//dfATR5XADuyAdVLpaGcwV/ZrMdSfI85CIStyWg8+v7g0vHH6y98piifMmZ+pVhqYVJ1lQd9hpG9MWtuStYKAxGtyNphJiy4bTXagTRCiPZMdV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769163993; c=relaxed/simple;
	bh=OdeSduHmTAzvihGJiHAik/WWY7qH/g767+4vH3CnIhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nW15/X9W8wXDBNbR7EMyO3dHd6GnNqTGtEPyWtKqWnRzRt/aotWljTePFEobMejz3ylZq7WBYKD+NIan4CCBaFa5itW7N6Y/qWUF0cAQQklycD/u/KPdqrMqJrNo2qsbz+qPb0xo7OLF0e6RH+fh1b+uAFAaDI6Tg02objTiUx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsRpqVkr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDA1C4CEF1;
	Fri, 23 Jan 2026 10:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769163992;
	bh=OdeSduHmTAzvihGJiHAik/WWY7qH/g767+4vH3CnIhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RsRpqVkrfSOfcs2UySBMqjofUtZ7pgivy+qoRaedsDe19iPTHxD175pXIjz6fDl9z
	 2rwjznHXpZgF1Ncjc3Fkfu+FQNxoAiOIV6SSi7k607Kbg3/lLtagmM95dTW8coe62z
	 X1a/QOc286Ocj7XaYPznZpfX58lZDQ3ONO8/E22lHNLaLj3T6ArmBdsiv3cxKt0BhT
	 MW+Bto3b8v697r7aLogo+afMRlefgxsu7KcorgFzUd5rZrHmFxcKEtGjIuvA7g9VqZ
	 GBxk/dTrSFGind+1Wq+2ZQa2rvQlLz1OXOu96Ujw9lGu6hT8s90jP3rWnS5Yysr7V+
	 82oljLL2R+Vlw==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] pid: reorder fields in pid_namespace to reduce false sharing
Date: Fri, 23 Jan 2026 11:26:26 +0100
Message-ID: <20260123-hoftheater-traufe-d81dc3c6c0c7@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260120204820.1497002-1-mjguzik@gmail.com>
References: <20260120204820.1497002-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1069; i=brauner@kernel.org; h=from:subject:message-id; bh=OdeSduHmTAzvihGJiHAik/WWY7qH/g767+4vH3CnIhs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQW+1wuKEg8u57/7aH5ai2HvC+Lb2hbNnXG9dN/awVv3 SqIOy7+pKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAianwM/9OvbpiUueKh4e38 55/jebW62PbNcdzjK3dGcHd0vu8mK36G/x5z3338bJZ39sL/5jOmdtP4fvJlrswJm59T3qbKsn5 5BzcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75259-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB09D74559
X-Rspamd-Action: no action

On Tue, 20 Jan 2026 21:48:20 +0100, Mateusz Guzik wrote:
> alloc_pid() loads pid_cachep, level and pid_max prior to taking the
> lock.
> 
> It dirties idr and pid_allocated with the lock.
> 
> Some of these fields share the cacheline as is, split them up.
> 
> [...]

Applied to the kernel-7.0.misc branch of the vfs/vfs.git tree.
Patches in the kernel-7.0.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: kernel-7.0.misc

[1/1] pid: reorder fields in pid_namespace to reduce false sharing
      https://git.kernel.org/vfs/vfs/c/e7d0463629d1


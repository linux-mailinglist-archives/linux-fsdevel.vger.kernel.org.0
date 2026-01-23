Return-Path: <linux-fsdevel+bounces-75297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIdzH0eMc2l0xAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 15:57:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C53774CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 15:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D817A303FF1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 14:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1FB32D0E7;
	Fri, 23 Jan 2026 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLYx87g/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C372D592D;
	Fri, 23 Jan 2026 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769180160; cv=none; b=c3CLc6ItCtfbFangUeLDqwwSVM8A7D8dE9Pd+UWtZkWj8VC6rqp4wDPainhYUiJNqXEn9ZK6B7CPT1wActlHEwwQPMP6cXazPvC4NjCkY4Wp8qcxSj5g4VDa5XdZDDyYlTdJYb7qIajgq0vE5Am+1j2rP2uSK5u/PZYNeN9Zx9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769180160; c=relaxed/simple;
	bh=nM6wei6S8isBJ7NthtQVm+j+g0SqQK+3QLy6kExLyIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QfF0sndnRPUOHkK10xcBuQlg3U3SgGTKOdaSNh6CDvDlo+/ljgcL2F/s7KNSF7Zweon+usKQMkfwfojN7x7eSScIgY2hvkxXTmxeakQpVrt/6lZhpbw0hQArYRAClrKehYAf+KHchvONzsveasxa+JJn4hq9BzwmfWzQNYRklKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLYx87g/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B572CC4CEF1;
	Fri, 23 Jan 2026 14:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769180160;
	bh=nM6wei6S8isBJ7NthtQVm+j+g0SqQK+3QLy6kExLyIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bLYx87g/G62pjSI+ZNYUkUAarMUnaVNtyIAxCm2HsS25NI2n0NU8LPH1dUQVO9aUj
	 JmOb71JDsQt9Aph47wYpgHW9UEdgsxGNMKV28I+O3buXzxvRgNPxqs51oBDwhuvtjS
	 V8iVP30SUF0gVs0eLr9ko/apo8O9aHN9CdlEkVP0YW0Yvbf47J6BOhXpK8PSb6KNb+
	 K5hz/Ylvpk6WMkoFz4lt7yinzviWR6tI1zaRw1hieJeD6n4uBVfcJ7oaZc49YPtpdv
	 WXf9ZKlqyWcyN256BgnzSOyowcOCdH+mAHG5ulYTD0Z9Be6VznPMAPZpAy5bsID+Fm
	 JKHDr09A0IG/w==
From: Christian Brauner <brauner@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: reset read-only fsflags together with xflags
Date: Fri, 23 Jan 2026 15:55:49 +0100
Message-ID: <20260123-diesmal-hetzjagd-5a1d71ef29b8@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260121193645.3611716-1-aalbersh@kernel.org>
References: <20260121193645.3611716-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1291; i=brauner@kernel.org; h=from:subject:message-id; bh=nM6wei6S8isBJ7NthtQVm+j+g0SqQK+3QLy6kExLyIY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQWd/9+clRfYY602nRVq2d5octWngw5eGhhc2QZ2417H Jl2B/iMO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACay4AUjwy5Tcf8P7wuNA0Md Ju9KOqerf8h4QfYqxo2vHY3+W9mfm8bwv7DnvbXFfUHxqPhw+UcT2c+KTmffy+k+w+WxyIG+BWt VmAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75297-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E4C53774CD
X-Rspamd-Action: no action

On Wed, 21 Jan 2026 20:36:43 +0100, Andrey Albershteyn wrote:
> While setting file attributes, the read-only flags are reset
> for ->xflags, but not for ->flags if flag is shared between both. This
> is fine for now as all read-only xflags don't overlap with flags.
> However, for any read-only shared flag this will create inconsistency
> between xflags and flags. The non-shared flag will be reset in
> vfs_fileattr_set() to the current value, but shared one is past further
> to ->fileattr_set.
> 
> [...]

Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.0.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.0.misc

[1/1] fs: reset read-only fsflags together with xflags
      https://git.kernel.org/vfs/vfs/c/9396bfdacb5a


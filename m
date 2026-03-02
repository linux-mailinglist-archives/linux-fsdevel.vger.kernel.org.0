Return-Path: <linux-fsdevel+bounces-78879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLWVJChjpWmJ/QUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 11:15:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F831D6358
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 11:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBFD830965ED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 10:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21AE395D8E;
	Mon,  2 Mar 2026 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMBR0xHs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C83639448E;
	Mon,  2 Mar 2026 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772446122; cv=none; b=CnSSokeZ3Ss0eZo5i4L9WFHmm2K6X/x0T1e6iGcqxKRvYSIbKWLRYFjwzJ1m/v78OwB1W5XvCK/e8qAEDyNHOFn5bqAEacrMkKPC1K0HtwycNNW59/dWW+DnFcD2znAvcXL9C149RAqKkjRthciLVcSf+GMfpq/DAaX206u/Fmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772446122; c=relaxed/simple;
	bh=TaxkzrEGBaT9PneQGTQJRqRh50qnh7AQ8q3hOddXbc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sczouN+QYDJO9osPQTeP/kQ7mFIJhaewXp8KCvfgUEo1rIr6fm6B0p4WrclE41iLIuH+GL7i3xiAibQeMnFicODxk9GIQQ5CIJ02cDzKWOrxyRvFlLXzR1YL2AI+p52S0uAzHlAnSediXa9U+tUTFEchxH6ppFp9TXgOZemNMGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMBR0xHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414FEC2BCAF;
	Mon,  2 Mar 2026 10:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772446122;
	bh=TaxkzrEGBaT9PneQGTQJRqRh50qnh7AQ8q3hOddXbc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eMBR0xHsAquhsBNoSljC/y+VT9NeDhyXbcxBUy1vOCVeqkM2ElSn3pTEICwm8IgAv
	 nlbC8F/SCKv5JBWzrW6Z2/d59ts1MvXaq47jWBxT65/xrZbkR6j735CjSVJLywq1qF
	 Myyq4VN/bzlw16r1UVvto9YhHs2n/jMfPtjr99CxaTp8WLKVrmBbHz+qFAN1nYlaWB
	 7OYRp0g/+/BIpyaJxQ/U2X7wrLZH/P0yoFUqmajW48mN5W/S77WyTuVyjy7v6Z7ESa
	 2HsnsZtmVHVoAUQgA25lJv9GZ6rGDJGGDYaAeIcPOrIyHWAhlhfMBwIXALCPY3GaPB
	 1FcCkjyA8wU9Q==
From: Christian Brauner <brauner@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v3] selftests/filesystems: Assume that TIOCGPTPEER is defined
Date: Mon,  2 Mar 2026 11:08:31 +0100
Message-ID: <20260302-hahnenkamm-flehen-401a6dfedc64@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260227-selftests-filesystems-devpts-tiocgptpeer-v3-1-07db4d85d5aa@kernel.org>
References: <20260227-selftests-filesystems-devpts-tiocgptpeer-v3-1-07db4d85d5aa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1232; i=brauner@kernel.org; h=from:subject:message-id; bh=TaxkzrEGBaT9PneQGTQJRqRh50qnh7AQ8q3hOddXbc8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQuTVz6omm5SjhjW7fAri/b7e349hQYs13MXiQxSVBR8 XzRZaPyjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInEMjL8L9XnMMj9rWtx5lLB g28XG585BRSH9XkYX5rNWLbEOLWdi+Gv8O8gxerexUreN2omB75bm6wzlZO7UyLS5fmk3RIHj65 kAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78879-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.685];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E4F831D6358
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 15:20:35 +0000, Mark Brown wrote:
> The devpts_pts selftest has an ifdef in case an architecture does not
> define TIOCGPTPEER, but the handling for this is broken since we need
> errno to be set to EINVAL in order to skip the test as we should. Given
> that this ioctl() has been defined since v4.15 we may as well just assume
> it's there rather than write handling code which will probably never get
> used.
> 
> [...]

Applied to the vfs-7.1.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.1.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.1.misc

[1/1] selftests/filesystems: Assume that TIOCGPTPEER is defined
      https://git.kernel.org/vfs/vfs/c/f7df26875b9a


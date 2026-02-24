Return-Path: <linux-fsdevel+bounces-78232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEuJGMlvnWk9QAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 10:30:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EFE1849FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 10:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A50FD30AB640
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 09:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AC236C0BA;
	Tue, 24 Feb 2026 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKmfUfR2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA62F1C862E;
	Tue, 24 Feb 2026 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771925434; cv=none; b=jCHWPTJhaMJOEI0fKHdfgiGyqoktPafGrvhQR8qWOvEpVTJGIHUXVyzDu4IxYycUd5HDLcPV13daEJ1nE32wtHZbmtOzvlo/83t1iqKPqv++SnkYCBrFM/uoLdke79PfTQh352UosDrcwJ7zHcaf4QRQiiumjRIR3n/H5gKvAVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771925434; c=relaxed/simple;
	bh=03awTux1Dw+dsQ6Wvx23bw+z2w3wycwlne1P3JaOyEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrmku5SSwk9y68km7DcS9tRi8ZulYjSRcEA1iBdi6la5GPjkgVSc9mYERkJz99JiteJxcASBRr/BWyqg7NsSeBBV7YpokmbcfttiTrbFMLfE2wCFZSLKq0TT2C+nz//rRmwIvJweVeSrZwaLpobM6J480I2ySs28fXhH5yZPxDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKmfUfR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C53FC116D0;
	Tue, 24 Feb 2026 09:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771925433;
	bh=03awTux1Dw+dsQ6Wvx23bw+z2w3wycwlne1P3JaOyEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nKmfUfR2gJjfHwIxBGqw/p0SfOszrBjVtFLH/FUPFEto074EAD0LNZ3V93nIoJTFG
	 sKVX+tvMpZFbducRBqb+K3uFT2aIrmsANr5lkKonlG75TB+IDQJn9i0BQeJN7WaI1U
	 iN57DyT4sZ0sNfskh0+ronZiCVoNa4BuvX1S/NaxxYAsnWkjLyWe6Wt2Pkg/BJL4ea
	 tgPCE4c9x6pZpoqqRmawvqeoUa2ogKanEkmyAbBs22aDMVKY+7+DmxQIEj0FD076i7
	 gFpvRVrJtug8wFIh+0IT3pJMFlCGRFgXOqWcG7+LGZLaPH3+9Hta7VjI2ylhkhvY9n
	 STH3w1opDNbSQ==
Date: Tue, 24 Feb 2026 10:30:29 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: jlayton@kernel.org, chuck.lever@oracle.com, alex.aring@gmail.com, 
	viro@zeniv.linux.org.uk, jack@suse.cz, arnd@arndb.de, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] Add support for empty path in openat and openat2 syscalls
Message-ID: <20260224-vorfuhr-spitzen-783550d623a2@brauner>
References: <20260223151652.582048-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260223151652.582048-1-jkoolstra@xs4all.nl>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78232-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[xs4all.nl];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,gmail.com,zeniv.linux.org.uk,suse.cz,arndb.de,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xs4all.nl:email]
X-Rspamd-Queue-Id: E8EFE1849FA
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 04:16:52PM +0100, Jori Koolstra wrote:
> To get an operable version of an O_PATH file descriptors, it is possible
> to use openat(fd, ".", O_DIRECTORY) for directories, but other files
> currently require going through open("/proc/<pid>/fd/<nr>") which
> depends on a functioning procfs.
> 
> This patch adds the O_EMPTY_PATH flag to openat and openat2. If passed
> LOOKUP_EMPTY is set at path resolve time.
> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---

Out of curiosity, did you pick this taken from our uapi-group list?

https://github.com/uapi-group/kernel-features?tab=readme-ov-file#at_empty_path-support-for-openat-and-openat2
https://github.com/uapi-group/kernel-features/issues/47

?


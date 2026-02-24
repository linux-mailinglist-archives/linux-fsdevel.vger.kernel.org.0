Return-Path: <linux-fsdevel+bounces-78298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aM7gOBz6nWnLSwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 20:21:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CC118BF33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 20:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D475D305C320
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 19:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C5C3ACA5B;
	Tue, 24 Feb 2026 19:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itx+6p8l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7752E5418;
	Tue, 24 Feb 2026 19:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960640; cv=none; b=U7OtA9FdcwUDsvxEUFUCoZ9wqpCSc8gN6/sJzAEhLSAewNApTQXVs7d2VP/qjaVFU7qDN1A60bFyTpc9nifWwSmZ9Axk+d8ygl9TUhLgJGjM0sFTQBe3HpD200oYZgGakDcEvJyfABS+xQ+XyxuBZTEP+oFPSJJfS9R+9/M521M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960640; c=relaxed/simple;
	bh=faguA4shdIM+KkhQL9WA+K6xihdWfZPqdSPDIbLMpKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXvo4owIvG1JRrA7fDDx5x0TlocVTvShJfeViXRnBW/nIWMGfpNv2yPJ1Zd9POWQIUGsFB8O9nd+Eutf/H41nyShWQL4e4dN7V6AKmEvW6TPY5eE/Nj7FIAfI9vEwI25FZvDdOkkQYlu4l+nEsZezuF8qko5X8NuWPfQmC4a/iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itx+6p8l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A02C116D0;
	Tue, 24 Feb 2026 19:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771960640;
	bh=faguA4shdIM+KkhQL9WA+K6xihdWfZPqdSPDIbLMpKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=itx+6p8lv4hxjibsTkQujlUwfXPNx271bSJ+A42P8iapQry7iyF17p5ZEVOhVZOzS
	 MdiR+XaaHySiKiasCTfuVQlGD1rNSyKD5b468rTUGitc8qx2ic3Xa6/ZDLjnBVu5qZ
	 9vC4RX1nBrzbv1eGWxyiJmq1CdG9rs+0dI5IcCcXQPUAxneB/RGJ7QeIMADqGJ56wb
	 u2guxdQ/VFHYQ64wBLhI4Moov/bXLyIDJay/NA6L0aRboM8uND4VHu+AL9Uc0kDb2e
	 j08DK+SRHnCenuA9KqU2397gFH9n4Xr+ud6q0mWTQmqJCek4REWFMyKNoXuHcuUFp0
	 MPLHOvbwkBtpA==
Date: Tue, 24 Feb 2026 11:17:19 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, miklos@szeredi.hu, bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/2] iomap: allow directio callers to supply _COMP_WORK
Message-ID: <20260224191719.GA13829@frogsfrogsfrogs>
References: <177188733433.3935463.11119081161286211234.stgit@frogsfrogsfrogs>
 <177188733463.3935463.15637212610999039409.stgit@frogsfrogsfrogs>
 <20260224140030.GA9516@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224140030.GA9516@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78298-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54CC118BF33
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 03:00:30PM +0100, Christoph Hellwig wrote:
> On Mon, Feb 23, 2026 at 03:07:53PM -0800, Darrick J. Wong wrote:
> >  #define IOMAP_DIO_NO_INVALIDATE	(1U << 26)
> > -#define IOMAP_DIO_COMP_WORK	(1U << 27)
> >  #define IOMAP_DIO_WRITE_THROUGH	(1U << 28)
> >  #define IOMAP_DIO_NEED_SYNC	(1U << 29)
> >  #define IOMAP_DIO_WRITE		(1U << 30)
> 
> Maybe move up IOMAP_DIO_NO_INVALIDATE to avoid unused bits?
> 
> Otherwise this looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Done, and thanks for the review!

--D


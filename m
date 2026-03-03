Return-Path: <linux-fsdevel+bounces-79246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yI8cGDj2pmmgawAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 15:54:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DEB1F1D82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 15:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C92E30055A0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 14:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E813B8950;
	Tue,  3 Mar 2026 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vwicla6O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6088447DF89;
	Tue,  3 Mar 2026 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549674; cv=none; b=nBybzX7DdWY+Heg1+0SFtN7T4PjAvmZZeDJULq7k9VRmyDCjc2DR4YUDTk5o7syRMG5jYpsw0z4V4u3Z2thPmK4eQtZ0A+DPZFTj0uPSmZmPZjlKeTX/q+1LDw8+Bcy42wWKuUaTpxjaxmApTHMFvdc1t/93FUTTpm3Zpg5jMw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549674; c=relaxed/simple;
	bh=Moit/K87vMx+jMZRbscMvV2mu0ip1PtbBQxaqyS4EQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AggJNj1Zt2nna7varF2vkv4nDecqZnrcl5kDO0ghu7j3eB9Sn7MkXLFcPH3haqaEBUD3ahT9v9gIJdgar1P7Ew1uyz6OfvjH8Qk84EpEG81xo/QmnkOEdmokb+HhCXYNPk8jkCeUA6QOXjSjdtHaOd6fgAZ3PWD/URiNgHM7kKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Vwicla6O; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4jkfdMOGxaOV5m+ZC+AwRoFEfjLylQ+rHaRfwNk7O8U=; b=Vwicla6OpwA/VRQpz/yGJeXdgp
	NX+CLnYGsqNIehvMHpoIbw9w933GaDmZ7GxahlFSVav/AR8kWx8mf7X6nMAZKWIsgVh9xMcqbuJXC
	pzvLOLxahgTuZ6rF5lFhOZFERle5fabVWukOlvfohVZ8fPV8toaK/jEzBbaXQUX25GHUBxlhe4yYN
	isN+Ind667wUw8iyFkXIUN22UEpY7DK5nQs+OKw7A3/V/SoCIMdGCyIfeorwjP6UQ0+0mcCSCFLxV
	N7vLZc2LLMpBzYwLGPjdmY40IMaKctaTfZUA9bSYJ2Pt8+YhRtDiW7xfzprZZKF0MuqBfqTI1tTSF
	egMFYnRg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxR8n-0000000FMSl-0TbL;
	Tue, 03 Mar 2026 14:54:29 +0000
Date: Tue, 3 Mar 2026 06:54:29 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, linux-fsdevel@vger.kernel.org, hch@lst.de,
	gabriel@krisman.be, amir73il@gmail.com, jack@suse.cz,
	fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/1] generic: test fsnotify filesystem error reporting
Message-ID: <aab2JbAZI8RFq_XE@infradead.org>
References: <177249785452.483405.17984642662799629787.stgit@frogsfrogsfrogs>
 <177249785472.483405.1160086113668716052.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177249785472.483405.1160086113668716052.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 03DEB1F1D82
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,lst.de,krisman.be,gmail.com,suse.cz];
	TAGGED_FROM(0.00)[bounces-79246-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Action: no action

> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2021, Collabora Ltd.
> + */

Where is this coming from?

> +#ifndef __GLIBC__
> +#include <asm-generic/int-ll64.h>
> +#endif

And what is this for?  Looks pretty whacky.

> +case "$FSTYP" in
> +xfs)
> +	# added as a part of xfs health monitoring
> +	_require_xfs_io_command healthmon
> +	# no out of place writes
> +	_require_no_xfs_always_cow
> +	;;
> +ext4)
> +	# added at the same time as uevents
> +	modprobe fs-$FSTYP
> +	test -e /sys/fs/ext4/features/uevents || \
> +		_notrun "$FSTYP does not support fsnotify ioerrors"
> +	;;
> +*)
> +	_notrun "$FSTYP does not support fsnotify ioerrors"
> +	;;
> +esac

Please abstract this out into a documented helper in common/

> +#
> +# The dm-error map added by this test doesn't work on zoned devices because
> +# table sizes need to be aligned to the zone size, and even for zoned on
> +# conventional this test will get confused because of the internal RT device.
> +#
> +# That check requires a mounted file system, so do a dummy mount before setting
> +# up DM.
> +#
> +_scratch_mount
> +test $FSTYP = xfs && _require_xfs_scratch_non_zoned
> +_scratch_unmount

Hmm, this is a bit sad.  Can we align the map?  Or should we carve in
and add proper error injection to the block code, which has been
somewhere on my todo list forever because dm-error and friends are
so painful to setup.  Maybe I need to expedite that.



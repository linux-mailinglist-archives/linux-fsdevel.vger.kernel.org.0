Return-Path: <linux-fsdevel+bounces-77530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yH9bB25elWk0PwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:38:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCB615378E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4F48301178D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 06:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DAC309DC0;
	Wed, 18 Feb 2026 06:38:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE932EB5CD;
	Wed, 18 Feb 2026 06:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771396711; cv=none; b=DmIBVmeRzmvFbB8x6AHSPhVaCT0VY9gGORb568WJ7yGv72SyWDRStW776CzHqfYbE0qOSiehrPb+U2A9+O0ADa0ip9aDkSzbwsDJH3jY0GH94a2kd52ddo3RM7tCAYxcSHKdfeRFChXyDSkef+5M+1MTh0A8slQhAqrFOua6gSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771396711; c=relaxed/simple;
	bh=Xh+aEf6fRSCm2Xp5MFk/l03KD7JiTa8EUFrR+GPqRc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MENER8rMJfTLttqU+8rtii6UNpj7FSuIKOLj+1sxgg3ecPSiQxf9tPLIxl0arhMR52Ubr4aRid6wupPj9xNM8eJJCIBtIIzxy//blfis2PRth4rokGK2lONYP+iwjhNpWzA9rFBISRHB6DJkQYnSTAsCCH0/wsUfiaMt/lxOpMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C2D4F68B05; Wed, 18 Feb 2026 07:38:27 +0100 (CET)
Date: Wed, 18 Feb 2026 07:38:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de,
	djwong@kernel.org
Subject: Re: [PATCH v3 23/35] xfs: add helper to check that inode data need
 fsverity verification
Message-ID: <20260218063827.GA8768@lst.de>
References: <20260217231937.1183679-1-aalbersh@kernel.org> <20260217231937.1183679-24-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217231937.1183679-24-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-77530-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: EDCB615378E
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 12:19:23AM +0100, Andrey Albershteyn wrote:
> +	       (offset < fsverity_metadata_offset(inode));

No need for the braces.

> +}
> +
> diff --git a/fs/xfs/xfs_fsverity.h b/fs/xfs/xfs_fsverity.h
> new file mode 100644
> index 000000000000..5fc55f42b317
> --- /dev/null
> +++ b/fs/xfs/xfs_fsverity.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2026 Red Hat, Inc.
> + */
> +#ifndef __XFS_FSVERITY_H__
> +#define __XFS_FSVERITY_H__
> +
> +#include "xfs.h"
> +
> +#ifdef CONFIG_FS_VERITY
> +bool xfs_fsverity_sealed_data(const struct xfs_inode *ip,
> +		loff_t offset);
> +#else
> +static inline loff_t xfs_fsverity_offset_to_disk(struct xfs_inode *ip,
> +						 loff_t pos)
> +{
> +	WARN_ON_ONCE(1);
> +	return ULLONG_MAX;
> +}
> +#endif	/* CONFIG_FS_VERITY */

It looks like this got messed up a bit when splitting the patches and
you want an xfs_fsverity_sealed_data stub here?

Also I'm not sure introducing the "sealed" terminology just for this
function make much sense.  Just say xfs_is_fsverity_data maybe?


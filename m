Return-Path: <linux-fsdevel+bounces-78267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NxhEBuvnWmgQwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 15:00:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC32D1881F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 15:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A49630F5818
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 14:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF1439C627;
	Tue, 24 Feb 2026 14:00:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B221A23A4;
	Tue, 24 Feb 2026 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771941642; cv=none; b=t8RhXVVNmGXjFxV+2P6a3Lg+zSxJBdpm9EoLt8Acmq1uAntcB83mNK7nOZ/r0pbBwXv87LIHGxaXrSg8V4N1ulOqiax8jzvACDxCJGACF1XzNVHwKlqxJ7zMsXpyXFncZQZo3+KYLO+IeX5fQTvnuPsptTWBXHWmE0HKZuKSbFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771941642; c=relaxed/simple;
	bh=GXTIbK49DlYAkMtDSgmMIqn5iqtFtB8PXEmjTPuhvxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmR6S6oU8hXokuIQDadrtaOHddvL3KZ+QCCaKjB8XLbkwFbPgEx9iobielxfFwXBRXuJH3Gv2BMXeyg29d9s6pM0MSnm6p1mS9guT5/GdJlHEufh+wgyBuUP8juJ62Mv75iYc0Q/V7TJL823R3fQc8aWl/6CnZHG0e2C6UNmm0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8855D68C7B; Tue, 24 Feb 2026 15:00:31 +0100 (CET)
Date: Tue, 24 Feb 2026 15:00:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, bpf@vger.kernel.org, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/2] iomap: allow directio callers to supply _COMP_WORK
Message-ID: <20260224140030.GA9516@lst.de>
References: <177188733433.3935463.11119081161286211234.stgit@frogsfrogsfrogs> <177188733463.3935463.15637212610999039409.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177188733463.3935463.15637212610999039409.stgit@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid,lst.de:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-78267-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: BC32D1881F8
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 03:07:53PM -0800, Darrick J. Wong wrote:
>  #define IOMAP_DIO_NO_INVALIDATE	(1U << 26)
> -#define IOMAP_DIO_COMP_WORK	(1U << 27)
>  #define IOMAP_DIO_WRITE_THROUGH	(1U << 28)
>  #define IOMAP_DIO_NEED_SYNC	(1U << 29)
>  #define IOMAP_DIO_WRITE		(1U << 30)

Maybe move up IOMAP_DIO_NO_INVALIDATE to avoid unused bits?

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


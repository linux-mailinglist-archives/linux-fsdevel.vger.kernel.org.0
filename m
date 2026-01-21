Return-Path: <linux-fsdevel+bounces-74819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMPiCSWRcGkaYgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 09:41:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF8A53B65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 09:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3397542AA2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 08:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B54B477E56;
	Wed, 21 Jan 2026 08:38:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226F0421EEC;
	Wed, 21 Jan 2026 08:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768984694; cv=none; b=M8hamiMabS7D+9HCQglNnMHmIlMFiOgX/0ALhQihG7TzV6zFxSerkAXFXiMJAX2n9tm/s+WTCzfIAmdop1489yJUHjpDGsWOSFWRgaNdrAzwQ3NiQIs3HRXatjnXijI3ueA0UIJhAszSphYjBTNqklDkM2o8+pVYHqWS1Pb644Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768984694; c=relaxed/simple;
	bh=ztCuDhTR1/VE13/PrrFQ1FjqyBka2YWhv+S+4Pjg+Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S91qVO9VR5ygRm5kuF8AkxmuDeJMhguBfxVgX/UxAndzMMhBTQfQ940A7pCzlPUJ8V43gxYDzRB6ftUPXjh9Ojqo+Ye4shUmOc6V+FM+ESwlzhP0Qb4fubPufoD1LPWcWnxEzGwAZXiuBaiXeLhSx31PApcaaZz4+TIMoxBsVHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 18495227AAA; Wed, 21 Jan 2026 09:38:08 +0100 (CET)
Date: Wed, 21 Jan 2026 09:38:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, chuck.lever@oracle.com,
	jlayton@kernel.org, neil@brown.name, okorniev@redhat.com,
	tom@talpey.com, alex.aring@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSD: Enforce recall timeout for layout conflict
Message-ID: <20260121083807.GA15669@lst.de>
References: <20260119174737.3619599-1-dai.ngo@oracle.com> <20260120072638.GA6380@lst.de> <0b0112f8-793c-42af-a2a7-ee662496a9e4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b0112f8-793c-42af-a2a7-ee662496a9e4@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : No valid SPF, No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74819-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lst.de,oracle.com,kernel.org,brown.name,redhat.com,talpey.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 7BF8A53B65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 10:54:39AM -0800, Dai Ngo wrote:
> Thank you Christoph! I have a couple of questions regarding to
> xfs_break_layouts and xfs_break_leased_layouts.
>
> . Should we break out of the while loop in xfs_break_leased_layouts
> if the 2nd call to break_layout, inside the while loop, returns error
> other than -EWOULDBLOCK?

Good question.

> . In xfs_break_leased_layouts, the return value of the 2nd call to
> break_layout was rightly ignored since the call was made without
> holding the xfs_inode lock so there could be a race condition where
> a new layout was handled out to another client.

I have to admin that I'm not sure what other errors we could
have.  Looking through the code I see:

 o -EINVAL for incorrect flags.
 o the error from lease_alloc, which could be -ENOMEM, -EINVAL
   again for a wrong type
 o -EINTR or similar from wait_event_interruptible_timeout

The -EINVAL cases can't happen, for code hygiene they probably should be
handled.  -EINTR means the caller gave up, so it should be handled.
-ENOMEM for the tiny structure is basically impossible to hit, but there
is no point in not giving up, so it should be handled as well.

So yeah, I think we should break out of the loop on error.



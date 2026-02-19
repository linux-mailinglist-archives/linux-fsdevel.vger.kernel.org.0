Return-Path: <linux-fsdevel+bounces-77665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGhTLfWllmmTiQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 06:56:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A8415C3D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 06:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EC483061E10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 05:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FA92D1916;
	Thu, 19 Feb 2026 05:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ntCE8AFe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970691CEADB;
	Thu, 19 Feb 2026 05:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771480385; cv=none; b=X2oEe2mwSJmb/Mv+6l1v5PLRLSC65AJweEQtdQxdSqhI51PTEOk9VmA8dUXzpCbIyePpq8P4y2fvQ+QKBhdtw+KRu5anCFN5aQOHxji6yG1bG47pc2CWJm50rHX4FCIGPNLM4Xb/H/vHWaJvKB4zJJz7PSlNljVJC0joL0rR6lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771480385; c=relaxed/simple;
	bh=K0kG06pKn3R2cRR9bHd4DBWXTxGuGqxRCAVx09mAWbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbsS8Qp3TfRcFoVF8pRT8vJC+U75C1u5eo88xwEuaGK5tvS8SzHB0/YoWFhSmpuc9VAMoyosehvLMJQLFdAvFxY5JMsY7L/uqCCvRjO2b1IgfVCwma/BGURSqny3NVa3AeO2Vg+7HUTf5wKKoC7s7BKrvDg2f6Iq6GOYbG3SX7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ntCE8AFe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LQrhLyPm/M05Es2tbws8TKLZ0/6cPO0ottKK4LiOVaU=; b=ntCE8AFeARo1GIWoJY+QnpjfXi
	o4Der/4fWe38FDkDB6WTZqoVdm7FeQOasOpsSI1J0ZktaBe10x+MP20q3vtSEHbt5y5NL7maylY9J
	sgr1q97XvXqbb9Vu0Gihvb69PaOZvAnGZfDCQGse62zVkmsdPtBLgyv+JEXAc6Cq3S1BvSjzRqxgd
	yzZyhB+Tc2YcASm5l0Ymff/4MGD50eljCjwVvFP8fEFOV/XlfJvWSucEMPhRmj5YOUkM4Nl1Kgl6w
	Wb4ajQQFQz7OTBbar41EGBpyNEwrFqwewGUIVrIh05g7Yq7AkOB6XoRGQRH5UZmlSzjLvr9JNEghi
	90Okxv4A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vswyF-0000000AvYN-0aiF;
	Thu, 19 Feb 2026 05:53:03 +0000
Date: Wed, 18 Feb 2026 21:53:03 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Chinner <dgc@kernel.org>,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Subject: Re: inconsistent lock state in the new fserror code
Message-ID: <aZalP0kfWO1rHf4_@infradead.org>
References: <aY7BndIgQg3ci_6s@infradead.org>
 <20260213160041.GT1535390@frogsfrogsfrogs>
 <20260213190757.GJ7693@frogsfrogsfrogs>
 <aY-n4leNi4NCzri1@dread>
 <aZQBAYCc5ouSoVXe@infradead.org>
 <20260218190039.GA6503@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218190039.GA6503@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77665-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 36A8415C3D0
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 11:00:39AM -0800, Darrick J. Wong wrote:
> > but that won't help other users like the block device code, zonefs and
> > gfs2.  Maybe we'll need an opt-in for the fserror reporting now to
> > exclude them?
> 
> <shrug> Assuming that file IO errors aren't a frequent occurrence, it's
> easy enough to attach them to a global list and schedule_worker to
> process the list when an error comes in.

I'd rather not created random forests of workqueues if we can.
Let file systems opt into features when they provide the infrastructure,
and left common enough infrastructure into common code as we usually do.

> 
> > On something related, if we require a user context for fserror_report
> > anyway, there is no need for the workqueue bouncing in it.
> 
> Bouncing the fserror_event to an async kworker is useful for laundering
> the inode locking context -- fsnotify and ->report_error know they're
> running in process context without any filesystem locks held.
> 
> I tried getting rid of the wq bouncing and immediately ran into the same
> lockdep complaint but on xfs_inode::i_flags_lock.

Ok.



Return-Path: <linux-fsdevel+bounces-79270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IC8SK+0Sp2mfdQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 17:57:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CA11F4338
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 17:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32C35305ED13
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 16:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92986481FAB;
	Tue,  3 Mar 2026 16:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lZUzoahV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF3D3DBD66;
	Tue,  3 Mar 2026 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556797; cv=none; b=blWisOkL/E7sN7lyz2hNyAYqwu6IS/zFh1zcna6Z+7kvz5Usy5rl8LcgjT/Eh9qxkyC85VYUBqr8L3FfFJd6nC/rw9HTE3j9Xlq9Q5QOSs5A4+B/F4VRks9cXZKKPgr55dB2RqB+csBo+j9kMIqwNGTdkffSxq15THtCZOLzuBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556797; c=relaxed/simple;
	bh=hM3JuSJObjPYSaMejdndGHeShGaty5RqSUN6GqELeZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdvcXfDSl3o8mAdJOrhpUsyqIL/36oNzo3frRrWXNiWLDChmykcR2q56uI2MTjTI0tkvl43Ppqy68Pz4soslLPQX9KdpnMYgmJkEjVtkEkdMMBPps1rgDt94YewFPM37vMYKDhG17wfLGBHWKz0zlL6YaJUYXoPvHzMJW66gzCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lZUzoahV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LK5ovpByNqMJYEsOUFqrGM8WApOp3poHiGmOjO+XhlA=; b=lZUzoahVcm4BR6DSZEXlobv0kn
	2M0ZYyZW3ViL5NF+WB88v0QV2eoS5wflLDsr3U5kTfkVag85Jfd00a65yz3jKtvdoIqbfFRMXdZQC
	DwKfOKlpBaUXOPtGt3GtAfv911qQEM7zNt7Zq793idsBDI3DkgXfbGZir0yVa4EyoOsYX2iCNysNz
	ZJyahRkTL6i/emRSuSRFW6HhEVY+m749s41o+eieuEazBXOuBXCT1WPqkajLgUbtKKMwwFiJFT59t
	FTVh4WJdkNjvEOJrNij/FpCkYKHjsIXyui6D2p5RT2HGGX9stlb1kzhR0itWWbR3Y8kVavwyUqZ5f
	0Nb8L5qw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxSzg-0000000FbtI-1hEH;
	Tue, 03 Mar 2026 16:53:12 +0000
Date: Tue, 3 Mar 2026 08:53:12 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, zlang@redhat.com,
	linux-fsdevel@vger.kernel.org, hch@lst.de, gabriel@krisman.be,
	amir73il@gmail.com, jack@suse.cz, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/1] generic: test fsnotify filesystem error reporting
Message-ID: <aacR-EYFd0x_nRz-@infradead.org>
References: <177249785452.483405.17984642662799629787.stgit@frogsfrogsfrogs>
 <177249785472.483405.1160086113668716052.stgit@frogsfrogsfrogs>
 <aab2JbAZI8RFq_XE@infradead.org>
 <20260303164901.GJ57948@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303164901.GJ57948@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 31CA11F4338
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,vger.kernel.org,lst.de,krisman.be,gmail.com,suse.cz];
	TAGGED_FROM(0.00)[bounces-79270-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 08:49:01AM -0800, Darrick J. Wong wrote:
> > > +ext4)
> > > +	# added at the same time as uevents
> > > +	modprobe fs-$FSTYP
> > > +	test -e /sys/fs/ext4/features/uevents || \
> > > +		_notrun "$FSTYP does not support fsnotify ioerrors"
> > > +	;;
> > > +*)
> > > +	_notrun "$FSTYP does not support fsnotify ioerrors"
> > > +	;;
> > > +esac
> > 
> > Please abstract this out into a documented helper in common/
> 
> Ok.  I'm not sure how to check for feature support on ext4 anymore since
> the uevents patch didn't get merged, and then I clearly forgot to rip
> that out of this helper here.

Oh.  Well, drop that then and move the xfs side and the default n
into a common helper instead of hardcoding it in the test.

> > and add proper error injection to the block code, which has been
> > somewhere on my todo list forever because dm-error and friends are
> > so painful to setup.  Maybe I need to expedite that.
> 
> I think it's theoretically possible to figure out that there's a zone
> size and then round outwards the error-target part of the dm table to
> align with a zone.

It's the sysfs chunk size.  btrfs/237 harcodes reading that out,
which could be easily lifted into a helper.

> I have a lot more doubts about whether or not doing
> that in bash/awk is a good idea though.  It'd be a lot easier if either
> the block layer did error injection or if someone just fixes those
> limitations in dm itself.

I'll sign up to do the block layer stuff.  Doing so should allow us
to run a lot more of the error injetion tests on zoned xfs, which
would be good.  So I guess you should keep it as-is for now,
and I'll do a sweep later.



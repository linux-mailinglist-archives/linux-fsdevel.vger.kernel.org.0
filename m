Return-Path: <linux-fsdevel+bounces-76533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Kq/KJWJ+hWkhCgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 06:38:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F356BFA633
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 06:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C38483033239
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 05:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AC433A010;
	Fri,  6 Feb 2026 05:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ge5847HW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA22D29994B
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 05:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770356316; cv=none; b=ELgCDf6FKhC4QDVF780LSly2/P0hai3hG4W2yI9Zc4fuOl+yBkcrzvboMgvrFmZyBnav+8PthImYhC3yynK1lqGVX6ql1a3ktvI/3nUSV0gmvZQ+uPVwWVokU8nykR9IEFSqdP4wE/Bm0oNVOtmEIcV6sLLLHwcHRouGZTGE5Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770356316; c=relaxed/simple;
	bh=3Yx97c2NQ1jwp5nVeJKhASKjaBk2JVAENb9oHlObJ5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzU62u3jrEGHwJhFvB2dPbD8Qrl7tR7HM7v+mdaxuOSkKVKEt0/wdpPDV05MZ5OyuJDVDnBfXamuCwK19uspK+D7z4wY/e24ZUnSt4ugUkZ6is/Lf3BaqEpI2u0vscMQrxoaiGMOTsqCH/1Wo4t31h96jAuSalLT5eXF1kjMtZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ge5847HW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5B5C16AAE;
	Fri,  6 Feb 2026 05:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770356316;
	bh=3Yx97c2NQ1jwp5nVeJKhASKjaBk2JVAENb9oHlObJ5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ge5847HWUWZZXuiLNJtYuOIxe5j7d2lXxq/SaCGMsutr35MRPVHwOrh6P62YQI76b
	 8HjRW3DminBrB9mKJXcar1toV+kUluYPbUwiDND7OTmd8fidYI6KVS6lbvNV387Fjf
	 KR+DKxUO2cY5T5H9Q7g2iaD8wwzE5NvblEydz5XsyTfIXhMZJsJnBhg/ll/l5eO4Om
	 RytS9vI2cYcoYs+e2O6t0wldTs11roKHWZnmzxo42/a6p5qc2fWaTfql7FV1s8qAbl
	 JM91h/vFY4tsf/aMAxu0LR8MZ02kHIVyMIE7Twt/ygltLMhrVwvN+CCN/2WjnFQOQC
	 gByv3acUH8uxQ==
Date: Thu, 5 Feb 2026 21:38:35 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, f-pc@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	Joanne Koong <joannelkoong@gmail.com>,
	John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Luis Henriques <luis@igalia.com>,
	Horst Birthelmer <horst@birthelmer.de>
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
Message-ID: <20260206053835.GD7693@frogsfrogsfrogs>
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <20260204190649.GB7693@frogsfrogsfrogs>
 <ce74079f-1e0a-4fee-9259-48f08c6989aa@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce74079f-1e0a-4fee-9259-48f08c6989aa@linux.alibaba.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[szeredi.hu,lists.linux-foundation.org,vger.kernel.org,gmail.com,groves.net,bsbernd.com,igalia.com,birthelmer.de];
	TAGGED_FROM(0.00)[bounces-76533-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: F356BFA633
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 06:50:28AM +0800, Gao Xiang wrote:
> 
> 
> On 2026/2/5 03:06, Darrick J. Wong wrote:
> > On Mon, Feb 02, 2026 at 02:51:04PM +0100, Miklos Szeredi wrote:
> 
> ...
> 
> > 
> >   4 For defaults situations, where do we make policy about when to use
> >     f-s-c and when do we allow use of the kernel driver?  I would guess
> >     that anything in /etc/fstab could use the kernel driver, and
> >     everything else should use a fuse container if possible.  For
> >     unprivileged non-root-ns mounts I think we'd only allow the
> >     container?
> 
> Just a side note: As a filesystem for containers, I have to say here
> again one of the goal of EROFS is to allow unprivileged non-root-ns
> mounts for container users because again I've seen no on-disk layout
> security risk especially for the uncompressed layout format and
> container users have already request this, but as Christoph said,
> I will finish security model first before I post some code for pure
> untrusted images.  But first allow dm-verity/fs-verity signed images
> as the first step.

<nod> I haven't forgotten.  For readonly root fses erofs is probably the
best we're going to get, and it's less clunky than fuse.  There's less
of a firewall due to !microkernel but I'd wager that most immutable
distros will find erofs a good enough balance between performance and
isolation.

Fuse, otoh, is for all the other weird users -- you found an old
cupboard full of wide scsi disks; or management decided that letting
container customers bring their own prepopulated data partitions(!) is a
good idea; or the default when someone plugs in a device that the system
knows nothing about.

> On the other side, my objective thought of that is FUSE is becoming
> complex either from its protocol and implementations (even from the

It already is.

> TODO lists here) and leak of security design too, it's hard to say
> from the attack surface which is better and Linux kernel is never
> regarded as a microkernel model. In order to phase out "legacy and
> problematic flags", FUSE have to wait until all current users don't
> use them anymore.
> 
> I really think it should be a per-filesystem policy rather than the
> current arbitary policy just out of fragment words, but I will
> prepare more materials and bring this for more formal discussion
> until the whole goal is finished.

Well yes, the transition from kernel to kernel-or-fuse would be
decided on a per-filesystem basis.  When the fuse driver reaches par
with the kernel driver on functionality and stability then it becomes a
candidate for secure container usage.  Not before.

--D

> Thanks,
> Gao Xiang
> 
> 


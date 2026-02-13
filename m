Return-Path: <linux-fsdevel+bounces-77186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFseOiqlj2nqSAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 23:26:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F00139C8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 23:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53C2D301FA52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 22:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5775530F542;
	Fri, 13 Feb 2026 22:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZxUJclKI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DCE30F94B
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 22:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771021604; cv=none; b=pN6i0PRXulEfbd93Nx0RaD/lCMxoRc+ImH//xexWE/vGopkWvghNrQ+/fL6H69NTGArRayw5G/zepPbOLR5eMGg4dEk3HFeeudvf3eXoMIGbT5w3R6UEsPeBvMe+wIc/C2sWzVCwMsGjx0ZhAlFuK3myB1X6+QN6ANmlLHiP+ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771021604; c=relaxed/simple;
	bh=GwROMAbL1+3sx/8u0qfvwRD001YOTNzn+0GG0fwmm20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfuTUwqOTnvkHX8U4NGAIwrF3D1VVfGHOmiygN9i/fLl3kaJ44JnQL/XUtu43X7MHl/krscPl3xrM+qG4cJipbptnuzfrwvpH238P8eP07bGmOPjGOZ4MWgBb+RW13QUA2KeAMpznPkyrHGxDhrBuJtgZH5VE7LcsL52tViJn/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZxUJclKI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vHGZP+Ia2jZJX0fG/DYe08+rcAKSfGFkUL04ogz27ZQ=; b=ZxUJclKIzHQ9FUhb0/gcMAlpAF
	PJeLRKsHinqvtQcMJbKRcaSBkIdyoVVPiKHgOkf3HWUwAs7z6hY5MIfx9YAyUjVO3MgiOFTQV2IPX
	QkOjOLhohv16xG/D/SpQ9oXD7/JpXi/PrsHHMxYV4O+B2Z+UqkPnPTyKJzKt2JutCyzgA2ifQCdEf
	USyCE+4UR43vOis4YgWYveJ8KABy2W2slH1RtMO7n1+d/xkMjrjMV1+Han7BJlqkwtVo/wLAF10lb
	xVw7ksHgWJ13XyVFo7feQMm35RJM1inkZXuEY2aP+wcQp+rjQqnn+ZJu63Q6K0L+5bawkIikOdgqR
	fZ8rWt0Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vr1ej-00000002KwU-2vH2;
	Fri, 13 Feb 2026 22:28:57 +0000
Date: Fri, 13 Feb 2026 22:28:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Askar Safin <safinaskar@gmail.com>
Cc: christian@brauner.io, hpa@zytor.com, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
	werner@almesberger.net, Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [RFC] pivot_root(2) races
Message-ID: <20260213222857.GR3183987@ZenIV>
References: <20260212192254.GO3183987@ZenIV>
 <20260213173427.112803-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213173427.112803-1-safinaskar@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-77186-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:url,linux.org.uk:email,linux.org.uk:dkim]
X-Rspamd-Queue-Id: 48F00139C8D
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 08:34:27PM +0300, Askar Safin wrote:
> Al Viro <viro@zeniv.linux.org.uk>:
> > We could restrict the set of those who could be flipped, but I doubt
> > that "could ptrace" is workable - that would exclude all kernel threads,
> > and that could easily break existing setups in hard-to-recover ways.
> 
> No. Kernel threads share cwd and root with init, because we create PID 1
> with CLONE_FS:
> 
> https://elixir.bootlin.com/linux/v6.19-rc5/source/init/main.c#L722

knfsd does not.  There's an explicit "give me a separate fs_struct" since
it want ->umask to be independent.


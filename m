Return-Path: <linux-fsdevel+bounces-76199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFRoA4ECgmmYNgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 15:13:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 968B7DA685
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 15:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5DAC53038746
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 14:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9133A6403;
	Tue,  3 Feb 2026 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYRf9eFw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E9039E6EF;
	Tue,  3 Feb 2026 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770127995; cv=none; b=RZZdxOrODHomTslJhKLBiYNmdzTbHBSSzVjO8ov2MSt2V838Imco2OQzsD/CrcA0xqkH/SAAkHxcgQ/DArHNJRCh67zVRGgoRf01G+EeKUARiikNX/zNSg4oqDUpAmE+RHa0oJFd4EeYzaCJcsP0xGGPnlRmUv5ErfMqfpCGAcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770127995; c=relaxed/simple;
	bh=ud6/qDTvHEv3JHnnq3Ok9bapKUCIHzeDxsblGDgexJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=je87LZP8xJ2sqjUA1hg4JwqWp1jHu8iF8SarmvGCn+hD7KPzXblhZ5Kt3T9Q5ff1Odfb7BxCOHWVYD9S8MLsq8nHSBYATMlTH+VE5TLnS6XrtBRfMyRiNfB6iWFG2evALAMrmwa9mvZVNGm5WTzbdP6V1XZCpsLjV77s4OWfG28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYRf9eFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F802C116D0;
	Tue,  3 Feb 2026 14:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770127995;
	bh=ud6/qDTvHEv3JHnnq3Ok9bapKUCIHzeDxsblGDgexJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GYRf9eFwtLq8EBYcO6i1U7KkKaGBeE95DuVUY3g/j0bZkkLmB2U4Z34BKihIk/VHC
	 YRgPU7UoWxFTyl61mLAi5gfkVq0HOory4CuKYteEQFmN1XUlcG63nJWgXB/AEz19vK
	 fGUmCVAJwUebhWEq7EX6QoZE610YiQ4CNP0/8pwxCEwjjCf4WhvJUFOnf8RE0b/pEu
	 Jl66aOM49PVBQBnJIqSRtDbyFbczCvG5AvTM7iI1OzDbeYsNkUON+UlTm2fO+lHw0f
	 5G9tqtICTb6V9+2eqqF8NfbRCYNLnddApOybvh2TkP9zw+mXTrERoLdPzamAj1p6e4
	 unT6t6w/hNLAg==
Date: Tue, 3 Feb 2026 15:13:09 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Mateusz Guzik <mjguzik@gmail.com>, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hughd@google.com, 
	linux-ext4@vger.kernel.org, tytso@mit.edu, linux-mm@kvack.org
Subject: Re: [PATCH v3 0/3] symlink length caching
Message-ID: <20260203-reibt-bestnote-7da2affa6e26@brauner>
References: <20241120112037.822078-1-mjguzik@gmail.com>
 <20241121-blatt-akkubetrieben-ad5d655d184a@brauner>
 <20260203042052.GE3183987@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260203042052.GE3183987@ZenIV>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76199-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,vger.kernel.org,google.com,mit.edu,kvack.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 968B7DA685
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 04:20:52AM +0000, Al Viro wrote:
> On Thu, Nov 21, 2024 at 01:34:44PM +0100, Christian Brauner wrote:
> 
> > [1/3] vfs: support caching symlink lengths in inodes
> >       https://git.kernel.org/vfs/vfs/c/5cbb3c7e0051
> > [2/3] ext4: use inode_set_cached_link()
> >       https://git.kernel.org/vfs/vfs/c/740456f67017
> > [3/3] tmpfs: use inode_set_cached_link()
> >       https://git.kernel.org/vfs/vfs/c/30071e02c163
> 
> _Very_ belated note: that needs D/f/porting.rst chunk that would cover
> readlink_copy() calling conventions change.

No probs. I'll put something in there in a second.


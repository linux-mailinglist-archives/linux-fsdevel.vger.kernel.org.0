Return-Path: <linux-fsdevel+bounces-76120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMGnCUB3gWk0GgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 05:19:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E091D4601
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 05:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 817A3302AC12
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 04:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C6922D4DD;
	Tue,  3 Feb 2026 04:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WCMqgmbW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B9A2F872;
	Tue,  3 Feb 2026 04:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770092338; cv=none; b=uZeTlrOoVvYb7FAa6Olb0XIV7mqYfAoeSoZeqgS9yZmbIXWKp/HiwRE42TkkLzdF9Y/K/U56kWNSi8TcSzGsFUwHFTslTSxe4xvKQs0XfZNLc7IAseywzdH/+p0rJU4K/tbg4fvpocFVgaiLyrb76jcPQJsG7uTrcosfLsklc8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770092338; c=relaxed/simple;
	bh=T96g8RZf2HiNGWnfiiWDdqHaK1F796GT951hJ+BawgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CF0UTeDpupozV31KOUUvPhXSswLzcm1cSXDWO6sedVLndKX3QcYurs7ikNOQ0Du+NgIbiaXLmG7KNA7nDbGVc8STQesGE0Ay5RFmYvs7GAZ0mW23z/ZqkKLx+RPL0oXudPZtZSxd/OJTR8EYtrQxXEZc0yhv44UCcS7ZzvA695M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WCMqgmbW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=j1EC3qmx1utMyRmMhZAixXk0veYGDBA20z6LB+wdtE4=; b=WCMqgmbWqBWHiuofigjqa/ucVy
	ICoza4SxJDvdD4jHCsxn1SlzA2Ffir47CN3Nt52ORO7RiNenS2oGFwjHn2icg43T1p8/t2j2SYexR
	7NJxdDz1D982a6S6lkbg1PgJEBmGw1j4h8+tkp5KPsZ5utK5f1XKgYBIc6IzgDxrx2oRSyM2Tn0/k
	SZgl1PVIJQA982nsBr9/eIfEVm/R/U5y30DCKvDdnnqe3laT5b5F3ZJkCEm40rcQboVKPfydeKbfz
	5Kfp+Yhx7/0ebFJ/OI/byBgJNpc6UtwOwgtkT4r+OtRJ3jS1dQid3cxImNr9vDgD5Ji7PnezXZvpU
	zNvBO7kQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vn7uG-0000000EktT-1dlK;
	Tue, 03 Feb 2026 04:20:52 +0000
Date: Tue, 3 Feb 2026 04:20:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	hughd@google.com, linux-ext4@vger.kernel.org, tytso@mit.edu,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 0/3] symlink length caching
Message-ID: <20260203042052.GE3183987@ZenIV>
References: <20241120112037.822078-1-mjguzik@gmail.com>
 <20241121-blatt-akkubetrieben-ad5d655d184a@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121-blatt-akkubetrieben-ad5d655d184a@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76120-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,vger.kernel.org,google.com,mit.edu,kvack.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7E091D4601
X-Rspamd-Action: no action

On Thu, Nov 21, 2024 at 01:34:44PM +0100, Christian Brauner wrote:

> [1/3] vfs: support caching symlink lengths in inodes
>       https://git.kernel.org/vfs/vfs/c/5cbb3c7e0051
> [2/3] ext4: use inode_set_cached_link()
>       https://git.kernel.org/vfs/vfs/c/740456f67017
> [3/3] tmpfs: use inode_set_cached_link()
>       https://git.kernel.org/vfs/vfs/c/30071e02c163

_Very_ belated note: that needs D/f/porting.rst chunk that would cover
readlink_copy() calling conventions change.


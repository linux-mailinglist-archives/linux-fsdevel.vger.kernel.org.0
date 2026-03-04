Return-Path: <linux-fsdevel+bounces-79348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mL5PBBorqGnJpAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 13:52:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB811FFE00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 13:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BA11302C35B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 12:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3D41E8826;
	Wed,  4 Mar 2026 12:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICg+Flg0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69361891A9;
	Wed,  4 Mar 2026 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772628540; cv=none; b=m5qrMnTbd5AQ03kJRUltf1PxfYsx2SF6vyq+RSPd6RcMULbvvEw6xdrdEc7Np/TYIIGtVX26D8NbJ40ocZw4kv7xAceVLmH6uHKCRHmOfA7U4cC6JdYWtcVysIY+AlTNQ7Np1QRAjgYzw9MKiGhGclhTCr1cmFvcAH/BlDky/ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772628540; c=relaxed/simple;
	bh=VZ1IQZ9wkbkriXYlTeVOKrSSDilZmIyjz5pgJIAWLf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ntqn5gMNlgTXpABHVYvoaGNGZs8Bzhq+xhx1mU14hkw2pFK/tW0Zpx3eoqd7V8HL49DBDJbyja5eSeEb9+PJdjpmDkjq3Yx+/uIsn9Dv0af0Ubxoi41X1VYF6tedMEzEgzkBn5nlaPRx3q5f0+qg007B2cxFghnAWE3e8s5F4hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICg+Flg0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D61C19423;
	Wed,  4 Mar 2026 12:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772628539;
	bh=VZ1IQZ9wkbkriXYlTeVOKrSSDilZmIyjz5pgJIAWLf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ICg+Flg0GucrcK/Rp72ulJveVObDKbF74VwXPM1WlSI1LMqELjkUi6Z1yVFSvEdzx
	 sg4f3jMhAsjPe5+eS4uJwrFgCLC2x634qa7461r+1moEHf8kfuFszeph0AdcKmsKt1
	 YMDXm8+ua/G1ZldiSP/pvm7kJJ5+jdEmXmP4WjhB+BGHY1wWU2IemjZNp5ejFtDqX6
	 s2Oj6yA0YXmbBsB/pxBp3PhBqI5lTneSZBpJ+rUdDB0eqzmP+2sLWm8Ifx5AUBKSWg
	 VFnLzZ2Iex6vpQbWkYuo7BYDlnmJBzjw37/lgcK6OewxZWkKpJpOLSe+IP52ji6eXd
	 MSUewpqUQg7zA==
Date: Wed, 4 Mar 2026 13:48:53 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>, 
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>, David Sterba <dsterba@suse.com>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, 
	linux-aio@kvack.org, Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [PATCH 18/32] fs: Provide operation for fetching
 mapping_metadata_bhs
Message-ID: <20260304-schalldicht-bushaltestelle-0ed92f03754a@brauner>
References: <20260303101717.27224-1-jack@suse.cz>
 <20260303103406.4355-50-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260303103406.4355-50-jack@suse.cz>
X-Rspamd-Queue-Id: 7CB811FFE00
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79348-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kernel.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 11:34:07AM +0100, Jan Kara wrote:
> When we move mapping_metadata_bhs to fs-private part of an inode the
> generic code will need a way to get to this struct from general struct
> inode. Add inode operation for this similarly to operation for grabbing
> offset_ctx.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Yeah, it's a good enough trade-off, I think.


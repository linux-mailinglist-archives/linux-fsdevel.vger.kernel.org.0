Return-Path: <linux-fsdevel+bounces-79345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BdkKyInqGlhowAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 13:35:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6D51FFBAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 13:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 665653036762
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 12:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C57619CD1B;
	Wed,  4 Mar 2026 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5HZ9ZXC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E523319004A;
	Wed,  4 Mar 2026 12:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772627564; cv=none; b=Qqngzr1ogLtk2fAMRntUPeqCW03wVTsRh7lJU+DqztoLKpfC4e49+fPqXRsg6ONAk/0hJZZauoB0dBx3PXQ69P6zhRSbqOq3KHyCvSrhA+3e7+KI4Pxo7UP4p6eysGtRu8+Il9+cMP2cixQ2CpB5Wb5lJ+aqToi0F+acnuhig/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772627564; c=relaxed/simple;
	bh=e83BLM5GvLOSGz2uXBojTED9JFHiqSjMgXE8Lu25qK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLMQ0ONFGx+ZeOV/KiaVFz0ICMxkdZ/gxWhhhgFr28Gr9uTLMV9RKAPVwdI5j0TKcvOcSv2GZumEZwZAahtrrrs5g3s+r0CTf9eEkt0S09EMpzUvQeaH96GUCEGUiUq1byuNG6JP6w82jY0XUfT2Y8BilnEBtm25y/IR8A8tJRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5HZ9ZXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC92C19423;
	Wed,  4 Mar 2026 12:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772627563;
	bh=e83BLM5GvLOSGz2uXBojTED9JFHiqSjMgXE8Lu25qK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O5HZ9ZXCJqHwto+K5TFar84RC/tF8oNzANWMk/pDTUv0yJW8zjeLJacXbuLVY3Xr1
	 9fkVHSKfuzVaATC6KcP4bJBtD8p7xm0HmEXyxf+kH/slGw+wp9sTxWhhWTjK4S2y90
	 C4ycuiLzzeab0IYT1W06GcB2c0bw/oaa5k3o7ZhXK1Ty7Vi48HNCNwwnfIM9Ywmner
	 mlqK0IhGLn6Ady683UiqkEk5BAzJ4r+nasY/agjsM9bTZVEBCFgsaiQula10UbtIJo
	 UVTGmS8PhJknVNsogbZWNgSsN9uPDBXfi8bl6orUalEer0ct1mZsEBEvrP2u+6VVmN
	 k7I44NAJRlW2w==
Date: Wed, 4 Mar 2026 13:32:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>, 
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>, David Sterba <dsterba@suse.com>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, 
	linux-aio@kvack.org, Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [PATCH 0/32] fs: Move metadata bh tracking from address_space
Message-ID: <20260304-badeort-amtieren-d02d2e06f2c5@brauner>
References: <20260303101717.27224-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260303101717.27224-1-jack@suse.cz>
X-Rspamd-Queue-Id: 4C6D51FFBAA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79345-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 11:33:49AM +0100, Jan Kara wrote:
> Hello,
> 
> this patch series cleans up the mess that has accumulated over the years in
> metadata buffer_head tracking for inodes, moves the tracking into dedicated
> structure in filesystem-private part of the inode (so that we don't use
> private_list, private_data, and private_lock in struct address_space), and also
> moves couple other users of private_data and private_list so these are removed
> from struct address_space saving 3 longs in struct inode for 99% of inodes.  I

Yes! I love it.


Return-Path: <linux-fsdevel+bounces-12582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0084786144A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 15:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824091F21F41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 14:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAA45C902;
	Fri, 23 Feb 2024 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M77T8CVa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DmLVAV+p";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M77T8CVa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DmLVAV+p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF1E469D;
	Fri, 23 Feb 2024 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699162; cv=none; b=Qe00CGvL5+UXwyveHwOZHqOYOdInc6UDPgTM8BSGQ2ShQkrvY6b319IQ12ENcQ7o+drotJTvYfey7qTbDhyB1WIE8LRZhkHJ7GJh7S/E8uF4ajRcIHyWMJFzol61Kuz5yw+7c+j+JjlOsUI5qiziY6vlAdGHza2VNNqljpNZAqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699162; c=relaxed/simple;
	bh=N88eDDApOukIVRHcVGEjQMGzPhYEOOIRcLiwXv6jgD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBlMnpvtDDa6dbx4Yfd5I42EhEMxZPo7lQ2k7k4+P+d/ji9h8V5a0gZL1zqSf5hguENeLdIdyT407oXwF434IjWYgiPAhDELMUUN64gnnF+UtSXeskboZsSk2o3xbcYQ/XDXJLD6DhvDEoaIq8tZ2RaTlr+rZgb8Xz/qfGQcRtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M77T8CVa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DmLVAV+p; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M77T8CVa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DmLVAV+p; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 580221FBFB;
	Fri, 23 Feb 2024 14:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708699158;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fqf5LsADRHXxXKfmIl35CcLoeH12CyZugLleg6TXNrY=;
	b=M77T8CVaaok7Ksa6dDWEBj2+oVk8RNAuZsLBZq3tx1Ebxd3CrthEj51bRAyltQjCde5VlS
	EarpIvPTprZKQoJ3ItuAuIEqFr9xW2VXAq4rtSnD7E1AEVD+bvbq826r67yzlKXfIiRoub
	uV0QqtTRTp5gDqfgLShRxuiqj4Onq3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708699158;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fqf5LsADRHXxXKfmIl35CcLoeH12CyZugLleg6TXNrY=;
	b=DmLVAV+pTHZyj7ceUEfw9I/f4gw9NAVj+lvBjPULLyTvPmljskCjPcMtLWoVK2xMKWxUVT
	8qaAia+VJbF78JAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708699158;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fqf5LsADRHXxXKfmIl35CcLoeH12CyZugLleg6TXNrY=;
	b=M77T8CVaaok7Ksa6dDWEBj2+oVk8RNAuZsLBZq3tx1Ebxd3CrthEj51bRAyltQjCde5VlS
	EarpIvPTprZKQoJ3ItuAuIEqFr9xW2VXAq4rtSnD7E1AEVD+bvbq826r67yzlKXfIiRoub
	uV0QqtTRTp5gDqfgLShRxuiqj4Onq3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708699158;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fqf5LsADRHXxXKfmIl35CcLoeH12CyZugLleg6TXNrY=;
	b=DmLVAV+pTHZyj7ceUEfw9I/f4gw9NAVj+lvBjPULLyTvPmljskCjPcMtLWoVK2xMKWxUVT
	8qaAia+VJbF78JAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3827013419;
	Fri, 23 Feb 2024 14:39:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id brFPDRau2GU6CAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Fri, 23 Feb 2024 14:39:18 +0000
Date: Fri, 23 Feb 2024 15:38:39 +0100
From: David Sterba <dsterba@suse.cz>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: lsf-pc@lists.linux-foundation.org,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, josef@toxicpanda.com,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] Meta/Integrity/PI
 improvements
Message-ID: <20240223143839.GP355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CGME20240222193304epcas5p318426c5267ee520e6b5710164c533b7d@epcas5p3.samsung.com>
 <aca1e970-9785-5ff4-807b-9f892af71741@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aca1e970-9785-5ff4-807b-9f892af71741@samsung.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=M77T8CVa;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DmLVAV+p
X-Spamd-Result: default: False [-0.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[24.13%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.01
X-Rspamd-Queue-Id: 580221FBFB
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Fri, Feb 23, 2024 at 01:03:01AM +0530, Kanchan Joshi wrote:
> - Is there interest in filesystem leveraging the integrity capabilities 
> that almost every enterprise SSD has.
> Filesystems lacking checksumming abilities can still ask the SSD to do
> it and be more robust.
> And for BTRFS - there may be value in offloading the checksum to SSD.
> Either to save the host CPU or to get more usable space (by not
> writing the checksum tree). The mount option 'nodatasum' can turn off
> the data checksumming, but more needs to be done to make the offload
> work.

What would be the interface for offloading? E.g. the SSD capability is
provided by the async hash in linux crypto API.

As you say using the nodatasum option for the whole filesystem would
achieve the offloading and not storing the checksums. But other ways
would need an interface how to communicate the checksum values back to
the filesystem.

Dealing with the ahash as interface is not straightforward, may need
additional memory for requests and set up of the pages to pass the
memory. All that and the latency caused by issuing the request and
waiting could be slower than calculating the checksum on CPU.

Also the ahash interface is getting less popular, fsverity removed the
support not so long ago [1].

[1] https://lore.kernel.org/linux-crypto/20230406003714.94580-1-ebiggers@kernel.org/


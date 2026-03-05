Return-Path: <linux-fsdevel+bounces-79508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMA2G8KuqWn+CAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 17:26:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D01B2156A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 17:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBC5B30143E7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 16:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC9A3CF661;
	Thu,  5 Mar 2026 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O5N/ugDf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9pOq8IWi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O5N/ugDf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9pOq8IWi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D313C196B
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Mar 2026 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772727967; cv=none; b=iyo5nl5rhYwfECTqggM8+wstBlILmYH4nbJ3jqyPClNtW6CbuoqAwdhG0vYEIzK7O4WJnDyyornH6GKGMJpaX6cM9IcQFp9TfjSF+1c8NQ0hBPTmKe9mhX3xxOQ9wmBAnIWDxjbRzOpjghjaaA4+sUiqRfnSBmr6nwglEEj/fmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772727967; c=relaxed/simple;
	bh=HGqB00AB7RfYl7eQ14ECMuCxDXvaGItvt4zGWvXrlKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FiWnylOn0hexisNGJX8YB8dg1Esw+ON/TW6shJHdUcd4ci924zhlrd7R48dqGCLmglS23IhCGaCa2iGgD9cEvfCloHuTPSk8RECFwmGw9wwKb+xLKr5SYglsfkgUlvQZjebGiOZiWBY/ybnLRihAMNDr4y9I/cw3G2C6dQM/+kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O5N/ugDf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9pOq8IWi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O5N/ugDf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9pOq8IWi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EFDEA5BD0A;
	Thu,  5 Mar 2026 16:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772727963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VGezUwpGLCZyfFsnbu7s9tP4TEmi7eYjBzsMCkw+Gog=;
	b=O5N/ugDfDf+EKx4H5We7WyyuAbOI6DVQZfA4VZS3BtBKV9d1WOUju5wFJxoyIpnRFW57/A
	8DHxy1jWDRurrt2p1Iw6YjxrtDBiUwonQ9dpn/Zqg2tDTtnXwUzzVR2cpzF4r8wuQq/g37
	OdpFB573MMG2TC7cykRZ5rKdf+Vb0hM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772727963;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VGezUwpGLCZyfFsnbu7s9tP4TEmi7eYjBzsMCkw+Gog=;
	b=9pOq8IWi3c4YFHD/3lMN0Ti9PI1JTmjf0/uqQG1n/wuEQ3bTb05RZlf4KSgIxT9Z6i7CcR
	6bNutGvPV6j0YVCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="O5N/ugDf";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9pOq8IWi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772727963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VGezUwpGLCZyfFsnbu7s9tP4TEmi7eYjBzsMCkw+Gog=;
	b=O5N/ugDfDf+EKx4H5We7WyyuAbOI6DVQZfA4VZS3BtBKV9d1WOUju5wFJxoyIpnRFW57/A
	8DHxy1jWDRurrt2p1Iw6YjxrtDBiUwonQ9dpn/Zqg2tDTtnXwUzzVR2cpzF4r8wuQq/g37
	OdpFB573MMG2TC7cykRZ5rKdf+Vb0hM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772727963;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VGezUwpGLCZyfFsnbu7s9tP4TEmi7eYjBzsMCkw+Gog=;
	b=9pOq8IWi3c4YFHD/3lMN0Ti9PI1JTmjf0/uqQG1n/wuEQ3bTb05RZlf4KSgIxT9Z6i7CcR
	6bNutGvPV6j0YVCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E24023EA68;
	Thu,  5 Mar 2026 16:26:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C6o0N5quqWlDcQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Mar 2026 16:26:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D2CF4A0A8D; Thu,  5 Mar 2026 17:26:01 +0100 (CET)
Date: Thu, 5 Mar 2026 17:26:01 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-ext4@vger.kernel.org, 
	Ted Tso <tytso@mit.edu>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, 
	David Sterba <dsterba@suse.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, linux-aio@kvack.org, 
	Benjamin LaHaise <bcrl@kvack.org>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	ntfs3@lists.linux.dev
Subject: Re: [PATCH 19/32] ntfs3: Drop pointless sync_mapping_buffers() call
Message-ID: <e6fzrub3lvas5uigxiwgw2qpukjlfj5ifikqvvrn5bttgigvoo@riarrr4smkgs>
References: <20260303101717.27224-1-jack@suse.cz>
 <20260303103406.4355-51-jack@suse.cz>
 <aag2nTROMNra7t6l@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aag2nTROMNra7t6l@infradead.org>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 2D01B2156A4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79508-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,kernel.org,zeniv.linux.org.uk,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kvack.org,paragon-software.com,lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Wed 04-03-26 05:41:49, Christoph Hellwig wrote:
> 
> Can you move the various cleanups that don't really depend on any of
> the refactoring to the front of the list?  i.e., drop all the useless
> code first before doing real changes?

Yeah, good idea. Done.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


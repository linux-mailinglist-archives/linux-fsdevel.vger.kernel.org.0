Return-Path: <linux-fsdevel+bounces-44829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18E3A6CF85
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 14:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2133B4A64
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 13:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880D6433A6;
	Sun, 23 Mar 2025 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FV9N5rQC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BBZhvwsV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FV9N5rQC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BBZhvwsV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FF218B03
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Mar 2025 13:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742737483; cv=none; b=g0H4kIM/vxPUiGdrJJUnHUyBvxcGJcTIFckKzRXqzhsSRQH3ESrvZaX0rYOCVPp6oMGMtcE1r51bgp9ZOzwuLOPKngg88FmxhIP2sV4Xy4enRAJ94bKfD8mNVZY2TNat4sFo6BCy5WKEUqP/jYyS5FGzVS31ZSBRQopT1m1Lh1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742737483; c=relaxed/simple;
	bh=sfV8sTeG3E1hItfwSdC8ohJjAPzeBI/flxFeIAONGIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UGErd2PADCrnmvqcMdC7je1rjXEYu9gS7d/o36v2HXijwYRMEoTxphtK3kNyKvqIkNuB5sYKSwmzSHj53L4bIzTrN1JKPm4jTkHmSY590P+SRinDptv6N/jshBsBkuzQmKKkIgG6ieisncs/0ugZLfHhr6Q5IL+RZ+Ijus4Wcm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FV9N5rQC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BBZhvwsV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FV9N5rQC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BBZhvwsV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4FD3C2119B;
	Sun, 23 Mar 2025 13:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742737172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BWVZ3Kdi+HJq7l0g1Bgu8S33aVRgtrlzt+LCiTo58HU=;
	b=FV9N5rQCUbKqNJpr6VK34cwLh5HERn+QGIxB7STG1L/z5HIDePujWJfc+ZRGrJivQtYwVH
	XS+2SkWbm+zfE2zlweOy86hoW4+0dIe9bn0GVzcxTrcVbPQm3V2FGxFBoLf9G+QjQltuLl
	/a/Q+Zfge3b/5RRWQ7j8n9q6WUHN874=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742737172;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BWVZ3Kdi+HJq7l0g1Bgu8S33aVRgtrlzt+LCiTo58HU=;
	b=BBZhvwsVeWCu5ErNU8iXwE0kf9m/svPIg6cc/iykFhiaUsGoDU/gx3OUWooVYxzQwU4ZNu
	ZV51dmE1M7a/6WCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742737172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BWVZ3Kdi+HJq7l0g1Bgu8S33aVRgtrlzt+LCiTo58HU=;
	b=FV9N5rQCUbKqNJpr6VK34cwLh5HERn+QGIxB7STG1L/z5HIDePujWJfc+ZRGrJivQtYwVH
	XS+2SkWbm+zfE2zlweOy86hoW4+0dIe9bn0GVzcxTrcVbPQm3V2FGxFBoLf9G+QjQltuLl
	/a/Q+Zfge3b/5RRWQ7j8n9q6WUHN874=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742737172;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BWVZ3Kdi+HJq7l0g1Bgu8S33aVRgtrlzt+LCiTo58HU=;
	b=BBZhvwsVeWCu5ErNU8iXwE0kf9m/svPIg6cc/iykFhiaUsGoDU/gx3OUWooVYxzQwU4ZNu
	ZV51dmE1M7a/6WCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D800213757;
	Sun, 23 Mar 2025 13:39:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VCzALhIP4Gc5NQAAD6G6ig
	(envelope-from <hare@suse.de>); Sun, 23 Mar 2025 13:39:30 +0000
Message-ID: <107a8fbf-c36d-4870-be86-ec1415139cab@suse.de>
Date: Sun, 23 Mar 2025 14:39:25 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] iov_iter: Add composite, scatterlist and skbuff
 iterator types
To: Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
 Christian Brauner <christian@brauner.io>,
 Matthew Wilcox <willy@infradead.org>, Chuck Lever <chuck.lever@oracle.com>,
 Steve French <smfrench@gmail.com>, Ilya Dryomov <idryomov@gmail.com>,
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250321161407.3333724-1-dhowells@redhat.com>
 <Z9-oaC3lVIMQ4rUF@infradead.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Z9-oaC3lVIMQ4rUF@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,brauner.io,infradead.org,oracle.com,gmail.com,lists.linux.dev,vger.kernel.org,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 3/23/25 07:21, Christoph Hellwig wrote:
> This is going entirely in the wrong direction.  We don't need more iter
> types but less.  The reason why we have to many is because the underlying
> representation of the ranges is a mess which goes deeper than just the
> iterator, because it also means we have to convert between the
> underlying representations all the time.
> 
> E.g. the socket code should have (and either has for a while or at least
> there were patches) been using bio_vecs instead of reinventing them as sk
> fragment.  The crypto code should not be using scatterlists, which are a
> horrible data structure because they mix up the physical memory
> description and the dma mapping information which isn't even used for
> most uses, etc.
> 
> So instead of more iters let's convert everyone to a common
> scatter/gather memory definition, which simplifies the iters.  For now
> that is the bio_vec, which really should be converted from storing a
> struct page to a phys_addr_t (and maybe renamed if that helps adoption).
> That allows to trivially kill the kvec for example.
> 
> As for the head/tail - that seems to be a odd NFS/sunrpc fetish.  I've
> actually started a little project to just convert the sunrpc code to
> use bio_vecs, which massively simplifies the code, and allows directly
> passing it to the iters in the socket API.  It doesn't quite work yet
> but shows how all these custom (and in this case rather ad-hoc) memory
> fragment representation cause a huge mess.
> 
> I don't think the iterlist can work in practice, but it would be nice
> to have for a few use cases.  If it worked it should hopefully allow
> to kill off the odd xarray iterator.
> 
Can we have a session around this?
IE define how iterators should be used, and what the iterator elements
should be. If we do it properly this will also fix the frozen page 
discussion we're having; if we define iterators whose data elements
are _not_ pages then clearly one cannot take a reference to them.

But in either case, we should define the long-term goal such that
people can start converting stuff.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


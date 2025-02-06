Return-Path: <linux-fsdevel+bounces-41037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3ADA2A1DD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 08:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B73587A3CE4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 07:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041D8224AF9;
	Thu,  6 Feb 2025 07:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Kf96egR0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4dIfEXf6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x8GyPV1i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XZMOyB1D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD236150997;
	Thu,  6 Feb 2025 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738826257; cv=none; b=LGpIjdw7kvoZTIT5XDZkjffOI5Tkw/WlEL2wCM0Z/+eKwO90syPLW7qvXWXG43f2TX2zXYTfLMMtlFo4MNB3cjkiGmtX6ylaLI31urHSBH5DTwBvMDC+B3VQvM7gDK/Z+qoI4vp/dlrpzvTmofQOpMHoVeU7c6AiFB+1wKQHJoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738826257; c=relaxed/simple;
	bh=LP4Xdkv4iWxcFUqvr3PgIYC8t/HTJMhbP0Mq6GMX/1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pzHN/b4BPESxevlI94f6b0ch+ek3AmK7cAd02eCh8DQdeG5aSfKyxnAppgOiBy9NS49dnO9ceq30Cp3WV2AZODnHhcun8nMWK98ZDus7dIdIwL7bbjoMtXr0GY3U3Fvkvbv6DuLMMKSsBomuRmFXWoeMIlTX0PfCsG0lFztfIro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kf96egR0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4dIfEXf6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x8GyPV1i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XZMOyB1D; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CE32621109;
	Thu,  6 Feb 2025 07:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738826254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cEyg1Bi1rQfmvb8epL9nCJGXKFIHdCSoAsPBBawULm0=;
	b=Kf96egR0sBf4qwcR9MOQdwGFBJmhJibX4vKv9RJ261v38xOfB4BqYukfjyEQR3p0dsgEiN
	byi7BTq/xWF1ZlqQ+yha1zhCSLjv1wGpYoqANBhlX3ViNNSIpT2L35F5k5z5V8BF43Elaf
	+YHmDmMdPNJfabUCw8nDgAGhsesVm68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738826254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cEyg1Bi1rQfmvb8epL9nCJGXKFIHdCSoAsPBBawULm0=;
	b=4dIfEXf6x7v/LVvV48fmeOcPYh0z83viirF7vSK+z0C++B0J2VGpwyoB3ANPj3VNTiEAog
	IP7y9K8eCCPmYqBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=x8GyPV1i;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XZMOyB1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738826253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cEyg1Bi1rQfmvb8epL9nCJGXKFIHdCSoAsPBBawULm0=;
	b=x8GyPV1i0pGtKnqipEZz0kHbH11Po+P7UwQ5dpc4E1ntmOjLi3DKNP+1JWdiL22UtxiKjv
	UPajT6kIp3xEeVcgOhzBnqqOTVGBds7MjY4QWH7MEsgGnCBnZHoqi+1YIYes/YFSTSHm1L
	d8WxlwrnXwSBSqnoF5cGe04/LdX3DV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738826253;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cEyg1Bi1rQfmvb8epL9nCJGXKFIHdCSoAsPBBawULm0=;
	b=XZMOyB1DdjSeLg/xFGC1Z2pTgyB/942hEuiJfd+CasqTxW1PYTH+E7q3uJqcBxKfu1iiqI
	mKwkPdM/n+BVAsBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3513813694;
	Thu,  6 Feb 2025 07:17:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kIAACw1ipGc/HgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 06 Feb 2025 07:17:33 +0000
Message-ID: <13223185-5c5e-4c52-b7ab-00155b5ebd86@suse.de>
Date: Thu, 6 Feb 2025 08:17:32 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] fs/buffer: simplify block_read_full_folio() with
 bh_offset()
To: Matthew Wilcox <willy@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, dave@stgolabs.net,
 david@fromorbit.com, djwong@kernel.org, kbusch@kernel.org,
 john.g.garry@oracle.com, hch@lst.de, ritesh.list@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, gost.dev@samsung.com,
 p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
References: <20250204231209.429356-1-mcgrof@kernel.org>
 <20250204231209.429356-2-mcgrof@kernel.org>
 <1b211dd3-a45d-4a2e-aa2a-e0d3e302d4ca@suse.de>
 <Z6PgGccx6Uz-Jum6@casper.infradead.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Z6PgGccx6Uz-Jum6@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CE32621109
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,stgolabs.net,fromorbit.com,oracle.com,lst.de,gmail.com,vger.kernel.org,kvack.org,samsung.com,pankajraghav.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 2/5/25 23:03, Matthew Wilcox wrote:
> On Wed, Feb 05, 2025 at 05:18:20PM +0100, Hannes Reinecke wrote:
>> One wonders: shouldn't we use plugging here to make I/O more efficient?
> 
> Should we plug at a higher level?
> 
> Opposite question: What if getblk() needs to do a read (ie ext2 indirect
> block)?

Ah, that. Yes, plugging on higher level would be a good idea.
(And can we check for nested plugs? _Should_ we check for nested plugs?)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


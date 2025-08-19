Return-Path: <linux-fsdevel+bounces-58339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DBFB2CE35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 22:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A082E7A958A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 20:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF4E3431F3;
	Tue, 19 Aug 2025 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oOA15c7e";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tFSIqqBt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XwbxSdkr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wYGx29Fy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80DD342CBA
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 20:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755636255; cv=none; b=qgLjTQzuSalzcNOwjkXoo8TcfyEzgC2gxjwQhYHgRagxz06tVaYSjQoGa6pIEn0g8p4RIfqSAt8jrkQBjzxxCn8Zrg2H3gpiOF7a6jV877qNdYxIMhwLXWKgVlJRtkRT2gx8sR5922ceJpdRBon81PC/06+Pikb4ya2ecxdfuuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755636255; c=relaxed/simple;
	bh=yskEc8wIv51cerhp8yPely1CfVqLSErm9MIbDOWH38o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZuAqUcvncr/oV7vufAnc1s85/Y4NOmncwwLufYtVxj4n8lBuOFSB8IeNNHZVkKz/P4IAhlqVpgkJD0WlCRtUmAcVySuf2hSUshSOQEJQ8Is/97jd/PGcnslKqNiE8606vvBtMvEg5vQaLmxWghiosyL/aIZrtnq1U6r21JStRdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oOA15c7e; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tFSIqqBt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XwbxSdkr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wYGx29Fy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EB5501F44F;
	Tue, 19 Aug 2025 20:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755636252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kiZBOHQHtS7EbNjRKsYFSr+h5VQ6vZxjO2imvwuLhOI=;
	b=oOA15c7eGyRdf4n2H7GgU8K4HcMeDQPuvx3bPqmQrcUtawHWOpEA/Huh9SebvuF1hFHCmG
	KoRSCQBQRaTiwLX1tqP8rjKs4mBkXpNHXkPHQ7/37ffZ8hiojqubaufzEQATSmZsR+wyOr
	3AHZ8M3E0GEzQnrcNmMXp3EFMH0Afdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755636252;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kiZBOHQHtS7EbNjRKsYFSr+h5VQ6vZxjO2imvwuLhOI=;
	b=tFSIqqBtW2N/udvlQea40zZMC2AT7SiA6YodsNkO6+rIWbzi9W/pljkbQGF2VyRb4AJxfM
	1a5jtWiuUU4QbbAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755636251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kiZBOHQHtS7EbNjRKsYFSr+h5VQ6vZxjO2imvwuLhOI=;
	b=XwbxSdkr33qPdw+3ERTYgPZcxXAie7Vj8URnWXAS0REhyyLuxtV2RBVZucZilgIpycx5fq
	WylThYYJhfJ4VKk3pJ3BylA7LHQMtWQj/VyKVCEpSWYrdZkVqz3WFY0shne2aGWbLuomVT
	Cii+Usr7LL0pWmKzO+Nhdk5J1bqTeRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755636251;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kiZBOHQHtS7EbNjRKsYFSr+h5VQ6vZxjO2imvwuLhOI=;
	b=wYGx29FyVubS9632GdTdghO+o4Z/4oiWTWDtP+eBFLtYYnGAEe0eVQupQ4cV/GJYUn+TNL
	d478VHmUC6zrG0DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 034F6139B3;
	Tue, 19 Aug 2025 20:44:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xWw1OhripGidMQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 19 Aug 2025 20:44:10 +0000
Message-ID: <168098e4-a5f1-4b51-8216-7adee9959ba9@suse.cz>
Date: Tue, 19 Aug 2025 22:44:11 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] module: Rename EXPORT_SYMBOL_GPL_FOR_MODULES to
 EXPORT_SYMBOL_FOR_MODULES
To: David Hildenbrand <david@redhat.com>, Daniel Gomez
 <da.gomez@samsung.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Matthias Maennich <maennich@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
 Peter Zijlstra <peterz@infradead.org>, Shivank Garg <shivankg@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20250808-export_modules-v4-1-426945bcc5e1@suse.cz>
 <8334f7f9-065f-40b9-9c1e-95223da7980d@redhat.com>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <8334f7f9-065f-40b9-9c1e-95223da7980d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On 8/8/25 4:17 PM, David Hildenbrand wrote:
> On 08.08.25 15:28, Vlastimil Babka wrote:
>> Christoph suggested that the explicit _GPL_ can be dropped from the
>> module namespace export macro, as it's intended for in-tree modules
>> only. It would be possible to restrict it technically, but it was
>> pointed out [2] that some cases of using an out-of-tree build of an
>> in-tree module with the same name are legitimate.
> 
> I'm wondering if we could revisit that idea later, and have a config
> option that enables that. The use cases so far were mostly around
> testing IIRC, where people already run their own debug kernel or sth.
> like that.

I don't know. It made sense to do this in-tree restriction when it
looked like it could be done unconditionally. But if it would need to be
opt-in config, I think there's little gain. As noted in the lwn
coverage, the metadata can be easily faked anyway. AFAIK the only
serious module loading restriction is then the module signing, so this
would be just a mostly pointless config option?


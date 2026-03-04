Return-Path: <linux-fsdevel+bounces-79341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGcJLaMMqGn2nQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 11:42:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 166591FE7FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 11:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 104D730649CC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 10:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2823A256C;
	Wed,  4 Mar 2026 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZLHfxDTX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vPMWUlPA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="caQrhDFz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EQdbKa/5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C66D3A256E
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772620813; cv=none; b=eK79807+bfOZQLFFtysdl3Up92Dcv7LZVJrZahgJ/3GqbeEWE9nkho5W3eIudIKvCvbL09LQ3ERiY18fJyfI1en7TcjVUvAiR+4mV3rL/lFDIZs/md6Bm3EEprgTwg1ke0KBVHddEsu6XW54yUwq+jO/8/tsAFAxaKdMqnkjDQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772620813; c=relaxed/simple;
	bh=HJuurylLEpWY15LbSVFsmvD0mNg8NiRZLT+fr0t04XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hrlc8So6wl+T8Q+OEjC5hPWDbWa9pwMTamK9Kxj2AQcTmsH6NP/mMJZ6jLa6wIJEr4RcoQICaZYp8OAMjrauTaR7l/Vsin/OhT32PdtNpdceGpQL5gzoNIq3pJT+g4ZcIVjqFQVxRa66haHBoOSkappeDz3993LrTfwYXzLGZRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZLHfxDTX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vPMWUlPA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=caQrhDFz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EQdbKa/5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D8C835BDA8;
	Wed,  4 Mar 2026 10:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772620808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rR4mFGqDHT/6JchhPqj+UuMDZU2uzO46m5RbHchsX9Q=;
	b=ZLHfxDTXd88gvTNwT3Ka24ez2S2uO+QE7DWNBCtzYbuZ7c0T0KLd7MiPrl6scYLJBzo2JX
	k2PxZEuWNwkFXfU5hmf0pfHqrus/oL10yhiV5r7rfM4FEMaeJBBb07HlTZTM9D5KJByV8L
	rDDb0BPWWDzgziPy6DPJQayZDw8jwpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772620808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rR4mFGqDHT/6JchhPqj+UuMDZU2uzO46m5RbHchsX9Q=;
	b=vPMWUlPAvMcKnCjpWaRoY+5IIULMdThDQh/E/phutN6IJVmtAnfdhjsxaJeP9e0rMPJWXO
	fImmX3aUuN9KD3CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=caQrhDFz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="EQdbKa/5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772620807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rR4mFGqDHT/6JchhPqj+UuMDZU2uzO46m5RbHchsX9Q=;
	b=caQrhDFzbGKavIUQi1sqVT+7pZYAf8DcTE7/5PJZEzHbOy1ah2uO7h7uodxKaXMw7J5ohI
	9rNzEZWTkz4grjQSopVA0NT1eHaLZzUbJb3vCLR0NaEolmI9PF3DEmdjRkVH/uxVjyOye8
	6n1hLyU9N98qligXwpZRghTz3MISPmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772620807;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rR4mFGqDHT/6JchhPqj+UuMDZU2uzO46m5RbHchsX9Q=;
	b=EQdbKa/5Zs3pYrJTTSDEqpLQN/0KujZA3iVGrDFUIUiIMswYPnTf3LXaIlnuGM6UOSZm/u
	jHyKsKAXtSpSzjAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDA883EA69;
	Wed,  4 Mar 2026 10:40:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Sq0rMgcMqGknGQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Mar 2026 10:40:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 93D53A0A1B; Wed,  4 Mar 2026 11:39:59 +0100 (CET)
Date: Wed, 4 Mar 2026 11:39:59 +0100
From: Jan Kara <jack@suse.cz>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-ext4@vger.kernel.org, 
	Ted Tso <tytso@mit.edu>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, 
	David Sterba <dsterba@suse.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, linux-aio@kvack.org, 
	Benjamin LaHaise <bcrl@kvack.org>, gfs2@lists.linux.dev
Subject: Re: [PATCH 11/32] gfs2: Don't zero i_private_data
Message-ID: <yeexpqj7bu7y4wxfdnhdpmcb3zq2qyre4vuot6ecrkmwrgqlx2@odyk7234usmj>
References: <20260303101717.27224-1-jack@suse.cz>
 <20260303103406.4355-43-jack@suse.cz>
 <CAHc6FU61tUwnFf4pXWun_nLnL2jyUYHLKAN7C1hanbKk0GTZMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU61tUwnFf4pXWun_nLnL2jyUYHLKAN7C1hanbKk0GTZMA@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 166591FE7FC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79341-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,kernel.org,zeniv.linux.org.uk,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kvack.org,lists.linux.dev];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Tue 03-03-26 13:32:31, Andreas Gruenbacher wrote:
> Jan,
> 
> On Tue, Mar 3, 2026 at 11:34 AM Jan Kara <jack@suse.cz> wrote:
> > The zeroing is the only use within gfs2 so it is pointless.
> 
> "Remove the explicit zeroing of mapping->i_private_data since this
> field is no longer used."
> 
> Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

Thanks for review. I've updated the changelog.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


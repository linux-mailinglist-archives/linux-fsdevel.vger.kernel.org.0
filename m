Return-Path: <linux-fsdevel+bounces-26232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A25E0956487
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 09:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 255701F24F7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 07:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDB2157E61;
	Mon, 19 Aug 2024 07:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S3SEZNvh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o9x9pfpj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S3SEZNvh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o9x9pfpj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E1F13D251;
	Mon, 19 Aug 2024 07:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724052263; cv=none; b=kqLMcVbRkJimHpdpcgSCQgQDh8MMhGSY4EJlay7MPRSXqlYSyjFNPhW2o9/1gQnn4gfGgRi1YBiFDnMOulJRBOlOtmkYVDFX2mZ/VGyC3XMtXe5s3mUs9QoygPMPr01IBTGoMTtyddEFUzHdTccKRyjTqGlBubhZ2wBTe+zT9sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724052263; c=relaxed/simple;
	bh=5YIMhDZUZeYPafGp0Lm3WkEFLktzBos1gDlOZOQ0T3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pc4oROGwxwwAwUEiPCbK3g7kJVm8ZjBWS3izSEB5lQe1GDmDaiSFVn29zfKwysX23RU7P/9dB1vwVdUze3OZluV7MV3D6TNQhVPCIBcU6Cxo4J3Dx1aBMFxZHftLV+nRZToOc1GXpo6+g9wLZwtrYVVIIsJaN5tmt+oUW62Poko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=S3SEZNvh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o9x9pfpj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=S3SEZNvh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o9x9pfpj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4D4D71FE59;
	Mon, 19 Aug 2024 07:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724052260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JjblsRBqQt9XjsCMWCyWHK13e3lgdICqrKWEtbCBKW0=;
	b=S3SEZNvhm9WB02+Yj0iwxpTwMArolRzc6wnybGvn2J+8qGiR0rfoTcvpg5Max5nb5FJfJd
	iO6jIN7L+PKGiqNssWaSwHmAVL1uWTjvxbCH3UQoZn1UaLE+89H0uyp5OeJxseArFFpk9c
	ZwZMxdcYpcFG6Sv0k53zd4KjDIOn2J0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724052260;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JjblsRBqQt9XjsCMWCyWHK13e3lgdICqrKWEtbCBKW0=;
	b=o9x9pfpjBRSjUbmYsJp+Oxan5rNjzeol4LQ03/xrnaphM7kOi9rB2OdaoTYn6QbL3GlebK
	PEluzKmCRGkqW/Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=S3SEZNvh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=o9x9pfpj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724052260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JjblsRBqQt9XjsCMWCyWHK13e3lgdICqrKWEtbCBKW0=;
	b=S3SEZNvhm9WB02+Yj0iwxpTwMArolRzc6wnybGvn2J+8qGiR0rfoTcvpg5Max5nb5FJfJd
	iO6jIN7L+PKGiqNssWaSwHmAVL1uWTjvxbCH3UQoZn1UaLE+89H0uyp5OeJxseArFFpk9c
	ZwZMxdcYpcFG6Sv0k53zd4KjDIOn2J0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724052260;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JjblsRBqQt9XjsCMWCyWHK13e3lgdICqrKWEtbCBKW0=;
	b=o9x9pfpjBRSjUbmYsJp+Oxan5rNjzeol4LQ03/xrnaphM7kOi9rB2OdaoTYn6QbL3GlebK
	PEluzKmCRGkqW/Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85C051397F;
	Mon, 19 Aug 2024 07:24:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vW8EHyPzwmZWfwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 19 Aug 2024 07:24:19 +0000
Message-ID: <df26beed-97c7-44e4-b380-2260b8331ea9@suse.de>
Date: Mon, 19 Aug 2024 09:24:11 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 00/10] enable bs > ps in XFS
Content-Language: en-US
To: David Howells <dhowells@redhat.com>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: brauner@kernel.org, akpm@linux-foundation.org, chandan.babu@oracle.com,
 linux-fsdevel@vger.kernel.org, djwong@kernel.org, gost.dev@samsung.com,
 linux-xfs@vger.kernel.org, hch@lst.de, david@fromorbit.com,
 Zi Yan <ziy@nvidia.com>, yang@os.amperecomputing.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
 john.g.garry@oracle.com, cl@os.amperecomputing.com, p.raghav@samsung.com,
 mcgrof@kernel.org, ryan.roberts@arm.com
References: <20240818165124.7jrop5sgtv5pjd3g@quentin>
 <20240815090849.972355-1-kernel@pankajraghav.com>
 <2924797.1723836663@warthog.procyon.org.uk>
 <3141777.1724012176@warthog.procyon.org.uk>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <3141777.1724012176@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4D4D71FE59
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCPT_COUNT_TWELVE(0.00)[21];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

On 8/18/24 22:16, David Howells wrote:
> Pankaj Raghav (Samsung) <kernel@pankajraghav.com> wrote:
> 
>> I am no expert in network filesystems but are you sure there are no
>> PAGE_SIZE assumption when manipulating folios from the page cache in
>> AFS?
> 
> Note that I've removed the knowledge of the pagecache from 9p, afs and cifs to
> netfslib and intend to do the same to ceph.  The client filesystems just
> provide read and write ops to netfslib and netfslib uses those to do ordinary
> buffered I/O, unbuffered I/O (selectable by mount option on some filesystems)
> and DIO.
> 
> That said, I'm not sure that I haven't made some PAGE_SIZE assumptions.  I
> don't *think* I have since netfslib is fully multipage folio capable, but I
> can't guarantee it.
> 
I guess you did:

static int afs_fill_super(struct super_block *sb, struct afs_fs_context 
*ctx)
{
         struct afs_super_info *as = AFS_FS_S(sb);
         struct inode *inode = NULL;
         int ret;

         _enter("");

         /* fill in the superblock */
         sb->s_blocksize         = PAGE_SIZE;
         sb->s_blocksize_bits    = PAGE_SHIFT;
         sb->s_maxbytes          = MAX_LFS_FILESIZE;
         sb->s_magic             = AFS_FS_MAGIC;
         sb->s_op                = &afs_super_ops;

IE you essentially nail AFS to use PAGE_SIZE.
Not sure how you would tell AFS to use a different block size;
maybe a mount option?

And there are several other places which will need to be modified;
eg afs_mntpt_set_params() is trying to read from a page which
won't fly with large blocks (converted to read_full_folio()?),
and, of course, the infamous AFS_DIR_BLOCKS_PER_PAGE which will
overflow for large blocks.

So some work is required, but everything looks doable.
Maybe I can find some time until LPC.

> Mostly this was just a note to you that there might be an issue with your code
> - but I haven't investigated it yet and it could well be in my code.
> 
Hmm. I'd rather fix the obvious places in afs first; just do a quick
grep for 'PAGE_', that'll give you a good impression of places to look at.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich



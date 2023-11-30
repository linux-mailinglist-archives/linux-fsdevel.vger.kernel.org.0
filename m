Return-Path: <linux-fsdevel+bounces-4354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4155A7FED0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 11:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7158F1C2040B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 10:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E9038F83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E122D10DB;
	Thu, 30 Nov 2023 02:18:47 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4447F1FCE9;
	Thu, 30 Nov 2023 10:18:46 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 336A113A5C;
	Thu, 30 Nov 2023 10:18:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id jbs+DIZhaGV6MgAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 30 Nov 2023 10:18:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A5C17A07E3; Thu, 30 Nov 2023 11:18:45 +0100 (CET)
Date: Thu, 30 Nov 2023 11:18:45 +0100
From: Jan Kara <jack@suse.cz>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use
 iomap
Message-ID: <20231130101845.mt3hhwbbpnhroefg@quack3>
References: <8734wnj53k.fsf@doe.com>
 <87ttp3hefd.fsf@doe.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttp3hefd.fsf@doe.com>
X-Spamd-Bar: +++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [5.89 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(1.20)[suse.cz];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 MID_RHS_NOT_FQDN(0.50)[];
	 MX_GOOD(-0.01)[];
	 BAYES_HAM(-3.00)[100.00%];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,infradead.org:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 5.89
X-Rspamd-Queue-Id: 4447F1FCE9

On Thu 30-11-23 13:15:58, Ritesh Harjani wrote:
> Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:
> 
> > Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:
> >
> >> Christoph Hellwig <hch@infradead.org> writes:
> >>
> >>> On Wed, Nov 22, 2023 at 01:29:46PM +0100, Jan Kara wrote:
> >>>> writeback bit set. XFS plays the revalidation sequence counter games
> >>>> because of this so we'd have to do something similar for ext2. Not that I'd
> >>>> care as much about ext2 writeback performance but it should not be that
> >>>> hard and we'll definitely need some similar solution for ext4 anyway. Can
> >>>> you give that a try (as a followup "performance improvement" patch).
> 
> ok. So I am re-thinknig over this on why will a filesystem like ext2
> would require sequence counter check. We don't have collapse range
> or COW sort of operations, it is only the truncate which can race,
> but that should be taken care by folio_lock. And even if the partial
> truncate happens on a folio, since the logical to physical block mapping
> never changes, it should not matter if the writeback wrote data to a
> cached entry, right?

Yes, so this is what I think I've already mentioned. As long as we map just
the block at the current offset (or a block under currently locked folio),
we are fine and we don't need any kind of sequence counter. But as soon as
we start caching any kind of mapping in iomap_writepage_ctx we need a way
to protect from races with truncate. So something like the sequence counter.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


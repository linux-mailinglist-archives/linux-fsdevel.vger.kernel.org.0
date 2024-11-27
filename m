Return-Path: <linux-fsdevel+bounces-35963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C5F9DA408
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 09:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAFBAB2209A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 08:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CB818C008;
	Wed, 27 Nov 2024 08:37:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3497E1114;
	Wed, 27 Nov 2024 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732696646; cv=none; b=GrzU5VYbJt6HvX+tp4J/ptIwCCQRrYC1TQJyWaXlA3ldqtOBDeAbb6HIzyEYm9m8V7Z9V2vweZ+L07owf4M4hEt6Ln2FTc/AnZYjN17QkBg8GxVmacwrBNvnb8EEcKEUy0718VDe+wSKSGXZhPQtgaPiGCU5cQZSF9KGHygrZpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732696646; c=relaxed/simple;
	bh=r/4spSDsO2Eq03HHcRzuwsSHv01JdyKPJ0trxriIq2s=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Uh9A7gbLcPbgPiUY5kixOc/TNzCafT3kuB9U7L2rOXKo1mPS2axYZnOcGFjm3lYCSMKvAJIU9kfkIoULCyA+ttGMpDOm6IPl9pH8aDQl8Vl2qtq4GaMNwwvkvGVEUCSZfGz9cFlO4U4sAvQNZKRzQS+XQLetjAYG299uJuADvQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 67ECD1F74D;
	Wed, 27 Nov 2024 08:37:22 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2067813941;
	Wed, 27 Nov 2024 08:37:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Vl/SLT7aRmfsLAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 27 Nov 2024 08:37:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jan Kara" <jack@suse.cz>
Cc: "Anders Blomdell" <anders.blomdell@gmail.com>,
 "Philippe Troin" <phil@fifi.org>, "Jan Kara" <jack@suse.cz>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Andrew Morton" <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Regression in NFS probably due to very large amounts of readahead
In-reply-to: <20241126150613.a4b57y2qmolapsuc@quack3>
References: <>, <20241126150613.a4b57y2qmolapsuc@quack3>
Date: Wed, 27 Nov 2024 19:37:10 +1100
Message-id: <173269663098.1734440.13407516531783940860@noble.neil.brown.name>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 67ECD1F74D
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

On Wed, 27 Nov 2024, Jan Kara wrote:
> On Tue 26-11-24 11:37:19, Jan Kara wrote:
> > On Tue 26-11-24 09:01:35, Anders Blomdell wrote:
> > > On 2024-11-26 02:48, Philippe Troin wrote:
> > > > On Sat, 2024-11-23 at 23:32 +0100, Anders Blomdell wrote:
> > > > > When we (re)started one of our servers with 6.11.3-200.fc40.x86_64,
> > > > > we got terrible performance (lots of nfs: server x.x.x.x not
> > > > > responding).
> > > > > What triggered this problem was virtual machines with NFS-mounted
> > > > > qcow2 disks
> > > > > that often triggered large readaheads that generates long streaks of
> > > > > disk I/O
> > > > > of 150-600 MB/s (4 ordinary HDD's) that filled up the buffer/cache
> > > > > area of the
> > > > > machine.
> > > > >=20
> > > > > A git bisect gave the following suspect:
> > > > >=20
> > > > > git bisect start
> > > >=20
> > > > 8< snip >8
> > > >=20
> > > > > # first bad commit: [7c877586da3178974a8a94577b6045a48377ff25]
> > > > > readahead: properly shorten readahead when falling back to
> > > > > do_page_cache_ra()
> > > >=20
> > > > Thank you for taking the time to bisect, this issue has been bugging
> > > > me, but it's been non-deterministic, and hence hard to bisect.
> > > >=20
> > > > I'm seeing the same problem on 6.11.10 (and earlier 6.11.x kernels) in
> > > > slightly different setups:
> > > >=20
> > > > (1) On machines mounting NFSv3 shared drives. The symptom here is a
> > > > "nfs server XXX not responding, still trying" that never recovers
> > > > (while the server remains pingable and other NFSv3 volumes from the
> > > > hanging server can be mounted).
> > > >=20
> > > > (2) On VMs running over qemu-kvm, I see very long stalls (can be up to
> > > > several minutes) on random I/O. These stalls eventually recover.
> > > >=20
> > > > I've built a 6.11.10 kernel with
> > > > 7c877586da3178974a8a94577b6045a48377ff25 reverted and I'm back to
> > > > normal (no more NFS hangs, no more VM stalls).
> > > >=20
> > > Some printk debugging, seems to indicate that the problem
> > > is that the entity 'ra->size - (index - start)' goes
> > > negative, which then gets cast to a very large unsigned
> > > 'nr_to_read' when calling 'do_page_cache_ra'. Where the true
> > > bug is still eludes me, though.
> >=20
> > Thanks for the report, bisection and debugging! I think I see what's going
> > on. read_pages() can go and reduce ra->size when ->readahead() callback
> > failed to read all folios prepared for reading and apparently that's what
> > happens with NFS and what can lead to negative argument to
> > do_page_cache_ra(). Now at this point I'm of the opinion that updating
> > ra->size / ra->async_size does more harm than good (because those values
> > show *desired* readahead to happen, not exact number of pages read),
> > furthermore it is problematic because ra can be shared by multiple
> > processes and so updates are inherently racy. If we indeed need to store
> > number of read pages, we could do it through ractl which is call-site loc=
al
> > and used for communication between readahead generic functions and caller=
s.
> > But I have to do some more history digging and code reading to understand
> > what is using this logic in read_pages().
>=20
> Hum, checking the history the update of ra->size has been added by Neil two
> years ago in 9fd472af84ab ("mm: improve cleanup when ->readpages doesn't
> process all pages"). Neil, the changelog seems as there was some real
> motivation behind updating of ra->size in read_pages(). What was it? Now I
> somewhat disagree with reducing ra->size in read_pages() because it seems
> like a wrong place to do that and if we do need something like that,
> readahead window sizing logic should rather be changed to take that into
> account? But it all depends on what was the real rationale behind reducing
> ra->size in read_pages()...
>=20

I cannot tell you much more than what the commit itself says.
If there are any pages still in the rac, then we didn't try read-ahead
and shouldn't pretend that we did. Else the numbers will be wrong.

I think the important part of the patch was the
delete_from_page_cache().
Leaving pages in the page cache which we didn't try to read will cause
a future read-ahead to skip those pages and they can only be read
synchronously.

But maybe you are right that ra, being shared, shouldn't be modified
like this.

Thanks,
NeilBrown


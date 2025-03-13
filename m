Return-Path: <linux-fsdevel+bounces-43941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F5BA60273
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 21:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21BD01899372
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 20:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C171F3D50;
	Thu, 13 Mar 2025 20:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0iybBKZ/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vely52lh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N+W4Q1Mv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gFP3DcqD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C4E42AA9
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897329; cv=none; b=ADotH4aAO5YYhHgwOfONDrgRdzwPCj7irWet7EpnbEw2gBcP7HrH8hDQs8IHYtSFw1Aj2tie9hArH84g6u5tJY2XwQm1sCj8QvkwQ5DEmw0yPmshxKRspt0hgUILpXMeMNoZ0mYuw3DLtGpsgdKSz3NElKDZ1nmoakaeyfjRg3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897329; c=relaxed/simple;
	bh=QyIG9iZVp8qDeQ+9WFBtjBw9YJz+ONoMfblPgiDGmo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dByDCuovheAU2GxrbzVqRA1+6Zgs5TLhIh/JWGgFJNYLSLc+x+y7pV43nu1Y/Q9GdQBGHcq/YW8nX9bPrP/XkbNdcLi5CzElgvNgAF6isM4q87zpOsnGxx3cBwgq6UcjVwpUXptqsEZ5kMGO8AymGoBeCq7g9HEQAhB8S0mHSmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0iybBKZ/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vely52lh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N+W4Q1Mv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gFP3DcqD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 632651F452;
	Thu, 13 Mar 2025 20:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741897325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oCdvYaM7IiALjyTNbjWLtO2g/pLQ2/kScVpX65BzQRs=;
	b=0iybBKZ/7P3vcPQ8waBcokAGuhUrZ0d0evAW6kImlxWBUoAimJCwiGEmeviavZZ+9/zZBE
	Vw+ySL7rigb/Bz4F+0nZ4XHy5d089+t2lmqIr+dp6tLeziawoO07+WgeG0NQ0CpAdcAGNo
	iQkvXDPLarsztpjGwSekJZdncpnO/5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741897325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oCdvYaM7IiALjyTNbjWLtO2g/pLQ2/kScVpX65BzQRs=;
	b=Vely52lh+pvfU0yku7jB1Md4c9eSrbdJ6Z8FqKaEESav7unOrfCEY1X6qhpgo+IAszBO5N
	bkM7bVAUi5xDZpBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=N+W4Q1Mv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gFP3DcqD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741897324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oCdvYaM7IiALjyTNbjWLtO2g/pLQ2/kScVpX65BzQRs=;
	b=N+W4Q1Mvmq8QWCzDbvgD1ySe5gsu7BwiPaw898tuJfdhPyzcLbxK+jjfl/aU6p1lbPMmxA
	fXUMg5J8Rw91F7Yk/D7W+NuS1fyx7sNO6s7ERAJGaV3npLIE6RW+EeOf6Q4NHpj1cdJxfr
	IF7USx+kW962R1Z8TJFgoqLQbUuUK94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741897324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oCdvYaM7IiALjyTNbjWLtO2g/pLQ2/kScVpX65BzQRs=;
	b=gFP3DcqDPt1YnWYH7mZDY/lMczGSuwVgy0UntI2OzypzpysyscAf3voCHj9EUX2P+c8DxY
	AKbN2i64jFGbXEDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53A5E13797;
	Thu, 13 Mar 2025 20:22:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M40sFGw+02cLdAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 13 Mar 2025 20:22:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 10F9EA0908; Thu, 13 Mar 2025 21:22:00 +0100 (CET)
Date: Thu, 13 Mar 2025 21:22:00 +0100
From: Jan Kara <jack@suse.cz>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, 
	Christoph Hellwig <hch@lst.de>, lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	anuj20.g@samsung.com, mcgrof@kernel.org, joshi.k@samsung.com, axboe@kernel.dk, 
	clm@meta.com, willy@infradead.org, gost.dev@samsung.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Parallelizing filesystem writeback
Message-ID: <qdgoyhi5qjnlfk6zmlizp2lcrmg43rwmy3tl4yz6zkgavgfav5@nsfculj7aoxe>
References: <CGME20250129103448epcas5p1f7d71506e4443429a0b0002eb842e749@epcas5p1.samsung.com>
 <20250129102627.161448-1-kundan.kumar@samsung.com>
 <Z5qw_1BOqiFum5Dn@dread.disaster.area>
 <20250131093209.6luwm4ny5kj34jqc@green245>
 <Z6GAYFN3foyBlUxK@dread.disaster.area>
 <20250204050642.GF28103@lst.de>
 <s43qlmnbtjbpc5vn75gokti3au7qhvgx6qj7qrecmkd2dgrdfv@no2i7qifnvvk>
 <Z6qkLjSj1K047yPt@dread.disaster.area>
 <20250220141824.ju5va75s3xp472cd@green245>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250220141824.ju5va75s3xp472cd@green245>
X-Rspamd-Queue-Id: 632651F452
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Thu 20-02-25 19:49:22, Kundan Kumar wrote:
> > Well, that's currently selected by __inode_attach_wb() based on
> > whether there is a memcg attached to the folio/task being dirtied or
> > not. If there isn't a cgroup based writeback task, then it uses the
> > bdi->wb as the wb context.
> 
> We have created a proof of concept for per-AG context-based writeback, as
> described in [1]. The AG is mapped to a writeback context (wb_ctx). Using
> the filesystem handler, __mark_inode_dirty() selects writeback context
> corresponding to the inode.
> 
> We attempted to handle memcg and bdi based writeback in a similar manner.
> This approach aims to maintain the original writeback semantics while
> providing parallelism. This helps in pushing more data early to the
> device, trying to ease the write pressure faster.
> [1] https://lore.kernel.org/all/20250212103634.448437-1-kundan.kumar@samsung.com/

Yeah, I've seen the patches. Sorry for not getting to you earlier.
 
> > Then selecting inodes for writeback becomes a list_lru_walk()
> > variant depending on what needs to be written back (e.g. physical
> > node, memcg, both, everything that is dirty everywhere, etc).
> 
> We considered using list_lru to track inodes within a writeback context.
> This can be implemented as:
> struct bdi_writeback {
>  struct list_lru b_dirty_inodes_lru; // instead of a single b_dirty list
>  struct list_lru b_io_dirty_inodes_lru;
>  ...
>  ...
> };
> By doing this, we would obtain a sharded list of inodes per NUMA node.

I think you've misunderstood Dave's suggestion here. list_lru was given as
an example of a structure for inspiration. We cannot take it directly as is
for writeback purposes because we don't want to be sharding based on NUMA
nodes but rather based on some other (likely FS driven) criteria.

> However, we would also need per-NUMA writeback contexts. Otherwise,
> even if inodes are NUMA-sharded, a single writeback context would stil
> process them sequentially, limiting parallelism. But there’s a concern:
> NUMA-based writeback contexts are not aligned with filesystem geometry,
> which could negatively impact delayed allocation and writeback efficiency,
> as you pointed out in your previous reply [2].
> 
> Would it be better to let the filesystem dictate the number of writeback
> threads, rather than enforcing a per-NUMA model?

I was thinking about how to best parallelize the writeback and I think
there are two quite different demands for which we probably want two
different levels of parallelism.

One case is the situation when the filesystem for example has multiple
underlying devices (like btrfs or bcachefs) or for other reasons writeback
to different parts is fairly independent (like for different XFS AGs). Here
we want parallelism at rather high level I think including separate
dirty throttling, tracking of writeback bandwidth etc.. It is *almost* like
separate bdis (struct backing_dev_info) but I think it would be technically
and also conceptually somewhat easier to do the multiplexing by factoring
out:

        struct bdi_writeback wb;  /* the root writeback info for this bdi */
        struct list_head wb_list; /* list of all wbs */
#ifdef CONFIG_CGROUP_WRITEBACK
        struct radix_tree_root cgwb_tree; /* radix tree of active cgroup wbs */
        struct rw_semaphore wb_switch_rwsem; /* no cgwb switch while syncing */
#endif
        wait_queue_head_t wb_waitq;

into a new structure (looking for a good name - bdi_writeback_context???)
that can get multiplied (filesystem can create its own bdi on mount and
configure there number of bdi_writeback_contexts it wants). We also need to
add a hook sb->s_ops->get_inode_wb_context() called from __inode_attach_wb()
which will return appropriate bdi_writeback_context (or perhaps just it's
index?) for an inode. This will be used by the filesystem to direct
writeback code where the inode should go. This is kind of what Kundan did
in the last revision of his patches but I hope this approach should
somewhat limit the changes necessary to writeback infrastructure - the
patch 2 in his series is really unreviewably large...

Then another case is a situation where either the amount of CPU work is
rather high for IO submission (cases like Christoph mentioned where
filesystem needs to do checksumming on submission or similar) or simply the
device is rather fast for a single submission thread and the FS doesn't
have a sensible way to partition inodes (e.g. for ext4 there's no
meaningful way of partitioning inodes into independent groups - ext4
allocation groups are small and inodes often span multiple groups and the
sets of groups used by different inodes randomly overlap). In this case I
think we want single dirty throttling instance, single writeback throughput
estimation, single set of dirty inode lists etc. The level where the
parallelism needs to happen is fairly low - I'd say duplicate:

	struct delayed_work dwork;      /* work item used for writeback */

in struct bdi_writeback. Again, the number of dworks should be configurable
when creating bdi for the filesystem. 

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


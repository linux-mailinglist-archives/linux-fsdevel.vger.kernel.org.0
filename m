Return-Path: <linux-fsdevel+bounces-42585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DCCA44650
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 17:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36DD517341E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 16:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E56819415E;
	Tue, 25 Feb 2025 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ki2w8xfi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9Qe53lea";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MTRufa88";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E5rvB8Yz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E765218CC13
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501383; cv=none; b=QNjlWuEMrjXbS+e30ONvFJuRHCPkSVFRns8rzfsc9be3iRbpd2izeBdJf23+FKCQNgHOK4IHvD6Sk9sdFtmDl3uJwKNinWv/EIsoI15vqpBjZbWLf+ni5P8WFKipWs8AhbwrgzB18r0oJnvsBCH9paoWyIEqmB+k/r9ZC1c7+Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501383; c=relaxed/simple;
	bh=sc1vjX+0nxD/pUDmVV6amc/2wI0YPUs+YZVKf1VsByA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9NEWB9KPxqqaZ01wX5Tphglnl+IQIbpIPpWXGse2BOCD5AmtSvm1muEjTHAvoibrY30mL4khvl5/G2XYFtC2eXs+2b4D7NP7+oJbFGlOlY5porDL/ycAlkxcFBV6G+RZIC0bqO2t7X3PcGtLen09Cw/hF0d/b9wzNy6RiBatrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ki2w8xfi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9Qe53lea; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MTRufa88; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E5rvB8Yz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D3A271F44F;
	Tue, 25 Feb 2025 16:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740501380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PiCce6OsxqzWvruanZPQSkDrsXsjyuoHKjj8amNVC6I=;
	b=ki2w8xfioEAPzRw98WhKB7xOFgR1laC6zeJvJc82rRof4UpXmsOymvww2qeaEgSUqTHD09
	RS9vnxf8dErrmqtKdRJqby3xVsibJznmSj/oKthL/vzvhQ9y7dsLmJ6VgW/uLgljBgMn9b
	qZGbgRhiLeD+7WIf/0u8KGRNru25i9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740501380;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PiCce6OsxqzWvruanZPQSkDrsXsjyuoHKjj8amNVC6I=;
	b=9Qe53leawz8dSpjTbDinKf4tZ0xFQKPuutjCzbgbMJ4PrX6b31ii5OPGy1DSGWbWuXCetU
	D9eoI0rSsnf2uDCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740501379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PiCce6OsxqzWvruanZPQSkDrsXsjyuoHKjj8amNVC6I=;
	b=MTRufa88Sg73b61LE7l3CPDpLXxbpqI3rO/o+2Dy7bVschXKaBd9seBkaD5CIMJnNfcc03
	R7w1hMW0KYLC3LnnzYjKRoaaavzZhyPgK4aP9NSugiFPEXXxChb5h7QGnagw5TVCCTDrSw
	fYSnuFdS9zMu8XVKzmHGhcUituHj+wY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740501379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PiCce6OsxqzWvruanZPQSkDrsXsjyuoHKjj8amNVC6I=;
	b=E5rvB8Yz7OmgX28mcmHB0ftybK9BCxiLTzlMyCdnnmMSpFGMXBQCv+TxAOS/2f0iw+Bx24
	3kbZe95cVJ/p1lBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C834013888;
	Tue, 25 Feb 2025 16:36:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HbfZMIPxvWfLQAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Feb 2025 16:36:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 82F7AA08E0; Tue, 25 Feb 2025 17:36:19 +0100 (CET)
Date: Tue, 25 Feb 2025 17:36:19 +0100
From: Jan Kara <jack@suse.cz>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jan Kara <jack@suse.cz>, 
	lsf-pc@lists.linux-foundation.org, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	David Hildenbrand <david@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Juan Yescas <jyescas@google.com>, android-mm <android-mm@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, 
	"Cc: Android Kernel" <kernel-team@android.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Optimizing Page Cache Readahead
 Behavior
Message-ID: <jenbcj2kmujffuznxsmy4ozqch77ay5jzznx5ftvevgr663er6@wym7xxkbv2sc>
References: <CAC_TJvfG8GcwG_2w1o6GOTZS8tfEx2h9A91qsenYfYsX8Te=Bg@mail.gmail.com>
 <hep2a5d6k2kwth5klatzhl3ejbc6g2opqu6tyxyiohbpdyhvwp@lkg2wbb4zhy3>
 <3bd275ed-7951-4a55-9331-560981770d30@lucifer.local>
 <ivnv2crd3et76p2nx7oszuqhzzah756oecn5yuykzqfkqzoygw@yvnlkhjjssoz>
 <82fbe53b-98c4-4e55-9eeb-5a013596c4c6@lucifer.local>
 <CAC_TJvcnD731xyudgapjHx=dvVHY+cxoO1--2us7oo9TqA9-_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC_TJvcnD731xyudgapjHx=dvVHY+cxoO1--2us7oo9TqA9-_g@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Mon 24-02-25 13:36:50, Kalesh Singh wrote:
> On Mon, Feb 24, 2025 at 8:52 AM Lorenzo Stoakes
> > > > > OK, I agree the behavior you describe exists. But do you have some
> > > > > real-world numbers showing its extent? I'm not looking for some artificial
> > > > > numbers - sure bad cases can be constructed - but how big practical problem
> > > > > is this? If you can show that average Android phone has 10% of these
> > > > > useless pages in memory than that's one thing and we should be looking for
> > > > > some general solution. If it is more like 0.1%, then why bother?
> > > > >
> 
> Once I revert a workaround that we currently have to avoid
> fault-around for these regions (we don't have an out of tree solution
> to prevent the page cache population); our CI which checks memory
> usage after performing some common app user-journeys; reports
> regressions as shown in the snippet below. Note, that the increases
> here are only for the populated PTEs (bounded by VMA) so the actual
> pollution is theoretically larger.
> 
> Metric: perfetto_media.extractor#file-rss-avg
> Increased by 7.495 MB (32.7%)
> 
> Metric: perfetto_/system/bin/audioserver#file-rss-avg
> Increased by 6.262 MB (29.8%)
> 
> Metric: perfetto_/system/bin/mediaserver#file-rss-max
> Increased by 8.325 MB (28.0%)
> 
> Metric: perfetto_/system/bin/mediaserver#file-rss-avg
> Increased by 8.198 MB (28.4%)
> 
> Metric: perfetto_media.extractor#file-rss-max
> Increased by 7.95 MB (33.6%)
> 
> Metric: perfetto_/system/bin/incidentd#file-rss-avg
> Increased by 0.896 MB (20.4%)
> 
> Metric: perfetto_/system/bin/audioserver#file-rss-max
> Increased by 6.883 MB (31.9%)
> 
> Metric: perfetto_media.swcodec#file-rss-max
> Increased by 7.236 MB (34.9%)
> 
> Metric: perfetto_/system/bin/incidentd#file-rss-max
> Increased by 1.003 MB (22.7%)
> 
> Metric: perfetto_/system/bin/cameraserver#file-rss-avg
> Increased by 6.946 MB (34.2%)
> 
> Metric: perfetto_/system/bin/cameraserver#file-rss-max
> Increased by 7.205 MB (33.8%)
> 
> Metric: perfetto_com.android.nfc#file-rss-max
> Increased by 8.525 MB (9.8%)
> 
> Metric: perfetto_/system/bin/surfaceflinger#file-rss-avg
> Increased by 3.715 MB (3.6%)
> 
> Metric: perfetto_media.swcodec#file-rss-avg
> Increased by 5.096 MB (27.1%)
> 
> [...]
> 
> The issue is widespread across processes because in order to support
> larger page sizes Android has a requirement that the ELF segments are
> at-least 16KB aligned, which lead to the padding regions (never
> accessed).

Thanks for the numbers! It's much more than I'd expect. So you apparently
have a lot of relatively small segments?

> Another possible way we can look at this: in the regressions shared
> above by the ELF padding regions, we are able to make these regions
> sparse (for *almost* all cases) -- solving the shared-zero page
> problem for file mappings, would also eliminate much of this overhead.
> So perhaps we should tackle this angle? If that's a more tangible
> solution ?
> 
> From the previous discussions that Matthew shared [7], it seems like
> Dave proposed an alternative to moving the extents to the VFS layer to
> invert the IO read path operations [8]. Maybe this is a move
> approachable solution since there is precedence for the same in the
> write path?

Yeah, so I certainly wouldn't be opposed to this. What Dave suggests makes
a lot of sense. In principle we did something similar for DAX. But it won't be
a trivial change so details matter...

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


Return-Path: <linux-fsdevel+bounces-52535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCEDAE3E71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 13:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309CA3B7A22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 11:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6862472AA;
	Mon, 23 Jun 2025 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ycWt5zaO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z/+KnzlY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ycWt5zaO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z/+KnzlY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBD6246BA8
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 11:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679172; cv=none; b=L+eHAC2AMOSK7dRsi9uvNe0aLABisDPEixQbcBg5tJlTX0FmrWay0PvMS2FK4koSLpbG4VRbiypAyYEpZ4zP6Aq3XUb5dbQVXZlg791A7Yg5X0e/blSXXcJRdQd1/5bfBeHRPKoTNmNNPHClh2bSHtfj1+FALcDX+Q5V/fx3oX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679172; c=relaxed/simple;
	bh=2XB5GWQD6GjYFCP7EPP8tOevInmD8p1v2tY/GyP+3IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcFlWsHz1oQEkw/PBgKb3b+Zx0ORnc6wDM4B9sXAz1ZLMDVbTSN7XdO05JlTYS1PObrbMb2wQXY4VJciTm6OuX1SAf2OS4d0dLvoK9xx4UJYNW6HggvbLhkCvb0ytabOIAfQDWzs6vCHE3/uKCFgtMmEuU5cDXQvDqrSSl+/shE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ycWt5zaO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z/+KnzlY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ycWt5zaO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z/+KnzlY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 922FE1F385;
	Mon, 23 Jun 2025 11:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750679169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JdUl4HhCRYmzLnVS8Zl2/I5BKvrKx9Kk9F/gRypO5JU=;
	b=ycWt5zaOaSY/PZJ93EguE6UM05WB3Fpi6PLBXCOQda31qcqh6m0hg1Z4/VRzlZJKP/FCMB
	5wpvXeGc8XWfz2br6D4fkIO0zDruGpHGO4nzfkOpgHCPnVzv5z9XWFbbs6Ukd8vuHekRCn
	ctr+OkTvURklSQN2cjm6IOaXiDodKmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750679169;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JdUl4HhCRYmzLnVS8Zl2/I5BKvrKx9Kk9F/gRypO5JU=;
	b=Z/+KnzlYt14psu+Ahk32rlOhYeAGX5Tt0ZG2jcPWynXo5AEQM96I1xawJP8gNTcxNM/uyn
	HQ7HJYyghFeSIiDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750679169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JdUl4HhCRYmzLnVS8Zl2/I5BKvrKx9Kk9F/gRypO5JU=;
	b=ycWt5zaOaSY/PZJ93EguE6UM05WB3Fpi6PLBXCOQda31qcqh6m0hg1Z4/VRzlZJKP/FCMB
	5wpvXeGc8XWfz2br6D4fkIO0zDruGpHGO4nzfkOpgHCPnVzv5z9XWFbbs6Ukd8vuHekRCn
	ctr+OkTvURklSQN2cjm6IOaXiDodKmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750679169;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JdUl4HhCRYmzLnVS8Zl2/I5BKvrKx9Kk9F/gRypO5JU=;
	b=Z/+KnzlYt14psu+Ahk32rlOhYeAGX5Tt0ZG2jcPWynXo5AEQM96I1xawJP8gNTcxNM/uyn
	HQ7HJYyghFeSIiDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6414F13AC4;
	Mon, 23 Jun 2025 11:46:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id seBSF4E+WWgSNQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Jun 2025 11:46:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DE328A29F3; Mon, 23 Jun 2025 09:26:15 +0200 (CEST)
Date: Mon, 23 Jun 2025 09:26:15 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, yi.zhang@huawei.com, libaokun1@huawei.com, 
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 5/6] ext4/jbd2: reintroduce
 jbd2_journal_blocks_per_page()
Message-ID: <6koueljloyoehqg4my5ihbvybid4unimyiahqcbkoasx5cqtat@xehauy7m2ofq>
References: <20250611111625.1668035-1-yi.zhang@huaweicloud.com>
 <20250611111625.1668035-6-yi.zhang@huaweicloud.com>
 <ugup3tdvaxgzc6agaidbdh7sdcpzcqvwzsurqkesyhsyta7q7y@h3q6mrc2jcno>
 <558c7f74-3d0a-4394-b9ab-3eafab136a23@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <558c7f74-3d0a-4394-b9ab-3eafab136a23@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
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
	RCPT_COUNT_TWELVE(0.00)[12];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,huawei.com:email];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 

On Sat 21-06-25 15:46:40, Zhang Yi wrote:
> On 2025/6/20 0:44, Jan Kara wrote:
> > On Wed 11-06-25 19:16:24, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> This partially reverts commit d6bf294773a4 ("ext4/jbd2: convert
> >> jbd2_journal_blocks_per_page() to support large folio"). This
> >> jbd2_journal_blocks_per_folio() will lead to a significant
> >> overestimation of journal credits. Since we still reserve credits for
> >> one page and attempt to extend and restart handles during large folio
> >> writebacks, so we should convert this helper back to
> >> ext4_journal_blocks_per_page().
> >>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > 
> > Here I'm not decided. Does it make any particular sense to reserve credits
> > for one *page* worth of blocks when pages don't have any particular meaning
> > in our writeback code anymore? We could reserve credits just for one
> > physical extent and that should be enough.
> 
> Indeed, reserving credits for a single page is no longer suitable in the
> currently folio based context. It do seems more appropriate to allocate
> credits for a single extent.
> 
> > For blocksize == pagesize (most
> > common configs) this would be actually equivalent. If blocksize < pagesize,
> > this could force us to do some more writeback retries and thus get somewhat
> > higher writeback CPU overhead but do we really care for these configs?  It
> > is well possible I've overlooked something and someone will spot a
> > performance regression in practical setup with this in which case we'd have
> > to come up with something more clever but I think it's worth it to start
> > simple and complicate later.
> 
> This can indeed be a problem if the file system is already fragmented
> enough. However, thanks to the credits extension logic in
> __ext4_journal_ensure_credits(), I suppose that on most file system images,
> it will not trigger excessive retry operations. Besides, although there
> might be some lock cost in jbd2_journal_extend(), I suppose it won't be a
> big deal.
> 
> Perhaps we could reserve more credits through a complex formula at the
> outset, which would lower the cost of expanding the credits. But I don't
> think this will help much in reducing the number of retries, it may only
> be helpful in extreme cases (the running transaction stats to commit, we
> cannot extend it).
> 
> So, I think we can implement it by reserving for an extent for the time
> being. Do you agree?

Yes, I agree. After all this is easy to change if we find some real issues
with it.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


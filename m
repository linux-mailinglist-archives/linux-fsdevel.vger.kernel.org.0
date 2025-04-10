Return-Path: <linux-fsdevel+bounces-46202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 314BDA84274
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 14:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D577419E68C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 12:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8049D283C98;
	Thu, 10 Apr 2025 12:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TVhROIqS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FKs34CSh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TVhROIqS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FKs34CSh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CBB26FA77
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 12:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744286750; cv=none; b=ctmFHC69kG/xJ+Xe+o8govlhIVzwglklig9XfFfVjVsgvrcmEpewSalwvcL1XDx0aMAgWM+susBilc4eUleJmisQu5wY5Lxf+4ml/PtRNZPqbEPEuRUu9NnF8ozKFcz7tZmXUFuGQop2rTnnZGYtvBQ3UUTBu/319N4KNeBpGiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744286750; c=relaxed/simple;
	bh=l0QpljsybPV6b5xWsCu1e6i0Jb4XYg9Ai+DDs5vGD+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhWN2JvMYstcGU4zXwBzVTn9pYYnUlTZQ8drm36kSgaQ7tBw+r4yOQJMBu9Wd1bxOEgsSctMIzMrh1AQjCOkiQKivRkVMKQzSyXdaKlWeTz+QkG9KuTDq0WYK8vgB/TclPBX58NULl8kKQ1qovzuPJ/Vmk9+WiLKlzJ7v6KOxUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TVhROIqS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FKs34CSh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TVhROIqS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FKs34CSh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F65D1F38C;
	Thu, 10 Apr 2025 12:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744286747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TpD6XcpCBTjU8K7kBL2j3kkwigpBcTWrEVm7Rj4zBXE=;
	b=TVhROIqSVI5PErHC8rtgFD1WOJ9u43JASsEZutKqr16cw8PvuM4+q0UGr1YXrdTRnKp23F
	K0qOjIiT9EODNU7HvCYiLc2bsDBFjmS9WhG8pcT8QPWKiqk0/QbIHmknNUJZABEo0KCXHJ
	zJ/Ifa8qCGct+Zrdkm1m+vPjjMvBFAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744286747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TpD6XcpCBTjU8K7kBL2j3kkwigpBcTWrEVm7Rj4zBXE=;
	b=FKs34CShwrFCJOxyMWwf6eULdrzu6B4np08h+Jq3icJRhvvQgstoTQJrCy3sLjeRe5Ev9B
	dr39pdOOTylacIDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744286747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TpD6XcpCBTjU8K7kBL2j3kkwigpBcTWrEVm7Rj4zBXE=;
	b=TVhROIqSVI5PErHC8rtgFD1WOJ9u43JASsEZutKqr16cw8PvuM4+q0UGr1YXrdTRnKp23F
	K0qOjIiT9EODNU7HvCYiLc2bsDBFjmS9WhG8pcT8QPWKiqk0/QbIHmknNUJZABEo0KCXHJ
	zJ/Ifa8qCGct+Zrdkm1m+vPjjMvBFAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744286747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TpD6XcpCBTjU8K7kBL2j3kkwigpBcTWrEVm7Rj4zBXE=;
	b=FKs34CShwrFCJOxyMWwf6eULdrzu6B4np08h+Jq3icJRhvvQgstoTQJrCy3sLjeRe5Ev9B
	dr39pdOOTylacIDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2010D132D8;
	Thu, 10 Apr 2025 12:05:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nE3SBxu092crTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 10 Apr 2025 12:05:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 585A8A0910; Thu, 10 Apr 2025 14:05:38 +0200 (CEST)
Date: Thu, 10 Apr 2025 14:05:38 +0200
From: Jan Kara <jack@suse.cz>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: brauner@kernel.org, jack@suse.cz, tytso@mit.edu, 
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, riel@surriel.com, dave@stgolabs.net, 
	willy@infradead.org, hannes@cmpxchg.org, oliver.sang@intel.com, david@redhat.com, 
	axboe@kernel.dk, hare@suse.de, david@fromorbit.com, djwong@kernel.org, 
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org, gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com, 
	syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/8] migrate: fix skipping metadata buffer heads on
 migration
Message-ID: <dpn6pb7hwpmajoh5k5zla6x7fsmh4rlttstj3hkuvunp6tok3j@ikz2fxpikfv4>
References: <20250410014945.2140781-1-mcgrof@kernel.org>
 <20250410014945.2140781-2-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250410014945.2140781-2-mcgrof@kernel.org>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[f3c6fda1297c748a7076];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,mit.edu,dilger.ca,vger.kernel.org,surriel.com,stgolabs.net,infradead.org,cmpxchg.org,intel.com,redhat.com,kernel.dk,suse.de,fromorbit.com,gmail.com,kvack.org,samsung.com,syzkaller.appspotmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 09-04-25 18:49:38, Luis Chamberlain wrote:
> Filesystems which use buffer-heads where it cannot guarantees that there
> are no other references to the folio, for example with a folio
> lock, must use buffer_migrate_folio_norefs() for the address space
> mapping migrate_folio() callback. There are only 3 filesystems which use
> this callback:
> 
>   1) the block device cache

Well, but through this also all simple filesystems that use buffer_heads
for metadata handling...

>   2) ext4 for its ext4_journalled_aops, ie, jbd2
>   3) nilfs2
> 
> jbd2's use of this however callback however is very race prone, consider
> folio migration while reviewing jbd2_journal_write_metadata_buffer()
> and the fact that jbd2:
> 
>   - does not hold the folio lock
>   - does not have have page writeback bit set
>   - does not lock the buffer
>
> And so, it can race with folio_set_bh() on folio migration. The commit
> ebdf4de5642fb6 ("mm: migrate: fix reference  check race between
> __find_get_block() and migration") added a spin lock to prevent races
> with page migration which ext4 users were reporting through the SUSE
> bugzilla (bnc#1137609 [0]). Although we don't have exact traces of the
> original filesystem corruption we can can reproduce fs corruption on
> ext4 by just removing the spinlock and stress testing the filesystem
> with generic/750, we eventually end up after 3 hours of testing with
> kdevops using libvirt on the ext4 profiles ext4-4k and ext4-2k.

Correct, jbd2 holds bh reference (its private jh structure attached to
bh->b_private holds it) and that is expected to protect jbd2 from anybody
else mucking with the bh.

> It turns out that the spin lock doesn't in the end protect against
> corruption, it *helps* reduce the possibility, but ext4 filesystem
> corruption can still happen even with the spin lock held. A test was
> done using vanilla Linux and adding a udelay(2000) right before we
> spin_lock(&bd_mapping->i_private_lock) on __find_get_block_slow() and
> we can reproduce the same exact filesystem corruption issues as observed
> without the spinlock with generic/750 [1].

This is unexpected.

> ** Reproduced on vanilla Linux with udelay(2000) **
> 
> Call trace (ENOSPC journal failure):
>   do_writepages()
>     → ext4_do_writepages()
>       → ext4_map_blocks()
>         → ext4_ext_map_blocks()
>           → ext4_ext_insert_extent()
>             → __ext4_handle_dirty_metadata()
>               → jbd2_journal_dirty_metadata() → ERROR -28 (ENOSPC)

Curious. Did you try running e2fsck after the filesystem complained like
this? This complains about journal handle not having enough credits for
needed metadata update. Either we've lost some update to the journal_head
structure (b_modified got accidentally cleared) or some update to extent
tree.

> And so jbd2 still needs more work to avoid races with folio migration.
> So replace the current spin lock solution by just skipping jbd buffers
> on folio migration. We identify jbd buffers as its the only user of
> set_buffer_meta() on __ext4_handle_dirty_metadata(). By checking for
> buffer_meta() and bailing on migration we fix the existing racy ext4
> corruption while also removing the spin lock to be held while sleeping
> complaints originally reported by 0-day [5], and paves the way for
> buffer-heads for more users of large folios other than the block
> device cache.

I think we need to understand why private_lock protection does not protect
bh users holding reference like jbd2 from folio migration before papering
over this problem with the hack. Because there are chances other simple
filesystems suffer from the same problem...

> diff --git a/mm/migrate.c b/mm/migrate.c
> index f3ee6d8d5e2e..32fa72ba10b4 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -841,6 +841,9 @@ static int __buffer_migrate_folio(struct address_space *mapping,
>  	if (folio_ref_count(src) != expected_count)
>  		return -EAGAIN;
>  
> +	if (buffer_meta(head))
> +		return -EAGAIN;
> +
>  	if (!buffer_migrate_lock_buffers(head, mode))
>  		return -EAGAIN;
>  
> @@ -859,12 +862,12 @@ static int __buffer_migrate_folio(struct address_space *mapping,
>  			}
>  			bh = bh->b_this_page;
>  		} while (bh != head);
> +		spin_unlock(&mapping->i_private_lock);

No, you've just broken all simple filesystems (like ext2) with this patch.
You can reduce the spinlock critical section only after providing
alternative way to protect them from migration. So this should probably
happen at the end of the series.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


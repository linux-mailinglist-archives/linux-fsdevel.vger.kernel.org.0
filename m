Return-Path: <linux-fsdevel+bounces-50843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B81D3AD02FC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 15:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 737D217971F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 13:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9A5288CAE;
	Fri,  6 Jun 2025 13:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0ejGqWVE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x+1F+91L";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kJqquk8x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MPC7hMwc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F78288518
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749215773; cv=none; b=KaqRVadfyQKXZZq/i6HYPpQg7oGYsd+Fjw0cbKiyLyLQOvRNMP+8T9tVCMqfA3iZHdNoE/KyESLgGLYgHx4As8inSv/4OquOEbRC6tipm4iA9DCyEixHxmVVxGDH2ddbEjAWYyxoF//t9lIvOeeA7xiV75jAv0KmHo7/h239hfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749215773; c=relaxed/simple;
	bh=aNAeoahf41PqOn8gTd2tZQFikra1qq7P8aoAmbjBAmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aShPxVOokNiyIGfpaRQh3oMkG3TiXmsNcgfHUzxVWU0jhorLQgC7cpuEbJK87nQLND/GPq68H3tyDZto9DY+wIH9r+NrOTiIPCOaUrfXlMOk7FNsI4NCMwAEYt8rogwD81Zzk1fam8xrOSaUarlnDG/9fukdj9MFUG1Bf/ypc6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0ejGqWVE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x+1F+91L; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kJqquk8x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MPC7hMwc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3BB7B336B7;
	Fri,  6 Jun 2025 13:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749215769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=li2hhM0PVmESxCRoYcjpQzsbFhjZduZXOZsG1l3eIuE=;
	b=0ejGqWVEwf47lGKmWrHoTCdDFkx0TqT6z0IY1TQUC9yTVOhbqwaZaqAMqRcXI5EdA9lqiX
	JFFxRocCNRDCYA5OLLDBCKvDScWhj9Fbwl19bxNe2GgPhjBRnpxEiUGri7tMGUBKXkD1F9
	TFMGL9au1ZW02oGdnOtxBwYqBpo5W1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749215769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=li2hhM0PVmESxCRoYcjpQzsbFhjZduZXOZsG1l3eIuE=;
	b=x+1F+91LL38DEWByOEObnXkKLtUfshj131gBU06Q49T4zKttG3GA8Qut8Wr7PVV8CzrHFg
	Szx7d3JBzLfndbDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749215768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=li2hhM0PVmESxCRoYcjpQzsbFhjZduZXOZsG1l3eIuE=;
	b=kJqquk8xS6TgM53steRf7SQcAJ65YwGmd3MRhq7UMkqrjBezr9TOCHjIkm6+dkvFkjCFPp
	v8yrasRbdHYdzng9FmuLFtDB5s5aFl0hw3hv+gUKNdKPGhogJnik0O853d0o4lr6lFMeII
	1jgJSkgnkGOgdhGUbDiiNYdMFU8iWHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749215768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=li2hhM0PVmESxCRoYcjpQzsbFhjZduZXOZsG1l3eIuE=;
	b=MPC7hMwc5B42bCwyMmJkRDkbKbqfJQ90TO+aC2bKpS8WCuZHcGvLHUrzaFSxbun+I2yEUM
	itb0Sy3Oj/bfV7Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EA7E1336F;
	Fri,  6 Jun 2025 13:16:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sQtfCxjqQmjFdgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 06 Jun 2025 13:16:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C95B4A0951; Fri,  6 Jun 2025 15:16:07 +0200 (CEST)
Date: Fri, 6 Jun 2025 15:16:07 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, yi.zhang@huawei.com, libaokun1@huawei.com, 
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 1/5] ext4: restart handle if credits are insufficient
 during writepages
Message-ID: <uruplwi35qaajr3cqyozq7dpbwgqehuzstxpobx44retpek6cb@gplmkhlsaofk>
References: <20250530062858.458039-1-yi.zhang@huaweicloud.com>
 <20250530062858.458039-2-yi.zhang@huaweicloud.com>
 <byiax3ykefdvmu47xrgrndguxabwvakescnkanbhwwqoec7yky@dvzzkic5uzf3>
 <3aafd643-3655-420e-93fa-25d0d0ff4f32@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aafd643-3655-420e-93fa-25d0d0ff4f32@huaweicloud.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Fri 06-06-25 14:54:21, Zhang Yi wrote:
> On 2025/6/5 22:04, Jan Kara wrote:
> >> +		/*
> >> +		 * The credits for the current handle and transaction have
> >> +		 * reached their upper limit, stop the handle and initiate a
> >> +		 * new transaction. Note that some blocks in this folio may
> >> +		 * have been allocated, and these allocated extents are
> >> +		 * submitted through the current transaction, but the folio
> >> +		 * itself is not submitted. To prevent stale data and
> >> +		 * potential deadlock in ordered mode, only the
> >> +		 * dioread_nolock mode supports this.
> >> +		 */
> >> +		if (err > 0) {
> >> +			WARN_ON_ONCE(!ext4_should_dioread_nolock(inode));
> >> +			mpd->continue_map = 1;
> >> +			err = 0;
> >> +			goto update_disksize;
> >> +		}
> >>  	} while (map->m_len);
> >>  
> >>  update_disksize:
> >> @@ -2467,6 +2501,9 @@ static int mpage_map_and_submit_extent(handle_t *handle,
> >>  		if (!err)
> >>  			err = err2;
> >>  	}
> >> +	if (!err && mpd->continue_map)
> >> +		ext4_get_io_end(io_end);
> >> +
> > 
> > IMHO it would be more logical to not call ext4_put_io_end[_deferred]() in
> > ext4_do_writepages() if we see we need to continue doing mapping for the
> > current io_end.
> > 
> > That way it would be also more obvious that you've just reintroduced
> > deadlock fixed by 646caa9c8e196 ("ext4: fix deadlock during page
> > writeback"). This is actually a fundamental thing because for
> > ext4_journal_stop() to complete, we may need IO on the folio to finish
> > which means we need io_end to be processed. Even if we avoided the awkward
> > case with sync handle described in 646caa9c8e196, to be able to start a new
> > handle we may need to complete a previous transaction commit to be able to
> > make space in the journal.
> 
> Yeah, you are right, I missed the full folios that were attached to the
> same io_end in the previous rounds. If we continue to use this solution,
> I think we should split the io_end and submit the previous one which
> includes those full folios before the previous transaction is
> committed.

Yes, fully mapped folios definitely need to be submitted. But I think that
should be handled by ext4_io_submit() call in ext4_do_writepages() loop?

> > Thinking some more about this holding ioend for a folio with partially
> > submitted IO is also deadlock prone because mpage_prepare_extent_to_map()
> > can call folio_wait_writeback() which will effectively wait for the last
> > reference to ioend to be dropped so that underlying extents can be
> > converted and folio_writeback bit cleared.
> 
> I don't understand this one. The mpage_prepare_extent_to_map() should
> call folio_wait_writeback() for the current processing partial folio,
> not the previous full folios that were attached to the io_end. This is
> because mpd->first_page should be moved forward in mpage_folio_done()
> once we complete the previous full folio. Besides, in my current
> solution, the current partial folio will not be submitted, the
> folio_writeback flag will not be set, so how does this deadlock happen?

Sorry, this was me being confused. I went through the path again and indeed
if we cannot map all buffers underlying the folio, we don't clear buffer
(and folio) dirty bits and don't set folio writeback bit so there's no
deadlock there.

> > So what I think we need to do is that if we submit part of the folio and
> > cannot submit it all, we just redirty the folio and bail out of the mapping
> > loop (similarly as in ENOSPC case).
> 
> After looking at the ENOSPC case again, I found that the handling of
> ENOSPC before we enabling large folio is also wrong, it may case stale
> data on 1K block size. Suppose we are processing four bhs on a dirty
> page. We map the first bh, and the corresponding io_vec is added to the
> io_end, with the unwritten flag set. However, when we attempt to map
> the second bh, we bail out of the loop due to ENOSPC. At this point,
> ext4_do_writepages()->ext4_put_io_end() will convert the extent of the
> first bh to written. However, since the folio has not been committed
> (mpage_submit_folio() submit a full folio), it will trigger stale data
> issue. Is that right? I suppose we also have to write partial folio out
> in this case.

Yes, this case will be problematic actually both with dioread_nolock but
also without it (as in this case we create written extents from the start
and we tell JBD2 to only wait for data IO to complete but not to submit
it). We really need to make sure partially mapped folio is submitted for IO
as well in this case.

> > Then once IO completes
> > mpage_prepare_extent_to_map() is able to start working on the folio again.
> > Since we cleared dirty bits in the buffers we should not be repeating the
> > work we already did...
> > 
> 
> Hmm, it looks like this solution should work. We should introduce a
> partial folio version of mpage_submit_folio(), call it and redirty
> the folio once we need to bail out of the loop since insufficient
> space or journal credits. But ext4_bio_write_folio() will handle the
> the logic of fscrypt case, I'm not familiar with fscrypt, so I'm not
> sure it could handle the partial page properly. I'll give it a try.

As far as I can tell it should work fine. The logic in
ext4_bio_write_folio() is already prepared for handling partial folio
writeouts, redirtying of the page etc. (because it needs to handle writeout
from transaction commit where we can writeout only parts of folios with
underlying blocks allocated). We just need to teach mpage_submit_folio() to
substract only written-out number of pages from nr_to_write.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


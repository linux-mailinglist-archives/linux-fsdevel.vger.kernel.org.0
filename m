Return-Path: <linux-fsdevel+bounces-41247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66498A2CB9B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 19:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E6B3AC2CB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 18:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669B51A3157;
	Fri,  7 Feb 2025 18:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F1HHrTaK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZXY3hnYu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F1HHrTaK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZXY3hnYu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A45195980;
	Fri,  7 Feb 2025 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738953546; cv=none; b=QLUDoxDN10VHKaO58UHCaO5ZRdNYYLg58cNI1aqJdO2kTwtb8dPYZdDhQ0g+3EeYxHLKGOEuxTjI/2F04+V5nJmtnlk7kSGvgwQsMSvfWVdTZbRLlhFRmmOhJW1byiltHWbWd6J/7m5q+3gf/W/bQGFYsR1ujN2t8p1lBZ5g8+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738953546; c=relaxed/simple;
	bh=0mN7Hy+oiHJPrR9JOTGEnbtzguA2aG3VkR7wc+e+aZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Voc4SP0Nvp411VTH7B5yakJptPbSur+3kqbEjnR48csCSUgRC5xb89Gq5lNqfYhhRmKtWZ44rHagXrDH48l8e6hR4POmqC6pmQZEyOExtpNnKnRH3nijri/yBDnm4DM2hEI6FmOHeZIJH+sp0ls2vYjuvx06t2D0qpFUJ/iw17M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F1HHrTaK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZXY3hnYu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F1HHrTaK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZXY3hnYu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7457221166;
	Fri,  7 Feb 2025 18:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738953542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NTSHPtDs5dU3VHVIkTVdfknZnMffoRYfwLwXhn8e9IY=;
	b=F1HHrTaKxPJm5Gygma8c60ziQi7bCd7r9fgTkrMvu56o+6yK9/p/T15GUWzn/g2dCCktjh
	+91V4OY7II3b6KGIxwdgDzq2odYqS4yWcGjVDROF8m1JwQMiGY/T0dJBiCrATzJbVBzG3w
	Vwi5FzZKl+P9Z3T6Ta47lDuP0cuVpu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738953542;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NTSHPtDs5dU3VHVIkTVdfknZnMffoRYfwLwXhn8e9IY=;
	b=ZXY3hnYuHPumw8Ya80gqoDCXXGzTB/kC+KqLKrmJRqORo93E88moDUkeaZakdz8D/DF+au
	ve+G9+6jfUiKzRCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738953542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NTSHPtDs5dU3VHVIkTVdfknZnMffoRYfwLwXhn8e9IY=;
	b=F1HHrTaKxPJm5Gygma8c60ziQi7bCd7r9fgTkrMvu56o+6yK9/p/T15GUWzn/g2dCCktjh
	+91V4OY7II3b6KGIxwdgDzq2odYqS4yWcGjVDROF8m1JwQMiGY/T0dJBiCrATzJbVBzG3w
	Vwi5FzZKl+P9Z3T6Ta47lDuP0cuVpu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738953542;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NTSHPtDs5dU3VHVIkTVdfknZnMffoRYfwLwXhn8e9IY=;
	b=ZXY3hnYuHPumw8Ya80gqoDCXXGzTB/kC+KqLKrmJRqORo93E88moDUkeaZakdz8D/DF+au
	ve+G9+6jfUiKzRCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A3AB139CB;
	Fri,  7 Feb 2025 18:39:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OGO3FUZTpmd/BQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 07 Feb 2025 18:39:02 +0000
Message-ID: <8f7333f2-1ba9-4df4-bc54-44fd768b3d5b@suse.cz>
Date: Fri, 7 Feb 2025 19:39:02 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] Crash with Bad page state for FUSE/Flatpak
 related applications since v6.13
Content-Language: en-US
To: Josef Bacik <josef@toxicpanda.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Heusel
 <christian@heusel.eu>, Miklos Szeredi <mszeredi@redhat.com>,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, linux-mm <linux-mm@kvack.org>,
 =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>
References: <2f681f48-00f5-4e09-8431-2b3dbfaa881e@heusel.eu>
 <CAJfpegtaTET+R7Tc1MozTQWmYfgsRp6Bzc=HKonO=Uq1h6Nzgw@mail.gmail.com>
 <9cd88643-daa8-4379-be0a-bd31de277658@suse.cz>
 <20250207172917.GA2072771@perftesting>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20250207172917.GA2072771@perftesting>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[szeredi.hu,heusel.eu,redhat.com,lists.linux.dev,vger.kernel.org,gmail.com,infradead.org,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 2/7/25 18:29, Josef Bacik wrote:
> On Fri, Feb 07, 2025 at 05:49:34PM +0100, Vlastimil Babka wrote:
>> On 2/7/25 10:34, Miklos Szeredi wrote:
>> > [Adding Joanne, Willy and linux-mm].
>> > 
>> > 
>> > On Thu, 6 Feb 2025 at 11:54, Christian Heusel <christian@heusel.eu> wrote:
>> >>
>> >> Hello everyone,
>> >>
>> >> we have recently received [a report][0] on the Arch Linux Gitlab about
>> >> multiple users having system crashes when using Flatpak programs and
>> >> related FUSE errors in their dmesg logs.
>> >>
>> >> We have subsequently bisected the issue within the mainline kernel tree
>> >> to the following commit:
>> >>
>> >>     3eab9d7bc2f4 ("fuse: convert readahead to use folios")
>> 
>> I see that commit removes folio_put() from fuse_readpages_end(). Also it now
>> uses readahead_folio() in fuse_readahead() which does folio_put(). So that's
>> suspicious to me. It might be storing pointers to pages to ap->pages without
>> pinning them with a refcount.
>> 
>> But I don't understand the code enough to know what's the proper fix. A
>> probably stupid fix would be to use __readahead_folio() instead and keep the
>> folio_put() in fuse_readpages_end().
> 
> Agreed, I'm also confused as to what the right thing is here.  It appears the
> rules are "if the folio is locked, nobody messes with it", so it's not "correct"
> to hold a reference on the folio while it's being read.  I don't love this way
> of dealing with folios, but that seems to be the way it's always worked.
> 
> I went and looked at a few of the other file systems and we have NFS which holds
> it's own reference to the folio while the IO is outstanding, which FUSE is most
> similar to NFS so this would make sense to do.
> 
> Btrfs however doesn't do this, BUT we do set_folio_private (or whatever it's
> called) so that keeps us from being reclaimed since we'll try to lock the folio
> before we do the reclaim.
> 
> So perhaps that's the issue here?  We need to have a private on the folio + the
> folio locked to make sure it doesn't get reclaimed while it's out being read?
> 
> I'm knee deep in other things, if we want a quick fix then I think your
> suggestion is correct Vlastimil.  But I definitely want to know what Willy
> expects to be the proper order of operations here, and if this is exactly what
> we're supposed to be doing then something else is going wrong and we should try
> to reproduce locally and figure out what's happening.  Thanks,

Thanks, Josef. I guess we can at least try to confirm we're on the right track.
Can anyone affected see if this (only compile tested) patch fixes the issue?
Created on top of 6.13.1.

----8<----
From c0fdf9174f6c17c93a709606384efe2877a3a596 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 7 Feb 2025 19:35:25 +0100
Subject: [PATCH] fuse: prevent folio use-after-free in readahead

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 fs/fuse/file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 7d92a5479998..a40d65ffb94d 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -955,8 +955,10 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 		fuse_invalidate_atime(inode);
 	}
 
-	for (i = 0; i < ap->num_folios; i++)
+	for (i = 0; i < ap->num_folios; i++) {
 		folio_end_read(ap->folios[i], !err);
+		folio_put(ap->folios[i]);
+	}
 	if (ia->ff)
 		fuse_file_put(ia->ff, false);
 
@@ -1048,7 +1050,7 @@ static void fuse_readahead(struct readahead_control *rac)
 		ap = &ia->ap;
 
 		while (ap->num_folios < cur_pages) {
-			folio = readahead_folio(rac);
+			folio = __readahead_folio(rac);
 			ap->folios[ap->num_folios] = folio;
 			ap->descs[ap->num_folios].length = folio_size(folio);
 			ap->num_folios++;
-- 
2.48.1




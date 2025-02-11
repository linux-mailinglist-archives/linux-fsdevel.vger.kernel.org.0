Return-Path: <linux-fsdevel+bounces-41545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F441A3170C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 22:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D761888D55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 21:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A76264630;
	Tue, 11 Feb 2025 21:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IRteA8/7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2GamUOuR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IRteA8/7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2GamUOuR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E703F2641ED;
	Tue, 11 Feb 2025 21:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739307689; cv=none; b=RcjUUH1KwgBdRqqKhp4+EwSOuCyrGtABe7viY+j1ZJ7hQQZTIs9g7qKKRfrXjRKoeeixPSZtlTyfWWFcUlFZ/fth3lOIHeClfyDdZmZ6rEPK+caBCa2n9s31X/6smkYOnk6dztTC2NCiEdSpVH7WrbixB/aRxA2w88WP8nQHJF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739307689; c=relaxed/simple;
	bh=RGfFf0HBdkWUCBG7jGVd51pRB+EB3GnM3b4jrYGR6ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=It7FK0BrJrN5VGUdSCjn/cYB0kL2vyQjfXHFREAe4q77o+ySeKEzPAgqrYd6DTOWacE8gIg5Y07fxsvmmy/Kve/abTY8s3iAXymivuaRaLng98RFOSmUF5Tuj1XFtYcg1N6lEwgshAV5Nbccnstu8SxbA1uvSbRiDD0IBMMKwVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IRteA8/7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2GamUOuR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IRteA8/7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2GamUOuR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B74FB336A9;
	Tue, 11 Feb 2025 21:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739307684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qTU08azJs2A2UBxMybdmuUejCEYDS89iY7+VKEUW20g=;
	b=IRteA8/7IXV197Ylcki5RGDbGb536hKLiwbvBalKSyECld3MGDRa3TaRTYW3/tYwnqCdVg
	RD0DDqxJZiifvoSXccJUHiy4FN6/9i3ifBruK1yNtCfSuCTF7cMOwGw5kEPrMgzr5Qsi68
	NGxDin93TtroAk4YRpE05J2dyZZgk20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739307684;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qTU08azJs2A2UBxMybdmuUejCEYDS89iY7+VKEUW20g=;
	b=2GamUOuRdD9UyfA5DKzU2I5TvgSWo2kKIRKNI9w++agEEWf9kzzG0H4hOiZts4wBo1rB7I
	lcGtPVAF9QVljHCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="IRteA8/7";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2GamUOuR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739307684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qTU08azJs2A2UBxMybdmuUejCEYDS89iY7+VKEUW20g=;
	b=IRteA8/7IXV197Ylcki5RGDbGb536hKLiwbvBalKSyECld3MGDRa3TaRTYW3/tYwnqCdVg
	RD0DDqxJZiifvoSXccJUHiy4FN6/9i3ifBruK1yNtCfSuCTF7cMOwGw5kEPrMgzr5Qsi68
	NGxDin93TtroAk4YRpE05J2dyZZgk20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739307684;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qTU08azJs2A2UBxMybdmuUejCEYDS89iY7+VKEUW20g=;
	b=2GamUOuRdD9UyfA5DKzU2I5TvgSWo2kKIRKNI9w++agEEWf9kzzG0H4hOiZts4wBo1rB7I
	lcGtPVAF9QVljHCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9ABBC13782;
	Tue, 11 Feb 2025 21:01:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QIZhJaS6q2fDSwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 11 Feb 2025 21:01:24 +0000
Message-ID: <85f1b4ca-cdc7-48d0-a985-4185eff1b49a@suse.cz>
Date: Tue, 11 Feb 2025 22:01:24 +0100
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
To: Joanne Koong <joannelkoong@gmail.com>, Jeff Layton <jlayton@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Josef Bacik <josef@toxicpanda.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Christian Heusel <christian@heusel.eu>,
 Miklos Szeredi <mszeredi@redhat.com>, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm <linux-mm@kvack.org>, =?UTF-8?Q?Mantas_Mikul=C4=97nas?=
 <grawity@gmail.com>
References: <CAJfpegtaTET+R7Tc1MozTQWmYfgsRp6Bzc=HKonO=Uq1h6Nzgw@mail.gmail.com>
 <9cd88643-daa8-4379-be0a-bd31de277658@suse.cz>
 <20250207172917.GA2072771@perftesting>
 <8f7333f2-1ba9-4df4-bc54-44fd768b3d5b@suse.cz>
 <CAJnrk1aNVMCfTjL0vo-Qki68-5t1W+6-bJHg+x67kHEo_-q0Eg@mail.gmail.com>
 <Z6ct4bEdeZwmksxS@casper.infradead.org>
 <CAJnrk1aY0ZFcS4JvmJL=icigencsCD8g4qmZiTuoPWj2S2Y_LQ@mail.gmail.com>
 <81298bd1-e630-4940-ae5b-7882576b6bf4@suse.cz>
 <CAJnrk1aBc5uvL78s3kdpXojH-B11wtOPSDUJ0XnCzmHH+eO2Nw@mail.gmail.com>
 <20250210191235.GA2256827@perftesting>
 <Z6pjSYyzFJHaQo73@casper.infradead.org>
 <8a99f6bf3f0b5cb909f11539fb3b0ef0d65b3a73.camel@kernel.org>
 <ecee2d1392fcb9b075687e7b59ec69057d3c1bb3.camel@kernel.org>
 <CAJnrk1ZkhNdCf_v4KHmsFoh3EcEaKY0Z8SVn2nJouVDxTZxv=A@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAJnrk1ZkhNdCf_v4KHmsFoh3EcEaKY0Z8SVn2nJouVDxTZxv=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B74FB336A9
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[infradead.org,toxicpanda.com,szeredi.hu,heusel.eu,redhat.com,lists.linux.dev,vger.kernel.org,kvack.org,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 2/11/25 20:23, Joanne Koong wrote:
> On Tue, Feb 11, 2025 at 6:01 AM Jeff Layton <jlayton@kernel.org> wrote:
>>
>> On Mon, 2025-02-10 at 17:38 -0500, Jeff Layton wrote:
>> > On Mon, 2025-02-10 at 20:36 +0000, Matthew Wilcox wrote:
>> > > On Mon, Feb 10, 2025 at 02:12:35PM -0500, Josef Bacik wrote:
>> > > > From: Josef Bacik <josef@toxicpanda.com>
>> > > > Date: Mon, 10 Feb 2025 14:06:40 -0500
>> > > > Subject: [PATCH] fuse: drop extra put of folio when using pipe splice
>> > > >
>> > > > In 3eab9d7bc2f4 ("fuse: convert readahead to use folios"), I converted
>> > > > us to using the new folio readahead code, which drops the reference on
>> > > > the folio once it is locked, using an inferred reference on the folio.
>> > > > Previously we held a reference on the folio for the entire duration of
>> > > > the readpages call.
>> > > >
>> > > > This is fine, however I failed to catch the case for splice pipe
>> > > > responses where we will remove the old folio and splice in the new
>> > > > folio.  Here we assumed that there is a reference held on the folio for
>> > > > ap->folios, which is no longer the case.
>> > > >
>> > > > To fix this, simply drop the extra put to keep us consistent with the
>> > > > non-splice variation.  This will fix the UAF bug that was reported.
>> > > >
>> > > > Link: https://lore.kernel.org/linux-fsdevel/2f681f48-00f5-4e09-8431-2b3dbfaa881e@heusel.eu/
>> > > > Fixes: 3eab9d7bc2f4 ("fuse: convert readahead to use folios")
>> > > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> > > > ---
>> > > >  fs/fuse/dev.c | 2 --
>> > > >  1 file changed, 2 deletions(-)
>> > > >
>> > > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> > > > index 5b5f789b37eb..5bd6e2e184c0 100644
>> > > > --- a/fs/fuse/dev.c
>> > > > +++ b/fs/fuse/dev.c
>> > > > @@ -918,8 +918,6 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
>> > > >   }
>> > > >
>> > > >   folio_unlock(oldfolio);
>> > > > - /* Drop ref for ap->pages[] array */
>> > > > - folio_put(oldfolio);
>> > > >   cs->len = 0;
>> > >
>> > > But aren't we now leaking a reference to newfolio?  ie shouldn't
>> > > we also:
>> > >
>> > > -   folio_get(newfolio);
>> > >
>> > > a few lines earlier?
>> > >
>> >
>> >
>> > I think that ref was leaking without Josef's patch, but your proposed
>> > fix seems correct to me. There is:
>> >
>> > - 1 reference stolen from the pipe_buffer
>> > - 1 reference taken for the pagecache in replace_page_cache_folio()
>> > - the folio_get(newfolio) just after that
>> >
>> > The pagecache ref doesn't count here, and we only need the reference
>> > that was stolen from the pipe_buffer to replace the one in pagep.
>>
>> Actually, no. I'm wrong here. A little after the folio_get(newfolio)
>> call, we do:
>>
>>         /*
>>          * Release while we have extra ref on stolen page.  Otherwise
>>          * anon_pipe_buf_release() might think the page can be reused.
>>          */
>>         pipe_buf_release(cs->pipe, buf);
>>
>> ...so that accounts for the extra reference. I think the newfolio
>> refcounting is correct as-is.
> 
> I think we do need to remove the folio_get(newfolio); here or we are
> leaking the reference.
> 
> new_folio = page_folio(buf->page) # ref is 1
> replace_page_cache_folio() # ref is 2
> folio_get() # ref is 3
> pipe_buf_release() # ref is 2
> 
> One ref belongs to the page cache and will get dropped by that, but
> the other ref is unaccounted for (since the original patch removed
> "folio_put()" from fuse_readpages_end()).
> 
> I still think acquiring an explicit reference on the folio before we
> add it to ap->folio and then dropping it when we're completely done
> with it in fuse_readpages_end() is the best solution, as that imo
> makes the refcounting / lifetimes the most explicit / clear. For
> example, in try_move_pages(), if we get rid of that "folio_get()"
> call, the page cache is the holder of the remaining reference on it,
> and we rely on the earlier "folio_clear_uptodate(newfolio);" line in
> try_move_pages() to guarantee that the newfolio isn't freed out from
> under us if memory gets tight and it's evicted from the page cache.
> 
> imo, a patch like this makes the refcounting the most clear:
> 
> From 923fa98b97cf6dfba3bb486833179c349d566d64 Mon Sep 17 00:00:00 2001
> From: Joanne Koong <joannelkoong@gmail.com>
> Date: Tue, 11 Feb 2025 10:59:40 -0800
> Subject: [PATCH] fuse: acquire explicit folio refcount for readahead
> 
> In 3eab9d7bc2f4 ("fuse: convert readahead to use folios"), the logic
> was converted to using the new folio readahead code, which drops the
> reference on the folio once it is locked, using an inferred reference
> on the folio. Previously we held a reference on the folio for the
> entire duration of the readpages call.
> 
> This is fine, however for the case for splice pipe responses where we
> will remove the old folio and splice in the new folio (see
> fuse_try_move_page()), we assume that there is a reference held on the
> folio for ap->folios, which is no longer the case.
> 
> To fix this and make the refcounting explicit, acquire a refcount on the
> folio before we add it to ap->folios[] and drop it when we are done with
> the folio in fuse_readpages_end(). This will fix the UAF bug that was
> reported.
> 
> Link: https://lore.kernel.org/linux-fsdevel/2f681f48-00f5-4e09-8431-2b3dbfaa881e@heusel.eu/
> Fixes: 3eab9d7bc2f4 ("fuse: convert readahead to use folios")

Can we add some tags?

Reported-by: Christian Heusel <christian@heusel.eu>
Closes: https://lore.kernel.org/all/2f681f48-00f5-4e09-8431-2b3dbfaa881e@heusel.eu/
Closes: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/110
Reported-by: Mantas Mikulėnas <grawity@gmail.com>
Closes: https://lore.kernel.org/all/34feb867-09e2-46e4-aa31-d9660a806d1a@gmail.com/
Closes: https://bugzilla.opensuse.org/show_bug.cgi?id=1236660
Cc: <stable@vger.kernel.org>

> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/file.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 7d92a5479998..6fa535c73d93 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -955,8 +955,10 @@ static void fuse_readpages_end(struct fuse_mount
> *fm, struct fuse_args *args,
>                 fuse_invalidate_atime(inode);
>         }
> 
> -       for (i = 0; i < ap->num_folios; i++)
> +       for (i = 0; i < ap->num_folios; i++) {
>                 folio_end_read(ap->folios[i], !err);
> +               folio_put(ap->folios[i]);
> +       }
>         if (ia->ff)
>                 fuse_file_put(ia->ff, false);
> 
> @@ -1049,6 +1051,12 @@ static void fuse_readahead(struct readahead_control *rac)
> 
>                 while (ap->num_folios < cur_pages) {
>                         folio = readahead_folio(rac);
> +                       /*
> +                        * Acquire an explicit reference on the folio in case
> +                        * it's replaced in the page cache in the splice case
> +                        * (see fuse_try_move_page()).
> +                        */
> +                       folio_get(folio);

It would be more efficient to use __readahead_folio() instead of doing a folio_get()
to counter a folio_put() in readahead_folio(). An adjusted comment can explain why
we use __readahead_folio().

>                         ap->folios[ap->num_folios] = folio;
>                         ap->descs[ap->num_folios].length = folio_size(folio);
>                         ap->num_folios++;
> --
> 2.43.5
> 
>> --
>> Jeff Layton <jlayton@kernel.org>



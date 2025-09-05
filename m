Return-Path: <linux-fsdevel+bounces-60402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9257BB46737
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 01:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FDBA189CB91
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 23:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E2321D3C9;
	Fri,  5 Sep 2025 23:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vp15W6Y7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569EC1F583D
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 23:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757115018; cv=none; b=FHG8/+6LghxIC7d9aOyNVY20dES5XRk5k24i4TfvFfTfNwGDiuzk23sJbsWKxao7lMMqmSWlH95EBp6kGTaEobs0LvbjkaRJCXjIf2idKz0m83Xlqs/0pXLLfFiASH+x74FvQPS4kZWGlzu3wzEO+OvGLDvqdWMS/XXDxuZDL9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757115018; c=relaxed/simple;
	bh=QrnFD7NA097mUx0LUedFYfm3Qycjn/BhGzQ9Dbpkk+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hk/vaxARbsLkFsDH9QihsEvxo2/jD5ob/dnJWVnUrsA177OlJ/6mtpHV0qiUdVjzEGsEOSHwJGkjZpRWTA2F38Q8vaeNURZCyuYS9IEdYHN7mGXn7Zu3ltsXRVWrkwAQ8x0lRvvkfgwTsiEcPtxpyJMmz4VvIIIpRKnWYzr9Qug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vp15W6Y7; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b2f4ac4786so25612701cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Sep 2025 16:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757115015; x=1757719815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EF+XVyk/Jfc7wXpcoymcEIzdCHfNoD/Izz/T8+YHh+I=;
        b=Vp15W6Y7CoMwPBXOqjoRZ2PXiv9D4EI24amVrca8sJEdKFRW0MC53lMd+NNcmG1w5Q
         /NH+9t3Ix0TlRILaX6w4+LIW0PxN/zRZizHBXzhSHbVsNh3Qwq4iso6MXWCG21fNBjzX
         Zn4yzM5qIc0SnoqZpAxqWZzW7ZVIEnXpOLCY+6WdFmsfh3t6bDDxqm6W9o63E/LrsOo0
         3rh6YumScv94Y9o+AaoeuhZjgxH9DhwVL7elxCsIKWPjgHx4Efgt27l4M0bUSCAzWzzC
         m0U5TJd9wA64Fxj27LLCEsG9Hw+pjRRUeqeYUYUQc31rKxyEZblumXTZ0PWZ7HFakBXX
         6KKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757115015; x=1757719815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EF+XVyk/Jfc7wXpcoymcEIzdCHfNoD/Izz/T8+YHh+I=;
        b=RymyK8Bt0qEBJm1z4syFlHVNJCetXHS1E3HFnMBNRBIBwljYlECJKvInflu+kU6sCY
         v+6BYnqnOAhKP9j1wyTJIwwox0lzTTSCm0tAfRkVinCb8UONNRGpO0/eazhGC17iqjQO
         /dPafPe6Zmca1HzBtQWtdID9OFuXFZKW98dWSxA6hL6mLuXx9YTR/cCXReel2mrtc1Ji
         1Zz/6dJKhAitTjy2f6pD9k9ZfL0YmHGmgMhVr/Zp1Y5gMsQfSplg8o/nmd+neji86e4t
         1LmCtKq8lWODk0YnvKefUMQ4+WrEi6jdfUh64FCj6qn0Q9zO3cuJ/Ot2BCiFbmEppDHT
         b/EA==
X-Forwarded-Encrypted: i=1; AJvYcCVfKD+y0inYBEqDFxpOfP0WyHjIXsQs44TpCowbKtVUfuPgkqRzdyHidkVNX/rhhJ4bWTZhxmUTyme6Ff9t@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwio1atoJOxpJ0zDBRMCEeCQO+n0+OQs/WsYKo/DNR7Qze+8qT
	akbZxAW+nUTnJwc7h6XnO0Iquw3ym0HGO7OwoDh5yhz34FseHjNZZbZmusbHpMKcN9eZrBmqBjg
	WhcaUqsVQIo3w2hadPo5XmDMN6yG5IB8=
X-Gm-Gg: ASbGncsReINfphP0i2Is94ym7urT3x8ugJHcEQHlwYOwpZYe9nXpT8F9Cy0MKMY3brL
	LxlTgJRiualimZOF6VQd4BpIBMJJcVvLtxHD7wxe17s7bHx127QWYwWjTHf7Vfg7OhIlN/epp9O
	BPg+413QhG9UXQOtWH8spBicfALedwzE7eDeIEHrujIc5AnLAJYsB53xHDay7dnXMl3j/dppb4Q
	wbUn8wb
X-Google-Smtp-Source: AGHT+IEm/7sv9TgmQJ9gQ5gdWa/6muLJPHRmIjLUZ8FuBE6psy68phxWZ6f+MuRrCcfshIzQgD7k6jz3MLj++RNUJuQ=
X-Received: by 2002:a05:622a:28a:b0:4b5:e903:7784 with SMTP id
 d75a77b69052e-4b5f8570e2cmr5052141cf.64.1757115014985; Fri, 05 Sep 2025
 16:30:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829233942.3607248-1-joannelkoong@gmail.com>
 <20250829233942.3607248-13-joannelkoong@gmail.com> <20250902234604.GC1587915@frogsfrogsfrogs>
 <aLiNYdLaMIslxySo@bfoster> <CAJnrk1Z6qKqkOwHJwaBfE9FEGABGD4JKoEwNbRJTpOWL-VtPrg@mail.gmail.com>
 <aLl8P8Qzn1IDw_7j@bfoster> <20250904200749.GZ1587915@frogsfrogsfrogs>
 <CAJnrk1aD=n1NzyxgftoQfvC83OO73w2E7ChvGHAh5xfxKrM86Q@mail.gmail.com>
 <aLrG_eOwiROSi-XB@bfoster> <rzgqmgmovfkreo5gdl36sxoxixcortjwkii2ilgmwsbhrwqx2z@3ncosg2erpta>
In-Reply-To: <rzgqmgmovfkreo5gdl36sxoxixcortjwkii2ilgmwsbhrwqx2z@3ncosg2erpta>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 5 Sep 2025 16:30:02 -0700
X-Gm-Features: Ac12FXxwfm5tl2soXeTwfC7VqiVLsMYobl5WnJQYv0WBsRtRBt8RqcQkElEHmZI
Message-ID: <CAJnrk1ZEmihX5yhmz0f7_sd77quCgxww+zkXfEXkWDZfFRp+2w@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] iomap: add granular dirty and writeback accounting
To: Jan Kara <jack@suse.cz>
Cc: Brian Foster <bfoster@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org, 
	brauner@kernel.org, willy@infradead.org, hch@infradead.org, 
	jlayton@kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 5:43=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 05-09-25 07:19:05, Brian Foster wrote:
> > On Thu, Sep 04, 2025 at 05:14:21PM -0700, Joanne Koong wrote:
> > > On Thu, Sep 4, 2025 at 1:07=E2=80=AFPM Darrick J. Wong <djwong@kernel=
.org> wrote:
> > > > On Thu, Sep 04, 2025 at 07:47:11AM -0400, Brian Foster wrote:
> > > > > On Wed, Sep 03, 2025 at 05:35:51PM -0700, Joanne Koong wrote:
> > > > > > On Wed, Sep 3, 2025 at 11:44=E2=80=AFAM Brian Foster <bfoster@r=
edhat.com> wrote:
> > > > > > > On Tue, Sep 02, 2025 at 04:46:04PM -0700, Darrick J. Wong wro=
te:
> > > > > > > > On Fri, Aug 29, 2025 at 04:39:42PM -0700, Joanne Koong wrot=
e:
> > > > > > > > > Add granular dirty and writeback accounting for large fol=
ios. These
> > > > > > > > > stats are used by the mm layer for dirty balancing and th=
rottling.
> > > > > > > > > Having granular dirty and writeback accounting helps prev=
ent
> > > > > > > > > over-aggressive balancing and throttling.
> > > > > > > > >
> > > > > > > > > There are 4 places in iomap this commit affects:
> > > > > > > > > a) filemap dirtying, which now calls filemap_dirty_folio_=
pages()
> > > > > > > > > b) writeback_iter with setting the wbc->no_stats_accounti=
ng bit and
> > > > > > > > > calling clear_dirty_for_io_stats()
> > > > > > > > > c) starting writeback, which now calls __folio_start_writ=
eback()
> > > > > > > > > d) ending writeback, which now calls folio_end_writeback_=
pages()
> > > > > > > > >
> > > > > > > > > This relies on using the ifs->state dirty bitmap to track=
 dirty pages in
> > > > > > > > > the folio. As such, this can only be utilized on filesyst=
ems where the
> > > > > > > > > block size >=3D PAGE_SIZE.
> > > > > > > >
> > > > > > > > Er... is this statement correct?  I thought that you wanted=
 the granular
> > > > > > > > dirty page accounting when it's possible that individual su=
b-pages of a
> > > > > > > > folio could be dirty.
> > > > > > > >
> > > > > > > > If i_blocksize >=3D PAGE_SIZE, then we'll have set the min =
folio order and
> > > > > > > > there will be exactly one (large) folio for a single fsbloc=
k.  Writeback
> > > > > >
> > > > > > Oh interesting, this is the part I'm confused about. With i_blo=
cksize
> > > > > > >=3D PAGE_SIZE, isn't there still the situation where the folio=
 itself
> > > > > > could be a lot larger, like 1MB? That's what I've been seeing o=
n fuse
> > > > > > where "blocksize" =3D=3D PAGE_SIZE =3D=3D 4096. I see that xfs =
sets the min
> > > > > > folio order through mapping_set_folio_min_order() but I'm not s=
eeing
> > > > > > how that ensures "there will be exactly one large folio for a s=
ingle
> > > > > > fsblock"? My understanding is that that only ensures the folio =
is at
> > > > > > least the size of the fsblock but that the folio size can be la=
rger
> > > > > > than that too. Am I understanding this incorrectly?
> > > > > >
> > > > > > > > must happen in units of fsblocks, so there's no point in do=
ing the extra
> > > > > > > > accounting calculations if there's only one fsblock.
> > > > > > > >
> > > > > > > > Waitaminute, I think the logic to decide if you're going to=
 use the
> > > > > > > > granular accounting is:
> > > > > > > >
> > > > > > > >       (folio_size > PAGE_SIZE && folio_size > i_blocksize)
> > > > > > > >
> > > > > >
> > > > > > Yeah, you're right about this - I had used "ifs && i_blocksize =
>=3D
> > > > > > PAGE_SIZE" as the check, which translates to "i_blocks_per_foli=
o > 1
> > > > > > && i_block_size >=3D PAGE_SIZE", which in effect does the same =
thing as
> > > > > > what you wrote but has the additional (and now I'm realizing,
> > > > > > unnecessary) stipulation that block_size can't be less than PAG=
E_SIZE.
> > > > > >
> > > > > > > > Hrm?
> > > > > > > >
> > > > > > >
> > > > > > > I'm also a little confused why this needs to be restricted to=
 blocksize
> > > > > > > gte PAGE_SIZE. The lower level helpers all seem to be managin=
g block
> > > > > > > ranges, and then apparently just want to be able to use that =
directly as
> > > > > > > a page count (for accounting purposes).
> > > > > > >
> > > > > > > Is there any reason the lower level functions couldn't return=
 block
> > > > > > > units, then the higher level code can use a blocks_per_page o=
r some such
> > > > > > > to translate that to a base page count..? As Darrick points o=
ut I assume
> > > > > > > you'd want to shortcut the folio_nr_pages() =3D=3D 1 case to =
use a min page
> > > > > > > count of 1, but otherwise ISTM that would allow this to work =
with
> > > > > > > configs like 64k pagesize and 4k blocks as well. Am I missing=
 something?
> > > > > > >
> > > > > >
> > > > > > No, I don't think you're missing anything, it should have been =
done
> > > > > > like this in the first place.
> > > > > >
> > > > >
> > > > > Ok. Something that came to mind after thinking about this some mo=
re is
> > > > > whether there is risk for the accounting to get wonky.. For examp=
le,
> > > > > consider 4k blocks, 64k pages, and then a large folio on top of t=
hat. If
> > > > > a couple or so blocks are dirtied at one time, you'd presumably w=
ant to
> > > > > account that as the minimum of 1 dirty page. Then if a couple mor=
e
> > > > > blocks are dirtied in the same large folio, how do you determine =
whether
> > > > > those blocks are a newly dirtied page or part of the already acco=
unted
> > > > > dirty page? I wonder if perhaps this is the value of the no sub-p=
age
> > > > > sized blocks restriction, because you can imply that newly dirtie=
d
> > > > > blocks means newly dirtied pages..?
> > > > >
> > > > > I suppose if that is an issue it might still be manageable. Perha=
ps we'd
> > > > > have to scan the bitmap in blks per page windows and use that to
> > > > > determine how many base pages are accounted for at any time. So f=
or
> > > > > example, 3 dirty 4k blocks all within the same 64k page size wind=
ow
> > > > > still accounts as 1 dirty page, vs. dirty blocks in multiple page=
 size
> > > > > windows might mean multiple dirty pages, etc. That way writeback
> > > > > accounting remains consistent with dirty accounting. Hm?
> > > >
> > > > Yes, I think that's correct -- one has to track which basepages /we=
re/
> > > > dirty, and then which ones become dirty after updating the ifs dirt=
y
> > > > bitmap.
> > > >
> > > > For example, if you have a 1k fsblock filesystem, 4k base pages, an=
d a
> > > > 64k folio, you could write a single byte at offset 0, then come bac=
k and
> > > > write to a byte at offset 1024.  The first write will result in a c=
harge
> > > > of one basepage, but so will the second, I think.  That results
> > > > incharges for two dirty pages, when you've really only dirtied a si=
ngle
> > > > basepage.
> > >
> > > Does it matter though which blocks map to which pages? AFAIU, the
> > > "block size" is the granularity for disk io and is not really related
> > > to pages (eg for writing out to disk, only the block gets written, no=
t
> > > the whole page). The stats (as i understand it) are used to throttle
> > > how much data gets written back to disk, and the primary thing it
> > > cares about is how many bytes that is, not how many pages, it's just
> > > that it's in PAGE_SIZE granularity because prior to iomap there was n=
o
> > > dirty tracking of individual blocks within a page/folio; it seems lik=
e
> > > it suffices then to just keep track of  total # of dirty blocks,
> > > multiply that by blocksize, and roundup divide that by PAGE_SIZE and
> > > pass that to the stats.
> > >
> >
> > I suppose it may not matter in terms of the purpose of the mechanism
> > itself. In fact if the whole thing could just be converted to track
> > bytes, at least internally, then maybe that would eliminate some of the
> > confusion in dealing with different granularity of units..? I have no
> > idea how practical or appropriate that is, though. :)
> >
> > The concern Darrick and I were discussing is more about maintaining
> > accounting consistency in the event that we do continue translating
> > blocks to pages and ultimately add support for the block size < page
> > size case.
> >
> > In that case the implication is that we'd still need to account
> > something when we dirty a single block out of a page (i.e.  use
> > Darrick's example where we dirty a 1k fs block out of a 4k page). If we
> > round that partial page case up to 1 dirty page and repeat as each 1k
> > block is dirtied, then we have to make sure accounting remains
> > consistent in the case where we dirty account each sub-block of a page
> > through separate writes, but then clear dirty accounting for the entire
> > folio once at writeback time.

Agreed, in the case where we do need to care about which block maps to
which page, we could parse the bitmap in PAGE_SIZE chunks where if any
bit in that range is marked dirty then the whole page is accounted for
as dirty. I don't think this would add too much overhead given that we
already need to iterate over bitmap ranges. Looking at this patchset
again, I think we can even get rid of ifs_count_dirty_pages() entirely
and just do the counting dynamically as blocks get dirtied, not sure
if there was some reason I didn't do it this way earlier, but I think
that works.

> >
> > But I suppose we are projecting the implementation a bit so it might no=
t
> > be worth getting this far into the weeds until you determine what
> > direction you want to go with this and have more code to review. All in
> > all, I do agree with Jan's general concern that I'd rather not have to
> > deal with multiple variants of sub-page state tracking in iomap. It's

I agree, I think we should try to keep the iomap stats accounting as
simple as possible. I like Jan's idea of having iomap's accounting go
towards bdi_writeback and leaving the other stuff untouched.

> > already a challenge to support multiple different filesystems. This doe=
s
> > seem like a useful enhancement to me however, so IMO it would be fine t=
o
> > just try and make it more generic (short of something more generic on
> > the mm side or whatever) than it is currently.
> >
> > > But, as Jan pointed out to me in his comment, the stats are also used
> > > for monitoring the health of reclaim, so maybe it does matter then ho=
w
> > > the blocks translate to pages.
> > >
> >
> > Random thought, but would having an additional/optional stat to track
> > bytes (alongside the existing page granularity counts) help at all? For
> > example, if throttling could use optional byte granular dirty/writeback
> > counters when they are enabled instead of the traditional page granular=
,
> > would that solve your problem and be less disruptive to other things
> > that actually prefer the page count?
>
> FWIW my current thinking is that the best might be to do byte granularity
> tracking for wb_stat_ counters and leave current coarse-grained accountin=
g
> for the zone / memcg stats. That way mm counters could be fully managed
> within mm code and iomap wouldn't have to care and writeback counters
> (which care about amount of IO, not amount of pinned memory) would be
> maintained by filesystems / iomap. We'd just need to come up with sensibl=
e
> rules where writeback counters should be updated when mm doesn't do it.
>

I like your idea a lot.

Thanks,
Joanne
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR


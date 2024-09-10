Return-Path: <linux-fsdevel+bounces-29024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28569973922
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 15:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D350D288722
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 13:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13784192B9C;
	Tue, 10 Sep 2024 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/yHp5kQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CFA18E11
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725976554; cv=none; b=BybLbssuHUPG+EYi1hv78KI9sA2Z0YBSTFDc10oFAYkchQ/O2qhnD//4EypUmjHen416/BuA1fMY5qON9ndgwVEnECk8X72qtOC2jknw8XqAkhPL9Cn7CsSHMruEV8AMiFC+i7V4ig1/7FPLnlsgU6zyoyEpEko+8+q+/qnGg1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725976554; c=relaxed/simple;
	bh=GWlsZej73ZuMUvV2G9lPWgMO0TgQPuJmV7m0LHgiSGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgW12tJ9I8jmjP5C7Oz+5xvM1H3LToOYwGT1FOG6EH1xuZ3IRkzUoX+RcQfDvciw6Ky6OUunK/fObGjl867bfe7P3j3m/DCxgyqZBQJRNwehuD1H7vEXjj2c1EOyVp6vW/kLRJh9xx0IZnj6l2VNNABp9++L1Ec6M9NsoRVkVmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i/yHp5kQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725976551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LG+03y8yV9cb/vSxnf/qXQ6Ec/O5RnTluBcXm/HyM/8=;
	b=i/yHp5kQaiFpU/WSLXyrY4QDJ3ENRMpmlNAlCCHvmvcbrEZzptbk6fiMQ+QqoD2MDzhpQE
	++L2/pOu4qvq3Dgkd4A2xst+ZVzBtuuFv232l9rCOVSTn20gsnuBFHXJAm9W1hyhGPBC+T
	2I5lmlB05ZVPPVBpWEuicxC4zDlqyso=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-jllPkfM9O7GvO_AfPrh_uA-1; Tue,
 10 Sep 2024 09:55:47 -0400
X-MC-Unique: jllPkfM9O7GvO_AfPrh_uA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 334171910409;
	Tue, 10 Sep 2024 13:55:41 +0000 (UTC)
Received: from bfoster (unknown [10.22.16.69])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3D5F19560B6;
	Tue, 10 Sep 2024 13:55:33 +0000 (UTC)
Date: Tue, 10 Sep 2024 09:56:36 -0400
From: Brian Foster <bfoster@redhat.com>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org,
	viro@zeniv.linux.org.uk, djwong@kernel.org, david@fromorbit.com,
	hch@lst.de, syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] iomap: Do not unshare exents beyond EOF
Message-ID: <ZuBQFMkIa5XNXrU0@bfoster>
References: <20240905102425.1106040-1-sunjunchao2870@gmail.com>
 <ZttT_sHrS5NQPAM9@bfoster>
 <CAHB1Nag5+AEqhd=nDKPg7S4y89CRAZp0mRU4_UHuQ=WnR58WpQ@mail.gmail.com>
 <Zt74BI7C-ZPn_WV_@bfoster>
 <CAHB1Nahz2UmrCpqEivV0Dzkt5P=rjbRaBekxtaXeWNraXfvCCA@mail.gmail.com>
 <Zt9MrgnBStwlGWpY@bfoster>
 <767963be0ce83221792d58667afd8b4ccc4f160d.camel@gmail.com>
 <ZuA70EmA47amHnwH@bfoster>
 <CAHB1Naj2XsnmeXJorOon1d1sOJnKKX4qeu_XZ+Z+8rd2vzcZow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHB1Naj2XsnmeXJorOon1d1sOJnKKX4qeu_XZ+Z+8rd2vzcZow@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Sep 10, 2024 at 09:25:41PM +0800, Julian Sun wrote:
> Brian Foster <bfoster@redhat.com> 于2024年9月10日周二 20:29写道：
> >
> > On Tue, Sep 10, 2024 at 03:03:18PM +0800, Julian Sun wrote:
> > > On Mon, 2024-09-09 at 15:29 -0400, Brian Foster wrote:
> > > > On Tue, Sep 10, 2024 at 01:40:24AM +0800, Julian Sun wrote:
> > > > > Brian Foster <bfoster@redhat.com> 于2024年9月9日周一 21:27写道：
> > > > > >
> > > > > > On Mon, Sep 09, 2024 at 08:15:43PM +0800, Julian Sun wrote:
> > > > > > > Hi Brian,
> > > > > > >
> > > > > > > Brian Foster <bfoster@redhat.com> 于2024年9月7日周六 03:11写道：
> > > > > > > >
> > > > > > > > On Thu, Sep 05, 2024 at 06:24:24PM +0800, Julian Sun wrote:
> > > > > > > > > Attempting to unshare extents beyond EOF will trigger
> > > > > > > > > the need zeroing case, which in turn triggers a warning.
> > > > > > > > > Therefore, let's skip the unshare process if extents are
> > > > > > > > > beyond EOF.
> > > > > > > > >
> > > > > > > > > Reported-and-tested-by: syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
> > > > > > > > > Closes: https://syzkaller.appspot.com/bug?extid=296b1c84b9cbf306e5a0
> > > > > > > > > Fixes: 32a38a499104 ("iomap: use write_begin to read pages to unshare")
> > > > > > > > > Inspired-by: Dave Chinner <david@fromorbit.com>
> > > > > > > > > Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> > > > > > > > > ---
> > > > > > > > >  fs/iomap/buffered-io.c | 3 +++
> > > > > > > > >  1 file changed, 3 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > > > > > > > index f420c53d86ac..8898d5ec606f 100644
> > > > > > > > > --- a/fs/iomap/buffered-io.c
> > > > > > > > > +++ b/fs/iomap/buffered-io.c
> > > > > > > > > @@ -1340,6 +1340,9 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
> > > > > > > > >       /* don't bother with holes or unwritten extents */
> > > > > > > > >       if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
> > > > > > > > >               return length;
> > > > > > > > > +     /* don't try to unshare any extents beyond EOF. */
> > > > > > > > > +     if (pos > i_size_read(iter->inode))
> > > > > > > > > +             return length;
> > > > > > > >
> > > > > > > > Hi Julian,
> > > > > > > >
> > > > > > > >
> > > > > > > > > What about if pos starts within EOF and the operation extends beyond it?
> > > > > > >
> > > > > > > Extents within EOF will be unshared as usual. Details are below.
> > > > > > > >
> > > > > > > > > I ask because I think I've reproduced this scenario, though it is a bit
> > > > > > > > > tricky and has dependencies...
> > > > > > > > >
> > > > > > > > > For one, it seems to depend on the cowblocks patch I recently posted
> > > > > > > > > here [1] (though I don't think this is necessarily a problem with the
> > > > > > > > > patch, it just depends on keeping COW fork blocks around after the
> > > > > > > > > unshare). With that, I reproduce via fsx with unshare range support [2]
> > > > > > > > > using the ops file appended below [3] on a -bsize=1k XFS fs.
> > > > > > > > >
> > > > > > > > > I haven't quite characterized the full sequence other than it looks like
> > > > > > > > > the unshare walks across EOF with a shared data fork block and COW fork
> > > > > > > > > delalloc, presumably finds the post-eof part of the folio !uptodate (so
> > > > > > > > > iomap_adjust_read_range() doesn't skip it), and then trips over the
> > > > > > > > > warning and error return associated with the folio zeroing in
> > > > > > > > > __iomap_write_begin().
> > > > > > >
> > > > > > > The scenario has already been reproduced by syzbot[1]. The reproducer
> > > > > > > provided by syzbot constructed the following extent maps for a file of
> > > > > > > size 0xE00 before fallocate unshare:
> > > > > > >
> > > > > > > 0 - 4k: shared between two files
> > > > > > > 4k - 6k: hole beyond EOF, not shared
> > > > > > > 6k - 8k: delalloc extends
> > > > > > >
> > > > > > > Then the reproducer attempted to unshare the extent between 0 and
> > > > > > > 0x2000 bytes, but the file size is 0xE00. This is likely the scenario
> > > > > > > you were referring to?
> > > > > > >
> > > > > >
> > > > > > Yes, sort of..
> > > > > >
> > > > > > > Eventually the unshare code does:
> > > > > > > first map: 0 - 4k - unshare successfully.
> > > > > > > second map: 4k - 6k - hole, skip. Beyond EOF.
> > > > > > > third map: 6k - 8k - delalloc, beyond EOF so needs zeroing.
> > > > > > > Fires warnings because UNSHARE.
> > > > > > >
> > > > > > > During the first call to iomap_unshare_iter(), iomap_length() returned
> > > > > > > 4k, so 4k bytes were unshared.
> > > > > > > See discuss here[2] for more details.
> > > > > > > >
> > > > > > > > This all kind of has me wondering.. do we know the purpose of this
> > > > > > > > warning/error in the first place? It seems like it's more of an
> > > > > > > > "unexpected situation" than a specific problem. E.g., assuming the same
> > > > > > > > page were mmap'd, I _think_ the read fault path would do the same sort
> > > > > > > > of zeroing such that the unshare would see a fully uptodate folio and
> > > > > > > > carry on as normal. I added the mapread op to the opsfile below to give
> > > > > > > > that a quick test (remove the "skip" text to enable it), and it seems to
> > > > > > > > prevent the error, but I've not confirmed whether that theory is
> > > > > > > > actually what's happening.
> > > > > > > >
> > > > > > > >
> > > > > > > > > FWIW, I also wonder if another way to handle this would be to just
> > > > > > > > > restrict the range of iomap_file_unshare() to within EOF. IOW if a
> > > > > > > > > caller passes a range beyond EOF, just process whatever part of the
> > > > > > > > > range falls within EOF. It seems iomap isn't responsible for the file
> > > > > > > > > extending aspect of the fallocate unshare command anyways.
> > > > > > >
> > > > > > > It already does 'just process whatever part of the range falls within EOF'.
> > > > > > > Check the above case.
> > > > > > >
> > > > > > > I'm not sure if I fully understand what you mean. This patch does not
> > > > > > > prevent unsharing extents within the EOF. This patch checks if pos is
> > > > > > > beyond EOF, instead of checking if pos + length is beyond EOF. So the
> > > > > > > extents within EOF should be unshared as usual.
> > > > > > >
> > > > > >
> > > > > > I'm not concerned about preventing unsharing. I'm concerned that this
> > > > > > patch doesn't always prevent attempts to unshare post-eof ranges. I
> > > > > > think the difference here is that in the variant I was hitting, we end
> > > > > >
> > > > > > > up with a mapping that starts within EOF and ends beyond EOF, whereas
> > > > > > > the syzbot variant produces a scenario where the problematic mapping
> > > > > > > always starts beyond EOF.
> > > > >
> > > > > This is not true. In the case above, the syzbot did indeed unshare the
> > > > > extents between 0-4k, which were started within EOF and ended beyond
> > > > > EOF. The specific variants here are: pos:0 len:0x1000 EOF: 0xE00. And
> > > > > the unshare code successfully unshared extents between 0 and 4k.
> > > > >
> > > > > During the next loop in iomap_file_unshare(), the pos became 0x1000,
> > > > > which is beyond EOF.  What this patch does is to skip the unshare
> > > > > during the second loop.
> > > > > Is there anything I misunderstand？
> > > >
> > > > Hmm, what block size? Does the associated mapping have at least one full
> > > > block beyond EOF? If you have a map at offset 0, length 0x1000 and EOF
> > > > at 0xE00, then unless you have 512b blocks it sounds like the EOF block
> > > > actually starts within EOF.
> > >
> > > The block size here is 2k, and there isn't a full block beyond EOF within
> > > this extent map.
> >
> > Ok. That likely explains the difference in behavior. The fsx variant has
> > a mapping that starts within EOF and has at least one post-EOF block
> > that unshare attempts to process.
> >
> > > >
> > > > The variant I'm seeing is more like this.. consider a -bsize=1k fs, a
> > > > file size of 0x3c400, and an EOF mapping of (offset 0x3c000, length
> > > > 0x4000). The EOF folio in this case is 4k in size and starts at the same
> > > > 0x3c000 offset as the EOF mapping.
> > > >
> > > > So with 1k blocks, the EOF mapping starts one block before EOF and
> > > > extends well beyond it. What happens in the test case is that
> > > > iomap_unshare_iter() is called with the EOF folio, pos 0x3c000, length
> > > > 0x800, and where the block at offset 0x3c400 is not marked uptodate. pos
> > > > is thus within EOF, but the while loop in __iomap_write_begin() walks
> > > > past it and attempts to process one block beyond EOF.
> > >
> > > Ok, so the key point here is that there is a full block beyond EOF within
> > > the associated extent map, which is different with the scenario reproduced
> > > by syzbot.
> > > According to the Dave's comments, the trimming behavior seems like should
> > > be done in filesystem(e.g.,xfs), instead of iomap. I will reconsider this scenario.
> > >
> >
> > Seems reasonable, but I don't agree that is a suitable fix for iomap. To
> > be clear, it's perfectly fine for the fs to trim the range however it
> > sees fit (i.e. no shared blocks beyond EOF in XFS), but we should also
> > recognize that iomap is a generic layer and unshare is currently
> > implemented to trip over itself, warn and fail if passed a post-eof
> > range.
> >
> >
> > > I still suspect that just making unshare work correctly around i_size
> > > might be the more elegant long term solution, but that is not totally
> > > clear. IMO, as long as unshare is written to intentionally trip over
> > > itself for post-eof ranges, it should either trim the range or check for
> > > valid parameters and document the limitation. Otherwise we just leave a
> > > landmine for the next caller to have to work through the same problems,
> > > which is particularly subtle since the higher level fallocate unshare
> > > mode supports post-eof ranges. Just my .02.
> 
> Yeah, totally agreed. I prefer to do the trimming in the vfs layer
> just like what generic_copy_file_checks() does, instead of a specific
> file system. Maybe we need a helper function
> generic_fallocate_checks(). But it requires more thought and testing.
> 

I would agree with that if not for the subtle difference between
fallocate unshare and the iomap implementation. fallocate unshare is
basically just a behavior modifier for how shared blocks are handled by
mode=0 preallocation, so AIUI it fully supports post-eof ranges. It can
extend the file size or leave it unchanged (based on whether KEEP_SIZE
is set) and preallocate beyond EOF.

IOW, it might be perfectly valid for a caller to run an fallocate
unshare across EOF that happens to unshare various shared blocks within
EOF, and then preallocate and extend the file size as part of the same
command. The functional responsibility just happens to be split between
iomap and the fs.

Brian

> >
> > Brian
> >
> > > Thanks for your comments and review.
> > > >
> > > > Brian
> > > >
> > > > > >
> > > > > > So IOW, this patch works for the syzbot variant because it happens to
> > > > > > reproduce a situation where pos will be beyond EOF, but that is an
> > > > > >
> > > > > > > assumption that might not always be true. The fsx generated variant runs
> > > > > > > a sequence that produces a mapping that spans across EOF, which means
> > > > > > > that pos is within EOF at the start of unshare, so unshare proceeds to
> > > > > > > walk across the EOF boundary, the corresponding EOF folio is not fully
> > > > > > > uptodate, and thus write begin wants to do partial zeroing and
> > > > > > > fails/warns.
> > > > >
> > > > > Yeah, it's exactly what the syzbot does.
> > > > > >
> > > > > > I suspect that if the higher level range were trimmed to be within EOF
> > > > > > in iomap_file_unshare(), that would prevent this problem in either case.
> > > > > > Note that this was on a -bsize=1k fs, so what I'm not totally sure about
> > > > > > is whether skipping zeroing as such would be a problem with larger FSBs.
> > > > > > My initial thinking was this might not be possible since the EOF folio
> > > > > > should be fully uptodate in that case, but that probably requires some
> > > > > > thought/review/testing.
> > > > > >
> > > > > > Brian
> > > > > >
> > > > > > > BTW, maybe the check here should be
> > > > > > >                   if (pos >= i_size_read(iter->inode))
> > > > > > >
> > > > > > > If there is any misunderstanding, please let me know, thanks.
> > > > > > >
> > > > > > > [1]: https://lore.kernel.org/all/0000000000008964f1061f8c32b6@google.com/T/
> > > > > > > [2]: https://lore.kernel.org/all/20240903054808.126799-1-sunjunchao2870@gmail.com/
> > > > > > >
> > > > > > > >
> > > > > > > > Thoughts?
> > > > > > > >
> > > > > > > > Brian
> > > > > > > >
> > > > > > > > [1] https://lore.kernel.org/linux-xfs/20240906114051.120743-1-bfoster@redhat.com/
> > > > > > > > [2] https://lore.kernel.org/fstests/20240906185606.136402-1-bfoster@redhat.com/
> > > > > > > > [3] fsx ops file:
> > > > > > > >
> > > > > > > > fallocate 0x3bc00 0x400 0
> > > > > > > > write 0x3bc00 0x800 0x3c000
> > > > > > > > clone_range 0x3bc00 0x400 0x0 0x3c400
> > > > > > > > skip mapread 0x3c000 0x400 0x3c400
> > > > > > > > fallocate 0x3bc00 0xc00 0x3c400 unshare
> > > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > Thanks,
> > > > > > > --
> > > > > > > Julian Sun <sunjunchao2870@gmail.com>
> > > > > > >
> > > > > >
> > > > >
> > > > > Thanks,
> > > > > --
> > > > > Julian Sun <sunjunchao2870@gmail.com>
> > > > >
> > > >
> > >
> > > Thanks,
> > > --
> > > Julian Sun <sunjunchao2870@gmail.com>
> > >
> >
> 
> 
> -- 
> Julian Sun <sunjunchao2870@gmail.com>
> 



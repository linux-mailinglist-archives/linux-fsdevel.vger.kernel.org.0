Return-Path: <linux-fsdevel+bounces-678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 621F77CE44D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 19:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C1A281A6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 17:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F5A3FB01;
	Wed, 18 Oct 2023 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UIQBdSCq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6BB3D984;
	Wed, 18 Oct 2023 17:20:28 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E64E35AC;
	Wed, 18 Oct 2023 10:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NJ1BTP4enJNNNxCONLlghXCw4BKj6HZF59i7tPQQ3q4=; b=UIQBdSCq8VXUQ0YaI2sU7iCwpN
	XO0OCWPf1TJbyHOFpE+2uvC11vloGWvOX+//b9ffLb2iKLoG75cmtiqNgUHxjkmZ0CZseXZ0n17pS
	0YImBIUPE0Xo+0+qNVUmdq2lvv5Xq9bNxrSq5H3v0cunVktjL6aofUJeXBdpk8gdFQzqWhQBUCm72
	fQUpazpLJchjdI0ZOM036PhyTnAKwNIPWKlnFK33DLQIvLVUnhjAhOywhErm6XAsHaG2l7ILbvHi+
	g3noZWD5ZuAVYc5J9F8P0jWWvOuxDKTDF72Smp0VhjlcHPiwuLFNhDIfibnK1U97dv+D13XfJ8l3i
	SSZY17Sg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qtADJ-0027gQ-Vj; Wed, 18 Oct 2023 17:20:10 +0000
Date: Wed, 18 Oct 2023 18:20:09 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 19/19] tarfs: introduce tar fs
Message-ID: <ZTATyXETyGeAVSxd@casper.infradead.org>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-20-wedsonaf@gmail.com>
 <ZTAOfMvegVAc58Yn@casper.infradead.org>
 <CANeycqqTgj_cVyRx1ZvGFjZjK0ACBUPobDk93ovP41DSXK2Xmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANeycqqTgj_cVyRx1ZvGFjZjK0ACBUPobDk93ovP41DSXK2Xmg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 02:05:51PM -0300, Wedson Almeida Filho wrote:
> On Wed, 18 Oct 2023 at 13:57, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Oct 18, 2023 at 09:25:18AM -0300, Wedson Almeida Filho wrote:
> > > +    fn read_folio(inode: &INode<Self>, mut folio: LockedFolio<'_>) -> Result {
> > > +        let pos = u64::try_from(folio.pos()).unwrap_or(u64::MAX);
> > > +        let size = u64::try_from(inode.size())?;
> > > +        let sb = inode.super_block();
> > > +
> > > +        let copied = if pos >= size {
> > > +            0
> > > +        } else {
> > > +            let offset = inode.data().offset.checked_add(pos).ok_or(ERANGE)?;
> > > +            let len = core::cmp::min(size - pos, folio.size().try_into()?);
> > > +            let mut foffset = 0;
> > > +
> > > +            if offset.checked_add(len).ok_or(ERANGE)? > sb.data().data_size {
> > > +                return Err(EIO);
> > > +            }
> > > +
> > > +            for v in sb.read(offset, len)? {
> > > +                let v = v?;
> > > +                folio.write(foffset, v.data())?;
> > > +                foffset += v.data().len();
> > > +            }
> > > +            foffset
> > > +        };
> > > +
> > > +        folio.zero_out(copied, folio.size() - copied)?;
> > > +        folio.mark_uptodate();
> > > +        folio.flush_dcache();
> > > +
> > > +        Ok(())
> > > +    }
> >
> > Who unlocks the folio here?
> 
> The `Drop` implementation of `LockedFolio`.
> 
> Note that `read_folio` is given ownership of `folio` (the last
> argument), so when it goes out of scope (or when it's explicitly
> dropped) its `drop` function is called automatically. You'll its
> implementation (and the call to `folio_unlock`) in patch 9.

That works for synchronous implementations of read_folio(), but for
an asynchronous implementation, we need to unlock the folio once the
read completes, typically in the bio completion handler.  What's the
plan for that?  Hand ownership of the folio to the bio submission path,
which hands it to the bio completion path, which drops the folio?


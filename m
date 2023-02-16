Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AFB699EB2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 22:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjBPVIs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 16:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjBPVIr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 16:08:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFE23CE2A;
        Thu, 16 Feb 2023 13:08:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 990BAB82953;
        Thu, 16 Feb 2023 21:08:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7A9C4339C;
        Thu, 16 Feb 2023 21:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676581719;
        bh=LvXIgDCIN74z8IeSY6yKYfnlHj9TM3k6hXkY0km0EW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hikKxQz3AH25YM7Yj7swfRo89ggmlTxL5wZ+t8ngdcR0TxFBH98IekShIEOzsRgK+
         LeIAaLccZSiORnG0COHoZ0KnXZkey5thc2g2d4BNKF5t0TgG54w6t9dYwRImOIWTYq
         RhoYCaayRBl4qav9fjF9l/j7ZVVJq6po2IDik5VEA5HvA1AExfNQJ5XiEpMjHtZ0Wp
         pUYtejiBRmqsOQ5E3BNn3hAe1pKv5h3ezas/qiXBGCA/39Rr0eOKtxVecnWh4HhqBF
         BxX0Qie8mx6h2whXwBZ0Fk0QPmIg74J8pELbiDg36VTBJrDQcAk6yg+hyAy2Qt0Pvy
         hUpXgQXjxAPDg==
Date:   Thu, 16 Feb 2023 13:08:38 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Allison Henderson <allison.henderson@oracle.com>
Cc:     Catherine Hoang <catherine.hoang@oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Chandan Babu <chandan.babu@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH 08/14] xfs: document btree bulk loading
Message-ID: <Y+6bVlkDRTLQfKtL@magnolia>
References: <167243825144.682859.12802259329489258661.stgit@magnolia>
 <167243825274.682859.12299993371367493328.stgit@magnolia>
 <09df3ede9060fb7a06a717e525d845154a637787.camel@oracle.com>
 <Y+WO0AGaKfZ1JuTe@magnolia>
 <d251e4463c6771af965f13a3d9733925d4230f78.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d251e4463c6771af965f13a3d9733925d4230f78.camel@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 16, 2023 at 03:46:02PM +0000, Allison Henderson wrote:

<snip to the relevant parts>

> > > > +Writing the New Tree
> > > > +````````````````````
> > > > +
> > > > +This part is pretty simple -- the btree builder
> > > > (``xfs_btree_bulkload``) claims
> > > > +a block from the reserved list, writes the new btree block
> > > > header,
> > > > fills the
> > > > +rest of the block with records, and adds the new leaf block to a
> > > > list of
> > > > +written blocks.
> > > > +Sibling pointers are set every time a new block is added to the
> > > > level.
> > > > +When it finishes writing the record leaf blocks, it moves on to
> > > > the
> > > > node
> > > > +blocks.
> > > > +To fill a node block, it walks each block in the next level down
> > > > in
> > > > the tree
> > > > +to compute the relevant keys and write them into the parent
> > > > node.
> > > > +When it reaches the root level, it is ready to commit the new
> > > > btree!
> > > I think most of this is as straight forward as it can be, but it's
> > > a
> > > lot visualizing too, which makes me wonder if it would benefit from
> > > an
> > > simple illustration if possible.
> > > 
> > > On a side note: In a prior team I discovered power points, while a
> > > lot
> > > work, were also really effective for quickly moving a crowd of
> > > people
> > > through connected graph navigation/manipulations.  Because each one
> > > of
> > > these steps was another slide that illustrated how the structure
> > > evolved through the updates.  I realize that's not something that
> > > fits
> > > in the scheme of a document like this, but maybe something
> > > supplemental
> > > to add later.  While it was a time eater, i noticed a lot of
> > > confused
> > > expressions just seemed to shake loose, so sometimes it was worth
> > > it.
> > 
> > That was ... surprisingly less bad than I feared it would be to cut
> > and
> > paste unicode linedraw characters and arrows.
> > 
> >           ┌─────────┐
> >           │root     │
> >           │PP       │
> >           └─────────┘
> >           ↙         ↘
> >       ┌────┐       ┌────┐
> >       │node│──────→│node│
> >       │PP  │←──────│PP  │
> >       └────┘       └────┘
> >       ↙   ↘         ↙   ↘
> >   ┌────┐ ┌────┐ ┌────┐ ┌────┐
> >   │leaf│→│leaf│→│leaf│→│leaf│
> >   │RRR │←│RRR │←│RRR │←│RRR │
> >   └────┘ └────┘ └────┘ └────┘
> > 
> > (Does someone have a program that does this?)
> I think Catherine mentioned she had used PlantUML for the larp diagram,
> though for something this simple I think this is fine

<nod>

> > I really like your version!  Can I tweak it a bit?
> > 
> > - Until the reverse mapping btree runs out of records:
> > 
> >   - Retrieve the next record from the btree and put it in a bag.
> > 
> >   - Collect all records with the same starting block from the btree
> > and
> >     put them in the bag.
> > 
> >   - While the bag isn't empty:
> > 
> >     - Among the mappings in the bag, compute the lowest block number
> >       where the reference count changes.
> >       This position will be either the starting block number of the
> > next
> >       unprocessed reverse mapping or the next block after the
> > shortest
> >       mapping in the bag.
> > 
> >     - Remove all mappings from the bag that end at this position.
> > 
> >     - Collect all reverse mappings that start at this position from
> > the
> >       btree and put them in the bag.
> > 
> >     - If the size of the bag changed and is greater than one, create
> > a
> >       new refcount record associating the block number range that we
> >       just walked to the size of the bag.
> > 
> > 
> Sure, that looks fine to me

Ok, will commit.

> > > Branch link?  Looks like maybe it's missing.  In fact this logic
> > > looks
> > > like it might have been cut off?
> > 
> > OH, heh.  I forgot that we already merged the AGFL repair code.
> > 
> > "See `fs/xfs/scrub/agheader_repair.c
> > <
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre
> > e/fs/xfs/scrub/agheader_repair.c>`_
> > for more details."
> > 
> > > In any case, maybe give some thought to the highlight link
> > > suggestions.
> > 
> > Er... how do those work?  In principle I like them, but none of your
> > links actually highlighted anything here.  Could you send the link
> > over
> > IRC so that urldefense crapola won't destroy it, please?
> > 
> > --D
> So I think the last we talked about these, we realized they're a chrome
> only format.  That's a shame, I think they really help people to
> quickly navigate the code in question.  Otherwise I'm pretty much just
> poking through the branches looking for code that resembles the
> description.

Yep.  Back in 2020, Google was pushing a "link to text fragment"
proposal wherein they'd add some secret sauce to URL anchors:

#:~:text=[prefix-,]textStart[,textEnd][,-suffix]

Which would inspire web browsers to highlight all instances of "text" in
a document and autoscroll to the first occurrence.  They've since
integrated this into Chrome and persuaded Safari to pick it up, but
there are serious problems with this hack.

https://wicg.github.io/scroll-to-text-fragment/

The first and biggest problem is that none of the prefix characters here
":~:text=" are invalid characters for a url anchor, nor are they ever
invalid for an <a name> tag.  This is valid html:

<a name="dork:~:text=farts">cow</a>

And this is valid link to that html anchor:

file:///tmp/a.html#dork:~:text=farts

Web browsers that are unaware of this extension (Firefox, lynx, w3m,
etc.) will not know to ignore everything starting with ":~:" when
navigating, so they will actually try to find an anchor matching that
name.  That's why it didn't work for me but worked fine for Allison.

This is even worse if the document also contains:

<a name="dork">frogs</a>

Because now the url "file:///tmp/a.html#dork:~:text=farts" jumps to
"cow" on Chrome, and "frogs" on Firefox.

Embrace and extend [with proprietary bullsh*t].  Thanks Google.

> I also poked around and found there was a firefox plugin that does the
> same (link to text fragment addon).  Though it doesn't look like the
> links generated are compatible between the browsers.

No, they are not.

> Maybe something to consider if we have a lot of chrome or ff users.  I
> think if they help facilitate more discussion they're better than
> nothing at least during review.

I'll comb through these documents and add some suggestions of where to
navigate, e.g.

"For more details, see the function xrep_reap."

Simple and readable by anyone, albeit without the convenient mechanical
links.

For more fun reading, apparently terminals support now escape sequences
to inject url links too:
https://github.com/Alhadis/OSC8-Adoption

--D

> > 
> > > Allison
> > > 
> 

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3729572E5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 08:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbiGMGqm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 02:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiGMGql (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:46:41 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1F4FDF396
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 23:46:40 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id A779E10E7ED9;
        Wed, 13 Jul 2022 16:46:33 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oBW8l-000Ihm-RN; Wed, 13 Jul 2022 16:46:31 +1000
Date:   Wed, 13 Jul 2022 16:46:31 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        ansgar.loesser@kom.tu-darmstadt.de, Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Max Schlecht <max.schlecht@informatik.hu-berlin.de>,
        =?iso-8859-1?Q?Bj=F6rn?= Scheuermann 
        <scheuermann@kom.tu-darmstadt.de>
Subject: Re: Information Leak: FIDEDUPERANGE ioctl allows reading writeonly
 files
Message-ID: <20220713064631.GC3600936@dread.disaster.area>
References: <a7c93559-4ba1-df2f-7a85-55a143696405@tu-darmstadt.de>
 <CAHk-=wjrOgiWfN2uWf8Ajgr4SjeWMkEJ1Sd=H6pnS_JLjJwTcQ@mail.gmail.com>
 <CAEzrpqdweuZ2ufMKDJwSzP5W021F7mgS+7toSo6VDgvDzd0ZqA@mail.gmail.com>
 <CAHk-=wgEgAjX5gRntm0NutaNtjkzN+OaJVMaJAqved4dxPtAqw@mail.gmail.com>
 <Ys3TrAf95FpRgr+P@localhost.localdomain>
 <CAHk-=wi1-o-3iF09+PnNHq6_HLQhRn+32ow_f44to7_JuNCUoA@mail.gmail.com>
 <Ys4WdKSUTcvktuEl@magnolia>
 <CAHk-=wjUw11O60KuPBpsq1-hut9-Y76puzGqvgFJr5RwUPLS_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjUw11O60KuPBpsq1-hut9-Y76puzGqvgFJr5RwUPLS_A@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62ce6a4e
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=RgO8CyIxsXoA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=jRWIXKmnMX9Bih7pznwA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 12, 2022 at 07:58:11PM -0700, Linus Torvalds wrote:
> On Tue, Jul 12, 2022 at 5:48 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > AFAICT, the reason why dedupe does all the weird checks it does is
> > because apparently some of the dedupe tools expect that they can do
> > weird things like dedupe into a file that they own but haven't opened
> > for writes or could open for writes.  Change those bits, and you break
> > userspace.
> 
> Christ, what a crock.

Yes, the dedupe API is ... poor. But we're stuck with it because
someone called Linus Torvalds who keeps telling us that we
should not break userspace if there's *any way possible* to avoid
doing so....

.... and in this case, I think the problem is avoided by a simple
fix to generic_remap_checks().

> > The dedupe implementations /do/ check file blocksize, it's under
> > generic_remap_file_range_prep.  The reason this exploit program works on
> > the 7-byte file is that we stop comparing at EOF, which means that there
> > are fewer bytes to guess.  But.  You can already read the file anyway.
> 
> The dedupe clearly does *not* check for blocksize. It doesn't even
> call generic_remap_file_range_prep().
> 
> Just check it yourself:

I did, hours ago, and concluded that you were on the wrong track and
I didn't care enough to get involved in a shouting match.

But you're not actually understanding the code, nor are you
listening to the people who are trying to point out that you haven't
understood how the code works. You're causing those people stress
and angst by shouting them down even though you are wrong - these
people know the code far better than you, so you need to listen to
them rather than shout over them.

So, let's clear all that away, and just follow the code. I'll map
out the path to block alignment for you:

>     do_vfs_ioctl ->
>         case FIDEDUPERANGE:
>          ioctl_file_dedupe_range(filp, argp) ->
>             vfs_dedupe_file_range(file, same) ->

There's no checks at this point because we can't do them safely.  We
have to first lock the inodes before we check against EOF so that
dedupe does not race against truncate, fallocate, or extending
writes. This is important because we have to support the "dedupe
whole file" case that is defined by src = {0, EOF}, dst = {0, EOF},
and that's where all the complexity lies.

Hence we have to continue down the dedupe stack to lock the inodes
and perform the block alignment checks:

	        vfs_dedupe_file_range_one()
		  file->f_op->remap_file_range()
		    xfs_file_remap_range()
		      <locks inodes>
		      <performs XFS specific remap checks>
		      generic_remap_file_range_prep()
		        generic_remap_checks()

generic_remap_checks() does:

.....
        loff_t bs = inode_out->i_sb->s_blocksize;
        int ret;

        /* The start of both ranges must be aligned to an fs block. */
        if (!IS_ALIGNED(pos_in, bs) || !IS_ALIGNED(pos_out, bs))
                return -EINVAL;
.....

        /*
         * If the user wanted us to link to the infile's EOF, round up to the
         * next block boundary for this check.
         *
         * Otherwise, make sure the count is also block-aligned, having
         * already confirmed the starting offsets' block alignment.
         */
        if (pos_in + count == size_in) {
                bcount = ALIGN(size_in, bs) - pos_in;
        } else {
                if (!IS_ALIGNED(count, bs))
                        count = ALIGN_DOWN(count, bs);
                bcount = count;
        }

It should be clear that this code does not allow unaligned file
offsets at all. It should also be clear that we silently round the
dedupe length down to block size alignment to avoid sub-block dedupe
attempts (not possible) rather than erroring out because it's always
valid to dedupe less range than was asked for.

However, we also have a special case for the "dedupe to EOF"
operation that allows whole file dedupe. In that case, we round the
length *up* to capture the whole EOF block in the remap attempt.
That's the case where bug the test case exploits lies - it fails to
check whether the dst range is also deduping all the way to EOF.

We haven't got to the data match checks yet - we're still deciding on
the bounds for the data match checks at this point. Hence if we get
the bound checks wrong here, the data checks might match when they
shouldn't. e.g. by only checking for partial block matches instead
of checking all the valid data in both src and dst match.

That's the bug in this code - the dedupe length EOF rounding needs
to be more constrained as it's allowing an EOF block to be partially
matched against any full filesystem block as long as the range from
start to EOF in the block matches. That's the information leak right
there, and it has nothing to do with permissions.

Hence if we restrict EOF block deduping to both the src and dst
files having matching EOF offsets in their EOF blocks like so:

-	if (pos_in + count == size_in) {
+	if (pos_in + count == size_in &&
+	    (!(remap_flags & REMAP_FILE_DEDUP) || pos_out + count == size_out)) {
                bcount = ALIGN(size_in, bs) - pos_in;
        } else {
                if (!IS_ALIGNED(count, bs))
                        count = ALIGN_DOWN(count, bs);
                bcount = count;
	}

This should fix the bug that was reported as it prevents dedupe an
EOF block against non-EOF blocks or even EOF blocks where EOF is at
a different offset into the EOF block.

So, yeah, I think arguing about permissions and API and all that
stuff is just going completely down the wrong track because it
doesn't actually address the root cause of the information leak....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A665617495
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 03:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiKCCzw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 22:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiKCCz0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 22:55:26 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2E710FEE;
        Wed,  2 Nov 2022 19:55:20 -0700 (PDT)
Received: from letrec.thunk.org (guestnat-104-133-8-97.corp.google.com [104.133.8.97] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2A32snCX003837
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Nov 2022 22:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1667444094; bh=41+/r6dUxN9gZm3tROUz2W96+3LztrQSpB7Atiqbua8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=l2AskeqKk2PUolI+9Mtp/Gc9/TRlFNdwgIaffB3SUR2vzFTrJJVt3mjqu6L6T4siJ
         UCCVzV/v1umgfTruoP8yvKDErQvVNJ/fA/+gPRDQTOL6c29VIYkXh0L+VbX3hKJv91
         6FazH1C+obJlSUJgDKRaMq0citWM2MrG7peakp+RXgkHwTHNC6avmuEAbCrJ/HCQaJ
         jqJnUghjMGcd5yP/+L4HVIPeBpvmFSvdrIDdS46k9jj7iVnBNZf09SKSBDdzk38ap9
         p9ey1iqpaKDZ0GH4uDy/WzYnzMrgx3lBfSAJ7qz7WFFkIQGDAAujnLzJupmDTG0T8O
         YAqFcTgI7o1bQ==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id BABF88C2A3A; Wed,  2 Nov 2022 22:54:48 -0400 (EDT)
Date:   Wed, 2 Nov 2022 22:54:48 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     David Sterba <dsterba@suse.cz>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chris Mason <clm@meta.com>, Christoph Hellwig <hch@lst.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: consolidate btrfs checksumming, repair and bio splitting
Message-ID: <Y2MteFkep2ko1UKA@mit.edu>
References: <20220901074216.1849941-1-hch@lst.de>
 <347dc0b3-0388-54ee-6dcb-0c1d0ca08d05@wdc.com>
 <20221024144411.GA25172@lst.de>
 <773539e2-b5f1-8386-aa2a-96086f198bf8@meta.com>
 <20221024171042.GF5824@suse.cz>
 <9f443843-4145-155b-2fd0-50613a9f7913@wdc.com>
 <20221026074145.2be5ca09@gandalf.local.home>
 <20221031121912.GY5824@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031121912.GY5824@twin.jikos.cz>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 31, 2022 at 01:19:12PM +0100, David Sterba wrote:
> > The policy is simple. If someone requires a copyright notice for their
> > code, you simply add it, or do not take their code. You can be specific
> > about what that code is that is copyrighted. Perhaps just around the code in
> > question or a description at the top.
> 
> Let's say it's OK for substantial amount of code. What if somebody
> moves existing code that he did not write to a new file and adds a
> copyright notice? We got stuck there, both sides have different answer.
> I see it at minimum as unfair to the original code authors if not
> completely wrong because it could appear as "stealing" ownership.

So for whatever it's worth, my personal opinion is that it should be
the Maintainer's call, subject to override by Linus.  I don't think
it's really worthwhile to try to come up to a formal policy which
would need to define "substantial amount of code".  This is an area
where I think it makes sense to assume that Maintainers will be
reasonable and make decisions that makes sense.  Ultimately, I think
Chris's phrasing is the one that makes sense.  How much do you want
the contribution?  If you want the contribution, and the contributor
requests that they want an explicit copyright notification --- make a
choice.  You can either tell Christoph no, and revert the changes, or
accept his request to include a copyright statement.

I understand your concern about "fairness" to other contributors ---
is this a hypothetical, or actual concern?  Are there other
significant contributors who have explicitly told you that they will
be mortally offended if Cristoph's request is honored, and their code
contribution was not so recognized?  It's unclear to whether this is a
theoretical or practical concern?

If it is a practical concern, how many contributors have contributed
more than Cristoph that have asked, and how many extra lines of
copyright statements are we're talking about?   2?  3?  10?  100?

Remember, if someone sends you whitespace fixups or doubled word fixes
found using checkpatch, and demeands a copyright acknowledgement,
you're free to reject the patch.  (Heck, some maintainers reject
checkpatch --file fixups on general principles.  :-) So this is why I
think the overall "Linux project standard" should be: "maintainer
discretion".

Cheers,

					- Ted

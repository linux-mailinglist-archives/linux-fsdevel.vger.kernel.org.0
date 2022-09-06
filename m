Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8935AF46D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 21:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiIFT3m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 15:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiIFT3k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:29:40 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E9BDFC5;
        Tue,  6 Sep 2022 12:29:38 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 665A8478E; Tue,  6 Sep 2022 15:29:37 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 665A8478E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1662492577;
        bh=XGLBKT9w9XX1IQDmpohtQXUS/bQ7LEyWy9wLLV07wy4=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=f0TOYAqq3DNhAF6nnR14fIi4+n8N0qXVeyO94lwN5bTTt1ovuVrBbkE6i4nvkhYyp
         j0myfRk6evmW/J/L2L1kMLeesn7O3mG0DduGlRFV2P9AFb/bXCDMRRy89+G2ibprFK
         bVDUxUV/CaccjngHJ3w9sgmffnlehVAnqqho7iJA=
Date:   Tue, 6 Sep 2022 15:29:37 -0400
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Florian Weimer <fweimer@redhat.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, djwong@kernel.org, david@fromorbit.com,
        trondmy@hammerspace.com, neilb@suse.de, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, jack@suse.cz, brauner@kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [RFC PATCH v2] statx, inode: document the new STATX_INO_VERSION
 field
Message-ID: <20220906192937.GE25323@fieldses.org>
References: <20220901121714.20051-1-jlayton@kernel.org>
 <874jxrqdji.fsf@oldenburg.str.redhat.com>
 <81e57e81e4570d1659098f2bbc7c9049a605c5e8.camel@kernel.org>
 <87ilm066jh.fsf@oldenburg.str.redhat.com>
 <d1ee62062c3f805460b7bdf2776e759be4dba43f.camel@kernel.org>
 <b8b0c5adc6598c57fb109447e3bc54492b54c36a.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8b0c5adc6598c57fb109447e3bc54492b54c36a.camel@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 06, 2022 at 01:04:05PM -0400, Jeff Layton wrote:
> On Tue, 2022-09-06 at 12:41 -0400, Jeff Layton wrote:
> > On Tue, 2022-09-06 at 14:17 +0200, Florian Weimer wrote:
> > > * Jeff Layton:
> > > 
> > > > All of the existing implementations use all 64 bits. If you were to
> > > > increment a 64 bit value every nanosecond, it will take >500 years for
> > > > it to wrap. I'm hoping that's good enough. ;)
> > > > 
> > > > The implementation that all of the local Linux filesystems use track
> > > > whether the value has been queried using one bit, so there you only get
> > > > 63 bits of counter.
> > > > 
> > > > My original thinking here was that we should leave the spec "loose" to
> > > > allow for implementations that may not be based on a counter. E.g. could
> > > > some filesystem do this instead by hashing certain metadata?
> > > 
> > > Hashing might have collisions that could be triggered deliberately, so
> > > probably not a good idea.  It's also hard to argue that random
> > > collisions are unlikely.
> > > 
> > 
> > In principle, if a filesystem could guarantee enough timestamp
> > resolution, it's possible collisions could be hard to achieve. It's also
> > possible you could factor in other metadata that wasn't necessarily
> > visible to userland to try and ensure uniqueness in the counter.
> > 
> > Still...

I've got one other nagging worry, about the ordering of change attribute
updates with respect to their corresponding changes.  I think with
current implementations it's possible that the only change attribute
update(s) may happen while the old file data is still visible, which
means a concurrent reader could cache the old data with the new change
attribute, and be left with a stale cache indefinitely.

For the purposes of close-to-open semantics I think that's not a
problem, though.

There may be some previous discussion of this in mailing list archives.

--b.

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C2368BE0B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Feb 2023 14:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjBFNW4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 08:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBFNWz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:22:55 -0500
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3242868E;
        Mon,  6 Feb 2023 05:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=PTKWEL8KfAMKMbeLLhW74FPh3ps+IFGA3tVormfA9wE=; b=Ng8xjZVqAhZc2EOOID2OTBI7lQ
        QxgGtIIGsN5f1s7eCMtLPl4NOqJoTurnpJdUdjvG9sjcp2ObG47rLYrp2kp5OAh5xQHw06IzVHKrc
        z3abvdHd+R+ZUD9hLt1HdVV8qSluoQM56tMXi46wzHYshSr0Fg40cdIWMHOJQB5JHuSzarvVoyEgj
        Mw75X4s2O69CDtyxVoJtXE743N9wDSgGTxCy2WulNmcfOXmv6I3yznOXDzKRosds9ChE1zmzzlfOP
        yOvJgavvzY7wLF58A94sP5hQuYW4e3db1Hf3lkG+nY9uZZgH8GUCAOYDJzQ8Jt4qclUuVXC9Xv+j1
        aU0+zqH3gTHwLOMdAkBLSWC2pJ/0xMaugCeBZ5qWiNwMOLXfVKUuKe2kxHeFJ/ziSHZw9ABxJgZog
        GC3QJcDIZzE3bDxv85TgG1U4dQjSePP5pvES+EGo3u8w9VLptFU1Ho4+IyRo+6lBBywAytfUOGBAN
        mPgSKRIK4jx/udAPteBZivI/yord4ccrcQur9lelwbN9X1XgtK14WPHE8+eQiVf0GsoIRQ7s3eK2R
        i4lMUVBX37hhw6snp772wgJbwFnjObDc53Hlet/AmMN1S6q5tUaptCOvt2ZV3g/LH8k28aXmHiMh5
        DbBiLoXwLNsOj7Dxl7kIHiLGWCF2OA+6+FFS9oF2I=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Eric Van Hensbergen <ericvh@gmail.com>
Cc:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net,
        Eric Van Hensbergen <ericvh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 00/11] Performance fixes for 9p filesystem
Date:   Mon, 06 Feb 2023 14:20:47 +0100
Message-ID: <1959073.LTPWMqHWT2@silver>
In-Reply-To: <CAFkjPT=nxuG5rSuJ1seFV9eWvWNkyzw2f45yWqyEQV3+M91MPg@mail.gmail.com>
References: <20221218232217.1713283-1-evanhensbergen@icloud.com>
 <2302787.WOG5zRkYfl@silver>
 <CAFkjPT=nxuG5rSuJ1seFV9eWvWNkyzw2f45yWqyEQV3+M91MPg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sunday, February 5, 2023 5:37:53 PM CET Eric Van Hensbergen wrote:
> I was so focused on the bugs that I forgot to respond to the
> performance concerns -- just to be clear, readahead and writeback
> aren't meant to be more performant than loose, they are meant to have
> stronger guarantees of consistency with the server file system.  Loose
> is inclusive of readahead and writeback, and it keeps the caches
> around for longer, and it does some dir caching as well -- so its
> always going to win, but it does so with risk of being more
> inconsistent with the server file system and should only be done when
> the guest/client has exclusive access or the filesystem itself is
> read-only.

Okay, that's surprising to me indeed. My expecation was that "loose" would 
still retain its previous behaviour, i.e. loose consistency cache but without 
any readahead or writeback. I already wondered about the transitivity you used 
in code for cache selection with direct `<=` comparison of user's cache 
option.

Having said that, I wonder whether it would make sense to handle these as 
options independent of each other (e.g. cache=loose,readahead), but not sure, 
maybe it would overcomplicate things unnecessarily.

> I've a design for a "tight" cache, which will also not be
> as performant as loose but will add consistent dir-caching on top of
> readahead and writeback -- once we've properly vetted that it should
> likely be the default cache option and any fscache should be built on
> top of it.  I was also thinking of augmenting "tight" and "loose" with
> a "temporal" cache that works more like NFS and bounds consistency to
> a particular time quanta.  Loose was always a bit of a "hack" for some
> particular use cases and has always been a bit problematic in my mind.

Or we could add notifications on file changes from server side, because that's 
what this is actually about, right?

> So, to make sure we are on the same page, was your performance
> uplifts/penalties versus cache=none or versus legacy cache=loose?

I have not tested cache=none at all, because in the scenario of 9p being a 
root fs, you need at least cache=mmap, otherwise you won't even be able to 
boot a minimum system.

I compared:

  * master(cache=loose) vs. this(cache=loose)

  * master(cache=loose) vs. this(cache=readahead)

  * master(cache=loose) vs. this(cache=writeback)

> The 10x perf improvement in the patch series was in streaming reads over
> cache=none.

OK, that's an important information to mention in the first place. Because 
when say you measured a performance plus of x times, I would assume you 
compared it to at least a somewhat similar setup. I mean cache=loose was 
always much faster than cache=none before.

> I'll add the cache=loose datapoints to my performance
> notebook (on github) for the future as points of reference, but I'd
> always expect cache=loose to be the upper bound (although I have seen
> some things in the code to do with directory reads/etc. that could be
> improved there and should benefit from some of the changes I have
> planned once I get to the dir caching).
> 
>           -eric



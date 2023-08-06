Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57754771540
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Aug 2023 15:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjHFN0B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Aug 2023 09:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHFN0B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Aug 2023 09:26:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A81B3;
        Sun,  6 Aug 2023 06:26:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9F7061138;
        Sun,  6 Aug 2023 13:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0187C433C7;
        Sun,  6 Aug 2023 13:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691328359;
        bh=egMvoe6nYl3MirXCExFG7Mag+dF3/2MBUdh7Je7OQYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=un5kdDEhIG5fw+14rCm5ojUSu9WW+0B248SGQZgCXBKTS3hZVPanAfptLuro2rYDU
         GPmo+NtVIryg7BmN3OotP29tH81TIgztCcsKpme/fBGaA2UzdudQmK68P1HNd/4oE+
         X6V3l9LD6IoCDhYyvFzvDmqzSD6b5dL7EPKm8G9lXhKNwB8SsiIcaosd/UgQNV7UjX
         te+cISU3WNSPIg/G4rmO6wUEkQqBH0C3fAM0gXOnxre6eLhRO0Rqx+sd8W/rCWgoYs
         aZN1iRsIxIMwyeZe5FQwNgQir48vskvlrifHORqOWXJjziR5vCglPcXAplfXE0PS7D
         p84WbvKCqp7fQ==
Date:   Sun, 6 Aug 2023 15:25:51 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mateusz Guzik <mjguzik@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] file: always lock position
Message-ID: <20230806-appell-heulen-61fc63545739@brauner>
References: <20230804-turnverein-helfer-ef07a4d7bbec@brauner>
 <20230805-furor-angekauft-82e334fc83a3@brauner>
 <CAHk-=witxS+hfdFc+xJVpb9y-cE6vYopkDaZvvk=aXHcv-P5=w@mail.gmail.com>
 <CAHk-=wiEzoh1gqfOp3DNTS9iPOxAWtS71qS0xv1XBziqGHGTwg@mail.gmail.com>
 <20230806-mundwinkel-wenig-d1c9dcb2c595@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230806-mundwinkel-wenig-d1c9dcb2c595@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 06, 2023 at 08:10:40AM +0200, Christian Brauner wrote:
> > Yes, some filesystems then still get the inode lock in write mode, but
> > now it's the filesystem itself that wraps its own iterator, rather
> > than cause pain for the callers.
> 
> And, btrfs already does this in some cases where it first upgrades from
> shared to non-shared and then downgrades again before returning in
> btrfs_real_readdir(). So it's not like this isn't already happening.
> 
> > 
> > So no more "Do you have an ->iterate() _or_ ->iterate_shared()
> > function?" and associated "I need to do locking differently"
> > nastiness. Only odd filesystems that never got the memo on "don't use
> > .iterate".
> 
> Ack. It's not pretty but that hasn't stopped us before and it's less
> ugly than double inode methods which pass exactly the same parameters. I
> think removing the double methods is good and I see no problem in
> shaming filesystems that didn't manage to convert properly in the last 7
> years.
> 
> And let's please not get stuck on incoming pinky promises that everyone
> will have converted before the next 7 years are over. I'd prefer to see
> the iop wiped and leave the ugliness to the individual filesystems rn.

We got sent a fix for a wrong check for O_TMPFILE during RESOLVE_CACHED
lookup which I've put on vfs.fixes yesterday:

git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.5-rc5.vfs.resolve_cached.fix

But in case you planned on applying this directly instead of waiting for
next cycle I've added your two appended patches on top of it and my
earlier patch for massaging the file_needs_f_pos_lock() check that
triggered this whole thing:

git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.5-rc5.vfs.fixes

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBA17713B8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Aug 2023 08:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjHFGKq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Aug 2023 02:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHFGKp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Aug 2023 02:10:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E44F1FCF;
        Sat,  5 Aug 2023 23:10:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B688760F5E;
        Sun,  6 Aug 2023 06:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA560C433C7;
        Sun,  6 Aug 2023 06:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691302240;
        bh=GZkAWygYnD5KZ+tpBloRAoQGU23mPvb9I6bj51CDkuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=induHqEOsj4DN0KZVbKpqQSwi3HvaK4/WuzFxRMDOvdIyf0ZlGp8iT9r0BwljpMMM
         013fAdxucn+46DeeBGf5Q1G14WaVTQe1oszbdea6XcJsu5qxUO+Oh/HPKqkAkOYzM1
         14IqGzCpexMM4DcuzUOSCHlo3F4xr6Z9Q4hFf1J9fZMgaKTwv0fjD/fKjblWxWiY49
         ah69rreM9ON45SoEerpznq2XtFIInQN4JhSaEwarX+X2VRfNb+B043C9BBmIx0Mjvk
         siX9OKrVfGCa2YreS1tFp2dOqRkyzKYRabHiCPOiQSxzrDnIONwqI+QgWTrQovF5yz
         r9VMm+3CAolLQ==
Date:   Sun, 6 Aug 2023 08:10:32 +0200
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
Message-ID: <20230806-mundwinkel-wenig-d1c9dcb2c595@brauner>
References: <20230804-turnverein-helfer-ef07a4d7bbec@brauner>
 <20230805-furor-angekauft-82e334fc83a3@brauner>
 <CAHk-=witxS+hfdFc+xJVpb9y-cE6vYopkDaZvvk=aXHcv-P5=w@mail.gmail.com>
 <CAHk-=wiEzoh1gqfOp3DNTS9iPOxAWtS71qS0xv1XBziqGHGTwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiEzoh1gqfOp3DNTS9iPOxAWtS71qS0xv1XBziqGHGTwg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Yes, some filesystems then still get the inode lock in write mode, but
> now it's the filesystem itself that wraps its own iterator, rather
> than cause pain for the callers.

And, btrfs already does this in some cases where it first upgrades from
shared to non-shared and then downgrades again before returning in
btrfs_real_readdir(). So it's not like this isn't already happening.

> 
> So no more "Do you have an ->iterate() _or_ ->iterate_shared()
> function?" and associated "I need to do locking differently"
> nastiness. Only odd filesystems that never got the memo on "don't use
> .iterate".

Ack. It's not pretty but that hasn't stopped us before and it's less
ugly than double inode methods which pass exactly the same parameters. I
think removing the double methods is good and I see no problem in
shaming filesystems that didn't manage to convert properly in the last 7
years.

And let's please not get stuck on incoming pinky promises that everyone
will have converted before the next 7 years are over. I'd prefer to see
the iop wiped and leave the ugliness to the individual filesystems rn.

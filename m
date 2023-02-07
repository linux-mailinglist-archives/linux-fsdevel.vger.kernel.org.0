Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C10568E026
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 19:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjBGSgn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Feb 2023 13:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBGSgR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:36:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB0B7A89;
        Tue,  7 Feb 2023 10:36:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFDF0B81A1F;
        Tue,  7 Feb 2023 18:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F13C433EF;
        Tue,  7 Feb 2023 18:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675794971;
        bh=+8bPplEj9D+RAhls58hk5WoZAwi96AUPzMSHDnrE+Fg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k9smcMlBp+XFmFCtIS41HEC/3+YPqRFV5QKkU2RKmG92yDjvjQ4n/U8V4MP443gQv
         fQrjSICWu8vijSTcm/sbaYiHNHOxS1YbCJ7Y+0bIA0D2DNpFy5z6KsRITF6FixqGX1
         Ayo4mPq1xx5vhS3veyTjKMbTzBwBYDPj8D8Rn0h7gdIp6hNRrzIFprIQeiaqf1vPgW
         XoBtOCc/tiZoSH17vULIwgYMorkWx+rFRr31+VSCpztQoLx9d0QzCtBkKdUkGO8Ecs
         ZoH6F61nvs7hJBbdQlbB2fYY9QSgHnoLHcm2SjWOTI9mL9Yiv385mERrE85ocIxrxO
         waOz9X1OrZr7Q==
Date:   Tue, 7 Feb 2023 18:36:09 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dan Carpenter <error27@gmail.com>, linux-block@vger.kernel.org,
        Julia Lawall <julia.lawall@inria.fr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maobibo <maobibo@loongson.cn>,
        Matthew Wilcox <willy@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: block: sleeping in atomic warnings
Message-ID: <Y+KaGenaX0lwSy9G@gmail.com>
References: <20230129060452.7380-1-zhanghongchen@loongson.cn>
 <CAHk-=wjw-rrT59k6VdeLu4qUarQOzicsZPFGAO5J8TKM=oukUw@mail.gmail.com>
 <Y+EjmnRqpLuBFPX1@bombadil.infradead.org>
 <4ffbb0c8-c5d0-73b3-7a4e-2da9a7b03669@inria.fr>
 <Y+Ja5SRs886CEz7a@kadam>
 <CAHk-=wg6ohuyrmLJYTfEpDbp2Jwnef54gkcpZ3-BYgy4C6UxRQ@mail.gmail.com>
 <Y+KP/fAQjawSofL1@gmail.com>
 <CAHk-=wgmZDqCOynfiH4NFoL50f4+yUjxjp0sCaWS=xUmy731CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgmZDqCOynfiH4NFoL50f4+yUjxjp0sCaWS=xUmy731CQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 07, 2023 at 10:24:45AM -0800, Linus Torvalds wrote:
> On Tue, Feb 7, 2023 at 9:53 AM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > It's a false positive.  See the comment above fscrypt_destroy_keyring()
> 
> Hmm. Ok. Unfortunate.
> 
> >  If the filesystem has not been mounted, then the call from __put_super()
> > is needed, but blk_crypto_evict_key() can never be executed in that case.
> 
> It's not all that clear that some *other* error might not have
> happened to keep the mount from actually succeeding, but after the
> keys have been instantiated?
> 
> IOW, what's the thing that makes "blk_crypto_evict_key() can never be
> executed in that case" be obvious?
> 
> I think _that_ is what might want a comment, about how we always call
> generic_shutdown_super() before the last put_super() happens.
> 
> It does seem like Dan's automated checks could be useful, but if
> there's no sane way to avoid the false positives, it's always going to
> be a lot of noise ;(
> 

blk_crypto_evict_key() only runs if a key was prepared for inline encryption,
which can only happen if a user does I/O to an encrypted file.  That can only
happen after the filesystem was successfully mounted.

Also note that keys are normally added using an ioctl, which can only be
executed after the filesystem was mounted.  The only exception is the key
associated with the "test_dummy_encryption" mount option.

By the way, the following code is in generic_shutdown_super(), and not in
__put_super(), for a very similar reason:

                if (sb->s_dio_done_wq) {
                        destroy_workqueue(sb->s_dio_done_wq);
                        sb->s_dio_done_wq = NULL;
                }

That code is only needed if there has been user I/O to the filesystem, which
again can only have happened if the filesystem was successfully mounted.

- Eric

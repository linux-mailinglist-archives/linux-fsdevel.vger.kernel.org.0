Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B1768E155
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 20:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjBGTf7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Feb 2023 14:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjBGTf6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Feb 2023 14:35:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF473B679;
        Tue,  7 Feb 2023 11:35:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFE45610E8;
        Tue,  7 Feb 2023 19:35:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5EBC433D2;
        Tue,  7 Feb 2023 19:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675798556;
        bh=GOpZdtZRgKDtmDXADa0qEIoR4yYcUa4yeh/TXWHd/4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rfDGzcDRrr8wmW6ribUKyx0FIWU+dM1UdE4+T6CtQa1uhZRtv8Nl4DMKEF06m7cTu
         yp9Kb6V8VivS4tLLvDgZzAsX8J7s6qe/dOFcvtGLYQrjUbXNd48x5Lhf5FD3y7KeqJ
         oWL78VFQcNCnggExiIrHmfi4iQIK+3I9TTt72UXy8PKjb9kj1VfrXWR+yCMe0ryfgz
         iN1Nw07UZE3LZ6s3Jk7CWxpLYkTARXiqQf/D0xcA1VGeA5ZCw86j+iZ/KYR36VKwBA
         gOcXD3xB/udACpov80jCWq80IFZz7v2lrrwIIZwDDaIGlGmssAhIQiJK2RHuUjH9e+
         B29EbRC/XUsDQ==
Date:   Tue, 7 Feb 2023 19:35:54 +0000
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
Message-ID: <Y+KoGikLhfhDoMWv@gmail.com>
References: <20230129060452.7380-1-zhanghongchen@loongson.cn>
 <CAHk-=wjw-rrT59k6VdeLu4qUarQOzicsZPFGAO5J8TKM=oukUw@mail.gmail.com>
 <Y+EjmnRqpLuBFPX1@bombadil.infradead.org>
 <4ffbb0c8-c5d0-73b3-7a4e-2da9a7b03669@inria.fr>
 <Y+Ja5SRs886CEz7a@kadam>
 <CAHk-=wg6ohuyrmLJYTfEpDbp2Jwnef54gkcpZ3-BYgy4C6UxRQ@mail.gmail.com>
 <Y+KP/fAQjawSofL1@gmail.com>
 <CAHk-=wgmZDqCOynfiH4NFoL50f4+yUjxjp0sCaWS=xUmy731CQ@mail.gmail.com>
 <Y+KaGenaX0lwSy9G@gmail.com>
 <CAHk-=whL+9An7TP-4vCyZUKP_2bZSLe-ZFR1pGA1DbkrTRLyeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whL+9An7TP-4vCyZUKP_2bZSLe-ZFR1pGA1DbkrTRLyeQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 07, 2023 at 10:57:08AM -0800, Linus Torvalds wrote:
> On Tue, Feb 7, 2023 at 10:36 AM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > Also note that keys are normally added using an ioctl, which can only be
> > executed after the filesystem was mounted.  The only exception is the key
> > associated with the "test_dummy_encryption" mount option.
> 
> Could we perhaps then replace the
> 
>                 fscrypt_destroy_keyring(s);
> 
> with a more specific
> 
>                 fscrypt_destroy_dummy_keyring(s);
>
> thing, that would only handle the dummy encryption case?


Sure, they would still need to do most of the same things though.

> Or could we just *fix* the dummy encryption test to actually work like
> real encryption cases, so that it doesn't have this bogus case?

We've wanted to do that for a very long time, but there never has been a way to
actually do it.  Especially with the filesystem-level keyring now, if the kernel
doesn't automatically add the key for test_dummy_encryption, then userspace
would have to do it *every time it mounts the filesystem*.

The point of the "test_dummy_encryption" mount option is that you can just add
it to the mount options and run existing tests, such as a full run of xfstests,
and test all the encrypted I/O paths that way.  Which is extremely useful; it
wouldn't really be possible to properly test the encryption feature without it.

So that's why we've gone through some pain to keep "test_dummy_encryption"
working over time.

Now, it's possible that "the kernel automatically adds the key for
test_dummy_encryption" could be implemented a bit differently.  It maybe could
be done at the last minute, when the key is being looked for due to a user
filesystem operation, instead of during the mount itself.  That would eliminate
the need to call fscrypt_destroy_keyring() from __put_super(), which would avoid
the issue being discussed here.  I'll see if there's a good way to do that.

- Eric

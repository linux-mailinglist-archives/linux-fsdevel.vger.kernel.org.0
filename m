Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0525968DF6F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 18:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjBGRxm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Feb 2023 12:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjBGRx2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:53:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35611716D;
        Tue,  7 Feb 2023 09:53:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4938860F92;
        Tue,  7 Feb 2023 17:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AD5C433EF;
        Tue,  7 Feb 2023 17:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675792397;
        bh=TDCxXpt5lc6BmBbmRUDOI07W1g4bR6Z7/dko3THjFnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZbLCCNIZOXyee6tMO7uwU0TwdaRe0I2KFVDaFPRv3q/ERNdTV0fqsi8yWeD3JiARj
         jfNbeHLOnHyqFiUV83OrLBKxUCrc+sz1XQG4bGz4UWUNa0oYcqH9tdSynO8pNmkO3b
         UaYF5A87GqgoRTInMSdlVfXQDk2yIu4jBwkD6TID7NNWGc7S9x39QZ1lOuKqGVoGLa
         iwROdr/nLNEJKUM9or/reu1MEfA3VQSbdkS+8v8KqHW5XW1B3Ry+B676CAfTEB+X1j
         0T3Tt+elQzlc0erHPJnWy2NCULKSkqAwD6h+GlL2LjRq/EUSkvw6bXeSlrf793o5ja
         l75fMqzzKfiBw==
Date:   Tue, 7 Feb 2023 17:53:01 +0000
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
Message-ID: <Y+KP/fAQjawSofL1@gmail.com>
References: <20230129060452.7380-1-zhanghongchen@loongson.cn>
 <CAHk-=wjw-rrT59k6VdeLu4qUarQOzicsZPFGAO5J8TKM=oukUw@mail.gmail.com>
 <Y+EjmnRqpLuBFPX1@bombadil.infradead.org>
 <4ffbb0c8-c5d0-73b3-7a4e-2da9a7b03669@inria.fr>
 <Y+Ja5SRs886CEz7a@kadam>
 <CAHk-=wg6ohuyrmLJYTfEpDbp2Jwnef54gkcpZ3-BYgy4C6UxRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg6ohuyrmLJYTfEpDbp2Jwnef54gkcpZ3-BYgy4C6UxRQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 07, 2023 at 08:15:04AM -0800, Linus Torvalds wrote:
> On Tue, Feb 7, 2023 at 6:06 AM Dan Carpenter <error27@gmail.com> wrote:
> >
> > block/blk-crypto-profile.c:382 __blk_crypto_evict_key() warn: sleeping in atomic context
> > block/blk-crypto-profile.c:390 __blk_crypto_evict_key() warn: sleeping in atomic context
> 
> Yeah, that looks very real, but doesn't really seem to be a block bug.
> 
> __put_super() has a big comment that it's called under the sb_lock
> spinlock, so it's all in atomic context, but then:
> 
> > -> __put_super()
> >    -> fscrypt_destroy_keyring()
> >       -> fscrypt_put_master_key_activeref()
> >          -> fscrypt_destroy_prepared_key()
> >             -> fscrypt_destroy_inline_crypt_key()
> >                -> blk_crypto_evict_key()
> 
> and we have a comment in __blk_crypto_evict_key() that it must be
> called in "process context".
> 
> However, the *normal* unmount sequence does all the cleanup *before*
> it gets sb_lock, and calls fscrypt_destroy_keyring() in process
> context, which is probably why it never triggers in practice, because
> the "last put" is normally there, not in __put_super.
> 
> Eric? Al?
> 
> It smells like __put_super() may need to do some parts delayed, not
> under sb_lock.
> 

It's a false positive.  See the comment above fscrypt_destroy_keyring(), which
is meant to explain this, though I can update the comment to be clearer.  If the
filesystem has been mounted, then fscrypt_destroy_keyring() is called from
generic_shutdown_super(), which can sleep, and the call from __put_super() is a
no-op.  If the filesystem has not been mounted, then the call from __put_super()
is needed, but blk_crypto_evict_key() can never be executed in that case.

- Eric

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE83568E884
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 07:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjBHGyC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 01:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBHGyC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:54:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894C2442E5;
        Tue,  7 Feb 2023 22:54:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A823B81C3A;
        Wed,  8 Feb 2023 06:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51395C433EF;
        Wed,  8 Feb 2023 06:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675839237;
        bh=j2RvOdUWlkVdm5KzuZffm+jK0TPD5jlPTX53boVgvQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G0QvCMxjOILwJAETzf/YHrrhsa0Cm5OrmEIcdozmfoQrXMbEFqBAb+RHNbvV0Ltix
         +82ghijaXVk2mrmJvx+eygrOEhK1OVRKUxyGCTRhYbP+wZG7RYD+DEK+R7KXBrCd/i
         H8Ooo300eTbNzYhCmuWkp4QntINfggfaEP2L3cXA4lR/K8/lTwG6TDNRCPTrp0e8O8
         OtCuR9NCEqnAgYkXUntuOsEAo5PNExyH3p5e2gu0FOsRgeOjnV5TDkgW3NeqZqjZLa
         uon5m0wrhy9Id6zQlVBUe+S+XKSKnZ44N/fA8p/tM2LRzjYdg3uoUEuVxRepDlUzfH
         y+fhfnWBj+7bQ==
Date:   Tue, 7 Feb 2023 22:53:55 -0800
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
Message-ID: <Y+NHA9kOw0eFlUQp@sol.localdomain>
References: <CAHk-=wjw-rrT59k6VdeLu4qUarQOzicsZPFGAO5J8TKM=oukUw@mail.gmail.com>
 <Y+EjmnRqpLuBFPX1@bombadil.infradead.org>
 <4ffbb0c8-c5d0-73b3-7a4e-2da9a7b03669@inria.fr>
 <Y+Ja5SRs886CEz7a@kadam>
 <CAHk-=wg6ohuyrmLJYTfEpDbp2Jwnef54gkcpZ3-BYgy4C6UxRQ@mail.gmail.com>
 <Y+KP/fAQjawSofL1@gmail.com>
 <CAHk-=wgmZDqCOynfiH4NFoL50f4+yUjxjp0sCaWS=xUmy731CQ@mail.gmail.com>
 <Y+KaGenaX0lwSy9G@gmail.com>
 <CAHk-=whL+9An7TP-4vCyZUKP_2bZSLe-ZFR1pGA1DbkrTRLyeQ@mail.gmail.com>
 <Y+KoGikLhfhDoMWv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+KoGikLhfhDoMWv@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 07, 2023 at 07:35:54PM +0000, Eric Biggers wrote:
> Now, it's possible that "the kernel automatically adds the key for
> test_dummy_encryption" could be implemented a bit differently.  It maybe could
> be done at the last minute, when the key is being looked for due to a user
> filesystem operation, instead of during the mount itself.  That would eliminate
> the need to call fscrypt_destroy_keyring() from __put_super(), which would avoid
> the issue being discussed here.  I'll see if there's a good way to do that.

"[PATCH 0/5] Add the test_dummy_encryption key on-demand"
(https://lore.kernel.org/linux-fscrypt/20230208062107.199831-1-ebiggers@kernel.org/T/#u)
implements this.

- Eric

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB23D7B1E32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 15:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjI1N0C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 09:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjI1N0C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:26:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB60319B;
        Thu, 28 Sep 2023 06:26:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9FDC433C8;
        Thu, 28 Sep 2023 13:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695907560;
        bh=Hw1kdCJHTUKyVQI8cwPwgA89Zea2YP/j5S8sNYlfyaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dblYqe+yhoU6HknPuT1Li7tqtIHqkPT31Fqgr9cM035dTtSl+V/SnVA2/hLqrVpL0
         1A+90K64uvNwVjYEMnbgsKqZvysTvJsMZq95Qqd+f7F9/M5forItau/PMFJBSv3qfe
         /s51Fc3utpAfHRRTkZ6XQ/3eKy812zBXIRMg3FKmJBF6BvHf9SCxbynp/nnUaUxYXV
         PS8WG1Yh3AheIdqxO06HfN+24LUrexjlE4J2EnsrgZ2r8ZS3tvsZFfH18tw3pLak3H
         ed2WmB/sYUtWYJEMozJ5EfQvBUl/NhVMpMoWTUtBixZG1uNcaumlL0hcPsFfxDi1XX
         OetJ6nyiXiqnA==
Date:   Thu, 28 Sep 2023 15:25:56 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: shave work on failed file open
Message-ID: <20230928-kulleraugen-restaurant-dd14e2a9c0b0@brauner>
References: <20230926162228.68666-1-mjguzik@gmail.com>
 <CAHk-=wjUCLfuKks-VGTG9hrFAORb5cuzqyC0gRXptYGGgL=YYg@mail.gmail.com>
 <CAGudoHGej+gmmv0OOoep2ENkf7hMBib-KL44Fu=Ym46j=r6VEA@mail.gmail.com>
 <20230927-kosmetik-babypuppen-75bee530b9f0@brauner>
 <CAHk-=whLadznjNKZPYUjxVzAyCH-rRhb24_KaGegKT9E6A86Kg@mail.gmail.com>
 <CAGudoHH2mvfjfKt+nOCEOfvOrQ+o1pqX63tN2r_1+bLZ4OqHNA@mail.gmail.com>
 <CAHk-=wjmgord99A-Gwy3dsiG1YNeXTCbt+z6=3RH_je5PP41Zw@mail.gmail.com>
 <ZRR1Kc/dvhya7ME4@f>
 <CAHk-=wibs_xBP2BGG4UHKhiP2B=7KJnx_LL18O0bGK8QkULLHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wibs_xBP2BGG4UHKhiP2B=7KJnx_LL18O0bGK8QkULLHg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Which all seems to be the case already, so with the put_cred() not
> needing the RCU delay, I thing we really could do this patch (note:

So I spent a good chunk of time going through this patch.

Before file->f_cred was introduced file->f_{g,u}id would have been
accessible just under rcu protection. And file->f_cred->f_fs{g,u}id
replaced that access. So I think the intention was that file->f_cred
would function the same way, i.e., it would be possible to go from file
to cred under rcu without requiring a reference.

But basically, file->f_cred is the only field that would give this
guarantee. Other pointers such as file->f_security
(security_file_free()) don't and are freed outside of the rcu delay
already as well.

This patch means that if someone wants to access file->f_cred under rcu
they now need to call get_file_rcu() first.

Nothing has relied on this rcu-only file->f_cred quirk/feature until now
so I think it's fine to change it.

Does that make sense?

Please take a look at:
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs.misc&id=e3f15ee79197fc8b17d3496b6fa4fa0fc20f5406
for testing.

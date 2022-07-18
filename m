Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F01577FFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 12:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbiGRKnR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jul 2022 06:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiGRKnQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:43:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AD51EAF6
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 03:43:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDEF3B8085F
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 10:43:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A18CC341C0;
        Mon, 18 Jul 2022 10:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658140993;
        bh=jq3aNfto7NRDW+Pf7sEd8ok1Gs1mH8KhqyXQ0pv7Va0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ssozMqMYuZ5lgvI6rQdRZPbYexTomFdOvgoXgu4c5hJ0p6tuxP1KggAE9ue7kkNdy
         g3xrkIomj04SNFwn5wey8weVPA2QjO/kreXApTinTbvHDI3xMPGpUbgAA5AKsFM+Nj
         B/kaf6XD/DJUqO2L4GPer+BJWPL9J1ryt7C8uDfZdLdHDL5sBM4DLXyPKY9Ao7jx4u
         /rpPP/sHewa83l+2UsbLkPEjRWzpNAPKs2tsrspmFCDTIgZsBQL+hYXGGipsv/JXA6
         aXAF0TjALPIcHtjavFU047dWPbB5UrMjVq/6Dd5gDqbSfRBiC0VG+6yjtX1YG75UHp
         iiFfPm4saKYNQ==
Message-ID: <59be17b0006f5aa866d176b8aedc582023f1d8b3.camel@kernel.org>
Subject: Re: [PATCH v3 0/2] fs/lock: Cleanup around flock syscall.
From:   Jeff Layton <jlayton@kernel.org>
To:     Kuniyuki Iwashima <kuniyu@amazon.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Kuniyuki Iwashima <kuni1840@gmail.com>,
        linux-fsdevel@vger.kernel.org
Date:   Mon, 18 Jul 2022 06:43:11 -0400
In-Reply-To: <20220717043532.35821-1-kuniyu@amazon.com>
References: <20220717043532.35821-1-kuniyu@amazon.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2022-07-16 at 21:35 -0700, Kuniyuki Iwashima wrote:
> The first patch removes allocate-and-free for struct file_lock
> in flock syscall and the second patch rearrange some operations.
>=20
> Changes:
>   v3:
>     * Test LOCK_MAND first in patch 2
>=20
>   v2: https://lore.kernel.org/linux-fsdevel/20220716233343.22106-1-kuniyu=
@amazon.com/
>     * Use F_UNLCK in locks_remove_flock() (Chuck Lever)
>     * Fix uninitialised error in flock syscall (kernel test robot)
>     * Fix error when setting LOCK_NB
>     * Split patches not to mix different kinds of optimisations and
>       not to miss errors reported by kernel test robot
>=20
>   v1: https://lore.kernel.org/linux-fsdevel/20220716013140.61445-1-kuniyu=
@amazon.com/
>=20
>=20
> Kuniyuki Iwashima (2):
>   fs/lock: Don't allocate file_lock in flock_make_lock().
>   fs/lock: Rearrange ops in flock syscall.
>=20
>  fs/locks.c | 77 ++++++++++++++++++++----------------------------------
>  1 file changed, 28 insertions(+), 49 deletions(-)
>=20

This looks good, and I've added it to the branch I feed into linux-next.
If all goes well, I'll plan to ask Linus to pull this in for v5.20.
Since you respun it, I dropped Chuck's Reviewed-by. Chuck, please re-
review if you want me to put that back.

Thanks!
--=20
Jeff Layton <jlayton@kernel.org>

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7CB736E1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 15:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjFTN6o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 09:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjFTN6n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:58:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFE41A1;
        Tue, 20 Jun 2023 06:58:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D20B161243;
        Tue, 20 Jun 2023 13:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98641C433C0;
        Tue, 20 Jun 2023 13:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687269521;
        bh=tZo3p85HeGAGWRgzT1telI+TDb2NCX9nBe9orj25FVQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OtGmZBktQqi81FOB+n45VLSw4hscMcOf3TswBrX6O8Lh1z9+X4ld6Nzj/Yw7606Er
         35/p7724zkw6B4KqYGAyy8whzjJPPTg7fmBplPk/hJh3klph7nZVOBHJInDbSdGGHH
         YeNPuI+e5HqhMKlmaOTV5tAnZ9nqpQd+2cZwWbeaJc0DEFahzUP3qiphZVOQBjHjVu
         svYskiJQsHuVM7gZDg8lH/a4yXmTFjdR3w+xmEZM4K0H5kJyME//IUwx5pu0trif4R
         UPyzzQJGbWXzA5ZJ+C7UwJOI8NTJ0jrIIoEHN528vPeuqtIks/fVd3QDGeF9CW7PoF
         i2BSZhNpN6NPg==
Message-ID: <e8c8c7d8bf871a0282f3e629d017c09ed38e2c5e.camel@kernel.org>
Subject: Re: [PATCH 2/3] fd/locks: allow get the lock owner by F_OFD_GETLK
From:   Jeff Layton <jlayton@kernel.org>
To:     stsp <stsp2@yandex.ru>, linux-kernel@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 20 Jun 2023 09:58:39 -0400
In-Reply-To: <ddb48e05-ab26-ae5d-86d5-01e47f0f0cd2@yandex.ru>
References: <20230620095507.2677463-1-stsp2@yandex.ru>
         <20230620095507.2677463-3-stsp2@yandex.ru>
         <5728ebda22a723b0eb209ae078e8f132d7b4ac7b.camel@kernel.org>
         <a1e7f5c1-76ef-19e5-91db-a62f7615b28a@yandex.ru>
         <eaccc14ddc6b546e5913eb557fec55f77cb5424d.camel@kernel.org>
         <5f644a24-90b5-a02f-b593-49336e8e0f5a@yandex.ru>
         <2eb8566726e95a01536b61a3b8d0343379092b94.camel@kernel.org>
         <d70b6831-3443-51d0-f64c-6f6996367a85@yandex.ru>
         <d0c18369245db91a3b78017fabdc81417418af67.camel@kernel.org>
         <ddb48e05-ab26-ae5d-86d5-01e47f0f0cd2@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-06-20 at 18:39 +0500, stsp wrote:
> 20.06.2023 18:19, Jeff Layton =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > The bottom line is that these locks are specifically not owned by a
> > process, so returning the l_pid field is unreliable (at best). There is
> > no guarantee that the pid returned will still represent the task that
> > set the lock.
>=20
> Though it will, for sure, represent the
> task that _owns_ the lock.
>=20
> > You may want to review this article. They're called "File-private" lock=
s
> > here, but the name was later changed to "Open file description" (OFD)
> > locks:
> >=20
> >      https://lwn.net/Articles/586904/
> >=20
> > The rationale for why -1 is reported is noted there.
> Well, they point to fork() and SCM_RIGHTS.
> Yes, these 2 beasts can make the same lock
> owned by more than one process.
> Yet l_pid returned, is going to be always valid:
> it will still represent one of the valid owners.

No, it won't. The l_pid field is populated from the file_lock->fl_pid.
That field is set when the lock is set, and never updated. So it's quite
possible for F_GETLK to return the pid of a process that no longer
exists.

In principle, we could try to address that by changing how we track lock
ownership, but that's a fairly major overhaul, and I'm not clear on any
use-cases where that matters.

> So my call is to be brave and just re-consider
> the conclusion of that article, made 10 years
> ago! :)
>=20

I think my foot has too many bullet wounds for that sort of bravery.

> Of course if returning just 1 of possibly multiple
> owners is a problem, then oh well, I'll drop
> this patch.


--=20
Jeff Layton <jlayton@kernel.org>

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F116873800A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 13:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjFUKhV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 06:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjFUKgm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:36:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE351BCD;
        Wed, 21 Jun 2023 03:35:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1908D61486;
        Wed, 21 Jun 2023 10:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8984C433C0;
        Wed, 21 Jun 2023 10:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687343723;
        bh=/nDUysOIs+S67QS0PXY41K9/6X1N3a9ho9GHTrfj2i0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=a6p6PJqCNZCyMhzG8L0y2KV1XMdLUq9rM7BtrK0thbvITt6Gbpu4/tg5tSRO+XIuE
         gqtY54aFk5vcoAOhF5Rulvr5Hibmec5CT6Y37PLVThyrlAej05jXapqpAeyuPu8rgq
         7D8g+WDF3jwxK5DifiLYwtvVdOuFH655lyvrCbCqiRNbiNRlwJfdy83IGz3tir5s2F
         swu0D+OvGOiGFJxORVSKVK+cGWgor/7YXe62lmWAVvlsmIpC0CV+bG9rZsS0L3zAyg
         n2FtNGgOJW2QbNvHi7mwiWNNMqMeZNTKMG4mTuVmRk1CTpcPrTv9p1+Uqomphqa7AY
         MFr2VGKSG1F8g==
Message-ID: <26dce201000d32fd3ca1ca5b5f8cd4f5ae0b38b2.camel@kernel.org>
Subject: Re: [PATCH 2/3] fd/locks: allow get the lock owner by F_OFD_GETLK
From:   Jeff Layton <jlayton@kernel.org>
To:     stsp <stsp2@yandex.ru>, linux-kernel@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Date:   Wed, 21 Jun 2023 06:35:21 -0400
In-Reply-To: <9c0a7cde-da32-bc09-0724-5b1387909d18@yandex.ru>
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
         <e8c8c7d8bf871a0282f3e629d017c09ed38e2c5e.camel@kernel.org>
         <9c0a7cde-da32-bc09-0724-5b1387909d18@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-06-21 at 11:57 +0500, stsp wrote:
> 20.06.2023 18:58, Jeff Layton =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > No, it won't. The l_pid field is populated from the file_lock->fl_pid.
> > That field is set when the lock is set, and never updated. So it's quit=
e
> > possible for F_GETLK to return the pid of a process that no longer
> > exists.
> >=20
> > In principle, we could try to address that by changing how we track loc=
k
> > ownership, but that's a fairly major overhaul, and I'm not clear on any
> > use-cases where that matters.
>=20
> OK, in this case I'll just put a comments
> into the code, summarizing the info I got
> from you and Matthew.
> Thanks guys for all the info, its very helpful.
>=20
> Now I only need to convert the current
> "fundamental problem" attitude into a "not
> implemented yet" via the code comment.
>=20
>=20
> > > So my call is to be brave and just re-consider
> > > the conclusion of that article, made 10 years
> > > ago! :)
> > >=20
> > I think my foot has too many bullet wounds for that sort of bravery.
> I am perfectly fine with leaving this thing
> unimplemented. But what really bothers
> me is the posix proposal, which I think was
> done. Please tell me it allows fixing fl_pid
> in the future (rather than to mandate -1),
> and I am calm.

I don't think we can change this at this point.

The bottom line (again) is that OFD locks are owned by the file
descriptor (much like with flock()), and since file descriptors can be
shared across multiple process it's impossible to say that some single
process owns it.
--=20
Jeff Layton <jlayton@kernel.org>

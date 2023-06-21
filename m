Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAB2738214
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 13:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjFULF3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 07:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjFULFU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:05:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3722910F1;
        Wed, 21 Jun 2023 04:05:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F4F7614E2;
        Wed, 21 Jun 2023 11:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CAFC433C8;
        Wed, 21 Jun 2023 11:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687345514;
        bh=OraY5YzpwAEOisjb2wEyx6Nb6K5/CYe1TzmxyoZxTuo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jpAXCBExsHuTSXdF0XCd5GLi5Vtp/AAjI7IXm9E+UaI9ai3JarebATww0T/ReZKrq
         /vGQa6V4iDkBtMyUnRS1ikPdIFrlDH9LVGUOlhH4kj5GDc/KCkzaRiKvM1tsXvffu+
         VAQ8ZIokqnEWvg4WtU4J7sCKGHKDo2FTpwMIsQpdjRre8joU1Pwhk1aO/fGNVeJjtL
         NHkLHPLGAalMEu9fhNefkNZlo20IKQ6fWxbm0RvACWyK8gn0O202cRvBoIg4NgjkJ+
         8dWC84jQkUmluJpxxYePExih+OxUQ+c9hHVxIWUv7qryOybhFEZZ7ggYedmPRNAaf+
         madwqE4HB3bVg==
Message-ID: <b7fd8146f9c758a8e16faeb371ca04a701e1a7b8.camel@kernel.org>
Subject: Re: [PATCH 2/3] fd/locks: allow get the lock owner by F_OFD_GETLK
From:   Jeff Layton <jlayton@kernel.org>
To:     stsp <stsp2@yandex.ru>, linux-kernel@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Date:   Wed, 21 Jun 2023 07:05:12 -0400
In-Reply-To: <0188af4b-fc74-df61-8e00-5bc81bbcb1cc@yandex.ru>
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
         <26dce201000d32fd3ca1ca5b5f8cd4f5ae0b38b2.camel@kernel.org>
         <0188af4b-fc74-df61-8e00-5bc81bbcb1cc@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-06-21 at 15:42 +0500, stsp wrote:
> 21.06.2023 15:35, Jeff Layton =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > I don't think we can change this at this point.
> >=20
> > The bottom line (again) is that OFD locks are owned by the file
> > descriptor (much like with flock()), and since file descriptors can be
> > shared across multiple process it's impossible to say that some single
> > process owns it.
> What's the problem with 2 owners?
> Can't you get one of them, rather than
> meaningless -1?
> Compare this situation with read locks.
> They can overlap, so when you get an
> info about a read lock (except for the
> new F_UNLCK case), you get the info
> about *some* of the locks in that range.
> In the case of multiple owners, you
> likewise get the info about about some
> owner. If you iteratively send them a
> "please release this lock" message
> (eg in a form of SIGKILL), then you
> traverse all, and end up with the
> lock-free area.
> Is there really any problem here?

Yes. Ambiguous answers are worse than none at all.

What problem are you trying to solve by having F_OFD_GETLK report a pid?
--=20
Jeff Layton <jlayton@kernel.org>

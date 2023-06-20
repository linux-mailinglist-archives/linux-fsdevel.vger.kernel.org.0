Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73399736D29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 15:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjFTNVh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 09:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbjFTNVS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:21:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D908E1997;
        Tue, 20 Jun 2023 06:20:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3FB56123C;
        Tue, 20 Jun 2023 13:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2D1C433C8;
        Tue, 20 Jun 2023 13:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687267200;
        bh=GXGZ0Ff+rSYBLHjOWgny4b4PWRciMPgUl5UkVam9brE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qu7qnkFPf/dMqD1eXcbOfOI2FjVMAmyu4YHHfL4SuLk9zERNVjxSJFPDQKlaE0vDI
         QVQi/Kw/mJ8gKIt+ocJoUmunTg8vqnEXT+Vsk1TmdH2EwlAtvUtLvR5hP1FD8NSmZ2
         z/eqkW1/gxAk5idPr4ViPh/1Pk3Y01IHHX9m9ugpUnAY2A+EPKPgpNdYLRvEDNLuAJ
         5Vt9/WwhRPCcpurnVzLZf/DvBljPYILCOeDf02x951yupCt/9P32xBVZd61JoqgJ67
         5vnfUGakhx3ucUsp99fU4CdFlosjVB4I4q3TOp5iFD84Zb4PcZ4HEszAKig8gWRUH4
         LYmqXZfWOPPFg==
Message-ID: <d0c18369245db91a3b78017fabdc81417418af67.camel@kernel.org>
Subject: Re: [PATCH 2/3] fd/locks: allow get the lock owner by F_OFD_GETLK
From:   Jeff Layton <jlayton@kernel.org>
To:     stsp <stsp2@yandex.ru>, linux-kernel@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 20 Jun 2023 09:19:58 -0400
In-Reply-To: <d70b6831-3443-51d0-f64c-6f6996367a85@yandex.ru>
References: <20230620095507.2677463-1-stsp2@yandex.ru>
         <20230620095507.2677463-3-stsp2@yandex.ru>
         <5728ebda22a723b0eb209ae078e8f132d7b4ac7b.camel@kernel.org>
         <a1e7f5c1-76ef-19e5-91db-a62f7615b28a@yandex.ru>
         <eaccc14ddc6b546e5913eb557fec55f77cb5424d.camel@kernel.org>
         <5f644a24-90b5-a02f-b593-49336e8e0f5a@yandex.ru>
         <2eb8566726e95a01536b61a3b8d0343379092b94.camel@kernel.org>
         <d70b6831-3443-51d0-f64c-6f6996367a85@yandex.ru>
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

On Tue, 2023-06-20 at 17:34 +0500, stsp wrote:
> 20.06.2023 17:02, Jeff Layton =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Suppose I start a process (call it pid 100), and then spawn a thread
> > (101). I then have 101 open a file and set an OFD lock on it (such that
> > the resulting fl_pid field in the file_lock is set to 101).
>=20
> How come?
> There are multiple places in locks.c
> with this line:
> fl->fl_pid =3D current->tgid;
>=20
> And I've yet to see the line like:
> fl->fl_pid =3D current->pid;
> Its simply not there.
>=20
> No, we put tgid into l_pid!
> tgid will still be 100, no matter how
> many threads you spawn or destroy.
> Or what am I misseng?
>=20
>
> > That's just one example, of course. The underlying problem is that OFD
> > locks are not owned by processes in the same way that traditional POSIX
> > locks are, so reporting a pid there is unreliable, at best.
> But we report tgid.
> It doesn't depend on threads.
> I don't understand. :)

Good point. I had forgotten that we stuffed the l_pid in there. So in
principle, that example would be OK. But...there is still the problem of
passing file descriptors via unix sockets.

The bottom line is that these locks are specifically not owned by a
process, so returning the l_pid field is unreliable (at best). There is
no guarantee that the pid returned will still represent the task that
set the lock.

You may want to review this article. They're called "File-private" locks
here, but the name was later changed to "Open file description" (OFD)
locks:

    https://lwn.net/Articles/586904/

The rationale for why -1 is reported is noted there.
--=20
Jeff Layton <jlayton@kernel.org>

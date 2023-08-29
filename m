Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A97278CEC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 23:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238989AbjH2Vcy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 17:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238972AbjH2Vcw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:32:52 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5D6A8;
        Tue, 29 Aug 2023 14:32:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9E58A6418DB0;
        Tue, 29 Aug 2023 23:32:48 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id YgmQcxzRH_Oh; Tue, 29 Aug 2023 23:32:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 429676234895;
        Tue, 29 Aug 2023 23:32:48 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6_dEfwL520lh; Tue, 29 Aug 2023 23:32:48 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 183AF6418DB5;
        Tue, 29 Aug 2023 23:32:48 +0200 (CEST)
Date:   Tue, 29 Aug 2023 23:32:47 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Alejandro Colomar <alx@kernel.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>, christian@brauner.io,
        ipedrosa@redhat.com, gscrivan@redhat.com,
        Andreas =?utf-8?Q?Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>, acl-devel@nongnu.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        ebiederm <ebiederm@xmission.com>
Message-ID: <1972367750.1870193.1693344767957.JavaMail.zimbra@nod.at>
In-Reply-To: <81098c50-bfec-9aa2-a302-abfebd0ff332@kernel.org>
References: <20230829205833.14873-1-richard@nod.at> <81098c50-bfec-9aa2-a302-abfebd0ff332@kernel.org>
Subject: Re: [PATCH 0/3] Document impact of user namespaces and negative
 permissions
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Document impact of user namespaces and negative permissions
Thread-Index: oqD1ROdFWsR4JsLdGEfYUyxCctkaCw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Alejandro Colomar" <alx@kernel.org>
> Can you please provide a small shell session where this is exemplified?

Sure. I sent the following to the shadow maintainers privately on Friday,
but since the issue is already known for years I don't hesitate to share.

# On a Debian Bookworm
# So far no entries are installed.
$ cat /etc/subuid

# useradd automatically does so.
$ useradd -m rw
$ cat /etc/subuid
rw:100000:65536

# Let's create a folder where the group "nogames" has no permissions.
$ mkdir /games
$ echo win > /games/game.txt
$ groupadd nogames
$ chown -R root:nogames /games
$ chmod 705 /games

# User "rw" must not play games
$ usermod -G nogames rw

# Works as expected
rw@localhost:~$ id
uid=1000(rw) gid=1000(rw) groups=1000(rw),1001(nogames)
rw@localhost:~$ cat /games/game.txt
cat: /games/game.txt: Permission denied

# By using unshare (which utilizes the newuidmap helper) we can get rid of the "nogames" group.
rw@localhost:~$ unshare -S 0 -G 0 --map-users=100000,0,65536 --map-groups=100000,0,65536 id
uid=0(root) gid=0(root) groups=0(root)

rw@localhost:~$ unshare -S 0 -G 0 --map-users=100000,0,65536 --map-groups=100000,0,65536 cat /games/game.txt
win

Thanks,
//richard

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E388373B5DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jun 2023 13:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjFWLIh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jun 2023 07:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjFWLIf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jun 2023 07:08:35 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D120A10F4;
        Fri, 23 Jun 2023 04:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=7YE9sah6m6BOooMB9JhCskJMQwa//8HJtLtELm3K1WQ=;
        t=1687518514; x=1688728114; b=iz9mOAa8fO4rth4sQlnfHl3X6lG1c2OSvIHAUc5uSMEywZh
        bH9vfi07vUPVhRV2KW4j33GXvBC6PIDMIq4AlwQ4vEmG+CY+ApEs+zUHfI95KBUuLur2t/OGRSQmr
        kvA2VXx43sowZrpjd8O57fb7Nz9bVqS4+iCukULdDB2hMYGo/KSizTZZVPQnPYtiCpDJ1NCoTbFTQ
        Qqunrm7F0lqeiJq4WEpD2pWg5lo6vYKQSVCMJGz5ix4yILfWqFnzB7gLq/7dy0S2LyHtwT9gyvVUK
        kdJkMoY8kQAsSGuH46IFok8XCOTQfb4WjOzcq5dz8vHONsdOVQDb/hcnwzuqlscQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qCeeO-00FhOU-2T;
        Fri, 23 Jun 2023 13:08:24 +0200
Message-ID: <d15cd98d8612e756b4c22a10394d680342512c44.camel@sipsolutions.net>
Subject: Re: [syzbot] [wireless?] [reiserfs?] general protection fault in
 __iterate_interfaces
From:   Johannes Berg <johannes@sipsolutions.net>
To:     syzbot <syzbot+1c54f0eff457978ad5f9@syzkaller.appspotmail.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Date:   Fri, 23 Jun 2023 13:08:23 +0200
In-Reply-To: <000000000000302fb805fd180f4a@google.com>
References: <000000000000302fb805fd180f4a@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-06-01 at 14:24 -0700, syzbot wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    715abedee4cd Add linux-next specific files for 20230515
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D13c9672528000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6a2745d066dda=
0ec
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D1c54f0eff457978=
ad5f9
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binuti=
ls for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1588e999280=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1013cbc128000=
0
>=20

Looking at the reproducers, there's basically nothing happening in wifi.

So seems likely it's just some really bad memory corruption issue in
reiserfs?

johannes

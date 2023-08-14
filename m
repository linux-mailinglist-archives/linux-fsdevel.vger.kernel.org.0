Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38C677B178
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 08:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjHNGT1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 02:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbjHNGTQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:19:16 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 13 Aug 2023 23:19:02 PDT
Received: from nov-007-i659.relay.mailchannels.net (nov-007-i659.relay.mailchannels.net [46.232.183.213])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083B41704;
        Sun, 13 Aug 2023 23:19:01 -0700 (PDT)
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id A2CA96C0033;
        Mon, 14 Aug 2023 06:03:35 +0000 (UTC)
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
X-MC-Relay: Neutral
X-MailChannels-SenderId: novatrend|x-authuser|juerg@bitron.ch
X-MailChannels-Auth-Id: novatrend
X-Irritate-Dime: 04724fc777e868c2_1691993015203_1516354339
X-MC-Loop-Signature: 1691993015203:2485974427
X-MC-Ingress-Time: 1691993015203
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitron.ch;
        s=default; h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:Cc:To:
        From:Subject:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=abnIXhxMnmz7H91FjaBZVjQweWzBsIH0IX64VLDz6+w=; b=nHC1bL7l71pHLh4MPs0HLHp0OE
        Xxg1Kh5ixMQ6exQGzi+Sw31s+CCC4OwjLgXc75zJHmUUEv81RKtHeaSPgLdFruM2I2u1F1K5s/dpr
        gsRnYbgJbAAcK3A2GDrfeM18c;
Message-ID: <4f66cded234462964899f2a661750d6798a57ec0.camel@bitron.ch>
Subject: [REGRESSION] fuse: execve() fails with ETXTBSY due to async
 fuse_flush
From:   =?ISO-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Tycho Andersen <tycho@tycho.pizza>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Date:   Mon, 14 Aug 2023 08:03:29 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-AuthUser: juerg@bitron.ch
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since v6.3-rc1 commit 5a8bee63b1 ("fuse: in fuse_flush only wait if
someone wants the return code") `fput()` is called asynchronously if a
file is closed as part of a process exiting, i.e., if there was no
explicit `close()` before exit.

If the file was open for writing, also `put_write_access()` is called
asynchronously as part of the async `fput()`.

If that newly written file is an executable, attempting to `execve()`
the new file can fail with `ETXTBSY` if it's called after the writer
process exited but before the async `fput()` has run.

I've confirmed that this issue is absent in v6.2 and reverting
5a8bee63b1 on top of v6.4.10 fixes the regression.

#regzbot introduced: 5a8bee63b1

J=C3=BCrg

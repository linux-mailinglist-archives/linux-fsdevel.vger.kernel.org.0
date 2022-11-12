Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB9C6268F7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Nov 2022 11:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbiKLKs5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Nov 2022 05:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbiKLKsz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Nov 2022 05:48:55 -0500
X-Greylist: delayed 94 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 12 Nov 2022 02:48:53 PST
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA0E1704A;
        Sat, 12 Nov 2022 02:48:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1668249051; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=LFqAfRynvUXCUpErtnOL6NDnj4CYj8iUanwK1DI2pR+ycJNXJzAwqaHIZmzZOgUIt02nNaJBMnJmhKGlIruks6xnjLYgWeI0U4bgegcQS0Or9DXN0OOsU+fJ6BR29aBMM7qz/NUICVDPdVbsW5J5hNoQ4dphep8ZwHCZ/uLWJIQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1668249051; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=BCGeylOFJYtUpHot+ky277Ye6xqHBGluvEQQ9Xbj6Mg=; 
        b=KNmJaKaRXLHJy2ps9hY+5dEQrg7iBmOw45HEscaazRCJAfFomGO/z3zFitv7w/OjVJjJ+W051G3AAH3Lp+rabtrQ2INaCv0/gHYL6kWKDmHOsy0Ted8tGhIMGA7fplxTjmw4YnAdviF6+UyCjf4Aiavc6a7Nuk/esNNph2AO7Wc=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1668249051;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=BCGeylOFJYtUpHot+ky277Ye6xqHBGluvEQQ9Xbj6Mg=;
        b=PozslzT7pVPO2qvIFATO1I96o2g8GSKMsxdghJMy8CfbfKGTpVvE6px9WGHEOunY
        HVzWfULbawSa5IR8qvhULazw3+TmhelCBIQbApNmSWHqGS3X9VbMmUiD7zzA8gBozNo
        3SaZNtO27VhwOcopImrs34fC1d/Kje44T4HTcxTE=
Received: from kampyooter.. (110.226.30.173 [110.226.30.173]) by mx.zoho.in
        with SMTPS id 166824904951082.6955736246938; Sat, 12 Nov 2022 16:00:49 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     keyrings <keyrings@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <cover.1668248462.git.code@siddh.me>
Subject: [RESEND PATCH v2 0/2] watch_queue: Clean up some code
Date:   Sat, 12 Nov 2022 16:00:39 +0530
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is a dangling reference to pipe in a watch_queue after clearing it.
Thus, NULL that pointer while clearing.

This change renders wqueue->defunct superfluous, as the latter is only used
to check if watch_queue is cleared. With this change, the pipe is NULLed
while clearing, so we can just check if the pipe is NULL.

Extending comment for watch_queue->pipe in the definition of watch_queue
made the comment conventionally too long (it was already past 80 chars),
so I have changed the struct annotations to be kerneldoc-styled, so that
I can extend the comment mentioning that the pipe is NULL when watch_queue
is cleared. In the process, I have also hopefully improved documentation
by documenting things which weren't documented before.

Changes in v2:
- Merged the NULLing and removing defunct patches.
- Removed READ_ONCE barrier in lock_wqueue().
- Improved and fixed errors in struct docs.
- Better commit messages.

Original date of posting patch: 6 Aug 2022

Siddh Raman Pant (2):
  include/linux/watch_queue: Improve documentation
  kernel/watch_queue: NULL the dangling *pipe, and use it for clear
    check

 include/linux/watch_queue.h | 100 ++++++++++++++++++++++++++----------
 kernel/watch_queue.c        |  12 ++---
 2 files changed, 79 insertions(+), 33 deletions(-)

--=20
2.35.1



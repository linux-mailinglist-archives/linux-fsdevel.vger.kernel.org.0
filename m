Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C555BFAF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 11:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiIUJ3P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 05:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiIUJ3K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:29:10 -0400
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0441B90808;
        Wed, 21 Sep 2022 02:29:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1663752488; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=DyPkmnbo/DgdALbJ52LApIG2RqgJrBXp54iMKHR2N8joa9qpQH0xRgYMaegejSefqgsnrjqqSx+Ccn1DYBZQIMgs57/eBSvxYvT8bGUksMEXqTTr44+vEoBOw2hBNnFa9ZvmuHeL3UP94yYFRafb5xdMCVyCVdJgSGRiZKT46dc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1663752488; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=1j9B3a9+XvhyGJpimzS54jknD3atX0UsgCNgtn4m3hM=; 
        b=PLirgJsQpDyE0sg0mrXKK4V5ji2GKVzgNcrtjvL9sXiI0AajxbNhzX/j0Nhpl3ytH2euBv81fYNVwOcKWhQ/deUZONY69m/tvV4elGfQKHiq0nKSMNC56ptUsBdmF3wIdh/bTefRgRHvdLDYXJh4OVbSXiEzC75gG9zZmaY8f7w=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663752488;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=1j9B3a9+XvhyGJpimzS54jknD3atX0UsgCNgtn4m3hM=;
        b=lGEFgPrPlgUunVg4iRYjjKsEFUFsp368JW4/G7YMvZJPZGPyESa4w1WqZHQb7RsZ
        igUC8LSnIeOaNuYs2p8WtTP2IFjv1nXx6QF1xaS97Imgr/oWsHsf0LzJ//HxjuzukAu
        h8RFhBAxxyKlg4kUwWStl0MZNXHn0QNj4mumG74w=
Received: from localhost.localdomain (103.240.204.191 [103.240.204.191]) by mx.zoho.in
        with SMTPS id 1663752487704363.0191740785489; Wed, 21 Sep 2022 14:58:07 +0530 (IST)
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
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Message-ID: <cover.1663750794.git.code@siddh.me>
Subject: [RESEND PATCH v2 0/2] watch_queue: Clean up some code
Date:   Wed, 21 Sep 2022 14:57:44 +0530
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

Siddh Raman Pant (2):
  include/linux/watch_queue: Improve documentation
  kernel/watch_queue: NULL the dangling *pipe, and use it for clear
    check

 include/linux/watch_queue.h | 100 ++++++++++++++++++++++++++----------
 kernel/watch_queue.c        |  12 ++---
 2 files changed, 79 insertions(+), 33 deletions(-)

--=20
2.35.1



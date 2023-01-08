Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784CA66148D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jan 2023 11:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjAHKhj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 05:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjAHKhe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 05:37:34 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CDFE0B9;
        Sun,  8 Jan 2023 02:37:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1673174207; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=R4sR6HypQhsq0FANUSSfT92ZwhHFDchRxsFIGEqe4+EA8pC9qA2wUtwkh8Kw1iMhCdTIsRsP/mK9je1Z9PNCidJP04cxYDGkoNQ3v5z4rAJSirhFGN1EmBrpik2seKCiS0NvPigLMLU4NpUqmwe3/2ZxL5CnZxwFdGvSvmkOOJg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1673174207; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=pcXt8bFzKFZCxe/K2x0CZ6wr09PH7+KBAfFhihnTjHU=; 
        b=V7u4OWXFpp4PlPYvEEKPtTBJGA2E3Ov6tJxkWSOT4sq1LQS+aIy9WwTx0h2d5BIrfN1TtaC58A6CnZB/HopVk0+LF/dUY1KLoEZoTaHNpLRFh57Q8NForv76xHyze0DR/CWDcQnCx6VBkkCxdCPpzr7ckl8lf1u/rVQd6kOVTI4=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1673174207;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=pcXt8bFzKFZCxe/K2x0CZ6wr09PH7+KBAfFhihnTjHU=;
        b=MyiAs1b9XVjh7OyDI6QRNFE/1Zxtc78eCokPbQL8L+SA9D0hwRszQaPPS2+vg+Au
        yEHFVV70X1V0pihDEzq9txLwGCHl8IAx0Esw2lVcvkZ7ygLF8/EQxuq4j615gedgax/
        ew1b4vxtQrp2jksCg/e5cnOZJss4nxEvg3aEQd9o=
Received: from kampyooter.. (110.226.31.37 [110.226.31.37]) by mx.zoho.in
        with SMTPS id 1673174205063602.2424519389933; Sun, 8 Jan 2023 16:06:45 +0530 (IST)
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
Message-ID: <cover.1673173920.git.code@siddh.me>
Subject: [PATCH v3 0/2] watch_queue: Clean up some code
Date:   Sun,  8 Jan 2023 16:06:30 +0530
X-Mailer: git-send-email 2.39.0
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

Changes in v3:
- Fixed misplaced/incorrect comment for members watch_list and list_node
  in struct watch.
- Minor rephrase of comment before NULLing in watch_queue_clear().

Changes in v2 (6 Aug 2022):
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
2.39.0



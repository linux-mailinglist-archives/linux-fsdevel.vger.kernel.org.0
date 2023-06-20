Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1F0736D82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 15:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjFTNju (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 09:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbjFTNjh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:39:37 -0400
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2FD19B1;
        Tue, 20 Jun 2023 06:39:22 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1380:0:640:6985:0])
        by forward101b.mail.yandex.net (Yandex) with ESMTP id 9061D6010C;
        Tue, 20 Jun 2023 16:39:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 7dhJcbqWm4Y0-WeZ40bE5;
        Tue, 20 Jun 2023 16:39:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687268348;
        bh=PhlDJFhZ9kE6LkIjRQx8p4TngH1FPLd3OMinLEFLzfY=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=ItTqvOVqvkCAfiVFI1M31Jkz73JWqryhUEXI9rlV+wp57O8YF7xbVJ4L6z3cuY7O4
         Izs8wX1RCYj3ZaXKoQQkObXfDRSUuSZskxEVcI1NQpQXRL/9t9bCbOxO+5XrhuMfx0
         C2VFAKxKIGVEEJ0QcObQfzzCjjVSdgXtPKuTE+sM=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <ddb48e05-ab26-ae5d-86d5-01e47f0f0cd2@yandex.ru>
Date:   Tue, 20 Jun 2023 18:39:07 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] fd/locks: allow get the lock owner by F_OFD_GETLK
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
References: <20230620095507.2677463-1-stsp2@yandex.ru>
 <20230620095507.2677463-3-stsp2@yandex.ru>
 <5728ebda22a723b0eb209ae078e8f132d7b4ac7b.camel@kernel.org>
 <a1e7f5c1-76ef-19e5-91db-a62f7615b28a@yandex.ru>
 <eaccc14ddc6b546e5913eb557fec55f77cb5424d.camel@kernel.org>
 <5f644a24-90b5-a02f-b593-49336e8e0f5a@yandex.ru>
 <2eb8566726e95a01536b61a3b8d0343379092b94.camel@kernel.org>
 <d70b6831-3443-51d0-f64c-6f6996367a85@yandex.ru>
 <d0c18369245db91a3b78017fabdc81417418af67.camel@kernel.org>
From:   stsp <stsp2@yandex.ru>
In-Reply-To: <d0c18369245db91a3b78017fabdc81417418af67.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


20.06.2023 18:19, Jeff Layton пишет:
> The bottom line is that these locks are specifically not owned by a
> process, so returning the l_pid field is unreliable (at best). There is
> no guarantee that the pid returned will still represent the task that
> set the lock.

Though it will, for sure, represent the
task that _owns_ the lock.

> You may want to review this article. They're called "File-private" locks
> here, but the name was later changed to "Open file description" (OFD)
> locks:
>
>      https://lwn.net/Articles/586904/
>
> The rationale for why -1 is reported is noted there.
Well, they point to fork() and SCM_RIGHTS.
Yes, these 2 beasts can make the same lock
owned by more than one process.
Yet l_pid returned, is going to be always valid:
it will still represent one of the valid owners.
So my call is to be brave and just re-consider
the conclusion of that article, made 10 years
ago! :)

Of course if returning just 1 of possibly multiple
owners is a problem, then oh well, I'll drop
this patch.

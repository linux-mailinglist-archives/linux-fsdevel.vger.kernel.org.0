Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA497400C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 18:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjF0QV1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 12:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjF0QVL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:21:11 -0400
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d501])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB9E30D6;
        Tue, 27 Jun 2023 09:20:42 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:5e29:0:640:6b8b:0])
        by forward501b.mail.yandex.net (Yandex) with ESMTP id 7A4E75EDC6;
        Tue, 27 Jun 2023 19:20:36 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id WKOEHL1WsiE0-MlTFllBQ;
        Tue, 27 Jun 2023 19:20:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687882835;
        bh=oWCGWtFnCjNqqD1WMRbx7b1uArOcxMJZ0ZCi5PjthmM=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=Pchl2J5ejPI6wKGbXgDartG31TfSQMycg3aSNeNM2Bm7Df87pZj6SEi+eZOMWzf6E
         Kr0RLEjiF+U2jeV1za7Sjj2TgPeRQaSkA7V0+HTK0rdlUqLUHlRdtmnjFo9nNELV1u
         2FxnwE5p/ew7rDbsI/gCDHgJPtigabaCFnRQnrQs=
Authentication-Results: mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <48c4333a-8c47-4bf9-322c-1621cd876968@yandex.ru>
Date:   Tue, 27 Jun 2023 21:20:31 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] fd/locks: allow get the lock owner by F_OFD_GETLK
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
References: <5f644a24-90b5-a02f-b593-49336e8e0f5a@yandex.ru>
 <2eb8566726e95a01536b61a3b8d0343379092b94.camel@kernel.org>
 <d70b6831-3443-51d0-f64c-6f6996367a85@yandex.ru>
 <d0c18369245db91a3b78017fabdc81417418af67.camel@kernel.org>
 <ddb48e05-ab26-ae5d-86d5-01e47f0f0cd2@yandex.ru>
 <e8c8c7d8bf871a0282f3e629d017c09ed38e2c5e.camel@kernel.org>
 <9c0a7cde-da32-bc09-0724-5b1387909d18@yandex.ru>
 <26dce201000d32fd3ca1ca5b5f8cd4f5ae0b38b2.camel@kernel.org>
 <0188af4b-fc74-df61-8e00-5bc81bbcb1cc@yandex.ru>
 <b7fd8146f9c758a8e16faeb371ca04a701e1a7b8.camel@kernel.org>
 <20230623-paranoia-reinschauen-329185eac276@brauner>
 <0697f0d1-490b-6613-fea0-967a40861b25@yandex.ru>
 <51e756daf978ba61fbc15f209effac5daf59137a.camel@kernel.org>
From:   stsp <stsp2@yandex.ru>
In-Reply-To: <51e756daf978ba61fbc15f209effac5daf59137a.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


27.06.2023 21:00, Jeff Layton пишет:
> Beyond all of this, there is a long history of problems with the l_pid
> field as well with network filesystems, even with traditional POSIX
> locks. What should go into the l_pid when a traditional POSIX lock is
> held by a process on a separate host?
>
> While POSIX mandates it, the l_pid is really sort of a "legacy" field
> that is really just for informational purposes only nowadays. It might
> have been a reliable bit of information back in the 1980's, but even
> since the 90's it was suspect as a source of information.
>
> Even if you _know_ you hold a traditional POSIX lock, be careful
> trusting the information in that field.
Thanks for info.
Additional problem with multiple owners
that I can think of, is that you don't know
if more owners are present. And even if
you use SIGKILL to "iterate", you still don't
know if you got another owner of the prev
lock, or maybe you got entirely different
read lock with the same range from another
owner.

Still if you do "man fcntl" you'll see this:

                pid_t l_pid;     /* PID of process blocking our lock

                                    (set by F_GETLK and F_OFD_GETLK) */

And no, its not my patch that did this. :)
So unless properly documented, this would
be treated as a bug. And it should _not_ be
documented as "OFD locks has no owner by
definition" or alike - no one buys that.


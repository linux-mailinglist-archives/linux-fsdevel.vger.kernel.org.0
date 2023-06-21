Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093A4738082
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 13:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjFUKpL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 06:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjFUKoq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:44:46 -0400
Received: from forward502c.mail.yandex.net (forward502c.mail.yandex.net [178.154.239.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433FD272C;
        Wed, 21 Jun 2023 03:42:20 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1e2b:0:640:94b5:0])
        by forward502c.mail.yandex.net (Yandex) with ESMTP id B91FD5F08A;
        Wed, 21 Jun 2023 13:42:17 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id FgficR1DSOs0-cgpcxfB7;
        Wed, 21 Jun 2023 13:42:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687344137;
        bh=apOh63U/ySYLd6SJidE3yth35ZpHrrGe52pobpX3XmY=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=G+goBNLiFgXVTHOd2qKAwE2UoBHwT0HtWHrxOFRObkYGDrE2yR6vR9kNyInFxboLT
         T0bO54VYSHPoydICwOFws644LIqRX7s8Y2f+5p+X+9W7M/8tIZTMASAxbksAXNrhPp
         o7sg/OKTsYUg3oZq92/ZflocvwwDk3+Ap37/VNR8=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <0188af4b-fc74-df61-8e00-5bc81bbcb1cc@yandex.ru>
Date:   Wed, 21 Jun 2023 15:42:14 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] fd/locks: allow get the lock owner by F_OFD_GETLK
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
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
From:   stsp <stsp2@yandex.ru>
In-Reply-To: <26dce201000d32fd3ca1ca5b5f8cd4f5ae0b38b2.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


21.06.2023 15:35, Jeff Layton пишет:
> I don't think we can change this at this point.
>
> The bottom line (again) is that OFD locks are owned by the file
> descriptor (much like with flock()), and since file descriptors can be
> shared across multiple process it's impossible to say that some single
> process owns it.
What's the problem with 2 owners?
Can't you get one of them, rather than
meaningless -1?
Compare this situation with read locks.
They can overlap, so when you get an
info about a read lock (except for the
new F_UNLCK case), you get the info
about *some* of the locks in that range.
In the case of multiple owners, you
likewise get the info about about some
owner. If you iteratively send them a
"please release this lock" message
(eg in a form of SIGKILL), then you
traverse all, and end up with the
lock-free area.
Is there really any problem here?

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603FD737BD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 09:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjFUG5y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 02:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjFUG5x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:57:53 -0400
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E978DD;
        Tue, 20 Jun 2023 23:57:50 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2891:0:640:3c15:0])
        by forward502b.mail.yandex.net (Yandex) with ESMTP id 39EBF5F12E;
        Wed, 21 Jun 2023 09:57:48 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id jvbXS14DTW20-atpQLnyJ;
        Wed, 21 Jun 2023 09:57:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687330667;
        bh=kxzsLoKA52whM2CNNdp6u6lW2oEAbMirlOhxND1ozNU=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=rnKGwgAt9Y5Zmj5F3Vr2pCBnNnbADgDgVVh7miTiFIybPeTsrLr0hmiZDgBodh+Yy
         QgdSPSPsPrKRgLOA0xx1dghOzU2WNb+jalPoHRs3gvhLO6OBWRrHJ+FXZ4OuQALmxg
         hu0t3Cts+//4WxMXoU7If5NXtezjenZ7mqPdo72U=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <9c0a7cde-da32-bc09-0724-5b1387909d18@yandex.ru>
Date:   Wed, 21 Jun 2023 11:57:45 +0500
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
From:   stsp <stsp2@yandex.ru>
In-Reply-To: <e8c8c7d8bf871a0282f3e629d017c09ed38e2c5e.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


20.06.2023 18:58, Jeff Layton пишет:
> No, it won't. The l_pid field is populated from the file_lock->fl_pid.
> That field is set when the lock is set, and never updated. So it's quite
> possible for F_GETLK to return the pid of a process that no longer
> exists.
>
> In principle, we could try to address that by changing how we track lock
> ownership, but that's a fairly major overhaul, and I'm not clear on any
> use-cases where that matters.

OK, in this case I'll just put a comments
into the code, summarizing the info I got
from you and Matthew.
Thanks guys for all the info, its very helpful.

Now I only need to convert the current
"fundamental problem" attitude into a "not
implemented yet" via the code comment.


>> So my call is to be brave and just re-consider
>> the conclusion of that article, made 10 years
>> ago! :)
>>
> I think my foot has too many bullet wounds for that sort of bravery.
I am perfectly fine with leaving this thing
unimplemented. But what really bothers
me is the posix proposal, which I think was
done. Please tell me it allows fixing fl_pid
in the future (rather than to mandate -1),
and I am calm.

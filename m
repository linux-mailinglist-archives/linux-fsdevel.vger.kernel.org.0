Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1619738339
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 14:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbjFULXT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 07:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjFULXS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:23:18 -0400
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF9BE57;
        Wed, 21 Jun 2023 04:22:53 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:601e:0:640:1bb:0])
        by forward502b.mail.yandex.net (Yandex) with ESMTP id 9CF145F16A;
        Wed, 21 Jun 2023 14:22:35 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id WMgg4Q5DReA0-eGt6VQFN;
        Wed, 21 Jun 2023 14:22:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687346555;
        bh=r2n6TaUiDkLeBd2u1AMjUDWTy7hXB70jCq4p4IOtyAI=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=W5909DLB61vF+amILsR9RXt2gOQ6DXpF0usgLzmBABtAtqpW4lWHJ4EWx0EuLbBgv
         odGFwtLUda1GAjvPltMBkZCnIvZMPymPcTJdXOjAYPzJ52aZORg5/8MPPMla3A/APN
         KB2g8yBVziSwegORFD21V7Jgl/epqlgOH0HqjRuU=
Authentication-Results: mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <2d9f894c-39aa-ec45-78f7-a11ac980bb62@yandex.ru>
Date:   Wed, 21 Jun 2023 16:22:32 +0500
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
 <0188af4b-fc74-df61-8e00-5bc81bbcb1cc@yandex.ru>
 <b7fd8146f9c758a8e16faeb371ca04a701e1a7b8.camel@kernel.org>
From:   stsp <stsp2@yandex.ru>
In-Reply-To: <b7fd8146f9c758a8e16faeb371ca04a701e1a7b8.camel@kernel.org>
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


21.06.2023 16:05, Jeff Layton пишет:
> Yes. Ambiguous answers are worse than none at all.

But same for read locks, when you
query them with F_OFD_GETLK.
It doesn't sound ambiguous to me,
you get the valid owner, and you can
iterate them if you kill them in a
process (same as for read locks).


> What problem are you trying to solve by having F_OFD_GETLK report a pid?
Just a way to abruptly kill offending lockers,
as that most likely means the process hanged
(I have a 3rd party code that drives the locking,
so it can't be trusted not to hang).
Its not essential though, for sure.
Curiosity also plays the role here. :)
Though if you don't want, I can as well
not add a TODO comment to the code.

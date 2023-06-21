Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5C7737962
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 04:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjFUCyV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 22:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFUCyU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 22:54:20 -0400
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917851704;
        Tue, 20 Jun 2023 19:54:18 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:2481:0:640:e0:0])
        by forward501b.mail.yandex.net (Yandex) with ESMTP id 036065F01D;
        Wed, 21 Jun 2023 05:54:16 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id DsXQr41DViE0-SPDjKbks;
        Wed, 21 Jun 2023 05:54:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687316055;
        bh=elhQiYgc/jirqX3wBHnMttM8AI1mnDD23NxVQeQhyPE=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=d/wmJgV+Kb8xW7NsO5+V8bCyHSYmrnnfmeiuJWLSpvJXZ4DBbqSZeZt4zgbDSCVTq
         SZ8PBm9LbeD7Lf7kDGuUqT4QtVhtuzEtIXXssbOYqNeaC4sATlhJziXs2qjhlEoZ+A
         1H4d6VRu6sG3IJcu3c51ifBApQuFx8lz7Z8enlKY=
Authentication-Results: mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <a874f022-bdd9-8f87-e571-75626f5901ee@yandex.ru>
Date:   Wed, 21 Jun 2023 07:54:13 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] fd/locks: allow get the lock owner by F_OFD_GETLK
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
References: <eaccc14ddc6b546e5913eb557fec55f77cb5424d.camel@kernel.org>
 <5f644a24-90b5-a02f-b593-49336e8e0f5a@yandex.ru>
 <2eb8566726e95a01536b61a3b8d0343379092b94.camel@kernel.org>
 <d70b6831-3443-51d0-f64c-6f6996367a85@yandex.ru>
 <d0c18369245db91a3b78017fabdc81417418af67.camel@kernel.org>
 <ddb48e05-ab26-ae5d-86d5-01e47f0f0cd2@yandex.ru>
 <ZJGtmrej8LraEsjj@casper.infradead.org>
 <cb88d464-30d8-810e-f3c4-35432d12a32d@yandex.ru>
 <ZJG5ZOK8HKl/eWmM@casper.infradead.org>
 <08612562-d2d7-a931-0c40-c401fff772c7@yandex.ru>
 <ZJHcT9DPGWVlTsHg@casper.infradead.org>
From:   stsp <stsp2@yandex.ru>
In-Reply-To: <ZJHcT9DPGWVlTsHg@casper.infradead.org>
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


20.06.2023 22:05, Matthew Wilcox пишет:
>> Does this mean, by any chance, that the
>> recipient actually owns an fd before
>> recvmsg() is done?
> no, it's not in their fd table.  they don't own it.
OK, thanks for showing this pathological
case. Let me just note that this changes
nothing at all. :)

The important thing to note here is that
any lock query is race-prone: locks can
come and go at any time. So if you need
some sequence of operations, you need
to employ some global locking for that.
I use flock(LOCK_EX) on the same fd, before
doing F_OFD_GETLK, and I do flock(LOCK_UN)
only when the entire sequence of operations
is completed. And I do the same on an
F_OFD_SETLK's side to guarantee the
atomicity. You can't do it otherwise,
it would be race-prone.

So given the above, the only thing we
need for l_pid consistency is for the
"donor" process to put LOCK_EX on an
fd before doing SCM_RIGHTS, and the
recipient should do LOCK_UN. Then
the other side, which also uses LOCK_EX,
will never see the owner-less state.
And as for the kernel's POV, l_pid should
be set to -1 only when there is no owner,
like in an example you mentioned.

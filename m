Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC7173BDAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jun 2023 19:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjFWRTG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jun 2023 13:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjFWRSd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:18:33 -0400
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB922721;
        Fri, 23 Jun 2023 10:18:28 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:58f:0:640:3768:0])
        by forward500a.mail.yandex.net (Yandex) with ESMTP id EACBE5EA4E;
        Fri, 23 Jun 2023 20:18:25 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id NILcZOZDaGk0-S35Pwuwb;
        Fri, 23 Jun 2023 20:18:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687540705;
        bh=kQSS/qORopd8NDqlspWE4bP9dR8P/jQxd/JVi56VTuY=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=Qh85RWDQ3psXAxoFrVkq5VLpFnk0QM7UCXiewRLIfwAQV99tDf0OhvRCE1Smaj8P5
         XWtGT+0a9khrZntiHHI5jqdHtZKWkVWDzPpMTMR4qaI72hLcjcbMGaNNZQgZdLNqDN
         o8mW36AG/AEqCe6tQDVUBTQ+USc1W5y1eoyNREQg=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <0697f0d1-490b-6613-fea0-967a40861b25@yandex.ru>
Date:   Fri, 23 Jun 2023 22:18:23 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] fd/locks: allow get the lock owner by F_OFD_GETLK
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>
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
From:   stsp <stsp2@yandex.ru>
In-Reply-To: <20230623-paranoia-reinschauen-329185eac276@brauner>
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


23.06.2023 20:25, Christian Brauner пишет:
> On Wed, Jun 21, 2023 at 07:05:12AM -0400, Jeff Layton wrote:
>> On Wed, 2023-06-21 at 15:42 +0500, stsp wrote:
>>> 21.06.2023 15:35, Jeff Layton пишет:
>>>> I don't think we can change this at this point.
>>>>
>>>> The bottom line (again) is that OFD locks are owned by the file
>>>> descriptor (much like with flock()), and since file descriptors can be
>>>> shared across multiple process it's impossible to say that some single
>>>> process owns it.
>>> What's the problem with 2 owners?
>>> Can't you get one of them, rather than
>>> meaningless -1?
>>> Compare this situation with read locks.
>>> They can overlap, so when you get an
>>> info about a read lock (except for the
>>> new F_UNLCK case), you get the info
>>> about *some* of the locks in that range.
>>> In the case of multiple owners, you
>>> likewise get the info about about some
>>> owner. If you iteratively send them a
>>> "please release this lock" message
>>> (eg in a form of SIGKILL), then you
>>> traverse all, and end up with the
>>> lock-free area.
>>> Is there really any problem here?
>> Yes. Ambiguous answers are worse than none at all.
> I agree.
>
> A few minor observations:
>
> SCM_RIGHTS have already been mentioned multiple times. But I'm not sure
> it's been mentioned explicitly but that trivially means it's possible to
> send an fd to a completely separate thread-group, then kill off the
> sending thread-group by killing their thread-group leader. Bad enough as
> the identifier is now useless. But it also means that at some later
> point that pid can be recycled.
Come on.
I never proposed anything like this.
Of course the returned pid should be
the pid of the current, actual owner,
or one of current owners.
If someone else proposed to return
stalled pids, then it wasn't me.

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9643A7370D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 17:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjFTPpp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 11:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjFTPpk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:45:40 -0400
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [178.154.239.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA74210C2;
        Tue, 20 Jun 2023 08:45:33 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:2087:0:640:7bf5:0])
        by forward500c.mail.yandex.net (Yandex) with ESMTP id 1A4E85F00E;
        Tue, 20 Jun 2023 18:45:24 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id LjjMmjuDReA0-6OlYo5Rk;
        Tue, 20 Jun 2023 18:45:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687275923;
        bh=UuD0riuPhdFI9gmbnXdcYZ8aN8C45eiZd+yMktkakzg=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=A/bbPRzs8UL2499Pjm/08MN/N7QX0uHCqVJy6PqV0aCBsMlyrGRyMvDqtrwbZQIjJ
         Fam6hbx4WNy7im177p5dWh5QCHSDFt8EG3AhJtKo4Vqk8TIxVnmtOKmmeXyxh4hroz
         nkjW/NLSp66pwUmBB9ohyQab+1gsTC+Tx4mCNz2I=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <08612562-d2d7-a931-0c40-c401fff772c7@yandex.ru>
Date:   Tue, 20 Jun 2023 20:45:21 +0500
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
References: <5728ebda22a723b0eb209ae078e8f132d7b4ac7b.camel@kernel.org>
 <a1e7f5c1-76ef-19e5-91db-a62f7615b28a@yandex.ru>
 <eaccc14ddc6b546e5913eb557fec55f77cb5424d.camel@kernel.org>
 <5f644a24-90b5-a02f-b593-49336e8e0f5a@yandex.ru>
 <2eb8566726e95a01536b61a3b8d0343379092b94.camel@kernel.org>
 <d70b6831-3443-51d0-f64c-6f6996367a85@yandex.ru>
 <d0c18369245db91a3b78017fabdc81417418af67.camel@kernel.org>
 <ddb48e05-ab26-ae5d-86d5-01e47f0f0cd2@yandex.ru>
 <ZJGtmrej8LraEsjj@casper.infradead.org>
 <cb88d464-30d8-810e-f3c4-35432d12a32d@yandex.ru>
 <ZJG5ZOK8HKl/eWmM@casper.infradead.org>
From:   stsp <stsp2@yandex.ru>
In-Reply-To: <ZJG5ZOK8HKl/eWmM@casper.infradead.org>
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


20.06.2023 19:36, Matthew Wilcox пишет:
> On Tue, Jun 20, 2023 at 06:47:31PM +0500, stsp wrote:
>> 20.06.2023 18:46, Matthew Wilcox пишет:
>>> On Tue, Jun 20, 2023 at 06:39:07PM +0500, stsp wrote:
>>>> Though it will, for sure, represent the
>>>> task that _owns_ the lock.
>>> No, it *DOESN'T*.  I can open a file, SCM_RIGHTS pass it to another task
>>> and then exit.  Now the only owner of that lock is the recipient ...
>> Won't I get the recipient's pid in an
>> l_pid then?
> You snipped the part where I pointed out that at times there can be
> _no_ task that owns it.  open a fd, set the lock, pass the fd to another
> task, exit.  until that task calls recvmsg(), no task owns it.
Hmm, interesting case.
So at least it seems if recipient also exits,
then the untransferred fd gets closed.
Does this mean, by any chance, that the
recipient actually owns an fd before
recvmsg() is done?

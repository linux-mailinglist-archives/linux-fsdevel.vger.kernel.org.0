Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1ACB736A11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 12:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjFTK5v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 06:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjFTK5n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:57:43 -0400
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D591510E2;
        Tue, 20 Jun 2023 03:57:37 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1e2b:0:640:94b5:0])
        by forward101b.mail.yandex.net (Yandex) with ESMTP id 332E36012D;
        Tue, 20 Jun 2023 13:57:27 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Ove6axoDbKo0-nCAOC5kc;
        Tue, 20 Jun 2023 13:57:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687258646;
        bh=8FUU/Xa/yU6MIGBp4GSl/zvrLBpWLS521oJYuRHSseE=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=xFE/ov3F6+ItKmJ6eOk67Vb1CbEyk+vE9zyZrtnnNVF1WxL0IKQoKeteIuvNBtACA
         FY4NmEVVZahjsVl9v/Tx47AqBadSyoNOn6Sk+pzn1qd321IrrDRfAr0bhs7GRKd+S7
         pCj/UFepciTUNyFi5wHraMfy1IDZiJKaaBvbaeDI=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <a1e7f5c1-76ef-19e5-91db-a62f7615b28a@yandex.ru>
Date:   Tue, 20 Jun 2023 15:57:23 +0500
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
From:   stsp <stsp2@yandex.ru>
In-Reply-To: <5728ebda22a723b0eb209ae078e8f132d7b4ac7b.camel@kernel.org>
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

Hello,

20.06.2023 15:51, Jeff Layton пишет:
> On Tue, 2023-06-20 at 14:55 +0500, Stas Sergeev wrote:
>> Currently F_OFD_GETLK sets the pid of the lock owner to -1.
>> Remove such behavior to allow getting the proper owner's pid.
>> This may be helpful when you want to send some message (like SIGKILL)
>> to the offending locker.
>>
>> Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
>>
>> CC: Jeff Layton <jlayton@kernel.org>
>> CC: Chuck Lever <chuck.lever@oracle.com>
>> CC: Alexander Viro <viro@zeniv.linux.org.uk>
>> CC: Christian Brauner <brauner@kernel.org>
>> CC: linux-fsdevel@vger.kernel.org
>> CC: linux-kernel@vger.kernel.org
>>
>> ---
>>   fs/locks.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/fs/locks.c b/fs/locks.c
>> index 210766007e63..ee265e166542 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -2158,8 +2158,6 @@ static pid_t locks_translate_pid(struct file_lock *fl, struct pid_namespace *ns)
>>   	pid_t vnr;
>>   	struct pid *pid;
>>   
>> -	if (IS_OFDLCK(fl))
>> -		return -1;
>>   	if (IS_REMOTELCK(fl))
>>   		return fl->fl_pid;
>>   	/*
> NACK on this one.
>
> OFD locks are not owned by processes. They are owned by the file
> description (hence the name). Because of this, returning a pid here is
> wrong.

But fd is owned by a process.
PID has a meaning, you can send SIGKILL
to the returned PID, and the lock is clear.
Was there any reason to hide the PID at
a first place?


> This precedent comes from BSD, where flock() and POSIX locks can
> conflict. BSD returns -1 for the pid if you call F_GETLK on a file
> locked with flock(). Since OFD locks have similar ownership semantics to
> flock() locks, we use the same convention here.
OK if you insist I can drop this one and
search the PID by some other means.
Just a bit unsure what makes it so important
to overwrite the potentially useful info
with -1.

So in case you insist on that, then should
I send a v2 or can you just drop the patch
yourself?

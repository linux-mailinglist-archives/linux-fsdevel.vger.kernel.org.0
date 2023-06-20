Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05D1736A20
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 13:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjFTLAw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 07:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjFTLAu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:00:50 -0400
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B136100;
        Tue, 20 Jun 2023 04:00:49 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5329:0:640:44d3:0])
        by forward502b.mail.yandex.net (Yandex) with ESMTP id 6E77C5ED9C;
        Tue, 20 Jun 2023 14:00:38 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Z0f0EvsDfiE0-oVPxsKpL;
        Tue, 20 Jun 2023 14:00:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687258837;
        bh=q5JZcXugVzzP13B3EGAtz/ROr1sjE6Mec5v2xBPhibE=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=kxBh9UJXLbuj6natLcxCMKYEtDIUl1ylGrahln92dIIIQ/103LMbtu2GIDS2nC5bP
         ldtfHS/P/cIf6BveNm2v2IvlN2ayAlboJCvE5mkxf6ZuO6HTikHpz8wTiFKdeyPjTo
         k+YvsNeIYMt2tDEiUY0Qz8Id3CZ0pHbNRwwWkag8=
Authentication-Results: mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <e7586b46-ff65-27ff-e829-c6009d7d4808@yandex.ru>
Date:   Tue, 20 Jun 2023 16:00:35 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] fs/locks: F_UNLCK extension for F_OFD_GETLK
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
References: <20230620095507.2677463-1-stsp2@yandex.ru>
 <20230620095507.2677463-2-stsp2@yandex.ru>
 <c6d4e620cad72da5f85df03443a64747b5719939.camel@kernel.org>
From:   stsp <stsp2@yandex.ru>
In-Reply-To: <c6d4e620cad72da5f85df03443a64747b5719939.camel@kernel.org>
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

20.06.2023 15:46, Jeff Layton пишет:
> On Tue, 2023-06-20 at 14:55 +0500, Stas Sergeev wrote:
>> Currently F_UNLCK with F_OFD_GETLK returns -EINVAL.
>> The proposed extension allows to use it for getting the lock
>> information from the particular fd.
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
>>   fs/locks.c | 23 ++++++++++++++++++++---
>>   1 file changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/locks.c b/fs/locks.c
>> index df8b26a42524..210766007e63 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -868,6 +868,21 @@ static bool posix_locks_conflict(struct file_lock *caller_fl,
>>   	return locks_conflict(caller_fl, sys_fl);
>>   }
>>   
>> +/* Determine if lock sys_fl blocks lock caller_fl. Used on xx_GETLK
>> + * path so checks for additional GETLK-specific things like F_UNLCK.
>> + */
>> +static bool posix_test_locks_conflict(struct file_lock *caller_fl,
>> +				      struct file_lock *sys_fl)
>> +{
>> +	/* F_UNLCK checks any locks on the same fd. */
>> +	if (caller_fl->fl_type == F_UNLCK) {
>> +		if (!posix_same_owner(caller_fl, sys_fl))
>> +			return false;
>> +		return locks_overlap(caller_fl, sys_fl);
>> +	}
>> +	return posix_locks_conflict(caller_fl, sys_fl);
>> +}
>> +
>>   /* Determine if lock sys_fl blocks lock caller_fl. FLOCK specific
>>    * checking before calling the locks_conflict().
>>    */
>> @@ -901,7 +916,7 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
>>   retry:
>>   	spin_lock(&ctx->flc_lock);
>>   	list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
>> -		if (!posix_locks_conflict(fl, cfl))
>> +		if (!posix_test_locks_conflict(fl, cfl))
>>   			continue;
>>   		if (cfl->fl_lmops && cfl->fl_lmops->lm_lock_expirable
>>   			&& (*cfl->fl_lmops->lm_lock_expirable)(cfl)) {
>> @@ -2207,7 +2222,8 @@ int fcntl_getlk(struct file *filp, unsigned int cmd, struct flock *flock)
>>   	if (fl == NULL)
>>   		return -ENOMEM;
>>   	error = -EINVAL;
>> -	if (flock->l_type != F_RDLCK && flock->l_type != F_WRLCK)
>> +	if (cmd != F_OFD_GETLK && flock->l_type != F_RDLCK
>> +			&& flock->l_type != F_WRLCK)
>>   		goto out;
>>   
>>   	error = flock_to_posix_lock(filp, fl, flock);
>> @@ -2414,7 +2430,8 @@ int fcntl_getlk64(struct file *filp, unsigned int cmd, struct flock64 *flock)
>>   		return -ENOMEM;
>>   
>>   	error = -EINVAL;
>> -	if (flock->l_type != F_RDLCK && flock->l_type != F_WRLCK)
>> +	if (cmd != F_OFD_GETLK && flock->l_type != F_RDLCK
>> +			&& flock->l_type != F_WRLCK)
>>   		goto out;
>>   
>>   	error = flock64_to_posix_lock(filp, fl, flock);
> This seems like a reasonable sort of interface to add, particularly for
> the CRIU case.

Just for the record: my own cases are
the remaining 2. CRIU case is not mine
and I haven't talked to CRIU people
about that.


>   Using F_UNLCK for this is a bit kludgey, but adding a new
> constant is probably worse.
>
> I'm willing to take this in with an eye toward v6.6. Are you also
> willing to draft up some manpage patches that detail this new interface?
Sure thing.
As soon as its applied, I'll prepare a man
patch, or should it be done before that point?

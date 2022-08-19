Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073A35997E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 10:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347511AbiHSIiK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 04:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347521AbiHSIhe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:37:34 -0400
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [IPv6:2001:1600:3:17::8faf])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0F61F638
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Aug 2022 01:36:18 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4M8FTX4gDJzMqBtp;
        Fri, 19 Aug 2022 10:36:16 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4M8FTW52yDzlqV0d;
        Fri, 19 Aug 2022 10:36:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1660898176;
        bh=fS0Sagv4c4kizeaF+IJFIIxKTvKCe2Lj5NBDmgHIS6I=;
        h=Date:From:To:Cc:References:Subject:In-Reply-To:From;
        b=hTcnjUDXFOL+0fgeJ0UAQ3vo1fsaudopIZwi1+Uzjut+njGUKASzglwfDCkvcCd2w
         VinVKig9zSfeNw1btprpnT5SR1pyAQk3JulrtgbP4Qp70T9P410kwmhOemyDj3Ta3k
         rxDyb1RIkX4xSoM19Onu/i5nSeNRDa3sAeE7rq/4=
Message-ID: <2e7afd64-d36f-f81d-2ae4-1a99769e173c@digikod.net>
Date:   Fri, 19 Aug 2022 10:36:15 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
References: <20220817203006.21769-1-gnoack3000@gmail.com>
 <20220817203006.21769-3-gnoack3000@gmail.com>
 <e90aaa5d-d6c8-838a-db29-868a30fd8e37@digikod.net> <Yv8elmJ4qfk8/Mw7@nuc>
 <86b013ed-b809-f533-5764-60b22272dce9@digikod.net>
Subject: Re: [PATCH v5 2/4] selftests/landlock: Selftests for file truncation
 support
In-Reply-To: <86b013ed-b809-f533-5764-60b22272dce9@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FYI, my -next branch is here: 
https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=next

Günther, let me know if everything is OK.

Konstantin, please rebase your work on it. It should mainly conflict 
with changes related to the Landlock ABI version.


On 19/08/2022 10:15, Mickaël Salaün wrote:
> Ok, it should be in -next soon. Thanks for your contribution!
> 
> Would you like to write a syzkaller test to cover this new access right?
> You only need to update the landlock_fs_accesses file with a call to
> truncate() returning EACCES and check that it covers
> hook_path_truncate(). You can take inspiration from this PR:
> https://github.com/google/syzkaller/pull/3133
> Please CC me, I can help.
> 
> Regards,
>    Mickaël
> 
> 
> On 19/08/2022 07:24, Günther Noack wrote:
>> On Thu, Aug 18, 2022 at 10:39:27PM +0200, Mickaël Salaün wrote:
>>> On 17/08/2022 22:30, Günther Noack wrote:
>>>> +/*
>>>> + * Invokes creat(2) and returns its errno or 0.
>>>> + * Closes the opened file descriptor on success.
>>>> + */
>>>> +static int test_creat(const char *const path, mode_t mode)
>>>
>>> This "mode" argument is always 0600. If it's OK with you, I hard code this
>>> mode and push this series to -next with some small cosmetic fixes.
>>
>> Yes, absolutely. Please do these fixes and push it to -next. :)
>>
>> Thanks,
>> —Günther
>>
>> --

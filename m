Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BA84DC420
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 11:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbiCQKnN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 06:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiCQKnM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 06:43:12 -0400
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [IPv6:2001:1600:3:17::190b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B185B1DEABF
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 03:41:54 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KK3c05KT3zMppQ4;
        Thu, 17 Mar 2022 11:41:52 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KK3bz6r1pzlhRV1;
        Thu, 17 Mar 2022 11:41:51 +0100 (CET)
Message-ID: <33d4a0fc-1b77-39df-31e9-ba974b851a97@digikod.net>
Date:   Thu, 17 Mar 2022 11:42:35 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v1 05/11] landlock: Move filesystem helpers and add a new
 one
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20220221212522.320243-1-mic@digikod.net>
 <20220221212522.320243-6-mic@digikod.net>
 <CAHC9VhQM33jnJYMz+z1YoNt9=nNceW=TutuGO=x+SSpHW7PMyg@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <CAHC9VhQM33jnJYMz+z1YoNt9=nNceW=TutuGO=x+SSpHW7PMyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 17/03/2022 02:26, Paul Moore wrote:
> On Mon, Feb 21, 2022 at 4:15 PM Mickaël Salaün <mic@digikod.net> wrote:
>>
>> From: Mickaël Salaün <mic@linux.microsoft.com>
>>
>> Move the SB_NOUSER and IS_PRIVATE dentry check to a standalone
>> is_nouser_or_private() helper.  This will be useful for a following
>> commit.
>>
>> Move get_mode_access() and maybe_remove() to make them usable by new
>> code provided by a following commit.
>>
>> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
>> Link: https://lore.kernel.org/r/20220221212522.320243-6-mic@digikod.net
>> ---
>>   security/landlock/fs.c | 87 ++++++++++++++++++++++--------------------
>>   1 file changed, 46 insertions(+), 41 deletions(-)
> 
> One nit-picky comment below, otherwise it looks fine to me.
> 
> Reviewed-by: Paul Moore <paul@paul-moore.com>
> 
>> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
>> index 9662f9fb3cd0..3886f9ad1a60 100644
>> --- a/security/landlock/fs.c
>> +++ b/security/landlock/fs.c
>> @@ -257,6 +257,18 @@ static inline bool unmask_layers(const struct landlock_rule *const rule,
>>          return false;
>>   }
>>
>> +static inline bool is_nouser_or_private(const struct dentry *dentry)
>> +{
>> +       /*
>> +        * Allows access to pseudo filesystems that will never be mountable
>> +        * (e.g. sockfs, pipefs), but can still be reachable through
>> +        * /proc/<pid>/fd/<file-descriptor> .
>> +        */
> 
> I might suggest moving this explanation up to a function header comment block.

Sounds good.


> 
> 
>> +       return (dentry->d_sb->s_flags & SB_NOUSER) ||
>> +                       (d_is_positive(dentry) &&
>> +                        unlikely(IS_PRIVATE(d_backing_inode(dentry))));
>> +}
>> +
>>   static int check_access_path(const struct landlock_ruleset *const domain,
>>                  const struct path *const path,
>>                  const access_mask_t access_request)
> 
> --
> paul-moore.com

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0647A5B28F9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 00:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiIHWFo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 18:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIHWFn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 18:05:43 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED601FCD8
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Sep 2022 15:05:42 -0700 (PDT)
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 288M55cH003898;
        Fri, 9 Sep 2022 07:05:05 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Fri, 09 Sep 2022 07:05:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 288M55Tr003894
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 9 Sep 2022 07:05:05 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9626409f-d4f5-0a39-2914-79beec812864@I-love.SAKURA.ne.jp>
Date:   Fri, 9 Sep 2022 07:04:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v6 1/5] security: create file_truncate hook from
 path_truncate hook
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?= =?UTF-8?Q?n?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        John Johansen <john.johansen@canonical.com>
References: <20220908195805.128252-1-gnoack3000@gmail.com>
 <20220908195805.128252-2-gnoack3000@gmail.com>
 <CAHC9VhSmjF1sYoP-Z8vj+O4=NPQMdw+L4=iFZtDbHzJg7ey6vA@mail.gmail.com>
 <YxpVkKqrZhjh5Pn8@nuc>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YxpVkKqrZhjh5Pn8@nuc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/09/09 5:50, Günther Noack wrote:
> On Thu, Sep 08, 2022 at 04:09:06PM -0400, Paul Moore wrote:
>> On Thu, Sep 8, 2022 at 3:58 PM Günther Noack <gnoack3000@gmail.com> wrote:
>>>
>>> Like path_truncate, the file_truncate hook also restricts file
>>> truncation, but is called in the cases where truncation is attempted
>>> on an already-opened file.
>>>
>>> This is required in a subsequent commit to handle ftruncate()
>>> operations differently to truncate() operations.
>>>
>>> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
>>
>> We need to get John and Tetsuo's ACKs on this patch, but in addition
>> to that I have two small comments (below).
> 
> +CC: John Johansen and Tetsuo Handa -- this change is splitting up the
> path_truncate LSM hook into a path_truncate and file_truncate variant,
> one operating on the path as before, and one operating on a struct
> file*. As a result, AppArmor and TOMOYO need to implement the
> file-based hook as well and treat it the same as before by looking at
> the file's ->f_path. Does this change seem reasonable to you?

Regarding TOMOYO part,

Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>


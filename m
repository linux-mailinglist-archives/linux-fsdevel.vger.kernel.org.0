Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF644F9A18
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 18:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbiDHQJ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 12:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbiDHQJ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 12:09:28 -0400
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [IPv6:2001:1600:4:17::1908])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294052B9A21
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Apr 2022 09:07:22 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KZjnN5NpVzMprng;
        Fri,  8 Apr 2022 18:07:20 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KZjnL3dFHzljsTT;
        Fri,  8 Apr 2022 18:07:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1649434040;
        bh=AQy78gX0PZQtfm+zKT+FxKBJBDhXbQUWIRIFqRcVQBc=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=e+d5CfPV6gj0QELwg4qD7JIkq1l+cpTVBSdDVTS2imF6k9O2TGR0K3YmwQv1yhQH7
         NagJTnN1uKdyquvQHoBTjzavKN8LKjbvoNI7stUFcv9f9d3koltrg0vBcZB0azJAwM
         3fFDHCJa5/bnc1X6hdpfeQC3AKvQ7BXhgsZq/AUs=
Message-ID: <3a5495b8-5d69-e327-1dfc-7a99257269ae@digikod.net>
Date:   Fri, 8 Apr 2022 18:07:17 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Shuah Khan <shuah@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20220329125117.1393824-1-mic@digikod.net>
 <20220329125117.1393824-8-mic@digikod.net>
 <CAHC9VhQpZ12Chgd+xMibUxgvcPjTn9FMnCdMGYbLcWG3eTqDQg@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v2 07/12] landlock: Add support for file reparenting with
 LANDLOCK_ACCESS_FS_REFER
In-Reply-To: <CAHC9VhQpZ12Chgd+xMibUxgvcPjTn9FMnCdMGYbLcWG3eTqDQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 08/04/2022 03:42, Paul Moore wrote:
> On Tue, Mar 29, 2022 at 8:51 AM Mickaël Salaün <mic@digikod.net> wrote:
>>
>> From: Mickaël Salaün <mic@linux.microsoft.com>
>>
>> Add a new LANDLOCK_ACCESS_FS_REFER access right to enable policy writers
>> to allow sandboxed processes to link and rename files from and to a
>> specific set of file hierarchies.  This access right should be composed
>> with LANDLOCK_ACCESS_FS_MAKE_* for the destination of a link or rename,
>> and with LANDLOCK_ACCESS_FS_REMOVE_* for a source of a rename.  This
>> lift a Landlock limitation that always denied changing the parent of an
>> inode.
>>
>> Renaming or linking to the same directory is still always allowed,
>> whatever LANDLOCK_ACCESS_FS_REFER is used or not, because it is not
>> considered a threat to user data.
>>
>> However, creating multiple links or renaming to a different parent
>> directory may lead to privilege escalations if not handled properly.
>> Indeed, we must be sure that the source doesn't gain more privileges by
>> being accessible from the destination.  This is handled by making sure
>> that the source hierarchy (including the referenced file or directory
>> itself) restricts at least as much the destination hierarchy.  If it is
>> not the case, an EXDEV error is returned, making it potentially possible
>> for user space to copy the file hierarchy instead of moving or linking
>> it.
>>
>> Instead of creating different access rights for the source and the
>> destination, we choose to make it simple and consistent for users.
>> Indeed, considering the previous constraint, it would be weird to
>> require such destination access right to be also granted to the source
>> (to make it a superset).  Moreover, RENAME_EXCHANGE would also add to
>> the confusion because of paths being both a source and a destination.
>>
>> See the provided documentation for additional details.
>>
>> New tests are provided with a following commit.
>>
>> Cc: Paul Moore <paul@paul-moore.com>
>> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
>> Link: https://lore.kernel.org/r/20220329125117.1393824-8-mic@digikod.net
>> ---
>>
>> Changes since v1:
>> * Update current_check_access_path() to efficiently handle
>>    RENAME_EXCHANGE thanks to the updated LSM hook (see previous patch).
>>    Only one path walk is performed per rename arguments until their
>>    common mount point is reached.  Superset of access rights is correctly
>>    checked, including when exchanging a file with a directory.  This
>>    requires to store another matrix of layer masks.
>> * Reorder and rename check_access_path_dual() arguments in a more
>>    generic way: switch from src/dst to 1/2.  This makes it easier to
>>    understand the RENAME_EXCHANGE cases alongs with the others.  Update
>>    and improve check_access_path_dual() documentation accordingly.
>> * Clean up the check_access_path_dual() loop: set both allowed_parent*
>>    when reaching internal filesystems and remove a useless one.  This
>>    allows potential renames in internal filesystems (like for other
>>    operations).
>> * Move the function arguments checks from BUILD_BUG_ON() to
>>    WARN_ON_ONCE() to avoid clang build error.
>> * Rename is_superset() to no_more_access() and make it handle superset
>>    checks of source and destination for simple and exchange cases.
>> * Move the layer_masks_child* creation from current_check_refer_path()
>>    to check_access_path_dual(): this is simpler and less error-prone,
>>    especially with RENAME_EXCHANGE.
>> * Remove one optimization in current_check_refer_path() to make the code
>>    simpler, especially with the RENAME_EXCHANGE handling.
>> * Remove overzealous WARN_ON_ONCE() for !access_request check in
>>    init_layer_masks().
>> ---
>>   include/uapi/linux/landlock.h                |  27 +-
>>   security/landlock/fs.c                       | 607 ++++++++++++++++---
>>   security/landlock/limits.h                   |   2 +-
>>   security/landlock/syscalls.c                 |   2 +-
>>   tools/testing/selftests/landlock/base_test.c |   2 +-
>>   tools/testing/selftests/landlock/fs_test.c   |   3 +-
>>   6 files changed, 566 insertions(+), 77 deletions(-)
> 
> I'm still not going to claim that I'm a Landlock expert, but this
> looks sane to me.
> 
> Reviewed-by: Paul Moore <paul@paul-moore.com>

Thanks Paul! I'll send a small update shortly, with some typo fixes, 
some unlikely() calls, and rebased on the other Landlock patch series.

> 
>> +static inline access_mask_t init_layer_masks(
>> +               const struct landlock_ruleset *const domain,
>> +               const access_mask_t access_request,
>> +               layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS])
>> +{
>> +       access_mask_t handled_accesses = 0;
>> +       size_t layer_level;
>> +
>> +       memset(layer_masks, 0, sizeof(*layer_masks));
>> +       /* An empty access request can happen because of O_WRONLY | O_RDWR. */
> 
>   ;)
> 

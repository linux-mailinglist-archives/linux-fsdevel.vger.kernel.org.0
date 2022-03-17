Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA994DC1DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 09:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiCQIvA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 04:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiCQIu6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:50:58 -0400
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F28CEA742
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 01:49:41 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KK0pf5LWCzMq31C;
        Thu, 17 Mar 2022 09:35:54 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KK0pd1DtQzlhRV1;
        Thu, 17 Mar 2022 09:35:53 +0100 (CET)
Message-ID: <ed8467f2-dcd0-bc2f-8e98-1d9129fb2c30@digikod.net>
Date:   Thu, 17 Mar 2022 09:36:36 +0100
MIME-Version: 1.0
User-Agent: 
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
 <20220221212522.320243-2-mic@digikod.net>
 <CAHC9VhQEEKGgCn7fYgUt-_WhXc-vrKq9TVm=cfwJUyWaUgY2Vw@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v1 01/11] landlock: Define access_mask_t to enforce a
 consistent access mask size
In-Reply-To: <CAHC9VhQEEKGgCn7fYgUt-_WhXc-vrKq9TVm=cfwJUyWaUgY2Vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
>> Create and use the access_mask_t typedef to enforce a consistent access
>> mask size and uniformly use a 16-bits type.  This will helps transition
>> to a 32-bits value one day.
>>
>> Add a build check to make sure all (filesystem) access rights fit in.
>> This will be extended with a following commit.
>>
>> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
>> Link: https://lore.kernel.org/r/20220221212522.320243-2-mic@digikod.net
>> ---
>>   security/landlock/fs.c      | 19 ++++++++++---------
>>   security/landlock/fs.h      |  2 +-
>>   security/landlock/limits.h  |  2 ++
>>   security/landlock/ruleset.c |  6 ++++--
>>   security/landlock/ruleset.h | 17 +++++++++++++----
>>   5 files changed, 30 insertions(+), 16 deletions(-)
>>
>> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
>> index 97b8e421f617..9de2a460a762 100644
>> --- a/security/landlock/fs.c
>> +++ b/security/landlock/fs.c
>> @@ -150,7 +150,7 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
>>    * @path: Should have been checked by get_path_from_fd().
>>    */
>>   int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
>> -               const struct path *const path, u32 access_rights)
>> +               const struct path *const path, access_mask_t access_rights)
>>   {
>>          int err;
>>          struct landlock_object *object;
>> @@ -182,8 +182,8 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
>>
>>   static inline u64 unmask_layers(
>>                  const struct landlock_ruleset *const domain,
>> -               const struct path *const path, const u32 access_request,
>> -               u64 layer_mask)
>> +               const struct path *const path,
>> +               const access_mask_t access_request, u64 layer_mask)
>>   {
>>          const struct landlock_rule *rule;
>>          const struct inode *inode;
>> @@ -223,7 +223,8 @@ static inline u64 unmask_layers(
>>   }
>>
>>   static int check_access_path(const struct landlock_ruleset *const domain,
>> -               const struct path *const path, u32 access_request)
>> +               const struct path *const path,
>> +               const access_mask_t access_request)
>>   {
>>          bool allowed = false;
>>          struct path walker_path;
>> @@ -308,7 +309,7 @@ static int check_access_path(const struct landlock_ruleset *const domain,
>>   }
>>
>>   static inline int current_check_access_path(const struct path *const path,
>> -               const u32 access_request)
>> +               const access_mask_t access_request)
>>   {
>>          const struct landlock_ruleset *const dom =
>>                  landlock_get_current_domain();
>> @@ -511,7 +512,7 @@ static int hook_sb_pivotroot(const struct path *const old_path,
>>
>>   /* Path hooks */
>>
>> -static inline u32 get_mode_access(const umode_t mode)
>> +static inline access_mask_t get_mode_access(const umode_t mode)
>>   {
>>          switch (mode & S_IFMT) {
>>          case S_IFLNK:
>> @@ -563,7 +564,7 @@ static int hook_path_link(struct dentry *const old_dentry,
>>                          get_mode_access(d_backing_inode(old_dentry)->i_mode));
>>   }
>>
>> -static inline u32 maybe_remove(const struct dentry *const dentry)
>> +static inline access_mask_t maybe_remove(const struct dentry *const dentry)
>>   {
>>          if (d_is_negative(dentry))
>>                  return 0;
>> @@ -631,9 +632,9 @@ static int hook_path_rmdir(const struct path *const dir,
>>
>>   /* File hooks */
>>
>> -static inline u32 get_file_access(const struct file *const file)
>> +static inline access_mask_t get_file_access(const struct file *const file)
>>   {
>> -       u32 access = 0;
>> +       access_mask_t access = 0;
>>
>>          if (file->f_mode & FMODE_READ) {
>>                  /* A directory can only be opened in read mode. */
>> diff --git a/security/landlock/fs.h b/security/landlock/fs.h
>> index 187284b421c9..74be312aad96 100644
>> --- a/security/landlock/fs.h
>> +++ b/security/landlock/fs.h
>> @@ -65,6 +65,6 @@ static inline struct landlock_superblock_security *landlock_superblock(
>>   __init void landlock_add_fs_hooks(void);
>>
>>   int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
>> -               const struct path *const path, u32 access_hierarchy);
>> +               const struct path *const path, access_mask_t access_hierarchy);
>>
>>   #endif /* _SECURITY_LANDLOCK_FS_H */
>> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
>> index 2a0a1095ee27..458d1de32ed5 100644
>> --- a/security/landlock/limits.h
>> +++ b/security/landlock/limits.h
>> @@ -9,6 +9,7 @@
>>   #ifndef _SECURITY_LANDLOCK_LIMITS_H
>>   #define _SECURITY_LANDLOCK_LIMITS_H
>>
>> +#include <linux/bitops.h>
>>   #include <linux/limits.h>
>>   #include <uapi/linux/landlock.h>
>>
>> @@ -17,5 +18,6 @@
>>
>>   #define LANDLOCK_LAST_ACCESS_FS                LANDLOCK_ACCESS_FS_MAKE_SYM
>>   #define LANDLOCK_MASK_ACCESS_FS                ((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
>> +#define LANDLOCK_NUM_ACCESS_FS         __const_hweight64(LANDLOCK_MASK_ACCESS_FS)
> 
> The line above, and the static_assert() in ruleset.h are clever.  I'll
> admit I didn't even know the hweightX() macros existed until looking
> at this code :)
> 
> However, the LANDLOCK_NUM_ACCESS_FS is never really going to be used
> outside the static_assert() in ruleset.h is it?  I wonder if it would
> be better to skip the extra macro and rewrite the static_assert like
> this:
> 
> static_assert(BITS_PER_TYPE(access_mask_t) >=
> __const_hweight64(LANDLOCK_MASK_ACCESS_FS));
> 
> If not, I might suggest changing LANDLOCK_NUM_ACCESS_FS to
> LANDLOCK_BITS_ACCESS_FS or something similar.

I declared LANDLOCK_NUM_ACCESS_FS in this patch to be able to have the 
static_assert() here and ease the review, but LANDLOCK_NUM_ACCESS_FS is 
really used in patch 6/11 to define an array size: 
get_handled_acceses(), init_layer_masks(), is_superset(), 
check_access_path_dual()…


> 
> 
>> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
>> index 2d3ed7ec5a0a..7e7cac68e443 100644
>> --- a/security/landlock/ruleset.h
>> +++ b/security/landlock/ruleset.h
>> @@ -9,13 +9,20 @@
>>   #ifndef _SECURITY_LANDLOCK_RULESET_H
>>   #define _SECURITY_LANDLOCK_RULESET_H
>>
>> +#include <linux/bitops.h>
>> +#include <linux/build_bug.h>
>>   #include <linux/mutex.h>
>>   #include <linux/rbtree.h>
>>   #include <linux/refcount.h>
>>   #include <linux/workqueue.h>
>>
>> +#include "limits.h"
>>   #include "object.h"
>>
>> +typedef u16 access_mask_t;
>> +/* Makes sure all filesystem access rights can be stored. */
>> +static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_FS);
> 
> --
> paul-moore.com

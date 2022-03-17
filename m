Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46B74DC571
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 13:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbiCQMFK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 08:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbiCQMFJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:05:09 -0400
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A531191416
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 05:03:51 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KK5QY4xB8zMqNfM;
        Thu, 17 Mar 2022 13:03:49 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KK5QT668mzljsTT;
        Thu, 17 Mar 2022 13:03:45 +0100 (CET)
Message-ID: <588e0fec-6a45-db81-e411-ae488b29e533@digikod.net>
Date:   Thu, 17 Mar 2022 13:04:29 +0100
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
 <20220221212522.320243-7-mic@digikod.net>
 <CAHC9VhSFXN39EuVG5aVK0jtgCOmzM2FSCoVa2Xrs=oJQ4AkWMQ@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v1 06/11] landlock: Add support for file reparenting with
 LANDLOCK_ACCESS_FS_REFER
In-Reply-To: <CAHC9VhSFXN39EuVG5aVK0jtgCOmzM2FSCoVa2Xrs=oJQ4AkWMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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
>> (to make it a superset).
>>
>> See the provided documentation for additional details.
>>
>> New tests are provided with a following commit.
>>
>> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
>> Link: https://lore.kernel.org/r/20220221212522.320243-7-mic@digikod.net
>> ---
>>   include/uapi/linux/landlock.h                |  27 +-
>>   security/landlock/fs.c                       | 550 ++++++++++++++++---
>>   security/landlock/limits.h                   |   2 +-
>>   security/landlock/syscalls.c                 |   2 +-
>>   tools/testing/selftests/landlock/base_test.c |   2 +-
>>   tools/testing/selftests/landlock/fs_test.c   |   3 +-
>>   6 files changed, 516 insertions(+), 70 deletions(-)
> 
> ...
> 
>> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
>> index 3886f9ad1a60..c7c7ce4e7cd5 100644
>> --- a/security/landlock/fs.c
>> +++ b/security/landlock/fs.c
>> @@ -4,6 +4,7 @@
>>    *
>>    * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
>>    * Copyright © 2018-2020 ANSSI
>> + * Copyright © 2021-2022 Microsoft Corporation
>>    */
>>
>>   #include <linux/atomic.h>
>> @@ -269,16 +270,188 @@ static inline bool is_nouser_or_private(const struct dentry *dentry)
>>                           unlikely(IS_PRIVATE(d_backing_inode(dentry))));
>>   }
>>
>> -static int check_access_path(const struct landlock_ruleset *const domain,
>> -               const struct path *const path,
>> +static inline access_mask_t get_handled_accesses(
>> +               const struct landlock_ruleset *const domain)
>> +{
>> +       access_mask_t access_dom = 0;
>> +       unsigned long access_bit;
> 
> Would it be better to declare @access_bit as an access_mask_t type?
> You're not using any macros like for_each_set_bit() in this function
> so I believe it should be safe.

Right, I'll change that.


> 
>> +       for (access_bit = 0; access_bit < LANDLOCK_NUM_ACCESS_FS;
>> +                       access_bit++) {
>> +               size_t layer_level;
> 
> Considering the number of layers has dropped down to 16, it seems like
> a normal unsigned int might be big enough for @layer_level :)

We could switch to u8, but I prefer to stick to size_t for array indexes 
which enable to reduce the cognitive workload related to the size of 
such array. ;) I guess there is enough info for compilers to optimize 
such code anyway.


> 
>> +               for (layer_level = 0; layer_level < domain->num_layers;
>> +                               layer_level++) {
>> +                       if (domain->fs_access_masks[layer_level] &
>> +                                       BIT_ULL(access_bit)) {
>> +                               access_dom |= BIT_ULL(access_bit);
>> +                               break;
>> +                       }
>> +               }
>> +       }
>> +       return access_dom;
>> +}
>> +
>> +static inline access_mask_t init_layer_masks(
>> +               const struct landlock_ruleset *const domain,
>> +               const access_mask_t access_request,
>> +               layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS])
>> +{
>> +       access_mask_t handled_accesses = 0;
>> +       size_t layer_level;
>> +
>> +       memset(layer_masks, 0, sizeof(*layer_masks));
>> +       if (WARN_ON_ONCE(!access_request))
>> +               return 0;
>> +
>> +       /* Saves all handled accesses per layer. */
>> +       for (layer_level = 0; layer_level < domain->num_layers;
>> +                       layer_level++) {
>> +               const unsigned long access_req = access_request;
>> +               unsigned long access_bit;
>> +
>> +               for_each_set_bit(access_bit, &access_req,
>> +                               ARRAY_SIZE(*layer_masks)) {
>> +                       if (domain->fs_access_masks[layer_level] &
>> +                                       BIT_ULL(access_bit)) {
>> +                               (*layer_masks)[access_bit] |=
>> +                                       BIT_ULL(layer_level);
>> +                               handled_accesses |= BIT_ULL(access_bit);
>> +                       }
>> +               }
>> +       }
>> +       return handled_accesses;
>> +}
>> +
>> +/*
>> + * Check that a destination file hierarchy has more restrictions than a source
>> + * file hierarchy.  This is only used for link and rename actions.
>> + */
>> +static inline bool is_superset(bool child_is_directory,
>> +               const layer_mask_t (*const
>> +                       layer_masks_dst_parent)[LANDLOCK_NUM_ACCESS_FS],
>> +               const layer_mask_t (*const
>> +                       layer_masks_src_parent)[LANDLOCK_NUM_ACCESS_FS],
>> +               const layer_mask_t (*const
>> +                       layer_masks_child)[LANDLOCK_NUM_ACCESS_FS])
>> +{
>> +       unsigned long access_bit;
>> +
>> +       for (access_bit = 0; access_bit < ARRAY_SIZE(*layer_masks_dst_parent);
>> +                       access_bit++) {
>> +               /* Ignores accesses that only make sense for directories. */
>> +               if (!child_is_directory && !(BIT_ULL(access_bit) & ACCESS_FILE))
>> +                       continue;
>> +
>> +               /*
>> +                * Checks if the destination restrictions are a superset of the
>> +                * source ones (i.e. inherited access rights without child
>> +                * exceptions).
>> +                */
>> +               if ((((*layer_masks_src_parent)[access_bit] & (*layer_masks_child)[access_bit]) |
>> +                                       (*layer_masks_dst_parent)[access_bit]) !=
>> +                               (*layer_masks_dst_parent)[access_bit])
>> +                       return false;
>> +       }
>> +       return true;
>> +}
>> +
>> +/*
>> + * Removes @layer_masks accesses that are not requested.
>> + *
>> + * Returns true if the request is allowed, false otherwise.
>> + */
>> +static inline bool scope_to_request(const access_mask_t access_request,
>> +               layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS])
>> +{
>> +       const unsigned long access_req = access_request;
>> +       unsigned long access_bit;
>> +
>> +       if (WARN_ON_ONCE(!layer_masks))
>> +               return true;
>> +
>> +       for_each_clear_bit(access_bit, &access_req, ARRAY_SIZE(*layer_masks))
>> +               (*layer_masks)[access_bit] = 0;
>> +       return !memchr_inv(layer_masks, 0, sizeof(*layer_masks));
>> +}
>> +
>> +/*
>> + * Returns true if there is at least one access right different than
>> + * LANDLOCK_ACCESS_FS_REFER.
>> + */
>> +static inline bool is_eacces(
>> +               const layer_mask_t (*const
>> +                       layer_masks)[LANDLOCK_NUM_ACCESS_FS],
>>                  const access_mask_t access_request)
>>   {
> 
> Granted, I don't have as deep of an understanding of Landlock as you
> do, but the function name "is_eacces" seems a little odd given the
> nature of the function.  Perhaps "is_fsrefer"?

Hmm, this helper does multiple things which are necessary to know if we 
need to return -EACCES or -EXDEV. Renaming it to is_fsrefer() would 
require to inverse the logic and use boolean negations in the callers 
(because of ordering). Renaming to something like without_fs_refer() 
would not be completely correct because we also check if there is no 
layer_masks, which indicated that it doesn't contain an access right 
that should return -EACCES. This helper is named as such because the 
underlying semantic is to check for such error code, which is a tricky. 
I can rename it co contains_eacces() or something, but a longer name 
would require to cut the caller lines to fit 80 columns. :|


> 
>> -       layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
>> -       bool allowed = false, has_access = false;
>> +       unsigned long access_bit;
>> +       /* LANDLOCK_ACCESS_FS_REFER alone must return -EXDEV. */
>> +       const unsigned long access_check = access_request &
>> +               ~LANDLOCK_ACCESS_FS_REFER;
>> +
>> +       if (!layer_masks)
>> +               return false;
>> +
>> +       for_each_set_bit(access_bit, &access_check, ARRAY_SIZE(*layer_masks)) {
>> +               if ((*layer_masks)[access_bit])
>> +                       return true;
>> +       }
> 
> Is calling for_each_set_bit() overkill here?  @access_check should
> only ever have at most one bit set (LANDLOCK_ACCESS_FS_REFER), yes?

No, it is the contrary, the bitmask is inverted and this loop check for 
non-FS_REFER access rights that should then return -EACCES. For 
instance, if a sandbox handles (and then restricts) MAKE_REG and REFER, 
a request to link a regular file would contains both of these bits, and 
the kernel should return -EACCES if MAKE_REG is not granted or -EXDEV if 
the request is only denied because of REFER. The reparent_* tests check 
the consistency of this behavior (with the exception of a 
RENAME_EXCHANGE case, see [1]).

[1] https://lore.kernel.org/r/20220222175332.384545-1-mic@digikod.net


> 
>> +       return false;
>> +}
>> +
>> +/**
>> + * check_access_path_dual - Check a source and a destination accesses
>> + *
>> + * @domain: Domain to check against.
>> + * @path: File hierarchy to walk through.
>> + * @child_is_directory: Must be set to true if the (original) leaf is a
>> + *     directory, false otherwise.
>> + * @access_request_dst_parent: Accesses to check, once @layer_masks_dst_parent
>> + *     is equal to @layer_masks_src_parent (if any).
>> + * @layer_masks_dst_parent: Pointer to a matrix of layer masks per access
>> + *     masks, identifying the layers that forbid a specific access.  Bits from
>> + *     this matrix can be unset according to the @path walk.  An empty matrix
>> + *     means that @domain allows all possible Landlock accesses (i.e. not only
>> + *     those identified by @access_request_dst_parent).  This matrix can
>> + *     initially refer to domain layer masks and, when the accesses for the
>> + *     destination and source are the same, to request layer masks.
>> + * @access_request_src_parent: Similar to @access_request_dst_parent but for an
>> + *     initial source path request.  Only taken into account if
>> + *     @layer_masks_src_parent is not NULL.
>> + * @layer_masks_src_parent: Similar to @layer_masks_dst_parent but for an
>> + *     initial source path walk.  This can be NULL if only dealing with a
>> + *     destination access request (i.e. not a rename nor a link action).
>> + * @layer_masks_child: Similar to @layer_masks_src_parent but only for the
>> + *     linked or renamed inode (without hierarchy).  This is only used if
>> + *     @layer_masks_src_parent is not NULL.
>> + *
>> + * This helper first checks that the destination has a superset of restrictions
>> + * compared to the source (if any) for a common path.  It then checks that the
>> + * collected accesses and the remaining ones are enough to allow the request.
>> + *
>> + * Returns:
>> + * - 0 if the access request is granted;
>> + * - -EACCES if it is denied because of access right other than
>> + *   LANDLOCK_ACCESS_FS_REFER;
>> + * - -EXDEV if the renaming or linking would be a privileged escalation
>> + *   (according to each layered policies), or if LANDLOCK_ACCESS_FS_REFER is
>> + *   not allowed by the source or the destination.
>> + */
>> +static int check_access_path_dual(const struct landlock_ruleset *const domain,
>> +               const struct path *const path,
>> +               bool child_is_directory,
>> +               const access_mask_t access_request_dst_parent,
>> +               layer_mask_t (*const
>> +                       layer_masks_dst_parent)[LANDLOCK_NUM_ACCESS_FS],
>> +               const access_mask_t access_request_src_parent,
>> +               layer_mask_t (*layer_masks_src_parent)[LANDLOCK_NUM_ACCESS_FS],
>> +               layer_mask_t (*layer_masks_child)[LANDLOCK_NUM_ACCESS_FS])
>> +{
>> +       bool allowed_dst_parent = false, allowed_src_parent = false, is_dom_check;
>>          struct path walker_path;
>> -       size_t i;
>> +       access_mask_t access_masked_dst_parent, access_masked_src_parent;
>>
>> -       if (!access_request)
>> +       if (!access_request_dst_parent && !access_request_src_parent)
>>                  return 0;
>>          if (WARN_ON_ONCE(!domain || !path))
>>                  return 0;
>> @@ -287,22 +460,20 @@ static int check_access_path(const struct landlock_ruleset *const domain,
>>          if (WARN_ON_ONCE(domain->num_layers < 1))
>>                  return -EACCES;
>>
>> -       /* Saves all layers handling a subset of requested accesses. */
>> -       for (i = 0; i < domain->num_layers; i++) {
>> -               const unsigned long access_req = access_request;
>> -               unsigned long access_bit;
>> -
>> -               for_each_set_bit(access_bit, &access_req,
>> -                               ARRAY_SIZE(layer_masks)) {
>> -                       if (domain->fs_access_masks[i] & BIT_ULL(access_bit)) {
>> -                               layer_masks[access_bit] |= BIT_ULL(i);
>> -                               has_access = true;
>> -                       }
>> -               }
>> +       BUILD_BUG_ON(!layer_masks_dst_parent);
> 
> I know the kbuild robot already flagged this, but checking function
> parameters with BUILD_BUG_ON() does seem a bit ... unusual :)

Yeah, I like such guarantee but it may not work without __always_inline. 
I moved this check in the previous WARN_ON_ONCE().


> 
>> +       if (layer_masks_src_parent) {
>> +               if (WARN_ON_ONCE(!layer_masks_child))
>> +                       return -EACCES;
>> +               access_masked_dst_parent = access_masked_src_parent =
>> +                       get_handled_accesses(domain);
>> +               is_dom_check = true;
>> +       } else {
>> +               if (WARN_ON_ONCE(layer_masks_child))
>> +                       return -EACCES;
>> +               access_masked_dst_parent = access_request_dst_parent;
>> +               access_masked_src_parent = access_request_src_parent;
>> +               is_dom_check = false;
>>          }
>> -       /* An access request not handled by the domain is allowed. */
>> -       if (!has_access)
>> -               return 0;
>>
>>          walker_path = *path;
>>          path_get(&walker_path);
>> @@ -312,11 +483,50 @@ static int check_access_path(const struct landlock_ruleset *const domain,
>>           */
>>          while (true) {
>>                  struct dentry *parent_dentry;
>> +               const struct landlock_rule *rule;
>> +
>> +               /*
>> +                * If at least all accesses allowed on the destination are
>> +                * already allowed on the source, respectively if there is at
>> +                * least as much as restrictions on the destination than on the
>> +                * source, then we can safely refer files from the source to
>> +                * the destination without risking a privilege escalation.
>> +                * This is crucial for standalone multilayered security
>> +                * policies.  Furthermore, this helps avoid policy writers to
>> +                * shoot themselves in the foot.
>> +                */
>> +               if (is_dom_check && is_superset(child_is_directory,
>> +                                       layer_masks_dst_parent,
>> +                                       layer_masks_src_parent,
>> +                                       layer_masks_child)) {
>> +                       allowed_dst_parent =
>> +                               scope_to_request(access_request_dst_parent,
>> +                                               layer_masks_dst_parent);
>> +                       allowed_src_parent =
>> +                               scope_to_request(access_request_src_parent,
>> +                                               layer_masks_src_parent);
>> +
>> +                       /* Stops when all accesses are granted. */
>> +                       if (allowed_dst_parent && allowed_src_parent)
>> +                               break;
>> +
>> +                       /*
>> +                        * Downgrades checks from domain handled accesses to
>> +                        * requested accesses.
>> +                        */
>> +                       is_dom_check = false;
>> +                       access_masked_dst_parent = access_request_dst_parent;
>> +                       access_masked_src_parent = access_request_src_parent;
>> +               }
>> +
>> +               rule = find_rule(domain, walker_path.dentry);
>> +               allowed_dst_parent = unmask_layers(rule, access_masked_dst_parent,
>> +                               layer_masks_dst_parent);
>> +               allowed_src_parent = unmask_layers(rule, access_masked_src_parent,
>> +                               layer_masks_src_parent);
>>
>> -               allowed = unmask_layers(find_rule(domain, walker_path.dentry),
>> -                               access_request, &layer_masks);
>> -               if (allowed)
>> -                       /* Stops when a rule from each layer grants access. */
>> +               /* Stops when a rule from each layer grants access. */
>> +               if (allowed_dst_parent && allowed_src_parent)
>>                          break;
> 
> If "(allowed_dst_parent && allowed_src_parent)" is true, you break out
> of the while loop only to do a path_put(), check the two booleans once
> more, and then return zero, yes?  Why not just do the path_put() and
> return zero here?

Correct, that would work, but I prefer not to duplicate the logic of 
granting access if it doesn't make the code more complex, which I think 
is not the case here, and I'm reluctant to duplicate path_get/put() 
calls. This loop break is a small optimization to avoid walking the path 
one more step, and writing it this way looks cleaner and less 
error-prone from my point of view.

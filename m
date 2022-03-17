Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04FC4DC41C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 11:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbiCQKmR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 06:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbiCQKmQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 06:42:16 -0400
X-Greylist: delayed 7502 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Mar 2022 03:41:00 PDT
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [IPv6:2001:1600:4:17::190c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EAE1DEAAA
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 03:40:59 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KK3Zx0xMrzMpxcm;
        Thu, 17 Mar 2022 11:40:57 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KK3Zt31x9zljsT7;
        Thu, 17 Mar 2022 11:40:54 +0100 (CET)
Message-ID: <d2ee2504-4daa-18d8-a9c2-083f488984ba@digikod.net>
Date:   Thu, 17 Mar 2022 11:41:38 +0100
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
 <20220221212522.320243-5-mic@digikod.net>
 <CAHC9VhT7+Xm+GCg5BqYQgauKOwRxsxfS5WCj+-HW2w6VpaF=6g@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v1 04/11] landlock: Fix same-layer rule unions
In-Reply-To: <CAHC9VhT7+Xm+GCg5BqYQgauKOwRxsxfS5WCj+-HW2w6VpaF=6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
>> The original behavior was to check if the full set of requested accesses
>> was allowed by at least a rule of every relevant layer.  This didn't
>> take into account requests for multiple accesses and same-layer rules
>> allowing the union of these accesses in a complementary way.  As a
>> result, multiple accesses requested on a file hierarchy matching rules
>> that, together, allowed these accesses, but without a unique rule
>> allowing all of them, was illegitimately denied.  This case should be
>> rare in practice and it can only be triggered by the path_rename or
>> file_open hook implementations.
>>
>> For instance, if, for the same layer, a rule allows execution
>> beneath /a/b and another rule allows read beneath /a, requesting access
>> to read and execute at the same time for /a/b should be allowed for this
>> layer.
>>
>> This was an inconsistency because the union of same-layer rule accesses
>> was already allowed if requested once at a time anyway.
>>
>> This fix changes the way allowed accesses are gathered over a path walk.
>> To take into account all these rule accesses, we store in a matrix all
>> layer granting the set of requested accesses, according to the handled
>> accesses.  To avoid heap allocation, we use an array on the stack which
>> is 2*13 bytes.  A following commit bringing the LANDLOCK_ACCESS_FS_REFER
>> access right will increase this size to reach 84 bytes (2*14*3) in case
>> of link or rename actions.
>>
>> Add a new layout1.layer_rule_unions test to check that accesses from
>> different rules pertaining to the same layer are ORed in a file
>> hierarchy.  Also test that it is not the case for rules from different
>> layers.
>>
>> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
>> Link: https://lore.kernel.org/r/20220221212522.320243-5-mic@digikod.net
>> ---
>>   security/landlock/fs.c                     |  77 ++++++++++-----
>>   security/landlock/ruleset.h                |   2 +
>>   tools/testing/selftests/landlock/fs_test.c | 107 +++++++++++++++++++++
>>   3 files changed, 160 insertions(+), 26 deletions(-)
>>
>> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
>> index 0bcb27f2360a..9662f9fb3cd0 100644
>> --- a/security/landlock/fs.c
>> +++ b/security/landlock/fs.c
>> @@ -204,45 +204,66 @@ static inline const struct landlock_rule *find_rule(
>>          return rule;
>>   }
>>
>> -static inline layer_mask_t unmask_layers(
>> -               const struct landlock_rule *const rule,
>> -               const access_mask_t access_request, layer_mask_t layer_mask)
>> +/*
>> + * @layer_masks is read and may be updated according to the access request and
>> + * the matching rule.
>> + *
>> + * Returns true if the request is allowed (i.e. relevant layer masks for the
>> + * request are empty).
>> + */
>> +static inline bool unmask_layers(const struct landlock_rule *const rule,
>> +               const access_mask_t access_request,
>> +               layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS])
>>   {
>>          size_t layer_level;
>>
>> +       if (!access_request || !layer_masks)
>> +               return true;
>>          if (!rule)
>> -               return layer_mask;
>> +               return false;
>>
>>          /*
>>           * An access is granted if, for each policy layer, at least one rule
>> -        * encountered on the pathwalk grants the requested accesses,
>> -        * regardless of their position in the layer stack.  We must then check
>> +        * encountered on the pathwalk grants the requested access,
>> +        * regardless of its position in the layer stack.  We must then check
>>           * the remaining layers for each inode, from the first added layer to
>> -        * the last one.
>> +        * the last one.  When there is multiple requested accesses, for each
>> +        * policy layer, the full set of requested accesses may not be granted
>> +        * by only one rule, but by the union (binary OR) of multiple rules.
>> +        * E.g. /a/b <execute> + /a <read> = /a/b <execute + read>
>>           */
>>          for (layer_level = 0; layer_level < rule->num_layers; layer_level++) {
>>                  const struct landlock_layer *const layer =
>>                          &rule->layers[layer_level];
>>                  const layer_mask_t layer_bit = BIT_ULL(layer->level - 1);
>> +               const unsigned long access_req = access_request;
>> +               unsigned long access_bit;
>> +               bool is_empty;
>>
>> -               /* Checks that the layer grants access to the full request. */
>> -               if ((layer->access & access_request) == access_request) {
>> -                       layer_mask &= ~layer_bit;
>> -
>> -                       if (layer_mask == 0)
>> -                               return layer_mask;
>> +               /*
>> +                * Records in @layer_masks which layer grants access to each
>> +                * requested access.
>> +                */
>> +               is_empty = true;
>> +               for_each_set_bit(access_bit, &access_req,
>> +                               ARRAY_SIZE(*layer_masks)) {
>> +                       if (layer->access & BIT_ULL(access_bit))
>> +                               (*layer_masks)[access_bit] &= ~layer_bit;
>> +                       is_empty = is_empty && !(*layer_masks)[access_bit];
> 
>>From what I can see the only reason not to return immediately once
> @is_empty is true is the need to update @layer_masks.  However, the
> only caller that I can see (up to patch 4/11) is check_access_path()
> which thanks to this patch no longer needs to reference @layer_masks
> after the call to unmask_layers() returns true.  Assuming that to be
> the case, is there a reason we can't return immediately after finding
> @is_empty true, or am I missing something?

Because @is_empty is initialized to true, and because each access 
right/bit must be checked by this loop, we cannot return earlier than 
the following if statement. Not returning in this loop also makes this 
helper safer (for potential future use) because @layer_mask will never 
be partially updated, which could lead to an inconsistent state. 
Moreover finishing this bits check loop makes the code simpler and have 
a negligible performance impact.


> 
> 
>>                  }
>> +               if (is_empty)
>> +                       return true;
>>          }
>> -       return layer_mask;
>> +       return false;
>>   }
>>
>>   static int check_access_path(const struct landlock_ruleset *const domain,
>>                  const struct path *const path,
>>                  const access_mask_t access_request)
>>   {
>> -       bool allowed = false;
>> +       layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
>> +       bool allowed = false, has_access = false;
>>          struct path walker_path;
>> -       layer_mask_t layer_mask;
>>          size_t i;
>>
>>          if (!access_request)
>> @@ -262,13 +283,20 @@ static int check_access_path(const struct landlock_ruleset *const domain,
>>                  return -EACCES;
>>
>>          /* Saves all layers handling a subset of requested accesses. */
>> -       layer_mask = 0;
>>          for (i = 0; i < domain->num_layers; i++) {
>> -               if (domain->fs_access_masks[i] & access_request)
>> -                       layer_mask |= BIT_ULL(i);
>> +               const unsigned long access_req = access_request;
>> +               unsigned long access_bit;
>> +
>> +               for_each_set_bit(access_bit, &access_req,
>> +                               ARRAY_SIZE(layer_masks)) {
>> +                       if (domain->fs_access_masks[i] & BIT_ULL(access_bit)) {
>> +                               layer_masks[access_bit] |= BIT_ULL(i);
>> +                               has_access = true;
>> +                       }
>> +               }
>>          }
>>          /* An access request not handled by the domain is allowed. */
>> -       if (layer_mask == 0)
>> +       if (!has_access)
>>                  return 0;
>>
>>          walker_path = *path;
>> @@ -280,14 +308,11 @@ static int check_access_path(const struct landlock_ruleset *const domain,
>>          while (true) {
>>                  struct dentry *parent_dentry;
>>
>> -               layer_mask = unmask_layers(find_rule(domain,
>> -                                       walker_path.dentry), access_request,
>> -                               layer_mask);
>> -               if (layer_mask == 0) {
>> +               allowed = unmask_layers(find_rule(domain, walker_path.dentry),
>> +                               access_request, &layer_masks);
>> +               if (allowed)
>>                          /* Stops when a rule from each layer grants access. */
>> -                       allowed = true;
>>                          break;
>> -               }
>>
>>   jump_up:
>>                  if (walker_path.dentry == walker_path.mnt->mnt_root) {
> 
> --
> paul-moore.com

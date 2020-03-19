Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 173B218BD49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 17:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgCSQ7A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 12:59:00 -0400
Received: from smtp-42ae.mail.infomaniak.ch ([84.16.66.174]:42269 "EHLO
        smtp-42ae.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727146AbgCSQ66 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 12:58:58 -0400
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 48jtR3525rzlhKm9;
        Thu, 19 Mar 2020 17:58:55 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 48jtR0633TzljLrP;
        Thu, 19 Mar 2020 17:58:52 +0100 (CET)
Subject: Re: [RFC PATCH v14 00/10] Landlock LSM
To:     Jann Horn <jannh@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <20200224160215.4136-1-mic@digikod.net>
 <CAG48ez21bEn0wL1bbmTiiu8j9jP5iEWtHOwz4tURUJ+ki0ydYw@mail.gmail.com>
 <873d7419-bdd9-8a52-0a9b-dddbe31df4f9@digikod.net>
 <CAG48ez0=0W5Ok-8nASqZrZ28JboXRRi3gDxV5u6mdcOtzwuRVA@mail.gmail.com>
 <688dda0f-0907-34eb-c19e-3e9e5f613a74@digikod.net>
 <CAG48ez16yT+zbK1WPxr2TnxrifW5c2DnpFLbWRRLUT_WpuFNmw@mail.gmail.com>
 <e8530226-f295-a897-1132-7e6970dad49f@digikod.net>
 <CAG48ez1K-7Lq2Ep_p9fOvXQ-fwj_8dA1CFd5SVDbT4ccqejDzA@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <2d48e3e3-e7b2-ec33-91c5-be6a308a12d4@digikod.net>
Date:   Thu, 19 Mar 2020 17:58:52 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CAG48ez1K-7Lq2Ep_p9fOvXQ-fwj_8dA1CFd5SVDbT4ccqejDzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 19/03/2020 00:33, Jann Horn wrote:
> On Wed, Mar 18, 2020 at 1:06 PM Mickaël Salaün <mic@digikod.net> wrote:
>> On 17/03/2020 20:45, Jann Horn wrote:
>>> On Tue, Mar 17, 2020 at 6:50 PM Mickaël Salaün <mic@digikod.net> wrote:
>>>> On 17/03/2020 17:19, Jann Horn wrote:
>>>>> On Thu, Mar 12, 2020 at 12:38 AM Mickaël Salaün <mic@digikod.net> wrote:
>>>>>> On 10/03/2020 00:44, Jann Horn wrote:
>>>>>>> On Mon, Feb 24, 2020 at 5:03 PM Mickaël Salaün <mic@digikod.net> wrote:
>>>>
>>>> [...]
>>>>
>>>>>>> Aside from those things, there is also a major correctness issue where
>>>>>>> I'm not sure how to solve it properly:
>>>>>>>
>>>>>>> Let's say a process installs a filter on itself like this:
>>>>>>>
>>>>>>> struct landlock_attr_ruleset ruleset = { .handled_access_fs =
>>>>>>> ACCESS_FS_ROUGHLY_WRITE};
>>>>>>> int ruleset_fd = landlock(LANDLOCK_CMD_CREATE_RULESET,
>>>>>>> LANDLOCK_OPT_CREATE_RULESET, sizeof(ruleset), &ruleset);
>>>>>>> struct landlock_attr_path_beneath path_beneath = {
>>>>>>>   .ruleset_fd = ruleset_fd,
>>>>>>>   .allowed_access = ACCESS_FS_ROUGHLY_WRITE,
>>>>>>>   .parent_fd = open("/tmp/foobar", O_PATH),
>>>>>>> };
>>>>>>> landlock(LANDLOCK_CMD_ADD_RULE, LANDLOCK_OPT_ADD_RULE_PATH_BENEATH,
>>>>>>> sizeof(path_beneath), &path_beneath);
>>>>>>> prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
>>>>>>> struct landlock_attr_enforce attr_enforce = { .ruleset_fd = ruleset_fd };
>>>>>>> landlock(LANDLOCK_CMD_ENFORCE_RULESET, LANDLOCK_OPT_ENFORCE_RULESET,
>>>>>>> sizeof(attr_enforce), &attr_enforce);
>>>>>>>
>>>>>>> At this point, the process is not supposed to be able to write to
>>>>>>> anything outside /tmp/foobar, right? But what happens if the process
>>>>>>> does the following next?
>>>>>>>
>>>>>>> struct landlock_attr_ruleset ruleset = { .handled_access_fs =
>>>>>>> ACCESS_FS_ROUGHLY_WRITE};
>>>>>>> int ruleset_fd = landlock(LANDLOCK_CMD_CREATE_RULESET,
>>>>>>> LANDLOCK_OPT_CREATE_RULESET, sizeof(ruleset), &ruleset);
>>>>>>> struct landlock_attr_path_beneath path_beneath = {
>>>>>>>   .ruleset_fd = ruleset_fd,
>>>>>>>   .allowed_access = ACCESS_FS_ROUGHLY_WRITE,
>>>>>>>   .parent_fd = open("/", O_PATH),
>>>>>>> };
>>>>>>> landlock(LANDLOCK_CMD_ADD_RULE, LANDLOCK_OPT_ADD_RULE_PATH_BENEATH,
>>>>>>> sizeof(path_beneath), &path_beneath);
>>>>>>> prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
>>>>>>> struct landlock_attr_enforce attr_enforce = { .ruleset_fd = ruleset_fd };
>>>>>>> landlock(LANDLOCK_CMD_ENFORCE_RULESET, LANDLOCK_OPT_ENFORCE_RULESET,
>>>>>>> sizeof(attr_enforce), &attr_enforce);
>>>>>>>
>>>>>>> As far as I can tell from looking at the source, after this, you will
>>>>>>> have write access to the entire filesystem again. I think the idea is
>>>>>>> that LANDLOCK_CMD_ENFORCE_RULESET should only let you drop privileges,
>>>>>>> not increase them, right?
>>>>>>
>>>>>> There is an additionnal check in syscall.c:get_path_from_fd(): it is
>>>>>> forbidden to add a rule with a path which is not accessible (according
>>>>>> to LANDLOCK_ACCESS_FS_OPEN) thanks to a call to security_file_open(),
>>>>>> but this is definitely not perfect.
>>>>>
>>>>> Ah, I missed that.
>>>>>
>>>>>>> I think the easy way to fix this would be to add a bitmask to each
>>>>>>> rule that says from which ruleset it originally comes, and then let
>>>>>>> check_access_path() collect these bitmasks from each rule with OR, and
>>>>>>> check at the end whether the resulting bitmask is full - if not, at
>>>>>>> least one of the rulesets did not permit the access, and it should be
>>>>>>> denied.
>>>>>>>
>>>>>>> But maybe it would make more sense to change how the API works
>>>>>>> instead, and get rid of the concept of "merging" two rulesets
>>>>>>> together? Instead, we could make the API work like this:
>>>>>>>
>>>>>>>  - LANDLOCK_CMD_CREATE_RULESET gives you a file descriptor whose
>>>>>>> ->private_data contains a pointer to the old ruleset of the process,
>>>>>>> as well as a pointer to a new empty ruleset.
>>>>>>>  - LANDLOCK_CMD_ADD_RULE fails if the specified rule would not be
>>>>>>> permitted by the old ruleset, then adds the rule to the new ruleset
>>>>>>>  - LANDLOCK_CMD_ENFORCE_RULESET fails if the old ruleset pointer in
>>>>>>> ->private_data doesn't match the current ruleset of the process, then
>>>>>>> replaces the old ruleset with the new ruleset.
>>>>>>>
>>>>>>> With this, the new ruleset is guaranteed to be a subset of the old
>>>>>>> ruleset because each of the new ruleset's rules is permitted by the
>>>>>>> old ruleset. (Unless the directory hierarchy rotates, but in that case
>>>>>>> the inaccuracy isn't much worse than what would've been possible
>>>>>>> through RCU path walk anyway AFAIK.)
>>>>>>>
>>>>>>> What do you think?
>>>>>>>
>>>>>>
>>>>>> I would prefer to add the same checks you described at first (with
>>>>>> check_access_path), but only when creating a new ruleset with
>>>>>> merge_ruleset() (which should probably be renamed). This enables not to
>>>>>> rely on a parent ruleset/domain until the enforcement, which is the case
>>>>>> anyway.
>>>>>> Unfortunately this doesn't work for some cases with bind mounts. Because
>>>>>> check_access_path() goes through one path, another (bind mounted) path
>>>>>> could be illegitimately allowed.
>>>>>
>>>>> Hmm... I'm not sure what you mean. At the moment, landlock doesn't
>>>>> allow any sandboxed process to change the mount hierarchy, right? Can
>>>>> you give an example where this would go wrong?
>>>>
>>>> Indeed, a Landlocked process must no be able to change its mount
>>>> namespace layout. However, bind mounts may already exist.
>>>> Let's say a process sandbox itself to only access /a in a read-write
>>>> way.
>>>
>>> So, first policy:
>>>
>>> /a RW
>>>
>>>> Then, this process (or one of its children) add a new restriction
>>>> on /a/b to only be able to read this hierarchy.
>>>
>>> You mean with the second policy looking like this?
>>
>> Right.
>>
>>>
>>> /a RW
>>> /a/b R
>>>
>>> Then the resulting policy would be:
>>>
>>> /a RW policy_bitmask=0x00000003 (bits 0 and 1 set)
>>> /a/b R policy_bitmask=0x00000002 (bit 1 set)
>>> required_bits=0x00000003 (bits 0 and 1 set)
>>>
>>>> The check at insertion
>>>> time would allow this because this access right is a subset of the
>>>> access right allowed with the parent directory. However, If /a/b is bind
>>>> mounted somewhere else, let's say in /private/b, then the second
>>>> enforcement just gave new access rights to this hierarchy too.
>>>
>>> But with the solution I proposed, landlock's path walk would see
>>> something like this when accessing a file at /private/b/foo:
>>> /private/b/foo <no rules>
>>>   policies seen until now: 0x00000000
>>> /private/b <access: R, policy_bitmask=0x00000002>
>>>   policies seen until now: 0x00000002
>>> /private <no rules>
>>>   policies seen until now: 0x00000002
>>> / <no rules>
>>>   policies seen until now: 0x00000002
>>>
>>> It wouldn't encounter any rule from the first policy, so the OR of the
>>> seen policy bitmasks would be 0x00000002, which is not the required
>>> value 0x00000003, and so the access would be denied.
>> As I understand your proposition, we need to build the required_bits
>> when adding a rule or enforcing/merging a ruleset with a domain. The
>> issue is that a rule only refers to a struct inode, not a struct path.
>> For your proposition to work, we would need to walk through the file
>> path when adding a rule to a ruleset, which means that we need to depend
>> of the current view of the process (i.e. its mount namespace), and its
>> Landlock domain.
> 
> I don't see why that is necessary. Why would we have to walk the file
> path when adding a rule?
> 
>> If the required_bits field is set when the ruleset is
>> merged with the domain, it is not possible anymore to walk through the
>> corresponding initial file path, which makes the enforcement step too
>> late to check for such consistency. The important point is that a
>> ruleset/domain doesn't have a notion of file hierarchy, a ruleset is
>> only a set of tagged inodes.
>>
>> I'm not sure I got your proposition right, though. When and how would
>> you generate the required_bits?
> 
> Using your terminology:
> A domain is a collection of N layers, which are assigned indices 0..N-1.
> For each possible access type, a domain has a bitmask containing N
> bits that stores which layers control that access type. (Basically a
> per-layer version of fs_access_mask.)

OK, so there is a bit for each domain, which means that you get a limit
of, let's say 64 layers? Knowing that each layer can be created by a
standalone application, potentially nested in a bunch of layers, this
seems artificially limiting.

> To validate an access, you start by ORing together the bitmasks for
> the requested access types; that gives you the required_bits mask,
> which lists all layers that want to control the access.
> Then you set seen_policy_bits=0, then do the
> check_access_path_continue() loop while keeping track of which layers
> you've seen with "seen_policy_bits |= access->contributing_policies",
> or something like that.
> And in the end, you check that seen_policy_bits is a superset of
> required_bits - something like `(~seen_policy_bits) & required_bits ==
> 0`.
> 
> AFAICS to create a new domain from a bunch of layers, you wouldn't
> have to do any path walking.

Right, I misunderstood your previous email.

> 
>> Here is my updated proposition: add a layer level and a depth to each
>> rule (once enforced/merged with a domain), and a top layer level for a
>> domain. When enforcing a ruleset (i.e. merging a ruleset into the
>> current domain), the layer level of a new rule would be the incremented
>> top layer level.
>> If there is no rule (from this domain) tied to the same
>> inode, then the depth of the new rule is 1. However, if there is already
>> a rule tied to the same inode and if this rule's layer level is the
>> previous top layer level, then the depth and the layer level are both
>> incremented and the rule is updated with the new access rights (boolean
>> AND).
>>
>> The policy looks like this:
>> domain top_layer=2
>> /a RW policy_bitmask=0x00000003 layer=1 depth=1
>> /a/b R policy_bitmask=0x00000002 layer=2 depth=1
>>
>> The path walk access check walks through all inodes and start with a
>> layer counter equal to the top layer of the current domain. For each
>> encountered inode tied to a rule, the access rights are checked and a
>> new check ensures that the layer of the matching rule is the same as the
>> counter (this may be a merged ruleset containing rules pertaining to the
>> same hierarchy, which is fine) or equal to the decremented counter (i.e.
>> the path walk just reached the underlying layer). If the path walk
>> encounter a rule with a layer strictly less than the counter minus one,
>> there is a whole in the layers which means that the ruleset
>> hierarchy/subset does not match, and the access must be denied.
>>
>> When accessing a file at /private/b/foo for a read access:
>> /private/b/foo <no rules>
>>   allowed_access=unknown layer_counter=2
>> /private/b <access: R, policy_bitmask=0x00000002, layer=2, depth=1>
>>   allowed_access=allowed layer_counter=2
>> /private <no rules>
>>   allowed_access=allowed layer_counter=2
>> / <no rules>
>>   allowed_access=allowed layer_counter=2
>>
>> Because the layer_counter didn't reach 1, the access request is then denied.
>>
>> This proposition enables not to rely on a parent ruleset at first, only
>> when enforcing/merging a ruleset with a domain. This also solves the
>> issue with multiple inherited/nested rules on the same inode (in which
>> case the depth just grows). Moreover, this enables to safely stop the
>> path walk as soon as we reach the layer 1.
> 
> (FWIW, you could do the same optimization with the seen_policy_bits approach.)
> 
> I guess the difference between your proposal and mine is that in my
> proposal, the following would work, in effect permitting W access to
> /foo/bar/baz (and nothing else)?
> 
> first ruleset:
>   /foo W
> second ruleset:
>   /foo/bar/baz W
> third ruleset:
>   /foo/bar W
> 
> whereas in your proposal, IIUC it wouldn't be valid for a new ruleset
> to whitelist a superset of what was whitelisted in a previous ruleset?
> 

This behavior seems dangerous because a process which sandbox itself to
only access /foo/bar W can bypass the restrictions from one of its
parent domains (i.e. only access /foo/bar/baz W). Indeed, each layer is
(most of the time) a different and standalone security policy.

To sum up, the bitmask approach doesn't have the notion of layers
ordering. It is then not possible to check that a rule comes from a
domain which is the direct ancestor of a child's domain. I want each
policy/layer to be really nested in the sense that a process sandboxing
itself can only add more restriction to itself with regard to its parent
domain (and the whole hierarchy). This is a similar approach to
seccomp-bpf (with chained filters), except there is almost no overhead
to nest several policies/layers together because they are flattened.
Using the layer level and depth approach enables to implement this.

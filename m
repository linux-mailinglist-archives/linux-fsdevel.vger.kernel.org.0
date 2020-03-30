Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8744019835C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 20:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgC3S0W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 14:26:22 -0400
Received: from smtp-42ab.mail.infomaniak.ch ([84.16.66.171]:49537 "EHLO
        smtp-42ab.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727370AbgC3S0W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:26:22 -0400
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 48rgrq4vzNzlj4P7;
        Mon, 30 Mar 2020 20:26:19 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 48rgrm6YdPzllGSS;
        Mon, 30 Mar 2020 20:26:16 +0200 (CEST)
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
 <2d48e3e3-e7b2-ec33-91c5-be6a308a12d4@digikod.net>
 <CAG48ez18LrDVLdp3agTwHNYxOBJyEb5PZ1dkwbNjpPVQoTsLcA@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <e07fe473-1801-01cc-12ae-b3167f95250e@digikod.net>
Date:   Mon, 30 Mar 2020 20:26:03 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CAG48ez18LrDVLdp3agTwHNYxOBJyEb5PZ1dkwbNjpPVQoTsLcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 19/03/2020 22:17, Jann Horn wrote:
> On Thu, Mar 19, 2020 at 5:58 PM Mickaël Salaün <mic@digikod.net> wrote:
>> On 19/03/2020 00:33, Jann Horn wrote:
>>> On Wed, Mar 18, 2020 at 1:06 PM Mickaël Salaün <mic@digikod.net> wrote:
> [...]
>>>> As I understand your proposition, we need to build the required_bits
>>>> when adding a rule or enforcing/merging a ruleset with a domain. The
>>>> issue is that a rule only refers to a struct inode, not a struct path.
>>>> For your proposition to work, we would need to walk through the file
>>>> path when adding a rule to a ruleset, which means that we need to depend
>>>> of the current view of the process (i.e. its mount namespace), and its
>>>> Landlock domain.
>>>
>>> I don't see why that is necessary. Why would we have to walk the file
>>> path when adding a rule?
>>>
>>>> If the required_bits field is set when the ruleset is
>>>> merged with the domain, it is not possible anymore to walk through the
>>>> corresponding initial file path, which makes the enforcement step too
>>>> late to check for such consistency. The important point is that a
>>>> ruleset/domain doesn't have a notion of file hierarchy, a ruleset is
>>>> only a set of tagged inodes.
>>>>
>>>> I'm not sure I got your proposition right, though. When and how would
>>>> you generate the required_bits?
>>>
>>> Using your terminology:
>>> A domain is a collection of N layers, which are assigned indices 0..N-1.
>>> For each possible access type, a domain has a bitmask containing N
>>> bits that stores which layers control that access type. (Basically a
>>> per-layer version of fs_access_mask.)
>>
>> OK, so there is a bit for each domain, which means that you get a limit
>> of, let's say 64 layers? Knowing that each layer can be created by a
>> standalone application, potentially nested in a bunch of layers, this
>> seems artificially limiting.
> 
> Yes, that is a downside of my approach.
> 
>>> To validate an access, you start by ORing together the bitmasks for
>>> the requested access types; that gives you the required_bits mask,
>>> which lists all layers that want to control the access.
>>> Then you set seen_policy_bits=0, then do the
>>> check_access_path_continue() loop while keeping track of which layers
>>> you've seen with "seen_policy_bits |= access->contributing_policies",
>>> or something like that.
>>> And in the end, you check that seen_policy_bits is a superset of
>>> required_bits - something like `(~seen_policy_bits) & required_bits ==
>>> 0`.
>>>
>>> AFAICS to create a new domain from a bunch of layers, you wouldn't
>>> have to do any path walking.
>>
>> Right, I misunderstood your previous email.
>>
>>>
>>>> Here is my updated proposition: add a layer level and a depth to each
>>>> rule (once enforced/merged with a domain), and a top layer level for a
>>>> domain. When enforcing a ruleset (i.e. merging a ruleset into the
>>>> current domain), the layer level of a new rule would be the incremented
>>>> top layer level.
>>>> If there is no rule (from this domain) tied to the same
>>>> inode, then the depth of the new rule is 1. However, if there is already
>>>> a rule tied to the same inode and if this rule's layer level is the
>>>> previous top layer level, then the depth and the layer level are both
>>>> incremented and the rule is updated with the new access rights (boolean
>>>> AND).
>>>>
>>>> The policy looks like this:
>>>> domain top_layer=2
>>>> /a RW policy_bitmask=0x00000003 layer=1 depth=1
>>>> /a/b R policy_bitmask=0x00000002 layer=2 depth=1
>>>>
>>>> The path walk access check walks through all inodes and start with a
>>>> layer counter equal to the top layer of the current domain. For each
>>>> encountered inode tied to a rule, the access rights are checked and a
>>>> new check ensures that the layer of the matching rule is the same as the
>>>> counter (this may be a merged ruleset containing rules pertaining to the
>>>> same hierarchy, which is fine) or equal to the decremented counter (i.e.
>>>> the path walk just reached the underlying layer). If the path walk
>>>> encounter a rule with a layer strictly less than the counter minus one,
>>>> there is a whole in the layers which means that the ruleset
>>>> hierarchy/subset does not match, and the access must be denied.
>>>>
>>>> When accessing a file at /private/b/foo for a read access:
>>>> /private/b/foo <no rules>
>>>>   allowed_access=unknown layer_counter=2
>>>> /private/b <access: R, policy_bitmask=0x00000002, layer=2, depth=1>
>>>>   allowed_access=allowed layer_counter=2
>>>> /private <no rules>
>>>>   allowed_access=allowed layer_counter=2
>>>> / <no rules>
>>>>   allowed_access=allowed layer_counter=2
>>>>
>>>> Because the layer_counter didn't reach 1, the access request is then denied.
>>>>
>>>> This proposition enables not to rely on a parent ruleset at first, only
>>>> when enforcing/merging a ruleset with a domain. This also solves the
>>>> issue with multiple inherited/nested rules on the same inode (in which
>>>> case the depth just grows). Moreover, this enables to safely stop the
>>>> path walk as soon as we reach the layer 1.
>>>
>>> (FWIW, you could do the same optimization with the seen_policy_bits approach.)
>>>
>>> I guess the difference between your proposal and mine is that in my
>>> proposal, the following would work, in effect permitting W access to
>>> /foo/bar/baz (and nothing else)?
>>>
>>> first ruleset:
>>>   /foo W
>>> second ruleset:
>>>   /foo/bar/baz W
>>> third ruleset:
>>>   /foo/bar W
>>>
>>> whereas in your proposal, IIUC it wouldn't be valid for a new ruleset
>>> to whitelist a superset of what was whitelisted in a previous ruleset?
>>>
>>
>> This behavior seems dangerous because a process which sandbox itself to
>> only access /foo/bar W can bypass the restrictions from one of its
>> parent domains (i.e. only access /foo/bar/baz W). Indeed, each layer is
>> (most of the time) a different and standalone security policy.
> 
> It isn't actually bypassing the restriction: You still can't actually
> access files like /foo/bar/blah, because a path walk from there
> doesn't encounter any rules from the second ruleset.

Right, this use case is legitimate, e.g. first giving access to
~/Downloads and then another layer giving access to ~/ (because it
doesn't know about the current restriction).

I think that neither my initial approach nor yours fit well, but I found
a new one inspired from both approaches. The first solution I gave, and
since implemented in the v15 [1], can manage 2^31-1 layers but it only
works when refining a security policy *knowing the parent one* (i.e.
refining an access tied to an inode, not a full file hierarchy). Instead
of having a layer level and a layer depth, my new implementation (for
v16) use a layer bitfield for each rule (and ruleset). We still AND
access rights when merging rulesets, but instead of storing the last
layer lever and depth, we set the corresponding bit in the layer
bitfield of the rule. This way we don't consume more memory than the v15
implementation (for 64 layers top, which would be 64 bits * number of
access types with your approach, i.e. between 1KB and 2KB) and Landlock
can properly manage supersets of access rights in nested hierarchies,
whatever their stacking order. However, I don't see another solution to
better handle more than 64 layers than a VLA, but that could come later.

[1] https://lore.kernel.org/lkml/20200326202731.693608-6-mic@digikod.net/

> 
>> To sum up, the bitmask approach doesn't have the notion of layers
>> ordering. It is then not possible to check that a rule comes from a
>> domain which is the direct ancestor of a child's domain. I want each
>> policy/layer to be really nested in the sense that a process sandboxing
>> itself can only add more restriction to itself with regard to its parent
>> domain (and the whole hierarchy). This is a similar approach to
>> seccomp-bpf (with chained filters), except there is almost no overhead
>> to nest several policies/layers together because they are flattened.
>> Using the layer level and depth approach enables to implement this.
> 

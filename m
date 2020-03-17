Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 666A4188C7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 18:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgCQRuP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 13:50:15 -0400
Received: from smtp-190d.mail.infomaniak.ch ([185.125.25.13]:35011 "EHLO
        smtp-190d.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726148AbgCQRuO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:50:14 -0400
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 564B9100470DA;
        Tue, 17 Mar 2020 18:50:10 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (ns3096276.ip-94-23-54.eu [94.23.54.103])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 48hgg42QGMzlt0RM;
        Tue, 17 Mar 2020 18:50:08 +0100 (CET)
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
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <688dda0f-0907-34eb-c19e-3e9e5f613a74@digikod.net>
Date:   Tue, 17 Mar 2020 18:50:07 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CAG48ez0=0W5Ok-8nASqZrZ28JboXRRi3gDxV5u6mdcOtzwuRVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 17/03/2020 17:19, Jann Horn wrote:
> On Thu, Mar 12, 2020 at 12:38 AM Mickaël Salaün <mic@digikod.net> wrote:
>> On 10/03/2020 00:44, Jann Horn wrote:
>>> On Mon, Feb 24, 2020 at 5:03 PM Mickaël Salaün <mic@digikod.net> wrote:

[...]

>>> Aside from those things, there is also a major correctness issue where
>>> I'm not sure how to solve it properly:
>>>
>>> Let's say a process installs a filter on itself like this:
>>>
>>> struct landlock_attr_ruleset ruleset = { .handled_access_fs =
>>> ACCESS_FS_ROUGHLY_WRITE};
>>> int ruleset_fd = landlock(LANDLOCK_CMD_CREATE_RULESET,
>>> LANDLOCK_OPT_CREATE_RULESET, sizeof(ruleset), &ruleset);
>>> struct landlock_attr_path_beneath path_beneath = {
>>>   .ruleset_fd = ruleset_fd,
>>>   .allowed_access = ACCESS_FS_ROUGHLY_WRITE,
>>>   .parent_fd = open("/tmp/foobar", O_PATH),
>>> };
>>> landlock(LANDLOCK_CMD_ADD_RULE, LANDLOCK_OPT_ADD_RULE_PATH_BENEATH,
>>> sizeof(path_beneath), &path_beneath);
>>> prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
>>> struct landlock_attr_enforce attr_enforce = { .ruleset_fd = ruleset_fd };
>>> landlock(LANDLOCK_CMD_ENFORCE_RULESET, LANDLOCK_OPT_ENFORCE_RULESET,
>>> sizeof(attr_enforce), &attr_enforce);
>>>
>>> At this point, the process is not supposed to be able to write to
>>> anything outside /tmp/foobar, right? But what happens if the process
>>> does the following next?
>>>
>>> struct landlock_attr_ruleset ruleset = { .handled_access_fs =
>>> ACCESS_FS_ROUGHLY_WRITE};
>>> int ruleset_fd = landlock(LANDLOCK_CMD_CREATE_RULESET,
>>> LANDLOCK_OPT_CREATE_RULESET, sizeof(ruleset), &ruleset);
>>> struct landlock_attr_path_beneath path_beneath = {
>>>   .ruleset_fd = ruleset_fd,
>>>   .allowed_access = ACCESS_FS_ROUGHLY_WRITE,
>>>   .parent_fd = open("/", O_PATH),
>>> };
>>> landlock(LANDLOCK_CMD_ADD_RULE, LANDLOCK_OPT_ADD_RULE_PATH_BENEATH,
>>> sizeof(path_beneath), &path_beneath);
>>> prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
>>> struct landlock_attr_enforce attr_enforce = { .ruleset_fd = ruleset_fd };
>>> landlock(LANDLOCK_CMD_ENFORCE_RULESET, LANDLOCK_OPT_ENFORCE_RULESET,
>>> sizeof(attr_enforce), &attr_enforce);
>>>
>>> As far as I can tell from looking at the source, after this, you will
>>> have write access to the entire filesystem again. I think the idea is
>>> that LANDLOCK_CMD_ENFORCE_RULESET should only let you drop privileges,
>>> not increase them, right?
>>
>> There is an additionnal check in syscall.c:get_path_from_fd(): it is
>> forbidden to add a rule with a path which is not accessible (according
>> to LANDLOCK_ACCESS_FS_OPEN) thanks to a call to security_file_open(),
>> but this is definitely not perfect.
> 
> Ah, I missed that.
> 
>>> I think the easy way to fix this would be to add a bitmask to each
>>> rule that says from which ruleset it originally comes, and then let
>>> check_access_path() collect these bitmasks from each rule with OR, and
>>> check at the end whether the resulting bitmask is full - if not, at
>>> least one of the rulesets did not permit the access, and it should be
>>> denied.
>>>
>>> But maybe it would make more sense to change how the API works
>>> instead, and get rid of the concept of "merging" two rulesets
>>> together? Instead, we could make the API work like this:
>>>
>>>  - LANDLOCK_CMD_CREATE_RULESET gives you a file descriptor whose
>>> ->private_data contains a pointer to the old ruleset of the process,
>>> as well as a pointer to a new empty ruleset.
>>>  - LANDLOCK_CMD_ADD_RULE fails if the specified rule would not be
>>> permitted by the old ruleset, then adds the rule to the new ruleset
>>>  - LANDLOCK_CMD_ENFORCE_RULESET fails if the old ruleset pointer in
>>> ->private_data doesn't match the current ruleset of the process, then
>>> replaces the old ruleset with the new ruleset.
>>>
>>> With this, the new ruleset is guaranteed to be a subset of the old
>>> ruleset because each of the new ruleset's rules is permitted by the
>>> old ruleset. (Unless the directory hierarchy rotates, but in that case
>>> the inaccuracy isn't much worse than what would've been possible
>>> through RCU path walk anyway AFAIK.)
>>>
>>> What do you think?
>>>
>>
>> I would prefer to add the same checks you described at first (with
>> check_access_path), but only when creating a new ruleset with
>> merge_ruleset() (which should probably be renamed). This enables not to
>> rely on a parent ruleset/domain until the enforcement, which is the case
>> anyway.
>> Unfortunately this doesn't work for some cases with bind mounts. Because
>> check_access_path() goes through one path, another (bind mounted) path
>> could be illegitimately allowed.
> 
> Hmm... I'm not sure what you mean. At the moment, landlock doesn't
> allow any sandboxed process to change the mount hierarchy, right? Can
> you give an example where this would go wrong?

Indeed, a Landlocked process must no be able to change its mount
namespace layout. However, bind mounts may already exist.
Let's say a process sandbox itself to only access /a in a read-write
way. Then, this process (or one of its children) add a new restriction
on /a/b to only be able to read this hierarchy. The check at insertion
time would allow this because this access right is a subset of the
access right allowed with the parent directory. However, If /a/b is bind
mounted somewhere else, let's say in /private/b, then the second
enforcement just gave new access rights to this hierarchy too. This is
why it seems risky to rely on a check about the legitimacy of a new
access right when adding it to a ruleset or when enforcing it.


> 
>> That makes the problem a bit more complicated. A solution may be to keep
>> track of the hierarchy of each rule (e.g. with a layer/depth number),
>> and only allow an access request if at least a rule of each layer allow
>> this access. In this case we also need to correctly handle the case when
>> rules from different layers are tied to the same object.
> 

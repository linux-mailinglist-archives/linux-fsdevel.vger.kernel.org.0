Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 793221825F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 00:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731502AbgCKXin (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 19:38:43 -0400
Received: from smtp-42ab.mail.infomaniak.ch ([84.16.66.171]:54697 "EHLO
        smtp-42ab.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731506AbgCKXin (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 19:38:43 -0400
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id AC4E6100351F7;
        Thu, 12 Mar 2020 00:38:39 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 48d7gx0FMFzlmRkW;
        Thu, 12 Mar 2020 00:38:36 +0100 (CET)
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
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <873d7419-bdd9-8a52-0a9b-dddbe31df4f9@digikod.net>
Date:   Thu, 12 Mar 2020 00:38:21 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CAG48ez21bEn0wL1bbmTiiu8j9jP5iEWtHOwz4tURUJ+ki0ydYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 10/03/2020 00:44, Jann Horn wrote:
> On Mon, Feb 24, 2020 at 5:03 PM Mickaël Salaün <mic@digikod.net> wrote:
>> This new version of Landlock is a major revamp of the previous series
>> [1], hence the RFC tag.  The three main changes are the replacement of
>> eBPF with a dedicated safe management of access rules, the replacement
>> of the use of seccomp(2) with a dedicated syscall, and the management of
>> filesystem access-control (back from the v10).
>>
>> As discussed in [2], eBPF may be too powerful and dangerous to be put in
>> the hand of unprivileged and potentially malicious processes, especially
>> because of side-channel attacks against access-controls or other parts
>> of the kernel.
>>
>> Thanks to this new implementation (1540 SLOC), designed from the ground
>> to be used by unprivileged processes, this series enables a process to
>> sandbox itself without requiring CAP_SYS_ADMIN, but only the
>> no_new_privs constraint (like seccomp).  Not relying on eBPF also
>> enables to improve performances, especially for stacked security
>> policies thanks to mergeable rulesets.
>>
>> The compiled documentation is available here:
>> https://landlock.io/linux-doc/landlock-v14/security/landlock/index.html
>>
>> This series can be applied on top of v5.6-rc3.  This can be tested with
>> CONFIG_SECURITY_LANDLOCK and CONFIG_SAMPLE_LANDLOCK.  This patch series
>> can be found in a Git repository here:
>> https://github.com/landlock-lsm/linux/commits/landlock-v14
>> I would really appreciate constructive comments on the design and the code.
> 
> I've looked through the patchset, and I think that it would be
> possible to simplify it quite a bit. I have tried to do that (and
> compiled-tested it, but not actually tried running it); here's what I
> came up with:
> 
> https://github.com/thejh/linux/commits/landlock-mod
> 
> The three modified patches (patches 1, 2 and 5) are marked with
> "[MODIFIED]" in their title. Please take a look - what do you think?
> Feel free to integrate my changes into your patches if you think they
> make sense.

Regarding the landlock_release_inodes(), the final wait_var_event() is
indeed needed (as does fsnotify), but why do you use a READ_ONCE() for
landlock_initialized?

I was reluctant to use function pointers but landlock_object_operations
makes a cleaner and more generic interface to manage objects.

Your get_inode_object() is much simpler and easier to understand than
the get_object() and get_cleaner().
The other main change is about the object cross-reference: you entirely
removed it, which means that an object will only be free when there are
no rules using it. This does not free an object when its underlying
object is being terminated. We now only have to worry about the
termination of the parent of an underlying object (e.g. the super-block
of an inode).

However, I think you forgot to increment object->usage in
create_ruleset_elem(). There is also an unused checked_mask variable in
merge_ruleset().

All this removes optimizations that made the code more difficult to
understand. The performance difference is negligible, and I think that
the memory footprint is fine.
These optimizations (and others) could be discussed later. I'm
integrating most of your changes in the next patch series.

Thank you very much for this review and the code.

> 
> 
> Apart from simplifying the code, I also found the following issues,
> which I have fixed in the modified patches:
> 
> put_hierarchy() has to drop a reference on its parent. (However, this
> must not recurse, so we have to do it with a loop.)

Right, fixed.

> 
> put_ruleset() is not in an RCU read-side critical section, so as soon
> as it calls kfree_rcu(), "freeme" might disappear; but "orig" is in
> "freeme", so when the loop tries to find the next element with
> rb_next(orig), that can be a UAF.
> rbtree_postorder_for_each_entry_safe() exists for dealing with such
> issues.

Good catch.

> 
> AFAIK the calls to rb_erase() in clean_ruleset() is not safe if
> someone is concurrently accessing the rbtree as an RCU reader, because
> concurrent rotations can prevent a lookup from succeeding. The
> simplest fix is probably to just make any rbtree that has been
> installed on a process immutable, and give up on the cleaning -
> arguably the memory wastage that can cause is pretty limited.

Yes, let's go for immutable domains.

> (By the
> way, as a future optimization, we might want to turn the rbtree into a
> hashtable when installing it?)

Definitely. This was a previous (private) implementation I did for
domains, but to simplify the code I reused the same type as a ruleset. A
future evolution of Landlock could add back this optimization.

> 
> The iput() in landlock_release_inode() looks unsafe - you need to
> guarantee that even if the deletion of a ruleset races with
> generic_shutdown_super(), every iput() for that superblock finishes
> before landlock_release_inodes() returns, even if the iput() is
> happening in the context of ruleset deletion. This is why
> fsnotify_unmount_inodes() has that wait_var_event() at the end.

Right, much better with that.

> 
> 
> Aside from those things, there is also a major correctness issue where
> I'm not sure how to solve it properly:
> 
> Let's say a process installs a filter on itself like this:
> 
> struct landlock_attr_ruleset ruleset = { .handled_access_fs =
> ACCESS_FS_ROUGHLY_WRITE};
> int ruleset_fd = landlock(LANDLOCK_CMD_CREATE_RULESET,
> LANDLOCK_OPT_CREATE_RULESET, sizeof(ruleset), &ruleset);
> struct landlock_attr_path_beneath path_beneath = {
>   .ruleset_fd = ruleset_fd,
>   .allowed_access = ACCESS_FS_ROUGHLY_WRITE,
>   .parent_fd = open("/tmp/foobar", O_PATH),
> };
> landlock(LANDLOCK_CMD_ADD_RULE, LANDLOCK_OPT_ADD_RULE_PATH_BENEATH,
> sizeof(path_beneath), &path_beneath);
> prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
> struct landlock_attr_enforce attr_enforce = { .ruleset_fd = ruleset_fd };
> landlock(LANDLOCK_CMD_ENFORCE_RULESET, LANDLOCK_OPT_ENFORCE_RULESET,
> sizeof(attr_enforce), &attr_enforce);
> 
> At this point, the process is not supposed to be able to write to
> anything outside /tmp/foobar, right? But what happens if the process
> does the following next?
> 
> struct landlock_attr_ruleset ruleset = { .handled_access_fs =
> ACCESS_FS_ROUGHLY_WRITE};
> int ruleset_fd = landlock(LANDLOCK_CMD_CREATE_RULESET,
> LANDLOCK_OPT_CREATE_RULESET, sizeof(ruleset), &ruleset);
> struct landlock_attr_path_beneath path_beneath = {
>   .ruleset_fd = ruleset_fd,
>   .allowed_access = ACCESS_FS_ROUGHLY_WRITE,
>   .parent_fd = open("/", O_PATH),
> };
> landlock(LANDLOCK_CMD_ADD_RULE, LANDLOCK_OPT_ADD_RULE_PATH_BENEATH,
> sizeof(path_beneath), &path_beneath);
> prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
> struct landlock_attr_enforce attr_enforce = { .ruleset_fd = ruleset_fd };
> landlock(LANDLOCK_CMD_ENFORCE_RULESET, LANDLOCK_OPT_ENFORCE_RULESET,
> sizeof(attr_enforce), &attr_enforce);
> 
> As far as I can tell from looking at the source, after this, you will
> have write access to the entire filesystem again. I think the idea is
> that LANDLOCK_CMD_ENFORCE_RULESET should only let you drop privileges,
> not increase them, right?

There is an additionnal check in syscall.c:get_path_from_fd(): it is
forbidden to add a rule with a path which is not accessible (according
to LANDLOCK_ACCESS_FS_OPEN) thanks to a call to security_file_open(),
but this is definitely not perfect.

> 
> I think the easy way to fix this would be to add a bitmask to each
> rule that says from which ruleset it originally comes, and then let
> check_access_path() collect these bitmasks from each rule with OR, and
> check at the end whether the resulting bitmask is full - if not, at
> least one of the rulesets did not permit the access, and it should be
> denied.
> 
> But maybe it would make more sense to change how the API works
> instead, and get rid of the concept of "merging" two rulesets
> together? Instead, we could make the API work like this:
> 
>  - LANDLOCK_CMD_CREATE_RULESET gives you a file descriptor whose
> ->private_data contains a pointer to the old ruleset of the process,
> as well as a pointer to a new empty ruleset.
>  - LANDLOCK_CMD_ADD_RULE fails if the specified rule would not be
> permitted by the old ruleset, then adds the rule to the new ruleset
>  - LANDLOCK_CMD_ENFORCE_RULESET fails if the old ruleset pointer in
> ->private_data doesn't match the current ruleset of the process, then
> replaces the old ruleset with the new ruleset.
> 
> With this, the new ruleset is guaranteed to be a subset of the old
> ruleset because each of the new ruleset's rules is permitted by the
> old ruleset. (Unless the directory hierarchy rotates, but in that case
> the inaccuracy isn't much worse than what would've been possible
> through RCU path walk anyway AFAIK.)
> 
> What do you think?
> 

I would prefer to add the same checks you described at first (with
check_access_path), but only when creating a new ruleset with
merge_ruleset() (which should probably be renamed). This enables not to
rely on a parent ruleset/domain until the enforcement, which is the case
anyway.
Unfortunately this doesn't work for some cases with bind mounts. Because
check_access_path() goes through one path, another (bind mounted) path
could be illegitimately allowed.
That makes the problem a bit more complicated. A solution may be to keep
track of the hierarchy of each rule (e.g. with a layer/depth number),
and only allow an access request if at least a rule of each layer allow
this access. In this case we also need to correctly handle the case when
rules from different layers are tied to the same object.

I would like Landlock to have "pure" syscalls, in the sense that a
process A (e.g. a daemon) could prepare a ruleset and sends its FD to a
process B which would then be able to use it to sandbox itself. I think
it makes the reasoning clearer not to have a given ruleset (FD) tied to
a domain (i.e. parent ruleset) at first.
Landlock should (as much as possible) return an error if a syscall
argument is invalid, not according to the current access control (which
is not the case currently because of the security_file_open() check).
This means that these additional merge_ruleset() checks should only
affect the new domain/ruleset, but it should not be visible to userspace.

In a future evolution, it may be useful to add a lock/seal command to
deny any additional rule enforcement. However that may be
counter-productive because that enable application developers (e.g. for
a shell) to deny the use of Landlock features to its child processes.
But it would be possible anyway with seccomp-bpf…

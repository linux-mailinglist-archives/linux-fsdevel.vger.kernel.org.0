Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41292F8E33
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Jan 2021 18:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbhAPRSS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Jan 2021 12:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbhAPRSR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Jan 2021 12:18:17 -0500
X-Greylist: delayed 166615 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 16 Jan 2021 09:17:32 PST
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [IPv6:2001:1600:3:17::42af])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58642C061573
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Jan 2021 09:17:32 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DJ4Th0JkRzMqHHH;
        Sat, 16 Jan 2021 18:16:40 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4DJ4Tc5tpwzlh8TM;
        Sat, 16 Jan 2021 18:16:36 +0100 (CET)
Subject: Re: [PATCH v26 07/12] landlock: Support filesystem access-control
To:     Jann Horn <jannh@google.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20201209192839.1396820-1-mic@digikod.net>
 <20201209192839.1396820-8-mic@digikod.net>
 <CAG48ez1wbAQwU-eoC9DngHyUM_5F01MJQpRnLaJFvfRUrnXBdA@mail.gmail.com>
 <aeb3e152-8108-89d2-0577-4b130368f14f@digikod.net>
 <CAG48ez2HJCFvmFALDYDYnufE755Dqh3JquAMf-1mnzmRrdKaoQ@mail.gmail.com>
 <9be6481f-9c03-dd32-378f-20bc7c52315c@digikod.net>
 <CAG48ez1O0VTwEiRd3KqexoF78WR+cmP5bGk5Kh5Cs7aPepiDVg@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <28d2a149-0fe0-764b-85b3-6f979d1dd931@digikod.net>
Date:   Sat, 16 Jan 2021 18:16:57 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CAG48ez1O0VTwEiRd3KqexoF78WR+cmP5bGk5Kh5Cs7aPepiDVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 15/01/2021 19:31, Jann Horn wrote:
> On Fri, Jan 15, 2021 at 10:10 AM Mickaël Salaün <mic@digikod.net> wrote:
>> On 14/01/2021 23:43, Jann Horn wrote:
>>> On Thu, Jan 14, 2021 at 7:54 PM Mickaël Salaün <mic@digikod.net> wrote:
>>>> On 14/01/2021 04:22, Jann Horn wrote:
>>>>> On Wed, Dec 9, 2020 at 8:28 PM Mickaël Salaün <mic@digikod.net> wrote:
>>>>>> Thanks to the Landlock objects and ruleset, it is possible to identify
>>>>>> inodes according to a process's domain.  To enable an unprivileged
>>>>>> process to express a file hierarchy, it first needs to open a directory
>>>>>> (or a file) and pass this file descriptor to the kernel through
>>>>>> landlock_add_rule(2).  When checking if a file access request is
>>>>>> allowed, we walk from the requested dentry to the real root, following
>>>>>> the different mount layers.  The access to each "tagged" inodes are
>>>>>> collected according to their rule layer level, and ANDed to create
>>>>>> access to the requested file hierarchy.  This makes possible to identify
>>>>>> a lot of files without tagging every inodes nor modifying the
>>>>>> filesystem, while still following the view and understanding the user
>>>>>> has from the filesystem.
>>>>>>
>>>>>> Add a new ARCH_EPHEMERAL_INODES for UML because it currently does not
>>>>>> keep the same struct inodes for the same inodes whereas these inodes are
>>>>>> in use.
>>>>>>
>>>>>> This commit adds a minimal set of supported filesystem access-control
>>>>>> which doesn't enable to restrict all file-related actions.  This is the
>>>>>> result of multiple discussions to minimize the code of Landlock to ease
>>>>>> review.  Thanks to the Landlock design, extending this access-control
>>>>>> without breaking user space will not be a problem.  Moreover, seccomp
>>>>>> filters can be used to restrict the use of syscall families which may
>>>>>> not be currently handled by Landlock.
>>>>> [...]
>>>>>> +static bool check_access_path_continue(
>>>>>> +               const struct landlock_ruleset *const domain,
>>>>>> +               const struct path *const path, const u32 access_request,
>>>>>> +               u64 *const layer_mask)
>>>>>> +{
>>>>> [...]
>>>>>> +       /*
>>>>>> +        * An access is granted if, for each policy layer, at least one rule
>>>>>> +        * encountered on the pathwalk grants the access, regardless of their
>>>>>> +        * position in the layer stack.  We must then check not-yet-seen layers
>>>>>> +        * for each inode, from the last one added to the first one.
>>>>>> +        */
>>>>>> +       for (i = 0; i < rule->num_layers; i++) {
>>>>>> +               const struct landlock_layer *const layer = &rule->layers[i];
>>>>>> +               const u64 layer_level = BIT_ULL(layer->level - 1);
>>>>>> +
>>>>>> +               if (!(layer_level & *layer_mask))
>>>>>> +                       continue;
>>>>>> +               if ((layer->access & access_request) != access_request)
>>>>>> +                       return false;
>>>>>> +               *layer_mask &= ~layer_level;
>>>>>
>>>>> Hmm... shouldn't the last 5 lines be replaced by the following?
>>>>>
>>>>> if ((layer->access & access_request) == access_request)
>>>>>     *layer_mask &= ~layer_level;
>>>>>
>>>>> And then, since this function would always return true, you could
>>>>> change its return type to "void".
>>>>>
>>>>>
>>>>> As far as I can tell, the current version will still, if a ruleset
>>>>> looks like this:
>>>>>
>>>>> /usr read+write
>>>>> /usr/lib/ read
>>>>>
>>>>> reject write access to /usr/lib, right?
>>>>
>>>> If these two rules are from different layers, then yes it would work as
>>>> intended. However, if these rules are from the same layer the path walk
>>>> will not stop at /usr/lib but go down to /usr, which grants write
>>>> access.
>>>
>>> I don't see why the code would do what you're saying it does. And an
>>> experiment seems to confirm what I said; I checked out landlock-v26,
>>> and the behavior I get is:
>>
>> There is a misunderstanding, I was responding to your proposition to
>> modify check_access_path_continue(), not about the behavior of landlock-v26.
>>
>>>
>>> user@vm:~/landlock$ dd if=/dev/null of=/tmp/aaa
>>> 0+0 records in
>>> 0+0 records out
>>> 0 bytes copied, 0.00106365 s, 0.0 kB/s
>>> user@vm:~/landlock$ LL_FS_RO='/lib' LL_FS_RW='/' ./sandboxer dd
>>> if=/dev/null of=/tmp/aaa
>>> 0+0 records in
>>> 0+0 records out
>>> 0 bytes copied, 0.000491814 s, 0.0 kB/s
>>> user@vm:~/landlock$ LL_FS_RO='/tmp' LL_FS_RW='/' ./sandboxer dd
>>> if=/dev/null of=/tmp/aaa
>>> dd: failed to open '/tmp/aaa': Permission denied
>>> user@vm:~/landlock$
>>>
>>> Granting read access to /tmp prevents writing to it, even though write
>>> access was granted to /.
>>>
>>
>> It indeed works like this with landlock-v26. However, with your above
>> proposition, it would work like this:
>>
>> $ LL_FS_RO='/tmp' LL_FS_RW='/' ./sandboxer dd if=/dev/null of=/tmp/aaa
>> 0+0 records in
>> 0+0 records out
>> 0 bytes copied, 0.000187265 s, 0.0 kB/s
>>
>> …which is not what users would expect I guess. :)
> 
> Ah, so we are disagreeing about what the right semantics are. ^^ To
> me, that is exactly the behavior I would expect.
> 
> Imagine that someone wants to write a program that needs to be able to
> load libraries from /usr/lib (including subdirectories) and needs to
> be able to write output to some user-specified output directory. So
> they use something like this to sandbox their program (plus error
> handling):
> 
> static void add_fs_rule(int ruleset_fd, char *path, u64 allowed_access) {
>   int fd = open(path, O_PATH);
>   struct landlock_path_beneath_attr path_beneath = {
>     .parent_fd = fd,
>     .allowed_access = allowed_access
>   };
>   landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
>           &path_beneath, 0);
>   close(fd);
> }
> int main(int argc, char **argv) {
>   char *output_dir = argv[1];
>   int ruleset_fd = landlock_create_ruleset(&ruleset_attr,
> sizeof(ruleset_attr, 0);
>   add_fs_rule(ruleset_fd, "/usr/lib", ACCESS_FS_ROUGHLY_READ);
>   add_fs_rule(ruleset_fd, output_dir,
> LANDLOCK_ACCESS_FS_WRITE_FILE|LANDLOCK_ACCESS_FS_MAKE_REG|LANDLOCK_ACCESS_FS_REMOVE_FILE);
>   prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
>   landlock_enforce_ruleset_current(ruleset_fd, 0);
> }
> 
> This will *almost* always work; but if the output directory is
> /usr/lib/x86_64-linux-gnu/ , loading libraries from that directory
> won't work anymore, right? So if userspace wanted this to *always*
> works correctly, it would have to somehow figure out whether there is
> a path upwards from the output directory (under any mount) that will
> encounter /usr/lib, and set different permissions if that is the case.
> That seems unnecessarily messy to me; and I think that this will make
> it harder for generic commandline tools and such to adopt landlock.
> 
> 
> If you do want to have the ability to deny access to subtrees of trees
> to which access is permitted, I think that that should be made
> explicit in the UAPI - e.g. you could (at a later point, after this
> series has landed) introduce a new EXCLUDE flag for
> landlock_add_rule() that means "I want to deny the access specified by
> this rule", or something like that. (And you'd have to very carefully
> document under which circumstances such rules are actually effective -
> e.g. if someone grants full access to $HOME, but excludes $HOME/.ssh,
> an attacker would still be able to rename $HOME/.ssh to $HOME/old_ssh,
> and then if the program is later restarted and creates the ruleset
> from scratch again, the old SSH folder will be accessible.)
> 

OK, it's indeed a more pragmatic approach. I'll take your change and
merge check_access_path_continue() with check_access_path(). Thanks!

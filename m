Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA9229E972
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 11:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgJ2Krr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 06:47:47 -0400
Received: from smtp-1909.mail.infomaniak.ch ([185.125.25.9]:38913 "EHLO
        smtp-1909.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725774AbgJ2Krq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:47:46 -0400
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CMMbM18Dqzlhss3;
        Thu, 29 Oct 2020 11:47:43 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4CMMbK0FgSzlh8TT;
        Thu, 29 Oct 2020 11:47:41 +0100 (CET)
Subject: Re: [PATCH v22 07/12] landlock: Support filesystem access-control
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
References: <20201027200358.557003-1-mic@digikod.net>
 <20201027200358.557003-8-mic@digikod.net>
 <CAG48ez1xMfxkwhXK4b1BB4GrTVauNzfwPoCutn9axKt_PFRSVQ@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <341f2e5d-1d7f-e1d7-b982-0135dfc276e3@digikod.net>
Date:   Thu, 29 Oct 2020 11:47:40 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CAG48ez1xMfxkwhXK4b1BB4GrTVauNzfwPoCutn9axKt_PFRSVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 29/10/2020 02:06, Jann Horn wrote:
> (On Tue, Oct 27, 2020 at 9:04 PM Mickaël Salaün <mic@digikod.net> wrote:
>> Thanks to the Landlock objects and ruleset, it is possible to identify
>> inodes according to a process's domain.  To enable an unprivileged
>> process to express a file hierarchy, it first needs to open a directory
>> (or a file) and pass this file descriptor to the kernel through
>> landlock_add_rule(2).  When checking if a file access request is
>> allowed, we walk from the requested dentry to the real root, following
>> the different mount layers.  The access to each "tagged" inodes are
>> collected according to their rule layer level, and ANDed to create
>> access to the requested file hierarchy.  This makes possible to identify
>> a lot of files without tagging every inodes nor modifying the
>> filesystem, while still following the view and understanding the user
>> has from the filesystem.
>>
>> Add a new ARCH_EPHEMERAL_INODES for UML because it currently does not
>> keep the same struct inodes for the same inodes whereas these inodes are
>> in use.
>>
>> This commit adds a minimal set of supported filesystem access-control
>> which doesn't enable to restrict all file-related actions.  This is the
>> result of multiple discussions to minimize the code of Landlock to ease
>> review.  Thanks to the Landlock design, extending this access-control
>> without breaking user space will not be a problem.  Moreover, seccomp
>> filters can be used to restrict the use of syscall families which may
>> not be currently handled by Landlock.
> [...]
>> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> [...]
>> +/**
>> + * DOC: fs_access
>> + *
>> + * A set of actions on kernel objects may be defined by an attribute (e.g.
>> + * &struct landlock_path_beneath_attr) including a bitmask of access.
>> + *
>> + * Filesystem flags
>> + * ~~~~~~~~~~~~~~~~
>> + *
>> + * These flags enable to restrict a sandbox process to a set of actions on
> 
> s/sandbox/sandboxed/

OK

> 
> [...]
>> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> [...]
>> +static const struct landlock_object_underops landlock_fs_underops = {
>> +       .release = release_inode
>> +};
> [...]
>> +/* Access-control management */
>> +
>> +static bool check_access_path_continue(
>> +               const struct landlock_ruleset *const domain,
>> +               const struct path *const path, const u32 access_request,
>> +               bool *const allow, u64 *const layer_mask)
>> +{
>> +       const struct landlock_rule *rule;
>> +       const struct inode *inode;
>> +       bool next = true;
>> +
>> +       prefetch(path->dentry->d_parent);
> 
> IIRC software prefetch() turned out to only rarely actually have a
> performance benefit, and they often actually make things worse; see
> e.g. <https://lwn.net/Articles/444336/>. Unless you have strong
> evidence that this actually brings a performance benefit, I'd probably
> get rid of this.

I took inspiration from the fs/d_path.c:prepend_path() but I agree. I'll
remove prefetch() calls in the next series. I'll add them later if a
benchmark shows an interesting performance impact.

> 
>> +       if (d_is_negative(path->dentry))
>> +               /* Continues to walk while there is no mapped inode. */
>> +               return true;
>> +       inode = d_backing_inode(path->dentry);
>> +       rcu_read_lock();
>> +       rule = landlock_find_rule(domain,
>> +                       rcu_dereference(landlock_inode(inode)->object));
>> +       rcu_read_unlock();
>> +
>> +       /* Checks for matching layers. */
>> +       if (rule && (rule->layers | *layer_mask)) {
>> +               *allow = (rule->access & access_request) == access_request;
>> +               if (*allow) {
>> +                       *layer_mask &= ~rule->layers;
>> +                       /* Stops when a rule from each layer granted access. */
>> +                       next = !!*layer_mask;
>> +               } else {
>> +                       next = false;
>> +               }
>> +       }
>> +       return next;
>> +}
>> +
>> +static int check_access_path(const struct landlock_ruleset *const domain,
>> +               const struct path *const path, u32 access_request)
>> +{
>> +       bool allow = false;
>> +       struct path walker_path;
>> +       u64 layer_mask;
>> +
>> +       if (WARN_ON_ONCE(!domain || !path))
>> +               return 0;
>> +       /*
>> +        * Allows access to pseudo filesystems that will never be mountable
>> +        * (e.g. sockfs, pipefs), but can still be reachable through
>> +        * /proc/self/fd .
>> +        */
>> +       if ((path->dentry->d_sb->s_flags & SB_NOUSER) ||
>> +                       (d_is_positive(path->dentry) &&
>> +                        unlikely(IS_PRIVATE(d_backing_inode(path->dentry)))))
>> +               return 0;
>> +       if (WARN_ON_ONCE(domain->nb_layers < 1))
>> +               return -EACCES;
>> +
>> +       layer_mask = GENMASK_ULL(domain->nb_layers - 1, 0);
>> +       /*
>> +        * An access request which is not handled by the domain should be
>> +        * allowed.
>> +        */
>> +       access_request &= domain->fs_access_mask;
>> +       if (access_request == 0)
>> +               return 0;
>> +       walker_path = *path;
>> +       path_get(&walker_path);
>> +       /*
>> +        * We need to walk through all the hierarchy to not miss any relevant
>> +        * restriction.
>> +        */
>> +       while (check_access_path_continue(domain, &walker_path, access_request,
>> +                               &allow, &layer_mask)) {
> 
> The logic in this code might be clearer if
> check_access_path_continue() just returns whether the rule permitted
> the access. Then it'd look like:
> 
> bool allow = false;
> [...]
> while (check_access_path_continue(domain, &walker_path,
> access_request, &layer_mask)) {
>   if (layer_mask == 0) {
>     allow = true;
>     break;
>   }
>   [...]
> }
> 
> I think that would make it clearer under which conditions we can end
> up returning "true" from check_access_path().
> 
> (The current code also looks correct to me, I just think it'd be
> clearer this way. If you disagree, you can keep it as-is.)

I agree, applied and tested.

> 
> 
>> +               struct dentry *parent_dentry;
>> +
>> +jump_up:
>> +               /*
>> +                * Does not work with orphaned/private mounts like overlayfs
>> +                * layers for now (cf. ovl_path_real() and ovl_path_open()).
>> +                */
>> +               if (walker_path.dentry == walker_path.mnt->mnt_root) {
>> +                       if (follow_up(&walker_path)) {
>> +                               /* Ignores hidden mount points. */
>> +                               goto jump_up;
>> +                       } else {
>> +                               /*
>> +                                * Stops at the real root.  Denies access
>> +                                * because not all layers have granted access.
>> +                                */
>> +                               allow = false;
>> +                               break;
>> +                       }
>> +               }
>> +               if (unlikely(IS_ROOT(walker_path.dentry))) {
>> +                       /*
>> +                        * Stops at disconnected root directories.  Only allows
>> +                        * access to internal filesystems (e.g. nsfs which is
>> +                        * reachable through /proc/self/ns).
>> +                        */
>> +                       allow = !!(walker_path.mnt->mnt_flags & MNT_INTERNAL);
>> +                       break;
>> +               }
>> +               parent_dentry = dget_parent(walker_path.dentry);
>> +               dput(walker_path.dentry);
>> +               walker_path.dentry = parent_dentry;
>> +       }
>> +       path_put(&walker_path);
>> +       return allow ? 0 : -EACCES;
>> +}
> [...]
>> +static inline u32 get_file_access(const struct file *const file)
>> +{
>> +       u32 access = 0;
>> +
>> +       if (file->f_mode & FMODE_READ) {
>> +               /* A directory can only be opened in read mode. */
>> +               if (S_ISDIR(file_inode(file)->i_mode))
>> +                       return LANDLOCK_ACCESS_FS_READ_DIR;
>> +               access = LANDLOCK_ACCESS_FS_READ_FILE;
>> +       }
>> +       /*
>> +        * A LANDLOCK_ACCESS_FS_APPEND could be added but we also need to check
>> +        * fcntl(2).
>> +        */
> 
> Once https://lore.kernel.org/linux-api/20200831153207.GO3265@brightrain.aerifal.cx/
> lands, pwritev2() with RWF_NOAPPEND will also be problematic for
> classifying "write" vs "append"; you may want to include that in the
> comment. (Or delete the comment.)

Right, I'll include it in the comment.

> 
>> +       if (file->f_mode & FMODE_WRITE)
>> +               access |= LANDLOCK_ACCESS_FS_WRITE_FILE;
>> +       /* __FMODE_EXEC is indeed part of f_flags, not f_mode. */
>> +       if (file->f_flags & __FMODE_EXEC)
>> +               access |= LANDLOCK_ACCESS_FS_EXECUTE;
>> +       return access;
>> +}
> [...]
> 

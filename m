Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346D83F7DFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Aug 2021 23:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbhHYVvj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Aug 2021 17:51:39 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57106 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhHYVvh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Aug 2021 17:51:37 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id E0ADC1F416A7
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.com>, Linux API <linux-api@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        David Howells <dhowells@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Bobrowski <repnop@google.com>, kernel@collabora.com
Subject: Re: [PATCH v6 09/21] fsnotify: Allow events reported with an empty
 inode
Organization: Collabora
References: <20210812214010.3197279-1-krisman@collabora.com>
        <20210812214010.3197279-10-krisman@collabora.com>
        <CAOQ4uxi7otGo6aNNMk9-fVQCx4Q0tDFe7sJaCr6jj1tNtfExTg@mail.gmail.com>
        <87tujdz7u7.fsf@collabora.com>
        <CAOQ4uxhj=UuvT5ZonFD2sgufqWrF9m4XJ19koQ5390GUZ32g7g@mail.gmail.com>
Date:   Wed, 25 Aug 2021 17:50:45 -0400
In-Reply-To: <CAOQ4uxhj=UuvT5ZonFD2sgufqWrF9m4XJ19koQ5390GUZ32g7g@mail.gmail.com>
        (Amir Goldstein's message of "Wed, 25 Aug 2021 22:45:37 +0300")
Message-ID: <87mtp5yz0q.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

> On Wed, Aug 25, 2021 at 9:40 PM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
>>
>> Amir Goldstein <amir73il@gmail.com> writes:
>>
>> > On Fri, Aug 13, 2021 at 12:41 AM Gabriel Krisman Bertazi
>> > <krisman@collabora.com> wrote:
>> >>
>> >> Some file system events (i.e. FS_ERROR) might not be associated with an
>> >> inode.  For these, it makes sense to associate them directly with the
>> >> super block of the file system they apply to.  This patch allows the
>> >> event to be reported with a NULL inode, by recovering the superblock
>> >> directly from the data field, if needed.
>> >>
>> >> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>> >>
>> >> --
>> >> Changes since v5:
>> >>   - add fsnotify_data_sb handle to retrieve sb from the data field. (jan)
>> >> ---
>> >>  fs/notify/fsnotify.c | 16 +++++++++++++---
>> >>  1 file changed, 13 insertions(+), 3 deletions(-)
>> >>
>> >> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
>> >> index 30d422b8c0fc..536db02cb26e 100644
>> >> --- a/fs/notify/fsnotify.c
>> >> +++ b/fs/notify/fsnotify.c
>> >> @@ -98,6 +98,14 @@ void fsnotify_sb_delete(struct super_block *sb)
>> >>         fsnotify_clear_marks_by_sb(sb);
>> >>  }
>> >>
>> >> +static struct super_block *fsnotify_data_sb(const void *data, int data_type)
>> >> +{
>> >> +       struct inode *inode = fsnotify_data_inode(data, data_type);
>> >> +       struct super_block *sb = inode ? inode->i_sb : NULL;
>> >> +
>> >> +       return sb;
>> >> +}
>> >> +
>> >>  /*
>> >>   * Given an inode, first check if we care what happens to our children.  Inotify
>> >>   * and dnotify both tell their parents about events.  If we care about any event
>> >> @@ -455,8 +463,10 @@ static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
>> >>   *             @file_name is relative to
>> >>   * @file_name: optional file name associated with event
>> >>   * @inode:     optional inode associated with event -
>> >> - *             either @dir or @inode must be non-NULL.
>> >> - *             if both are non-NULL event may be reported to both.
>> >> + *             If @dir and @inode are NULL, @data must have a type that
>> >> + *             allows retrieving the file system associated with this
>> >
>> > Irrelevant comment. sb must always be available from @data.
>> >
>> >> + *             event.  if both are non-NULL event may be reported to
>> >> + *             both.
>> >>   * @cookie:    inotify rename cookie
>> >>   */
>> >>  int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>> >> @@ -483,7 +493,7 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>> >>                  */
>> >>                 parent = dir;
>> >>         }
>> >> -       sb = inode->i_sb;
>> >> +       sb = inode ? inode->i_sb : fsnotify_data_sb(data, data_type);
>> >
>> >         const struct path *path = fsnotify_data_path(data, data_type);
>> > +       const struct super_block *sb = fsnotify_data_sb(data, data_type);
>> >
>> > All the games with @data @inode and @dir args are irrelevant to this.
>> > sb should always be available from @data and it does not matter
>> > if fsnotify_data_inode() is the same as @inode, @dir or neither.
>> > All those inodes are anyway on the same sb.
>>
>> Hi Amir,
>>
>> I think this is actually necessary.  I could identify at least one event
>> (FS_CREATE | FS_ISDIR) where fsnotify is invoked with a NULL data field.
>> In that case, fsnotify_dirent is called with a negative dentry from
>> vfs_mkdir().  I'm not sure why exactly the dentry is negative after the
>
> That doesn't sound right at all.
> Are you sure about this?
> Which filesystem was this mkdir called on?

You should be able to reproduce it on top of mainline if you pick only this
patch and do the change you suggested:

 -       sb = inode->i_sb;
 +       sb = fsnotify_data_sb(data, data_type);

And then boot a Debian stable with systemd.  The notification happens on
the cgroup pseudo-filesystem (/sys/fs/cgroup), which is being monitored
by systemd itself.  The event that arrives with a NULL data is telling the
directory /sys/fs/cgroup/*/ about the creation of directory
`init.scope`.

The change above triggers the following null dereference of struct
super_block, since data is NULL.

I will keep looking but you might be able to answer it immediately...

fsnotify was called with:
  data_type=2
  mask=40000100
  data=0
  name=init.scope

The code looks like this:

        fsnotify_mkdir(dir, dentry) {
       	  fsnotify_dirent(inode, dentry, FS_CREATE | FS_ISDIR) {
	    fsnotify_name(dir, mask, d_inode(dentry), &dentry->d_name, 0) {
	      fsnotify(mask, child, FSNOTIFY_EVENT_INODE, dir, name, NULL, cookie);
	    }
	  }
	}

The entire log:

BUG: kernel NULL pointer dereference, address: 00000000000003a8
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: 0000 [#1] SMP PTI
CPU: 3 PID: 1 Comm: systemd Not tainted 5.14.0-rc5- #279
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
RIP: 0010:fsnotify+0x103/0x5e0
Code: 84 c2 04 00 00 83 f8 02 0f 85 c6 04 00 00 48 8b 04 24 31 db 48 85 c0 0f 84 b9 04 00 00 48 8b 48 28 48 85 c9 0f 84 ac 04 00 00 <48> 83 b9 a8 03 00 00 00 0f 84 e3 03 00 00 8b 81 a0 03 00 00 48 85
RSP: 0018:ffffaff800013e18 EFLAGS: 00010246
RAX: 0000000000000026 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffaff800013ca8 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: c0000000ffffefff
R10: 0000000000000001 R11: ffffaff800013c48 R12: ffff9bbb80467778
R13: 0000000040000100 R14: 00000000000001ed R15: 0000000000000000
FS:  00007f2e4d2c4900(0000) GS:ffff9bbbbbd80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000003a8 CR3: 0000000100054000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 ? cgroup_kn_unlock+0x33/0x80
 ? cgroup_mkdir+0x13e/0x410
 vfs_mkdir+0x16e/0x1d0
 do_mkdirat+0x8c/0x100
 do_syscall_64+0x3a/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f2e4da91b07
Code: 1f 40 00 48 8b 05 89 f3 0c 00 64 c7 00 5f 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 53 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 59 f3 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007ffc02877ad8 EFLAGS: 00000202 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00007ffc02877b50 RCX: 00007f2e4da91b07
RDX: 00007ffc02877980 RSI: 00000000000001ed RDI: 00005646df5f01d0
RBP: 00005646de9ed770 R08: 0000000000000001 R09: 0000000000000000
R10: 00005646df5f01c0 R11: 0000000000000202 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ffc02877b50 R15: 00007ffc02877c60
Modules linked in:
CR2: 00000000000003a8
---[ end trace 4642e1d1df9669cb ]---

>
>> mkdir, but it would be possible we are racing with the file removal, I
>
> No. Both vfs_mkdir() and vfs_rmdir() hold the dir inode lock (on
> parent).
>
>> guess?  It might be a bug in fsnotify that this case even happen, but
>> I'm not sure yet.
>
> fsnotify_data_inode() should not be NULL.
> fsnotify_handle_inode_event() passes fsnotify_data_inode() to
> callbacks like audit_watch_handle_event() that checks
> WARN_ON_ONCE(!inode)
>
>>
>> The easiest way around it is what I proposed: just use inode->i_sb if
>> data is NULL.  Since, as you said, data, inode and dir are all on the
>> same superblock, it should work, I think.
>>
>
> It would be papering over another issue.
> I don't mind if we use inode->i_sb as long as we understand the reason
> for what you are reporting.
>
> Please provide more information.



-- 
Gabriel Krisman Bertazi

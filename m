Return-Path: <linux-fsdevel+bounces-46647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADE8A92ED2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 02:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E4D8E503B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 00:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A2D2F509;
	Fri, 18 Apr 2025 00:32:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [121.200.0.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2766C2A1D7;
	Fri, 18 Apr 2025 00:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.200.0.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744936351; cv=none; b=GwBXNPx+JTVz2QQE/ysFCMI2Rn7/obbA/LJclekqwq2h+At+zSNjTHn1x/u3PdX4SO9eKgTKc6Ef9G3bNJAFbCj1SYVY9tE3fEgITl7FBZv6u2anzYGZ9V/+BVt52UvwqQqNjSjgIb7dDRYYd1sNHvBINSjIvHObWkMTDQopX8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744936351; c=relaxed/simple;
	bh=VDqvgDdelzoNTiuQDOMjp5KLYH1YzujBYYv9jUna/P8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uf77+8E7XMR/VSDWn+7e4WwMzB2W246hbLqIbitAG3QKpQYGRZ3hFLA7ZV/TWXP2OOepVZ9IPa9OmE1xdlupzAkpeCF7J/bQQ4D2ML0glppA4Eem1u73d//2G2CdniyVFhK6wB1sHwmEw5RMglG0o/AqhK0kRKHS/r3sqhTAuWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=themaw.net; spf=fail smtp.mailfrom=themaw.net; arc=none smtp.client-ip=121.200.0.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=themaw.net
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp01.aussiebb.com.au (Postfix) with ESMTP id 9F8EE1011C2;
	Fri, 18 Apr 2025 10:31:17 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
	by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mmSAYoky6t-I; Fri, 18 Apr 2025 10:31:17 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
	id 8C399101289; Fri, 18 Apr 2025 10:31:17 +1000 (AEST)
X-Spam-Level: 
Received: from [192.168.0.229] (159-196-82-144.9fc452.per.static.aussiebb.net [159.196.82.144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ian146@aussiebb.com.au)
	by smtp01.aussiebb.com.au (Postfix) with ESMTPSA id EB262100BF1;
	Fri, 18 Apr 2025 10:31:04 +1000 (AEST)
Message-ID: <7980515f-2c5f-4279-bb41-7a3b336a4e26@themaw.net>
Date: Fri, 18 Apr 2025 08:31:03 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
To: Christian Brauner <brauner@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Eric Chanudet <echanude@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Ian Kent <ikent@redhat.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Alexander Larsson <alexl@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>,
 Aishwarya.TCV@arm.com
References: <20250408210350.749901-12-echanude@redhat.com>
 <fbbafa84-f86c-4ea4-8f41-e5ebb51173ed@sirena.org.uk>
 <20250417-wolfsrudel-zubewegt-10514f07d837@brauner>
 <fb566638-a739-41dc-bafc-aa8c74496fa4@themaw.net>
 <20250417-abartig-abfuhr-40e558b85f97@brauner>
 <20250417-outen-dreihundert-7a772f78f685@brauner>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net; keydata=
 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
In-Reply-To: <20250417-outen-dreihundert-7a772f78f685@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/4/25 23:12, Christian Brauner wrote:
> On Thu, Apr 17, 2025 at 01:31:40PM +0200, Christian Brauner wrote:
>> On Thu, Apr 17, 2025 at 06:17:01PM +0800, Ian Kent wrote:
>>> On 17/4/25 17:01, Christian Brauner wrote:
>>>> On Wed, Apr 16, 2025 at 11:11:51PM +0100, Mark Brown wrote:
>>>>> On Tue, Apr 08, 2025 at 04:58:34PM -0400, Eric Chanudet wrote:
>>>>>> Defer releasing the detached file-system when calling namespace_unlock()
>>>>>> during a lazy umount to return faster.
>>>>>>
>>>>>> When requesting MNT_DETACH, the caller does not expect the file-system
>>>>>> to be shut down upon returning from the syscall. Calling
>>>>>> synchronize_rcu_expedited() has a significant cost on RT kernel that
>>>>>> defaults to rcupdate.rcu_normal_after_boot=1. Queue the detached struct
>>>>>> mount in a separate list and put it on a workqueue to run post RCU
>>>>>> grace-period.
>>>>> For the past couple of days we've been seeing failures in a bunch of LTP
>>>>> filesystem related tests on various arm64 systems.  The failures are
>>>>> mostly (I think all) in the form:
>>>>>
>>>>> 20101 10:12:40.378045  tst_test.c:1833: TINFO: === Testing on vfat ===
>>>>> 20102 10:12:40.385091  tst_test.c:1170: TINFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
>>>>> 20103 10:12:40.391032  mkfs.vfat: unable to open /dev/loop0: Device or resource busy
>>>>> 20104 10:12:40.395953  tst_test.c:1170: TBROK: mkfs.vfat failed with exit code 1
>>>>>
>>>>> ie, a failure to stand up the test environment on the loopback device
>>>>> all happening immediately after some other filesystem related test which
>>>>> also used the loop device.  A bisect points to commit a6c7a78f1b6b97
>>>>> which is this, which does look rather relevant.  LTP is obviously being
>>>>> very much an edge case here.
>>>> Hah, here's something I didn't consider and that I should've caught.
>>>>
>>>> Look, on current mainline no matter if MNT_DETACH/UMOUNT_SYNC or
>>>> non-MNT_DETACH/UMOUNT_SYNC. The mntput() calls after the
>>>> synchronize_rcu_expedited() calls will end up in task_work():
>>>>
>>>>           if (likely(!(mnt->mnt.mnt_flags & MNT_INTERNAL))) {
>>>>                   struct task_struct *task = current;
>>>>                   if (likely(!(task->flags & PF_KTHREAD))) {
>>>>                           init_task_work(&mnt->mnt_rcu, __cleanup_mnt);
>>>>                           if (!task_work_add(task, &mnt->mnt_rcu, TWA_RESUME))
>>>>                                   return;
>>>>                   }
>>>>                   if (llist_add(&mnt->mnt_llist, &delayed_mntput_list))
>>>>                           schedule_delayed_work(&delayed_mntput_work, 1);
>>>>                   return;
>>>>           }
>>>>
>>>> because all of those mntput()s are done from the task's contect.
>>>>
>>>> IOW, if userspace does umount(MNT_DETACH) and the task has returned to
>>>> userspace it is guaranteed that all calls to cleanup_mnt() are done.
>>>>
>>>> With your change that simply isn't true anymore. The call to
>>>> queue_rcu_work() will offload those mntput() to be done from a kthread.
>>>> That in turn means all those mntputs end up on the delayed_mntput_work()
>>>> queue. So the mounts aren't cleaned up by the time the task returns to
>>>> userspace.
>>>>
>>>> And that's likely problematic even for the explicit MNT_DETACH use-case
>>>> because it means EBUSY errors are a lot more likely to be seen by
>>>> concurrent mounters especially for loop devices.
>>>>
>>>> And fwiw, this is exactly what I pointed out in a prior posting to this
>>>> patch series.
>>> And I didn't understand what you said then but this problem is more
>>>
>>> understandable to me now.
> I mean I'm saying it could be problematic for the MNT_DETACH case. I'm
> not sure how likely it is. If some process P1 does MNT_DETACH on a loop
> device and then another process P2 wants to use that loop device and
> sess EBUSY then we don't care. That can already happen. But even in this
> case I'm not sure if there aren't subtle ways where this will bite us.
>
> But there's two other problems:
>
> (1) The real issue is with the same process P1 doing stupid stuff that
>      just happened to work. For example if there's code out there that
>      does a MNT_DETACH on a filesystem that uses a loop device
>      immediately followed by the desire to reuse the loop device:
>
>      It doesn't matter whether such code must in theory already be
>      prepared to handle the case of seeing EBUSY after the MNT_DETACH. If
>      this currently just happens to work because we guarantee that the
>      last mntput() and cleanup_mnt() will have been done when the caller
>      returns to userspace it's a uapi break plain and simple.
>
>      This implicit guarantee isn't there anymore after your patch because
>      the final mntput() from is done from the system_unbound_wq which has
>      the consequence that the cleanup_mnt() is done from the
>      delayed_mntput_work workqeueue. And that leads to problem number
>      (2).

This is a bit puzzling to me.


All the mounts in the tree should be unhashed before any of these mntput()

calls so I didn't think it would be found. I'll need to look at the loop

device case to work out how it's finding (or holing onto) the stale mount

and concluding it's busy.


Although there was place I was concerned about:

                 disconnect = disconnect_mount(p, how);
                 if (mnt_has_parent(p)) {
                         mnt_add_count(p->mnt_parent, -1);
                         if (!disconnect) {
                                 /* Don't forget about p */
list_add_tail(&p->mnt_child, &p->mnt_parent->mnt_mounts);
                         } else {
                                 umount_mnt(p);
                         }
                 }

here p ends up not being unhashed so I need to look again at this area and

try and understand the special cases.


>
> (2) If a userspace task is dealing with e.g., a broken NFS server and
>      does a umount(MNT_DETACH) and that NFS server blocks indefinitely
>      then right now it will be the task's problem that called the umount.
>      It will simply hang and pay the price.
>
>      With your patch however, that cleanup_mnt() and the
>      deactivate_super() call it entails will be done from
>      delayed_mntput_work...
>
>      So if there's some userspace process with a broken NFS server and it
>      does umount(MNT_DETACH) it will end up hanging every other
>      umount(MNT_DETACH) on the system because the dealyed_mntput_work
>      workqueue (to my understanding) cannot make progress.
>
>      So in essence this patch to me seems like handing a DOS vector for
>      MNT_DETACH to userspace.

Umm ... this is a really serious problem and can fairly easily happen and

as much as NFS has improved over the years it still happens.


But again, the problem is not so much waiting for rcu-walks to be done as

waiting longer than is needed ...


>
>>>
>>>> But we've also worsened that situation by doing the deferred thing for
>>>> any non-UMOUNT_SYNC. That which includes namespace exit. IOW, if the
>>>> last task in a new mount namespace exits it will drop_collected_mounts()
>>>> without UMOUNT_SYNC because we know that they aren't reachable anymore,
>>>> after all the mount namespace is dead.
>>>>
>>>> But now we defer all cleanup to the kthread which means when the task
>>>> returns to userspace there's still mounts to be cleaned up.
>>> Correct me if I'm wrong but the actual problem is that the mechanism used
>>>
>>> to wait until there are no processes doing an rcu-walk on mounts in the
>>>
>>> discard list is unnecessarily long according to what Eric has seen. So a
>> I think that the current approach is still salvagable but I need to test
>> this and currently LTP doesn't really compile for me.
> I managed to reproduce this and it is like I suspected. I just thought
> "Oh well, if it's not UMOUNT_SYNC then we can just punt this to a
> workqueue." which is obviously not going to work.
>
> If a mount namespace gets cleaned up or if a detached mount tree is
> cleaned up or if audit calls drop_collected_mounts() we obviously don't
> want to defer the unmount. So the fix is to simply restrict this to
> userspace actually requesting MNT_DETACH.
>
> But I'm seeing way more substantial issues with this patch.

Yeah, it's certainly much more difficult than it looks at first sight.


Ian



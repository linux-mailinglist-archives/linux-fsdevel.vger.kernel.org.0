Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B756B6C3708
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 17:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjCUQgd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 12:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCUQgc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:36:32 -0400
X-Greylist: delayed 156933 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Mar 2023 09:36:23 PDT
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A54450FB3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 09:36:22 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Pgy0h5Y0jzMqhLG;
        Tue, 21 Mar 2023 17:36:20 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Pgy0g6shxzMtjgj;
        Tue, 21 Mar 2023 17:36:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1679416580;
        bh=qumkEvsAHLUYGB0O6o8Z2yH2ETlDqnV8tl0GiTv+1+I=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=CerXSfFaHDYxp5vRzazT1ckjFo4WZAXasujEXYp5dTFn8/expMQC4kaDXPekduvA1
         SFQcqjA83CLP8oKUDbti6M78609D6mVmihhBz0NTXIM5UvZhq7ro1QnIg/MU/Cm8Vr
         4512uzd7ekyhfHgVGKWTAvLDIAHtZgCtgxv5TFqo=
Message-ID: <e70f7926-21b6-fbce-c5d6-7b3899555535@digikod.net>
Date:   Tue, 21 Mar 2023 17:36:19 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: Does Landlock not work with eCryptfs?
Content-Language: en-US
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc:     landlock@lists.linux.dev, Tyler Hicks <code@tyhicks.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20230319.2139b35f996f@gnoack.org>
 <c1c9c688-c64d-adf2-cc96-dc2aaaae5944@digikod.net>
 <20230320.c6b83047622f@gnoack.org>
 <5d415985-d6ac-2312-3475-9d117f3be30f@digikod.net>
In-Reply-To: <5d415985-d6ac-2312-3475-9d117f3be30f@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is an inconsistency between ecryptfs_dir_open() and 
ecryptfs_open(). ecryptfs_dir_open() actually checks access right to the 
lower directory, which is why landlocked processes may not access the 
upper directory when reading its content. ecryptfs_open() uses a cache 
for upper files (which could be a problem on its own). The execution 
flow is:

ecryptfs_open() -> ecryptfs_get_lower_file() -> 
ecryptfs_init_lower_file() -> ecryptfs_privileged_open()

In ecryptfs_privileged_open(), the dentry_open() call failed if access 
to the lower file is not allowed by Landlock (or other access-control 
systems). Then wait_for_completion(&req.done) waits for a kernel's 
thread executing ecryptfs_threadfn(), which uses the kernel's credential 
to access the lower file.

I think there are two main solutions to fix this consistency issue:
- store the mounter credentials and uses them instead of the kernel's 
credentials for lower file and directory access checks 
(ecryptfs_dir_open and ecryptfs_threadfn changes);
- use the kernel's credentials for all lower file/dir access check, 
especially in ecryptfs_dir_open().

I think using the mounter credentials makes more sense, is much safer, 
and fits with overlayfs. It may not work in cases where the mounter 
doesn't have access to the lower file hierarchy though.

File creation calls vfs_*() helpers (lower directory) and there is not 
path nor file security hook calls for those, so it works unconditionally.

 From Landlock end users point of view, it makes more sense to grants 
access to a file hierarchy (where access is already allowed) and be 
allowed to access this file hierarchy, whatever it belongs to a specific 
filesystem (and whatever the potential lower file hierarchy, which may 
be unknown to users). This is how it works for overlayfs and I'd like to 
have the same behavior for ecryptfs.


On 20/03/2023 18:21, Mickaël Salaün wrote:
> 
> On 20/03/2023 18:15, Günther Noack wrote:
>> Hello!
>>
>> On Sun, Mar 19, 2023 at 10:00:46PM +0100, Mickaël Salaün wrote:
>>> Hi Günther,
>>>
>>> Thanks for the report, I confirm there is indeed a bug. I tested with a
>>> Debian distro:
>>>
>>> ecryptfs-setup-private --nopwcheck --noautomount
>>> ecryptfs-mount-private
>>> # And then with the kernel's sample/landlock/sandboxer:
>>> LL_FS_RO="/usr" LL_FS_RW="${HOME}/Private" sandboxer ls ~/Private
>>> ls: cannot open directory '/home/user/Private': Permission denied
>>>
>>> Actions other than listing a directory (e.g. creating files/directories,
>>> reading/writing to files) are controlled as expected. The issue might be
>>> that directories' inodes are not the same when listing the content of a
>>> directory or when creating new files/directories (which is weird). My
>>> hypothesis is that Landlock would then deny directory reading because the
>>> directory's inode doesn't match any rule. It might be related to the overlay
>>> nature of ecryptfs.
>>>
>>> Tyler, do you have some idea?
>>
>> I had a hunch, and found out that the example can be made to work by
>> granting the LANDLOCK_ACCESS_FS_READ_DIR right on the place where the
>> *encrypted* version of that home directory lives:
>>
>>     err := landlock.V1.RestrictPaths(
>>             landlock.RODirs(dir),
>>             landlock.PathAccess(llsys.AccessFSReadDir, "/home/.ecryptfs/gnoack/.Private"),
>>     )
>>
>> It does seem a bit like eCryptfs it calling security_file_open() under
>> the hood for the encrypted version of that file? Is that correct?
> 
> Yes, that's right, the lower directory is used to list the content of
> the ecryptfs directory:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ecryptfs/file.c#n112
> iterate_dir(lower_file, …)

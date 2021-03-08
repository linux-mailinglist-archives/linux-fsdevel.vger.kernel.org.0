Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C327D330FF0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 14:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhCHNuK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 08:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhCHNuI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:50:08 -0500
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE426C06174A;
        Mon,  8 Mar 2021 05:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Date:Message-ID:From:Cc:To;
        bh=QCUm7tpkFt2tWdJXz3H3pQyPN4ZzgogYKci/Ic620Ls=; b=P5UH8T8J5PugEckjE/lSnBdNGk
        ZIp4GSiZ2EYkNSsKECvEpdYgOGch+LHL0G9L/vTOlZ9re1EpTFPPpEl9ZUPHmc6uzzL1SJT5PlFTc
        uxLsqJ+0mMQPFFhCfFMDn4ux8qxNmDNL26sFRTMKegt1/yZP8l4/JBnqn70kIg/RTj1a6jTQSIdI2
        qg0905Roi4J1pWtj4O+20ZP7+shw6ET2raBxV6QEOJpYBa6a8zSd9mZWHsn9H5JrrqAmXuwugLWWA
        AlIwWmClCalxrOZwXo3f7SQ1I4uxyO6RaL+axiK9vYQelk+z3Bsl/x2Fo+asOo5htPkLp7bnPljT7
        EAi4cAtwTxoR36E1iOsgaK44DA4paL2b3NseJGbZH/mRdJTXeT6kdXH8p/RouWFTZRLvMOgwSwEd0
        pO55YTy0uox1cwuiSQxFbbA1VZOrNMd7YZUj6mPa69qeAjHW2j6F+J/pUXE/BkeWpR5VIZbgnAGnh
        O+9Q4NgrOJCwqhWMz50K3M5N;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lJGGr-0001cI-5Z; Mon, 08 Mar 2021 13:50:05 +0000
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Drew DeVault <sir@cmpwn.com>, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
References: <20210228002500.11483-1-sir@cmpwn.com>
 <YDr8UihFQ3M469x8@zeniv-ca.linux.org.uk> <C9KSZTRJ2CL6.DWD539LYTVZX@taiga>
 <YDsGzhBzLzSp6nPj@zeniv-ca.linux.org.uk>
 <20210301190259.GC14881@fieldses.org>
From:   Stefan Metzmacher <metze@samba.org>
Subject: Re: [RFC PATCH] fs: introduce mkdirat2 syscall for atomic mkdir
Message-ID: <ce717080-fe7f-06cf-c5ff-93f276496070@samba.org>
Date:   Mon, 8 Mar 2021 14:50:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210301190259.GC14881@fieldses.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Am 01.03.21 um 20:02 schrieb J. Bruce Fields:
> On Sun, Feb 28, 2021 at 02:58:22AM +0000, Al Viro wrote:
>> TBH, I don't understand what are you trying to achieve -
>> what will that mkdir+open combination buy you, especially
>> since that atomicity goes straight out of window if you try
>> to use that on e.g. NFS.  How is the userland supposed to make
>> use of that thing?
> 
> For what it's worth, the RPC that creates a directory can also get a
> filehandle of the new directory, so I don't think there's anything in
> the NFS protocol that would *prevent* implementing this.  (Whether
> that's useful, I don't know.)

The same applies to SMB, there's only a single SMB2/3 Create call,
which is able to create/open files or directories and returns
an open file handle for it.

With an atomic mkdir+open it would be possible have a single round trip
between client and server. It would help on the client, but also for Samba
as a server, as we would be able to skip additional syscalls.

And it would be great to have a way to specify flags similar to O_CREAT
and O_EXCL in order to create a new directory or open an existing one.

It should also be possible to pass in RESOLVE_* flags, so a similar call like openat2()
would be great.

For me openat2() with O_CREAT | O_EXCL | O_DIRECTORY, would be the natural thing to
support, because it's natural in the SMB protocol. But Al seems to hate that and I'm fine
with his arguments against that.

Plus we can't use that anyway as it's currently not rejected with EINVAL,
instead a regular file is created on disk, but -1 ENOTDIR
is returned to userspace.

Currently userspace needs to do something like this in order to be safe for
a given untrusted directory path string (userdirpath) being to be opened
(and created if it doesn't exist):

1. make a copy of userdirpath and call dirname() => dirnameresult
2. make a copy of userdirpath and call basename() => basenameresult
3. call dirfd = openat2(basedirfd, dirnameresult, how = {.flags = O_PATH | O_CLOEXEC, .resolve = RESOLVE_BENEATH});
4. call mkdirat(dirfd, basenameresult, 0755)
5. call close(dirfd)
6. ignore possible EEXIST from mkdirat
7. call fd = openat2(basedirfd, userdirpath, how = { .flags = O_DIRECTORY | O_CLOEXEC, .resolve = RESOLVE_BENEATH});

This requires memory allocations and 4 syscall round trips.

It would be wonderful to just have a single syscall for this.
I'm not sure about the exact details of the API or a possible name
for such a syscall (mkdirat2 seems wrong), but it could look like this:

struct somenewdirsyscall_how {
	__u64 flags; / only O_CLOEXEC, O_CREAT, O_EXCL */
        __u64 mode;
        __u64 resolve;
};

Instead of reusing O_* flags, new defines could also be used.

fd = somenewdirsyscall(basedirfd, userdirpath, how = { .flags = O_CLOEXEC | O_CREAT, .mask = 0755, .resolve = RESOLVE_BENEATH});

What would be a good way forward here?

metze

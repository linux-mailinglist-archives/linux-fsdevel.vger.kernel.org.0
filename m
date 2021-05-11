Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC13A379C20
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 03:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhEKBgL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 21:36:11 -0400
Received: from mout02.posteo.de ([185.67.36.66]:42033 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230035AbhEKBgK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 21:36:10 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id B90C32400E5
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 May 2021 03:35:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1620696903; bh=4Ve6PpcepWnf/1uVXxVGnf1sizBToTxqwyy5FVzOu+s=;
        h=Date:From:To:Cc:Subject:From;
        b=WRKLsztFBL4IdLyV6xPcPzf2PpafXRdeDp27psHYueB/BbmTHCLcfotIjTAIlpfDE
         I11lyPz4E9plZvBxRUn+kT+aPEQgILlVjgycZY6+KykgcP4Xbu2k8PNOqG82Q9OIIn
         ghF4akpgRYTST5+VmiCZ5P+gAeFlGLGuGDibmsnDscVK2pjSeTSxUTY7w9qHb2AnB+
         7RuowuMkVqppliz2x6fHqj8zr62bIOy0kIZ8ZhIqs4cpNM/d9/pU0w1xQaunaPbPAV
         otcVdYrrExe+7atsUQh68xvlP1a3A9VBQ2VPwu+8dJa+FirQHa7f17a1hmJ1G/3vnm
         W2+JcLW7mPA7w==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4FfL872b58z9rxG;
        Tue, 11 May 2021 03:35:03 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 11 May 2021 01:35:02 +0000
From:   Marek <mareksvoboda@posteo.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     jbacik@fusionio.com
Subject: Re: Allow btime to set any value or specify btime
In-Reply-To: <89e65eccbb92bd6418ee33c3d855acdd@posteo.de>
References: <89e65eccbb92bd6418ee33c3d855acdd@posteo.de>
Message-ID: <0e4303ed996223ce648913205fd11d5f@posteo.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Am 11.05.2021 02:37 schrieb Marek:
> Hi,
> 
> 
> since Linux kernel 4.11, btime has been added, but there is no way to
> change btime to a logical behavior.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a528d35e8bfcc521d7cb70aaf03e1bd296c8493f
> 
> This behavior causes users to report errors in user space software.
> Based on this report.
> https://bugzilla.redhat.com/show_bug.cgi?id=1919698
> 
> Users are using user space software in Fedora 33 or 34 and find it
> illogical how user space software and processes set btime.
> 
> Users expect:
> - btime to be lower than mtime when the operating system is first 
> installed
> - when files are changed, e.g. a .txt file in standard text editor,
> btime is no longer updated
> - btime is preserved when copying (file and directory) from source to
> destination
> 
> 
> Unfortunately, the problem cannot be solved from userspace because
> only the Linux kernel is allowed to use btime.
> 
> 
> As you can see in my answer there, I generally found out that there is
> no specification for btime in general.
> 
>> https://pubs.opengroup.org/onlinepubs/009696699/basedefs/xbd_chap04.html#tag_04_07
>> https://pubs.opengroup.org/onlinepubs/007904875/functions/open.html
> 
>> Further applies:
> 
>> If O_CREAT is set and the file did not previously exist, upon 
>> successful completion, open() shall mark for update the st_atime, 
>> st_ctime, and st_mtime fields of the file and the st_ctime and 
>> st_mtime fields of the parent directory.
> 
>> This means that ctime = mtime = atime applies when creating the file.
> 
> 
> If there is no specification then it means that btime can be set from
> user space to any value. That would have been the expected behavior.
> Unfortunately the mistake was made to add btime since Linux kernel
> 4.11 without specifying it.
> 
> There are 2 direct solutions.
> 
> 1)
> Add the expected behavior, that means in the next Linux kernel version
> the kernel can set btime to any value, because btime was not
> specified. No specification means that there is no reason and this
> value can be set freely.
> 
> 2)
> btime will be removed from the official Linux kernel release until a
> specification in general exists. A proposal should be sent to the
> POSIX (or its successor) people to specify btime together.
> 
> 
> My personal suggestion is as you can also see in my answers
> https://bugzilla.redhat.com/show_bug.cgi?id=1919698#c5
> 
>> - preserve btime when copying files and directories to the destination 
>> (this works for cabled transmissions and wireless transmissions)
>> - setting the btime to any value in an existing file and directory 
>> (very important for rsync to make --crtimes command work)
>> - if mtime, ctime and atime is set before btime, does not work there 
>> is an error message
>> - if btime sets after mtime, ctime and atime, does not work there is 
>> an error message
> 
>> The logic must always be that only the Linux kernel can use btime and 
>> btime must always be before mtime, ctime and atime.
> 
> 
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1919698#c7
> 
>> Perhaps an additional solution is also important, the atime and mtime 
>> must not be changed from the user space more, but it works only with 
>> the Linux kernel.
> 
> The standard behavior should be more in line with the real world. My
> very old mother, who is already over 100 years old and therefore older
> than most operating systems. She finds Linux generally not harmonious,
> because Linux creates illogical timestamps for her documents. I also
> have very similar reasons and many of my friends see it the same way.
> This is also why all my family do not use Linux on a daily basis.

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275F8246F1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 19:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbgHQRmw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 13:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729510AbgHQQP0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:15:26 -0400
X-Greylist: delayed 390 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Aug 2020 09:15:24 PDT
Received: from shout02.mail.de (shout02.mail.de [IPv6:2001:868:100:600::217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAF0C061389
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 09:15:24 -0700 (PDT)
Received: from postfix01.mail.de (postfix01.bt.mail.de [10.0.121.125])
        by shout02.mail.de (Postfix) with ESMTP id E9F48C0116;
        Mon, 17 Aug 2020 18:08:44 +0200 (CEST)
Received: from smtp03.mail.de (smtp03.bt.mail.de [10.0.121.213])
        by postfix01.mail.de (Postfix) with ESMTP id 8C8C48014B;
        Mon, 17 Aug 2020 18:08:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
        s=mailde201610; t=1597680524;
        bh=wtN7C8CA0SBhQPRHYCJWPWoCtmyDpGqMWD7XlGkdrVE=;
        h=From:Subject:To:Date:From;
        b=Cx+DcdVMJumm/vvyAULbDHtDQhDv+ZQ6hAgLzhcVVCkjSazcvGapq0gh3xJf9pQcg
         PyRCcxM8CahlmccMHSOmVa1ZM0c3dL2E3Q6vcu0MWX4c1pUIfQF+MJvmZsnxsUzm1I
         Q9LYWZZEHra4DVNQuU6YZbL1YOj+k080qVPaeudY=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp03.mail.de (Postfix) with ESMTPSA id 0B440A10B8;
        Mon, 17 Aug 2020 18:08:43 +0200 (CEST)
From:   Tycho Kirchner <tychokirchner@mail.de>
Subject: fanotify feature request FAN_MARK_PID
To:     amir73il@gmail.com, mbobrowski@mbobrowski.org,
        linux-fsdevel@vger.kernel.org
Message-ID: <dde082eb-b3eb-859e-b442-a65846cff6fa@mail.de>
Date:   Mon, 17 Aug 2020 18:08:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 2832
X-purgate-ID: 154282::1597680524-0000063F-9B277703/0/0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear Amir Goldstein,

Dear Matthew Bobrowski,

Dear developers of the kernel filesystem,

First of all, thanks for your effort in improving Linux, especially your 
work regarding fanotify, which I heavily use in one of my projects:

https://github.com/tycho-kirchner/shournal

For a more scientfic introduction please take a look at
Bashing irreproducibility with shournal
https://doi.org/10.1101/2020.08.03.232843

I wanted to kindly ask you, whether it is possible for you to add 
another feature to fanotify, that is reporting only events of a PID or 
any of its children.
This would be very useful, because especially in the world of 
bioinformatics there is a huge need to automatically and efficiently 
track file events on the shell, that is, you enter a command on the 
shell (bash) and then track, which file events were modified by the 
shell or any of its child-processes.
Right now this is realized in shournal by joining a mount namespace 
which is unique for each entered command and listening to file events of 
these mountpoints using fanotify.
This works great so far in most cases, but joining another mount 
namespace is actually something I would like to avoid, because

i.
Some applications (gdb and possibly others) do not play well in 
controlling applications across mount namespaces (see also 
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=940563)

ii.
Joining the mount-namespace has performance-implications, because a 
setuid-binary, which joins the mount-namespace, must be called 
beforehand. Further, care must be taken to preserve the environment (env).

iii.
setuid-binaries always impose a security-risk.


I imagine e.g. the following syscalls:

1.
Use fanotify_mark to restrict the fanotify notification group to a 
specific PID, optionally marking forked children as well.
fanotify_mark(fan_fd, FAN_MARK_ADD | FAN_MARK_PID, FAN_EVENT_ON_CHILD, 
pid, NULL);
// FAN_EVENT_ON_CHILD -> additional meaning: also forked child processes.

2.
Use fanotify_mark to remove a PID from the notification group.
fanotify_mark(fan_fd, FAN_MARK_REMOVE | FAN_MARK_PID, 0, pid, NULL);

3.
When reading from a fan_fd, which is marked for PID's which have all 
ended or were removed, return e.g. ENOENT.


Independent of that it would be also useful, to be able to track 
applications, which unshare their mount namespace as well (e.g. 
flatpak). So in case a process, whose mount points are observed, 
unshares, the new mount id's should also be added to the same fanotify 
notification group. To preserve backwards compatibility I suggest 
introducing a new flag FAN_MARK_MOUNT_REC:
fanotify_mark(fan_fd, FAN_MARK_ADD | FAN_MARK_MOUNT | 
FAN_MARK_MOUNT_REC, mask, AT_FDCWD, path);


Thanks in Advance
Kind Regards
Tycho Kirchner




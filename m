Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 691E515B1A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 21:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgBLURr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 15:17:47 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:33401 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBLURq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:17:46 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 48HrY356Zhz1rm9y;
        Wed, 12 Feb 2020 21:17:43 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 48HrY33zT5z1qqkK;
        Wed, 12 Feb 2020 21:17:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 7WtaXOWOfYFk; Wed, 12 Feb 2020 21:17:42 +0100 (CET)
X-Auth-Info: 3kWrqZVwXfB7LvJL/ypLJqgp7Mxkob+f37r7NsdXDN9TgDmJMWUg7HkPvjPTIrc/
Received: from igel.home (ppp-46-244-167-188.dynamic.mnet-online.de [46.244.167.188])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 12 Feb 2020 21:17:42 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id E0B622C0B28; Wed, 12 Feb 2020 21:17:41 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, libc-alpha@sourceware.org,
        linux-fsdevel@vger.kernel.org, Rich Felker <dalias@libc.org>
Subject: Re: XFS reports lchmod failure, but changes file system contents
References: <874kvwowke.fsf@mid.deneb.enyo.de>
        <20200212161604.GP6870@magnolia>
        <20200212181128.GA31394@infradead.org>
        <20200212183718.GQ6870@magnolia> <87d0ajmxc3.fsf@mid.deneb.enyo.de>
        <20200212195118.GN23230@ZenIV.linux.org.uk>
        <87wo8rlgml.fsf@mid.deneb.enyo.de>
X-Yow:  NOW, I'm taking the NEXT FLIGHT to ACAPULCO so I can write POEMS about
 BROKEN GUITAR STRINGS and sensuous PRE-TEENS!!
Date:   Wed, 12 Feb 2020 21:17:41 +0100
In-Reply-To: <87wo8rlgml.fsf@mid.deneb.enyo.de> (Florian Weimer's message of
        "Wed, 12 Feb 2020 21:01:22 +0100")
Message-ID: <87wo8r1rx6.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Feb 12 2020, Florian Weimer wrote:

> * Al Viro:
>
>> On Wed, Feb 12, 2020 at 08:15:08PM +0100, Florian Weimer wrote:
>>
>>> | Further, I've found some inconsistent behavior with ext4: chmod on the
>>> | magic symlink fails with EOPNOTSUPP as in Florian's test, but fchmod
>>> | on the O_PATH fd succeeds and changes the symlink mode. This is with
>>> | 5.4. Cany anyone else confirm this? Is it a problem?
>>> 
>>> It looks broken to me because fchmod (as an inode-changing operation)
>>> is not supposed to work on O_PATH descriptors.
>>
>> Why?  O_PATH does have an associated inode just fine; where does
>> that "not supposed to" come from?
>
> It fails on most file systems right now.  I thought that was expected.
> Other system calls (fsetxattr IIRC) do not work on O_PATH descriptors,
> either.  I assumed that an O_PATH descriptor was not intending to
> confer that capability.  Even openat fails.

According to open(2), this is expected:

       O_PATH (since Linux 2.6.39)
              Obtain a file descriptor that can be used for two  purposes:  to
              indicate a location in the filesystem tree and to perform opera-
              tions that act purely at the file descriptor  level.   The  file
              itself  is not opened, and other file operations (e.g., read(2),
              write(2), fchmod(2), fchown(2), fgetxattr(2), ioctl(2), mmap(2))
              fail with the error EBADF.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

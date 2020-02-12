Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E853315B1D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 21:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgBLU1q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 15:27:46 -0500
Received: from albireo.enyo.de ([37.24.231.21]:38502 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727548AbgBLU1p (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:27:45 -0500
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1j1ybe-0006mm-7t; Wed, 12 Feb 2020 20:27:34 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1j1yaJ-0006Eo-S9; Wed, 12 Feb 2020 21:26:11 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Rich Felker <dalias@libc.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, libc-alpha@sourceware.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: XFS reports lchmod failure, but changes file system contents
References: <874kvwowke.fsf@mid.deneb.enyo.de>
        <20200212161604.GP6870@magnolia>
        <20200212181128.GA31394@infradead.org>
        <20200212183718.GQ6870@magnolia> <87d0ajmxc3.fsf@mid.deneb.enyo.de>
        <20200212195118.GN23230@ZenIV.linux.org.uk>
        <87wo8rlgml.fsf@mid.deneb.enyo.de> <87wo8r1rx6.fsf@igel.home>
        <20200212201951.GC1663@brightrain.aerifal.cx>
Date:   Wed, 12 Feb 2020 21:26:11 +0100
In-Reply-To: <20200212201951.GC1663@brightrain.aerifal.cx> (Rich Felker's
        message of "Wed, 12 Feb 2020 15:19:51 -0500")
Message-ID: <87sgjflfh8.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Rich Felker:

> On Wed, Feb 12, 2020 at 09:17:41PM +0100, Andreas Schwab wrote:
>> On Feb 12 2020, Florian Weimer wrote:
>> 
>> > * Al Viro:
>> >
>> >> On Wed, Feb 12, 2020 at 08:15:08PM +0100, Florian Weimer wrote:
>> >>
>> >>> | Further, I've found some inconsistent behavior with ext4: chmod on the
>> >>> | magic symlink fails with EOPNOTSUPP as in Florian's test, but fchmod
>> >>> | on the O_PATH fd succeeds and changes the symlink mode. This is with
>> >>> | 5.4. Cany anyone else confirm this? Is it a problem?
>> >>> 
>> >>> It looks broken to me because fchmod (as an inode-changing operation)
>> >>> is not supposed to work on O_PATH descriptors.
>> >>
>> >> Why?  O_PATH does have an associated inode just fine; where does
>> >> that "not supposed to" come from?
>> >
>> > It fails on most file systems right now.  I thought that was expected.
>> > Other system calls (fsetxattr IIRC) do not work on O_PATH descriptors,
>> > either.  I assumed that an O_PATH descriptor was not intending to
>> > confer that capability.  Even openat fails.
>> 
>> According to open(2), this is expected:
>> 
>>        O_PATH (since Linux 2.6.39)
>>               Obtain a file descriptor that can be used for two  purposes:  to
>>               indicate a location in the filesystem tree and to perform opera-
>>               tions that act purely at the file descriptor  level.   The  file
>>               itself  is not opened, and other file operations (e.g., read(2),
>>               write(2), fchmod(2), fchown(2), fgetxattr(2), ioctl(2), mmap(2))
>>               fail with the error EBADF.
>
> That text is outdated and should be corrected. Fixing fchmod fchown,
> fstat, etc. to operate on O_PATH file descriptors was a very
> intentional change in the kernel.

I suppose we could do the S_ISLNK check, try fchmod, and if that
fails, go via /proc.  Is this the direction you want to go in?

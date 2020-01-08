Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D720013488A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 17:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgAHQxV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 11:53:21 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48025 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727308AbgAHQxV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:53:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578502399;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FN/IuZYmO2CKkrVNJKYtTYcQmJ17b8YYW3G6cuW8Rbk=;
        b=WyKGmnxL3ZSfo/fzAmlb4GOECVDQ14S4QGdMCg1W0jwvpLDml4YYIPP/QyRoOZlKnrCDHa
        iHNyZVKvnPHOZkzR1mE3VuN7Solc/vP1wSYQottv1g5eQonUz9X5eOnD3ambFxSgOHMlXg
        UlywFFpENBl6o18UML9F2NCgbDnVyRs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-3deuIUC2Pz--dinLZaMplg-1; Wed, 08 Jan 2020 11:53:18 -0500
X-MC-Unique: 3deuIUC2Pz--dinLZaMplg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF9188024D5;
        Wed,  8 Jan 2020 16:53:16 +0000 (UTC)
Received: from [10.3.112.12] (ovpn-112-12.phx2.redhat.com [10.3.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE4CC60C18;
        Wed,  8 Jan 2020 16:53:14 +0000 (UTC)
Reply-To: tasleson@redhat.com
Subject: Re: [RFC 9/9] __xfs_printk: Add durable name to output
To:     Dave Chinner <david@fromorbit.com>
Cc:     Sweet Tea Dorminy <sweettea@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20191223225558.19242-1-tasleson@redhat.com>
 <20191223225558.19242-10-tasleson@redhat.com>
 <20200104025620.GC23195@dread.disaster.area>
 <5ad7cf7b-e261-102c-afdc-fa34bed98921@redhat.com>
 <20200106220233.GK23195@dread.disaster.area>
 <CAMeeMh-zr309TzbC3ayKUKRniat+rzurgzmeM5LJYMFVDj7bLA@mail.gmail.com>
 <20200107012353.GO23195@dread.disaster.area>
 <4ce83a0e-13e1-6245-33a3-5c109aec4bf1@redhat.com>
 <20200108021002.GR23195@dread.disaster.area>
From:   Tony Asleson <tasleson@redhat.com>
Organization: Red Hat
Message-ID: <9e449c65-193c-d69c-1454-b1059221e5dc@redhat.com>
Date:   Wed, 8 Jan 2020 10:53:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108021002.GR23195@dread.disaster.area>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/7/20 8:10 PM, Dave Chinner wrote:
> On Tue, Jan 07, 2020 at 11:01:47AM -0600, Tony Asleson wrote:
>> On 1/6/20 7:23 PM, Dave Chinner wrote:
>>> On Mon, Jan 06, 2020 at 07:19:07PM -0500, Sweet Tea Dorminy wrote:
>>>>>>>> +
>>>>>>>>    if (mp && mp->m_fsname) {
>>>>>>>
>>>>>>> mp->m_fsname is the name of the device we use everywhere for log
>>>>>>> messages, it's set up at mount time so we don't have to do runtime
>>>>>>> evaulation of the device name every time we need to emit the device
>>>>>>> name in a log message.
>>>>>>>
>>>>>>> So, if you have some sooper speshial new device naming scheme, it
>>>>>>> needs to be stored into the struct xfs_mount to replace mp->m_fsname.
>>>>>>
>>>>>> I don't think we want to replace mp->m_fsname with the vpd 0x83 device
>>>>>> identifier.  This proposed change is adding a key/value structured data
>>>>>> to the log message for non-ambiguous device identification over time,
>>>>>> not to place the ID in the human readable portion of the message.  The
>>>>>> existing name is useful too, especially when it involves a partition.
>>>>>
>>>>> Oh, if that's all you want to do, then why is this identifier needed
>>>>> in every log message? 
>>
>> The value is we can filter all the messages by the id as they are all
>> individually identifiable.
> 
> Then what you want is the *filesystem label* or *filesystem UUID*
> in the *filesystem log output* to uniquely identify the *filesystem
> log output* regardless of the block device identifier the kernel
> assigned it's underlying disk.
> 
> By trying to use the block device as the source of a persistent
> filesytem identifier, you are creating more new problems about
> uniqueness than you are solving.  E.g.
> 
> - there can be more than one filesystem per block device, so the
>   identifier needs to be, at minimum, a {dev_id, partition} tuple.
>   The existing bdev name (e.g. sda2) that filesystems emit contain
>   this information. The underlying vpd device indentifier does not.

We are not removing any existing information, we are adding.

I think all the file systems should include their FS UUID in the FS log
messages too, but that is not part of the problem we are trying to solve.

> - the filesystem on a device can change (e.g. mkfs), so an unchanged
>   vpd identifier does not mean we mounted the same filesystem
> 
> - raid devices are made up of multiple physical devices, so using
>   device information for persistent identification is problematic,
>   especially when devices fail and are replaced with different
>   hardware.

For the desired use cases its not problematic.  With this we would have
a definitive id of which messages go with which disk.  We know if the
disk is still present in the system or if it went away and came back or
if it showed up in some other system.  We also have a definitive ID of
which disk to yank from the system.

> - clone a filesystem to a new device to replace a failing disk,
>   block device identifier changes but the filesystem doesn't.

Yes, and now you have log messages for two filesystems which exist on
different physical hardware which you cannot distinguish, if you
leverage the FS UUID in the log messages.

> Basically, if you need a *persistent filesystem identifier* for
> your log messages, then you cannot rely on the underlying device to
> provide that. Filesystems already have unique identifiers in them
> that can be used for this purpose, and we have mechanisms to allow
> users to configure them as well.

I'm not advocating for a persistent filesystem id.  Lets outline some
user stories to help illustrate.

I found a few log messages from 4 months ago, device sdk was
experiencing media errors.  How do I view the log messages for that
device in my entire log history, through the entire storage stack from
device driver to FS?

I have a storage device that is intermittently failing, was this disk
used anywhere else in our data center?  Was it experiencing issues
before?  Is it in the same batch of disks we bought together that has
been experiencing higher failure rates?

I have 2 identical external USB storage devices, I bought them at the
same time.  They get moved around in my home for backup and sometimes I
take one with when traveling.  I occasionally use dd to backup one
device to the other when the data is important and I haven't backed it
up anywhere else.  I found log messages that shows a device is
intermittently having a problem, which one is it so I can contact the
vendor for warranty replacement?


Trying to solve these questions can be difficult with the existing
convention of logging messages that look like:

blk_update_request: I/O error, dev sda, sector 89364488 op 0x0:(READ)
flags 0x80700 phys_seg 1 prio class 0

The user has to systematically and methodically go through the logs
trying to deduce what the identifier was referring to at the time of the
error.  This isn't trivial and virtually impossible at times depending
on circumstances.

> IOWs, you're trying to tackle this "filesystem identifier" at the
> wrong layer - use the persistent filesystem identifiers to
> persitently identify the filesystem across mounts, not some random
> block device identifier.

The vpd 0x83 is not random, it's the best thing we have to identify a
piece of storage hardware.  One issue is it's not available for every
device.  We need to find suitable ID's for those devices too.  We aren't
trying to persistently identify the FS, we are trying to persistently
identify which messages go with which device.

>> The structured data id that the patch series adds is not outputted by
>> default by journalctl.  Please look at cover letter in patch series for
>> example filter use.  You can see all the data in the journal entries by
>> using journalctl -o json-pretty.
> 
> Yes, I understand that. But my comments about adding redundant
> information to the log text output were directed at your suggestiong to
> use dev_printk() instead of printk to achieve what you want. That
> changes the log text output by prepending device specific strings to
> the filesystem output.
> 
>> One can argue that we are adding a lot of data to each log message
>> as the VPD data isn't trivial.  This could be mitigated by hashing
>> the VPD and storing the hash as the ID, but that makes it less
>> user friendly.  However, maybe it should be considered.
> 
> See above, I don't think the VPD information actually solves the
> problem you are seeking to solve.
> 
>>>>> It does not change over the life of the filesystem, so it the
>>>>> persistent identifier only needs to >>> be
>> emitted to the log once at filesystem mount time. i.e.  >>>
>> instead of:
>>>>>
>>>>> [    2.716841] XFS (dm-0): Mounting V5 Filesystem
>>>>>
>>>>> It just needs to be:
>>>>>
>>>>> [    2.716841] XFS (dm-0): Mounting V5 Filesystem on device
>>>>> <persistent dev id>
>>>>>
>>>>> If you need to do any sort of special "is this the right
>>>>> device" checking, it needs to be done immediately at mount
>>>>> time so action can be taken to shutdown the filesystem and
>>>>> unmount the device immediately before further damage is
>>>>> done....
>>>>>
>>>>> i.e. once the filesystem is mounted, you've already got a
>>>>> unique and persistent identifier in the log for the life of
>>>>> the filesystem (the m_fsname string), so I'm struggling to
>>>>> understand exactly what problem you are trying to solve by
>>>>> adding redundant information to every log message.....
>>
>> m_fsname is only valid for the life of the mount, not the life of
>> the FS.  Each and every time we reboot, remove/reattach a device
>> the attachment point may change and thus the m_fsname changes too.
> 
> Well, yes, that's because m_fsname is currently aimed at identifying
> the block device that the filesytem is currently mounted on. That's
> the block device we *actually care about* when trying to diagnose
> problems reported in the log.  From that perspective, I don't want
> the log output to change - it contains exactly what we need to
> diagnose problems when things go wrong.
> 
> But for structured logging, using block device identifiers for the
> filesystem identifier is just wrong. If you need new information,
> append the UUID from the filesystem to the log message and use that
> instead. i.e your original printk_emit() function should pass
> mp->m_sb.sb_uuid as the post-message binary filesystem identifier,
> not the block device VPD information.
> 
> If you need to convert the filesystem uuid to a block device, then
> you can just go look up /dev/disk/by-uuid/ and follow the link the
> filesystem uuid points to....
> 
>>> And, for the log rotation case, the filesystem log output
>>> already has a unique, persistent identifier for the life of the
>>> mount - the fsname ("dm-0" in the above example). We don't need
>>> to add a new device identifier to the XFS log messages to solve
>>> that problem because *we've already got a device identifier in
>>> the log messages*.
>>
>> It's very useful to have an ID that persists and identifies across
>> mounts.  The existing id logging scheme tells you where something
>> is attached, not what is attached.
> 
> Yup, that's what the filesystem labels and UUIDs provide. We've been
> using them for this purpose for a long, long time.

FS UUIDs exist on the media, they can be duplicated, destroyed or fail
to be read up due to media errors.  They do serve an important function,
esp. mounting, but they don't address the use cases described above.



Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18CC1132C66
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 18:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgAGRB5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 12:01:57 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48434 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728211AbgAGRB4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:01:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578416515;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D5OPPwIHTy22Wkt/OsS1YGH1EyOGhN2nFXTBHl/JscE=;
        b=bGb3ZgDRN+xx2qoP41r17k+3sGs/nScNuY9fcuL91bUd9HMNc2f/TPStLK42CwA3LgIG/3
        yw7YYSSnSa4PBXiSEKsfE1CjmM6Sd9o+QI0Wt6blkv7gxk+wrVD53UC8mUsgdwoLZCnWTy
        bZFKeeG3LnD/gmIDfGQLZ3MbBEePpqQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-ALH5CqgFNGWBGWYC2wATTA-1; Tue, 07 Jan 2020 12:01:54 -0500
X-MC-Unique: ALH5CqgFNGWBGWYC2wATTA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B1848024CC;
        Tue,  7 Jan 2020 17:01:53 +0000 (UTC)
Received: from [10.3.112.12] (ovpn-112-12.phx2.redhat.com [10.3.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0AE2486C48;
        Tue,  7 Jan 2020 17:01:49 +0000 (UTC)
Reply-To: tasleson@redhat.com
Subject: Re: [RFC 9/9] __xfs_printk: Add durable name to output
To:     Dave Chinner <david@fromorbit.com>,
        Sweet Tea Dorminy <sweettea@redhat.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20191223225558.19242-1-tasleson@redhat.com>
 <20191223225558.19242-10-tasleson@redhat.com>
 <20200104025620.GC23195@dread.disaster.area>
 <5ad7cf7b-e261-102c-afdc-fa34bed98921@redhat.com>
 <20200106220233.GK23195@dread.disaster.area>
 <CAMeeMh-zr309TzbC3ayKUKRniat+rzurgzmeM5LJYMFVDj7bLA@mail.gmail.com>
 <20200107012353.GO23195@dread.disaster.area>
From:   Tony Asleson <tasleson@redhat.com>
Organization: Red Hat
Message-ID: <4ce83a0e-13e1-6245-33a3-5c109aec4bf1@redhat.com>
Date:   Tue, 7 Jan 2020 11:01:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107012353.GO23195@dread.disaster.area>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/6/20 7:23 PM, Dave Chinner wrote:
> On Mon, Jan 06, 2020 at 07:19:07PM -0500, Sweet Tea Dorminy wrote:
>>>>>> +
>>>>>>    if (mp && mp->m_fsname) {
>>>>>
>>>>> mp->m_fsname is the name of the device we use everywhere for log
>>>>> messages, it's set up at mount time so we don't have to do runtime
>>>>> evaulation of the device name every time we need to emit the device
>>>>> name in a log message.
>>>>>
>>>>> So, if you have some sooper speshial new device naming scheme, it
>>>>> needs to be stored into the struct xfs_mount to replace mp->m_fsname.
>>>>
>>>> I don't think we want to replace mp->m_fsname with the vpd 0x83 device
>>>> identifier.  This proposed change is adding a key/value structured data
>>>> to the log message for non-ambiguous device identification over time,
>>>> not to place the ID in the human readable portion of the message.  The
>>>> existing name is useful too, especially when it involves a partition.
>>>
>>> Oh, if that's all you want to do, then why is this identifier needed
>>> in every log message? 

The value is we can filter all the messages by the id as they are all
individually identifiable.

The structured data id that the patch series adds is not outputted by
default by journalctl.  Please look at cover letter in patch series for
example filter use.  You can see all the data in the journal entries by
using journalctl -o json-pretty.

One can argue that we are adding a lot of data to each log message as
the VPD data isn't trivial.  This could be mitigated by hashing the VPD
and storing the hash as the ID, but that makes it less user friendly.
However, maybe it should be considered.

>>> It does not change over the life of the
>>> filesystem, so it the persistent identifier only needs to >>> be
emitted to the log once at filesystem mount time. i.e.  >>> instead of:
>>>
>>> [    2.716841] XFS (dm-0): Mounting V5 Filesystem
>>>
>>> It just needs to be:
>>>
>>> [    2.716841] XFS (dm-0): Mounting V5 Filesystem on device <persistent dev id>
>>>
>>> If you need to do any sort of special "is this the right device"
>>> checking, it needs to be done immediately at mount time so action
>>> can be taken to shutdown the filesystem and unmount the device
>>> immediately before further damage is done....
>>>
>>> i.e. once the filesystem is mounted, you've already got a unique and
>>> persistent identifier in the log for the life of the filesystem (the
>>> m_fsname string), so I'm struggling to understand exactly what
>>> problem you are trying to solve by adding redundant information
>>> to every log message.....

m_fsname is only valid for the life of the mount, not the life of the
FS.  Each and every time we reboot, remove/reattach a device the
attachment point may change and thus the m_fsname changes too.  Then the
user or script writer has to figure out what messages go with what
device.  This is true for all the different storage layer messages.
Some layers use sda, sata1.00 or sd 0:0:0:0 and they all refer to the
same device.

We have no unambiguous way today to identify which messages go with what
storage device across reboots and dynamic device re-configuration across
the storage stack.

>>
>> Log rotation loses that identifier though; there are plenty of setups
>> where a mount-time message has been rotated out of all logs by the
>> time something goes wrong after a month or two.
> 
> At what point months after you've mounted the filesystem do you care
> about whether the correct device was mounted or not?

This isn't a question about if the correct device was mounted or not.
It's the question of what actual storage hardware was associated with
the message(s), an association that doesn't change across reboots or
dynamic device reconfiguration or if you move the physical device to
another system.

The cover letter example shows filtered output of one specific device
encountering errors that has an XFS FS.  Without this added ID it would
not be so easy to determine that these messages all belong to the same
device.  In this case the attachment isn't changing, it's the simple
case.  When it does change over time it gets even more difficult.

> And, for the log rotation case, the filesystem log output already
> has a unique, persistent identifier for the life of the mount - the
> fsname ("dm-0" in the above example). We don't need to add a new
> device identifier to the XFS log messages to solve that problem
> because *we've already got a device identifier in the log messages*.

It's very useful to have an ID that persists and identifies across
mounts.  The existing id logging scheme tells you where something is
attached, not what is attached.

> Again - the "is this the right device" information only makes sense
> to be checked at mount time. If it was the right device at mount
> time, then after months of uptime how would it suddenly become "the
> wrong device"? And if it's the wrong device at mount time, then you
> need to take action *immediately*, not after using the filesysetms
> on the device for months...
> 
> Cheers,
> 
> Dave.
> 


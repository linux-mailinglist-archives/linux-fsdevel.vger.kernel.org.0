Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 903EE16EA6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 16:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbgBYPrv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 10:47:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37213 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730143AbgBYPrv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 10:47:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582645670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=trlBFUce873cn9ccfYK+IWU2Bv4WurycszVYAkntBjk=;
        b=GAmdvgR4XCXrtNG6+sJQfEUdI+kK4lHUsgw/fkslcVmCL1C9w1K7KMNEaFYSdsQHkXmlvT
        bu83FuG2py59BBIOAY7Wf1kF5yBPj6Si/HS63RoREpgLPA74fDSPYSOrLhik2Nn4VubIsJ
        e9T8g4mG2YHLXtdjEZ649AQRM/bEQPw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-QWWSaFm4O4GjTIfdmQKHTw-1; Tue, 25 Feb 2020 10:47:46 -0500
X-MC-Unique: QWWSaFm4O4GjTIfdmQKHTw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82437107BAAB;
        Tue, 25 Feb 2020 15:47:44 +0000 (UTC)
Received: from fogou.chygwyn.com (unknown [10.33.36.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 583305D9CD;
        Tue, 25 Feb 2020 15:47:41 +0000 (UTC)
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver
 #17]
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        David Howells <dhowells@redhat.com>,
        viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
 <1582316494.3376.45.camel@HansenPartnership.com>
 <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>
 <1582556135.3384.4.camel@HansenPartnership.com>
 <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
 <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com>
 <1582644535.3361.8.camel@HansenPartnership.com>
From:   Steven Whitehouse <swhiteho@redhat.com>
Message-ID: <1064c653-c911-5e82-bdcc-63f7315317ce@redhat.com>
Date:   Tue, 25 Feb 2020 15:47:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1582644535.3361.8.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 25/02/2020 15:28, James Bottomley wrote:
> On Tue, 2020-02-25 at 12:13 +0000, Steven Whitehouse wrote:
>> Hi,
>>
>> On 24/02/2020 15:28, Miklos Szeredi wrote:
>>> On Mon, Feb 24, 2020 at 3:55 PM James Bottomley
>>> <James.Bottomley@hansenpartnership.com> wrote:
>>>
>>>> Once it's table driven, certainly a sysfs directory becomes
>>>> possible. The problem with ST_DEV is filesystems like btrfs and
>>>> xfs that may have multiple devices.
>>> For XFS there's always  a single sb->s_dev though, that's what
>>> st_dev will be set to on all files.
>>>
>>> Btrfs subvolume is sort of a lightweight superblock, so basically
>>> all such st_dev's are aliases of the same master superblock.  So
>>> lookup of all subvolume st_dev's could result in referencing the
>>> same underlying struct super_block (just like /proc/$PID will
>>> reference the same underlying task group regardless of which of the
>>> task group member's PID is used).
>>>
>>> Having this info in sysfs would spare us a number of issues that a
>>> set of new syscalls would bring.  The question is, would that be
>>> enough, or is there a reason that sysfs can't be used to present
>>> the various filesystem related information that fsinfo is supposed
>>> to present?
>>>
>>> Thanks,
>>> Miklos
>>>
>> We need a unique id for superblocks anyway. I had wondered about
>> using s_dev some time back, but for the reasons mentioned earlier in
>> this thread I think it might just land up being confusing and
>> difficult to manage. While fake s_devs are created for sbs that don't
>> have a device, I can't help thinking that something closer to
>> ifindex, but for superblocks, is needed here. That would avoid the
>> issue of which device number to use.
>>
>> In fact we need that anyway for the notifications, since without
>> that  there is a race that can lead to missing remounts of the same
>> device, in  case a umount/mount pair is missed due to an overrun, and
>> then fsinfo returns the same device as before, with potentially the
>> same mount options too. So I think a unique id for a superblock is a
>> generically useful feature, which would also allow for sensible sysfs
>> directory naming, if required,
> But would this be informative and useful for the user?  I'm sure we can
> find a persistent id for a persistent superblock, but what about tmpfs
> ... that's going to have to change with every reboot.  It's going to be
> remarkably inconvenient if I want to get fsinfo on /run to have to keep
> finding what the id is.

That is a different question though, or at least it might be... the idea 
of the superblock id is to uniquely identify a particular superblock. 
The mount notification should give you the association between that 
superblock and any devices (assuming those are applicable), or you can 
use fsinfo if you were not listening to the notifications at the time of 
the mount to get the same information.

If someone unmounts /run and remounts it, then the superblock id would 
change, but otherwise it would stay the same, so you know that it is the 
same mount that is being described in future notifications. One of the 
main aims here being to combine the fsinfo information with the 
notifications in a race free manner.

There are a number of ways one might want to specify a filesystem: by 
device, by uuid, by volume label and so forth but we can't use any of 
those very easily as a unique id. Someone might remove a drive and 
replace it with a different one (so same device, but different content) 
or they might have two filesystems with the same uuid if they've just 
done a dd copy to a new device. For the mount notifications we need 
something that doesn't suffer from these issues, but which can also be 
very easily associated with what in most cases are more convenient ways 
to specify a particular filesystem.


>
> The other thing a file descriptor does that sysfs doesn't is that it
> solves the information leak: if I'm in a mount namespace that has no
> access to certain mounts, I can't fspick them and thus I can't see the
> information.  By default, with sysfs I can.
>
> James
>
Yes, thats true, and I wasn't advocating for the sysfs method over 
fspick here, just pointing out that a unique superblock id would be a 
generically useful thing to have,

Steve.



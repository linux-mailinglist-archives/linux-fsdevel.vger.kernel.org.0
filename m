Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0133B2CAAE2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 19:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392296AbgLAShs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 13:37:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31825 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392292AbgLAShs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:37:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606847781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Hwwb/sqROcJjesDx24ixk9y1xqaa3QRixDCyXmkWjY=;
        b=hyIGr/vUHpCJs9RWjnXZbywLs2m7BIU+28Y7WRAETMkJck5T56sVacBSHQLYcj5Ylex5Ma
        vPb3TsGPaxQInF1KpnuXoHEHL2m7bcWyQ4459C1+NItyGIlYgmfHRME9Jn6xjRYLrT1GvH
        eWNCaHW5BKcjrHuI4Pyh5ewbWIZzsvg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165--LG0vMF-Ps-AZqRBbWYVbg-1; Tue, 01 Dec 2020 13:36:16 -0500
X-MC-Unique: -LG0vMF-Ps-AZqRBbWYVbg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD1991842150;
        Tue,  1 Dec 2020 18:36:13 +0000 (UTC)
Received: from liberator.sandeen.net (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 776CB60BD8;
        Tue,  1 Dec 2020 18:36:12 +0000 (UTC)
Subject: Re: [PATCH 1/2] uapi: fix statx attribute value overlap for DAX &
 MOUNT_ROOT
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>, linux-ext4@vger.kernel.org,
        Xiaoli Feng <xifeng@redhat.com>
References: <e388f379-cd11-a5d2-db82-aa1aa518a582@redhat.com>
 <7027520f-7c79-087e-1d00-743bdefa1a1e@redhat.com>
 <20201201173213.GH143045@magnolia>
 <242fce05-90ed-2d2a-36f9-3c8432d57cbc@redhat.com>
 <7E59D613-41D7-4AD1-8674-BCF9F5DC2A0C@dilger.ca>
From:   Eric Sandeen <sandeen@redhat.com>
Message-ID: <95777e22-2807-1d34-be95-465e1d0cfb39@redhat.com>
Date:   Tue, 1 Dec 2020 12:36:12 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <7E59D613-41D7-4AD1-8674-BCF9F5DC2A0C@dilger.ca>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/1/20 12:31 PM, Andreas Dilger wrote:
> On Dec 1, 2020, at 10:44 AM, Eric Sandeen <sandeen@redhat.com> wrote:
>>
>> On 12/1/20 11:32 AM, Darrick J. Wong wrote:
>>> On Tue, Dec 01, 2020 at 10:57:11AM -0600, Eric Sandeen wrote:
>>>> STATX_ATTR_MOUNT_ROOT and STATX_ATTR_DAX got merged with the same value,
>>>> so one of them needs fixing. Move STATX_ATTR_DAX.
>>>>
>>>> While we're in here, clarify the value-matching scheme for some of the
>>>> attributes, and explain why the value for DAX does not match.
>>>>
>>>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>>>> ---
>>>> include/uapi/linux/stat.h | 7 ++++---
>>>> 1 file changed, 4 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
>>>> index 82cc58fe9368..9ad19eb9bbbf 100644
>>>> --- a/include/uapi/linux/stat.h
>>>> +++ b/include/uapi/linux/stat.h
>>>> @@ -171,9 +171,10 @@ struct statx {
>>>>  * be of use to ordinary userspace programs such as GUIs or ls rather than
>>>>  * specialised tools.
>>>>  *
>>>> - * Note that the flags marked [I] correspond to generic FS_IOC_FLAGS
>>>> + * Note that the flags marked [I] correspond to the FS_IOC_SETFLAGS flags
>>>>  * semantically.  Where possible, the numerical value is picked to correspond
>>>> - * also.
>>>> + * also. Note that the DAX attribute indicates that the inode is currently
>>>> + * DAX-enabled, not simply that the per-inode flag has been set.
>>>
>>> I don't really like using "DAX-enabled" to define "DAX attribute".  How
>>> about cribbing from the statx manpage?
>>>
>>> "Note that the DAX attribute indicates that the file is in the CPU
>>> direct access state.  It does not correspond to the per-inode flag that
>>> some filesystems support."
>>
>> Sure.  Consistency and specificity is good, I'll change that.
>>
>>>>  */
>>>> #define STATX_ATTR_COMPRESSED		0x00000004 /* [I] File is compressed by the fs */
>>>> #define STATX_ATTR_IMMUTABLE		0x00000010 /* [I] File is marked immutable */
>>>> @@ -183,7 +184,7 @@ struct statx {
>>>> #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
>>>> #define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
>>>> #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
>>>> -#define STATX_ATTR_DAX			0x00002000 /* [I] File is DAX */
>>>> +#define STATX_ATTR_DAX			0x00400000 /* File is currently DAX-enabled */
>>>
>>> Why not use the next bit in the series (0x200000)?  Did someone already
>>> claim it in for-next?
>>
>> Since it didn't match the FS_IOC_SETFLAGS flag, I was trying to pick one that
>> seemed unlikely to ever gain a corresponding statx flag, and since 0x00400000 is
>> "reserved for ext4" it seemed like a decent choice.
>>
>> But 0x200000 corresponds to FS_EA_INODE_FL/EXT4_EA_INODE_FL which is ext4-specific
>> as well, so sure, I'll change to that.
> 
> If you look a few lines up in the context, this is supposed to be using the
> same value as the other inode flags:
> 
>  * Note that the flags marked [I] correspond to generic FS_IOC_FLAGS
>  * semantically.  Where possible, the numerical value is picked to correspond
>  * also.
> 
> #define FS_DAX_FL                       0x02000000 /* Inode is DAX */
> #define EXT4_DAX_FL                     0x02000000 /* Inode is DAX */
> 
> (FS_DAX_FL also used by XFS) so this should really be "0x02000000" instead
> of some other value.

Setting this attribute in statx means that "the file is in the CPU direct access
state," not simply that the flag is set on disk.  There is not a 1:1 correspondence
in state, so I intentionally did not choose the same flag value.

(Honestly, no idea why we try to match the values in any case, all it leads to is...
this, AFAICT.)

-Eric



-Eric 


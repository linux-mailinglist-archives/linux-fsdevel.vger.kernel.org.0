Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2388F1AD664
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 08:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgDQGnm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 02:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728022AbgDQGnm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 02:43:42 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6E1C061A10
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2020 23:43:41 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a7so460287pju.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2020 23:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=5q3WqG9SB5tYdylD2a0m5b5mUeTB2l3FK9r70pi+Ta8=;
        b=DqK2lBOu1IjOaMaSXoWKH7Z3nE+GdH2xNBeBIFaPFIZXAMexv9v4dvdfVh2OSCXe2s
         775s6zQRsymiZbMg2KT+TJmTFnoy0mi79qnpBAJyx2Uc+iK47AIgrSVRYkhGFlWReplI
         XZ0rQ7ktoRxqI0voxTZKcxe/la8PNlMQFl6TZOZkuPT3TvBsBhI7amo2wyJUX7xC1dCS
         EjPK7wAtbH1Lt4M9ATsJlW0iqf2SDhBO174r1qojZ6Q3xoNgF5TeHe0e5F4KyEFGFLLc
         jgouEoiKD6oz5aHLizmmt1OmoijtGH0kxiuMzGp+UzFLwZnREgTxxw4R8GCGeBRPK0T3
         B9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=5q3WqG9SB5tYdylD2a0m5b5mUeTB2l3FK9r70pi+Ta8=;
        b=gKwODtFXYt7r+MQpDfZfwuYnZd07pOSg6qqocO2NqkdD12slw27vV2R6FGDyy883Ck
         a8enct+6zvvpS9O7jCYcATCaXSSi24di3IjE+QlvGRgeEplfbjCpo1rSp1pdOo0refIT
         NCNstMVWWtgCbkdULAg7x8xBRM+9At9tWO1+HImBbuKCYH1cu5wJwiB2JSmEZXKp87Od
         Czp8upb+7HnynKLuRv/tHlDKhMXvhCFS4cB/HQbsUePeqy5ugRB/k1W/jlmM1Xk+qFWk
         ZPsjp0JdnpzPJO9+58vq9TRuhmpxCIWLDzwavC0hm7De6ot6eFQ1vkXDjfhNemucjIt+
         KxAg==
X-Gm-Message-State: AGi0PuagJQR5v2ZjDmzLlyd0b4vkr6oAk/3HfcApRFmxvKNcNH5t6tNP
        FRwgLfuvJ2abakgi+GdmlKkPgA==
X-Google-Smtp-Source: APiQypLGkzoCro0ltAdsDK4nr1W39R+Zc9W7hACqJqfvv9aDZqi6iQ5f5vF/xvLE9JvhSHCIcunKEA==
X-Received: by 2002:a17:902:5999:: with SMTP id p25mr2141910pli.189.1587105821015;
        Thu, 16 Apr 2020 23:43:41 -0700 (PDT)
Received: from [192.168.10.175] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id h66sm17773686pgc.42.2020.04.16.23.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 23:43:40 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC 4/8] fs/ext4: Introduce DAX inode flag
Date:   Fri, 17 Apr 2020 00:43:39 -0600
Message-Id: <324CEF76-20AA-40F5-A31B-6E0B1CCED736@dilger.ca>
References: <20200417022036.GQ2309605@iweiny-DESK2.sc.intel.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <20200417022036.GQ2309605@iweiny-DESK2.sc.intel.com>
To:     Ira Weiny <ira.weiny@intel.com>
X-Mailer: iPhone Mail (17E262)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We still need to store an on-disk DAX flag for Ext4, and at that point it
doesn't make sense not to expose it via the standard Ext4 chattr utility.

So having EXT4_DAX_FL (=3D=3D FS_DAX_FL) is no extra effort to add.

Cheers, Andreas

> On Apr 16, 2020, at 20:20, Ira Weiny <ira.weiny@intel.com> wrote:
>=20
> =EF=BB=BFOn Thu, Apr 16, 2020 at 06:57:31PM -0700, Darrick J. Wong wrote:
>>> On Thu, Apr 16, 2020 at 05:37:19PM -0700, Ira Weiny wrote:
>>> On Thu, Apr 16, 2020 at 03:49:37PM -0700, Darrick J. Wong wrote:
>>>> On Thu, Apr 16, 2020 at 03:33:27PM -0700, Ira Weiny wrote:
>>>>> On Thu, Apr 16, 2020 at 09:25:04AM -0700, Darrick J. Wong wrote:
>>>>>> On Mon, Apr 13, 2020 at 09:00:26PM -0700, ira.weiny@intel.com wrote:
>>>>>>> From: Ira Weiny <ira.weiny@intel.com>
>>>>>>>=20
>>>>>>> Add a flag to preserve FS_XFLAG_DAX in the ext4 inode.
>>>>>>>=20
>>>>>>> Set the flag to be user visible and changeable.  Set the flag to be
>>>>>>> inherited.  Allow applications to change the flag at any time.
>>>>>>>=20
>>>>>>> Finally, on regular files, flag the inode to not be cached to facili=
tate
>>>>>>> changing S_DAX on the next creation of the inode.
>>>>>>>=20
>>>>>>> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>>>>>>> ---
>>>>>>> fs/ext4/ext4.h  | 13 +++++++++----
>>>>>>> fs/ext4/ioctl.c | 21 ++++++++++++++++++++-
>>>>>>> 2 files changed, 29 insertions(+), 5 deletions(-)
>>>>>>>=20
>>>>>>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>>>>>>> index 61b37a052052..434021fcec88 100644
>>>>>>> --- a/fs/ext4/ext4.h
>>>>>>> +++ b/fs/ext4/ext4.h
>>>>>>> @@ -415,13 +415,16 @@ struct flex_groups {
>>>>>>> #define EXT4_VERITY_FL            0x00100000 /* Verity protected ino=
de */
>>>>>>> #define EXT4_EA_INODE_FL            0x00200000 /* Inode used for lar=
ge EA */
>>>>>>> #define EXT4_EOFBLOCKS_FL        0x00400000 /* Blocks allocated beyo=
nd EOF */
>>>>>>> +
>>>>>>> +#define EXT4_DAX_FL            0x00800000 /* Inode is DAX */
>>>>>>=20
>>>>>> Sooo, fun fact about ext4 vs. the world--
>>>>>>=20
>>>>>> The GETFLAGS/SETFLAGS ioctl, since it came from ext2, shares the same=

>>>>>> flag values as the ondisk inode flags in ext*.  Therefore, each of th=
ese
>>>>>> EXT4_[whatever]_FL values are supposed to have a FS_[whatever]_FL
>>>>>> equivalent in include/uapi/linux/fs.h.
>>>>>=20
>>>>> Interesting...
>>>>>=20
>>>>>>=20
>>>>>> (Note that the "[whatever]" is a straight translation since the same
>>>>>> uapi header also defines the FS_XFLAG_[xfswhatever] flag values; igno=
re
>>>>>> those.)
>>>>>>=20
>>>>>> Evidently, FS_NOCOW_FL already took 0x800000, but ext4.h was never
>>>>>> updated to note that the value was taken.  I think Ted might be incli=
ned
>>>>>> to reserve the ondisk inode bit just in case ext4 ever does support c=
opy
>>>>>> on write, though that's his call. :)
>>>>>=20
>>>>> Seems like I should change this...  And I did not realize I was inhere=
ntly
>>>>> changing a bit definition which was exposed to other FS's...
>>>>=20
>>>> <nod> This whole thing is a mess, particularly now that we have two vfs=

>>>> ioctls to set per-fs inode attributes, both of which were inherited fro=
m
>>>> other filesystems... :(
>>>>=20
>>>=20
>>> Ok I've changed it.
>>>=20
>>>>=20
>>>>>>=20
>>>>>> Long story short - can you use 0x1000000 for this instead, and add th=
e
>>>>>> corresponding value to the uapi fs.h?  I guess that also means that w=
e
>>>>>> can change FS_XFLAG_DAX (in the form of FS_DAX_FL in FSSETFLAGS) afte=
r
>>>>>> that.
>>>>>=20
>>>>> :-/
>>>>>=20
>>>>> Are there any potential users of FS_XFLAG_DAX now?
>>>>=20
>>>> Yes, it's in the userspace ABI so we can't get rid of it.
>>>>=20
>>>> (FWIW there are several flags that exist in both FS_XFLAG_* and FS_*_FL=

>>>> form.)
>>>>=20
>>>>> =46rom what it looks like, changing FS_XFLAG_DAX to FS_DAX_FL would be=
 pretty
>>>>> straight forward.  Just to be sure, looks like XFS converts the FS_[xx=
x]_FL to
>>>>> FS_XFLAGS_[xxx] in xfs_merge_ioc_xflags()?  But it does not look like a=
ll the
>>>>> FS_[xxx]_FL flags are converted.  Is is that XFS does not support thos=
e
>>>>> options?  Or is it depending on the VFS layer for some of them?
>>>>=20
>>>> XFS doesn't support most of the FS_*_FL flags.
>>>=20
>>> If FS_XFLAG_DAX needs to continue to be user visible I think we need to k=
eep
>>> that flag and we should not expose the EXT4_DAX_FL flag...
>>>=20
>>> I think that works for XFS.
>>>=20
>>> But for ext4 it looks like EXT4_FL_XFLAG_VISIBLE was intended to be used=
 for
>>> [GET|SET]XATTR where EXT4_FL_USER_VISIBLE was intended to for [GET|SET]FL=
AGS...
>>> But if I don't add EXT4_DAX_FL in EXT4_FL_XFLAG_VISIBLE my test fails.
>>>=20
>>> I've been playing with the flags and looking at the code and I _thought_=
 the
>>> following patch would ensure that FS_XFLAG_DAX is the only one visible b=
ut for
>>> some reason FS_XFLAG_DAX can't be set with this patch.  I still need the=

>>> EXT4_FL_USER_VISIBLE mask altered...  Which I believe would expose EXT4_=
DAX_FL
>>> directly as well.
>>>=20
>>> Jan, Ted?  Any ideas?  Or should we expose EXT4_DAX_FL and FS_XFLAG_DAX i=
n
>>> ext4?
>>=20
>> Both flags should be exposed through their respective ioctl interfaces
>> in both filesystems.  That way we don't have to add even more verbiage
>> to the documentation to instruct userspace programmers on how to special
>> case ext4 and XFS for the same piece of functionality.
>=20
> Wouldn't it be more confusing for the user to have 2 different flags which=
 do
> the same thing?
>=20
> I would think that using FS_XFLAG_DAX _only_ (for both ext4 and xfs) would=
 be
> easier without special cases?
>=20
> Ira
>=20

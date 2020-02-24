Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF7016A78B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 14:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbgBXNqs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 08:46:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35759 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725535AbgBXNqs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 08:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582552006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y8ecsNHdnLw04uWOJgR7gWMO6EOFZjTJ6zejnqJyQQ0=;
        b=SyMF5TKay8sgy6OgSw0904SzFwQssuEENI4mqWmJcGlQuM17ToKp5uf8+UyqUORUpvlNOv
        4tz0dk31K8TlMkNVesqAHDGpZaqKcFwPW3/8O2HsR7k7txxRAdbrLfBF0ApX58U40BonOq
        TdiouNKahD+fxNxJySVlgSx0jH7o1iw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-z4yOuXrrOMORUtfbeHlWeA-1; Mon, 24 Feb 2020 08:46:42 -0500
X-MC-Unique: z4yOuXrrOMORUtfbeHlWeA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFF5E18A6EC1;
        Mon, 24 Feb 2020 13:46:41 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C47191833;
        Mon, 24 Feb 2020 13:46:41 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     fstests@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH V2 3/3] xfs/300: modify test to work on any fs block size
References: <20200220200632.14075-1-jmoyer@redhat.com>
        <20200220200632.14075-4-jmoyer@redhat.com>
        <20200222053152.GM14282@dhcp-12-102.nay.redhat.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Mon, 24 Feb 2020 08:46:40 -0500
In-Reply-To: <20200222053152.GM14282@dhcp-12-102.nay.redhat.com> (Zorro Lang's
        message of "Sat, 22 Feb 2020 13:31:53 +0800")
Message-ID: <x49ftf0p073.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Zorro Lang <zlang@redhat.com> writes:

> On Thu, Feb 20, 2020 at 03:06:32PM -0500, Jeff Moyer wrote:
>> The test currently assumes a file system block size of 4k.  It will
>> work just fine on any user-specified block size, though.
>> 
>> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
>> ---
>>  tests/xfs/300 | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/tests/xfs/300 b/tests/xfs/300
>> index 28608b81..4f1c927a 100755
>> --- a/tests/xfs/300
>> +++ b/tests/xfs/300
>> @@ -50,8 +50,9 @@ $XFS_IO_PROG -f -c "pwrite -S 0x63 0 4096" $SCRATCH_MNT/attrvals >> $seqres.full
>>  cat $SCRATCH_MNT/attrvals | attr -s name $SCRATCH_MNT/$seq.test >> $seqres.full 2>&1
>>  
>>  # Fragment the file by writing backwards
>> +bs=$(_get_file_block_size $SCRATCH_MNT)
>>  for I in `seq 6 -1 0`; do
>> -	dd if=/dev/zero of=$SCRATCH_MNT/$seq.test seek=$I bs=4k \
>> +	dd if=/dev/zero of=$SCRATCH_MNT/$seq.test seek=$I bs=${bs} \
>
> Although the original case won't fail on 64k test. But this change makes
> more sense.

It will fail for the case mentioned in the cover letter.  That is:

MKFS_OPTIONS="-m reflink=0 -b size=65536" MOUNT_OPTIONS="-o dax"

on a system with >4k page size (xfs, in this case).

Thanks,
Jeff


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC26730F32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 08:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbjFOGVY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 02:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243484AbjFOGVS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:21:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB38F213F;
        Wed, 14 Jun 2023 23:21:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 498BB21A98;
        Thu, 15 Jun 2023 06:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686810071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=biUIRbFtv4J5T47mu3LPEV5ukQGdv1abBVElBuXklZE=;
        b=ABpAS2iN+77+SWTFncbqQEqlqkmCWDTbFIBltIfmeyivtFMQlNSQSQL6Upge8/miL9KJYj
        ybUd5fY7HEBrWXIxK/vxDkMxnxPj3v5UkG+ORJdqTWgUAL2m7k7baCWjcraIH5X7OxWb8l
        Zdx29Psz834PXJ2NpK5yeXDppxF709o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686810071;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=biUIRbFtv4J5T47mu3LPEV5ukQGdv1abBVElBuXklZE=;
        b=MaCJaaYRzFshDmLg0yPD3GElWb1H/EdU7162MpR4sbWK+JgoRtRpKo0NZX0MpsbM1ouwX1
        +8Ap494dmNO7ubDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0153913467;
        Thu, 15 Jun 2023 06:21:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Wp4POtatimQJcAAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 15 Jun 2023 06:21:10 +0000
Message-ID: <df8e7a88-f540-af93-77dc-164262a5a3d0@suse.de>
Date:   Thu, 15 Jun 2023 08:21:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/7] RFC: high-order folio support for I/O
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20230614114637.89759-1-hare@suse.de>
 <cd816905-0e3e-6397-1a6f-fd4d29dfc739@suse.de>
 <ZInGbz6X/ZQAwdRx@casper.infradead.org>
 <b3fa1b77-d120-f86b-e02f-f79b6d13efcc@suse.de>
 <ZIpS9u4P43PgJwuj@dread.disaster.area>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZIpS9u4P43PgJwuj@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/15/23 01:53, Dave Chinner wrote:
> On Wed, Jun 14, 2023 at 05:06:14PM +0200, Hannes Reinecke wrote:
>> On 6/14/23 15:53, Matthew Wilcox wrote:
>>> On Wed, Jun 14, 2023 at 03:17:25PM +0200, Hannes Reinecke wrote:
>>>> Turns out that was quite easy to fix (just remove the check in
>>>> set_blocksize()), but now I get this:
>>>>
>>>> SGI XFS with ACLs, security attributes, quota, no debug enabled
>>>> XFS (ram0): File system with blocksize 16384 bytes. Only pagesize (4096) or
>>>> less will currently work.
>>>
>>> What happens if you just remove this hunk:
>>>
>>> +++ b/fs/xfs/xfs_super.c
>>> @@ -1583,18 +1583,6 @@ xfs_fs_fill_super(
>>>                   goto out_free_sb;
>>>           }
>>>
>>> -       /*
>>> -        * Until this is fixed only page-sized or smaller data blocks work.
>>> -        */
>>> -       if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
>>> -               xfs_warn(mp,
>>> -               "File system with blocksize %d bytes. "
>>> -               "Only pagesize (%ld) or less will currently work.",
>>> -                               mp->m_sb.sb_blocksize, PAGE_SIZE);
>>> -               error = -ENOSYS;
>>> -               goto out_free_sb;
>>> -       }
>>> -
>>>           /* Ensure this filesystem fits in the page cache limits */
>>>           if (xfs_sb_validate_fsb_count(&mp->m_sb, mp->m_sb.sb_dblocks) ||
>>>               xfs_sb_validate_fsb_count(&mp->m_sb, mp->m_sb.sb_rblocks)) {
>>
>> Whee! That works!
>>
>> Rebased things with your memcpy_{to,from}_folio() patches, disabled that
>> chunk, and:
>>
>> # mount /dev/ram0 /mnt
>> XFS (ram0): Mounting V5 Filesystem 5cd71ab5-2d11-4c18-97dd-71708f40e551
>> XFS (ram0): Ending clean mount
>> xfs filesystem being mounted at /mnt supports timestamps until 2038-01-19
>> (0x7fffffff)
>> # umount /mnt
>> XFS (ram0): Unmounting Filesystem 5cd71ab5-2d11-4c18-97dd-71708f40e551
> 
> Mounting the filesystem doesn't mean it works. XFS metadata has
> laways worked with bs > ps, and mounting the filesystem only does
> metadata IO.
> 
> It's not until you start reading/writing user data that the
> filesystem will start exercising the page cache....
> 
>> Great work, Matthew!
>>
>> (Now I just need to check why copying data from NFS crashes ...)
> 
> .... and then we see it doesn't actually work. :)
> 
> Likely you also need the large folio support in the iomap write path
> patches from Willy, plus whatever corner cases in iomap that still
> have implicit dependencies on PAGE_SIZE need to be fixed (truncate,
> invalidate, sub-block zeroing, etc may not be doing exactly the
> right thing).
> 
These are built on top of the mm-unstable branch from akpm, which does 
include the iomap write path patches from Willy, so yes, I know.

> All you need to do now is run the BS > PS filesytems through a full
> fstests pass (reflink + rmap enabled, auto group), and then we can
> start on the real data integrity validation work. It'll need tens of
> billions of fsx ops run on it, days of recoveryloop testing, days of
> fstress based exercise, etc before we can actually enable it in
> XFS....
> 
Hey, c'mon. I do know _that_. All I'm saying is that now we can _start_
running tests and figure out corner cases (like NFS crashing on me :-).
With this patchset we now have some infrastructure in place making it
even _possible_ to run those tests.

Don't be so pessimistic ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


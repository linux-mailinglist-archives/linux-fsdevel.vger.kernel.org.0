Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8F66DF733
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 15:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjDLNan (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 09:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDLNal (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:30:41 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035AC8A68
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 06:30:13 -0700 (PDT)
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 33CDTcCi076644;
        Wed, 12 Apr 2023 22:29:38 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Wed, 12 Apr 2023 22:29:38 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 33CDTbZx076638
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 12 Apr 2023 22:29:37 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <60f6bb85-825c-95e2-79b8-25a2d0e9979e@I-love.SAKURA.ne.jp>
Date:   Wed, 12 Apr 2023 22:29:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] fs/ntfs3: disable page fault during ntfs_fiemap()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     syzbot <syzbot+96cee7d33ca3f87eee86@syzkaller.appspotmail.com>,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Hillf Danton <hdanton@sina.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, trix@redhat.com,
        ndesaulniers@google.com, nathan@kernel.org
References: <000000000000e2102c05eeaf9113@google.com>
 <00000000000031b80705ef5d33d1@google.com>
 <f649c9c0-6c0c-dd0d-e3c9-f0c580a11cd9@I-love.SAKURA.ne.jp>
 <ZDaujCO3Azv92JxX@casper.infradead.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <ZDaujCO3Azv92JxX@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/04/12 22:13, Matthew Wilcox wrote:
>> Also, since Documentation/filesystems/fiemap.rst says that "If an error
>> is encountered while copying the extent to user memory, -EFAULT will be
>> returned.", I assume that ioctl(FS_IOC_FIEMAP) users can handle -EFAULT
>> error.
> 
> What?  No, that doesn't mean "You can return -EFAULT because random luck".
> That means "If you pass it an invalid address, you'll get -EFAULT back".
> 
> NACK.

Then, why does fiemap.rst say "If an error is encountered" rather than
"If an invalid address is passed" ?

Does the definition of -EFAULT limited to "the caller does not have permission
to access this address" ?

----------
int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
			    u64 phys, u64 len, u32 flags)
{
	struct fiemap_extent extent;
	struct fiemap_extent __user *dest = fieinfo->fi_extents_start;

	/* only count the extents */
	if (fieinfo->fi_extents_max == 0) {
		fieinfo->fi_extents_mapped++;
		return (flags & FIEMAP_EXTENT_LAST) ? 1 : 0;
	}

	if (fieinfo->fi_extents_mapped >= fieinfo->fi_extents_max)
		return 1;

	if (flags & SET_UNKNOWN_FLAGS)
		flags |= FIEMAP_EXTENT_UNKNOWN;
	if (flags & SET_NO_UNMOUNTED_IO_FLAGS)
		flags |= FIEMAP_EXTENT_ENCODED;
	if (flags & SET_NOT_ALIGNED_FLAGS)
		flags |= FIEMAP_EXTENT_NOT_ALIGNED;

	memset(&extent, 0, sizeof(extent));
	extent.fe_logical = logical;
	extent.fe_physical = phys;
	extent.fe_length = len;
	extent.fe_flags = flags;

	dest += fieinfo->fi_extents_mapped;
	if (copy_to_user(dest, &extent, sizeof(extent)))
		return -EFAULT;

	fieinfo->fi_extents_mapped++;
	if (fieinfo->fi_extents_mapped == fieinfo->fi_extents_max)
		return 1;
	return (flags & FIEMAP_EXTENT_LAST) ? 1 : 0;
}
----------

If copy_to_user() must not fail other than "the caller does not have
permission to access this address", what should we do for now?
Just remove ntfs_fiemap() and return -EOPNOTSUPP ?


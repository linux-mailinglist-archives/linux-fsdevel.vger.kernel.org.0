Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA44D31B750
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 11:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhBOKjE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 05:39:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:44206 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229802AbhBOKjC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 05:39:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6C69FAC32;
        Mon, 15 Feb 2021 10:38:20 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 3e5d9e0a;
        Mon, 15 Feb 2021 10:39:22 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] fs: Add flag to file_system_type to indicate
 content is generated
References: <20210212044405.4120619-1-drinkcat@chromium.org>
        <20210212124354.1.I7084a6235fbcc522b674a6b1db64e4aff8170485@changeid>
        <YCYybUg4d3+Oij4N@kroah.com>
        <CAOQ4uxhovoZ4S3WhXwgYDeOeomBxfQ1BdzSyGdqoVX6boDOkeA@mail.gmail.com>
        <YCY+tjPgcDmgmVD1@kroah.com> <871rdljxtx.fsf@suse.de>
        <YCZyBZ1iT+MUXLu1@kroah.com> <87sg61ihkj.fsf@suse.de>
        <CAOQ4uxi-VuBmE8Ej_B3xmBnn1nmp9qpiA-BkNpPcrE0PCRp1UA@mail.gmail.com>
Date:   Mon, 15 Feb 2021 10:39:22 +0000
In-Reply-To: <CAOQ4uxi-VuBmE8Ej_B3xmBnn1nmp9qpiA-BkNpPcrE0PCRp1UA@mail.gmail.com>
        (Amir Goldstein's message of "Mon, 15 Feb 2021 08:12:03 +0200")
Message-ID: <87h7mdvcmd.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

> On Fri, Feb 12, 2021 at 2:40 PM Luis Henriques <lhenriques@suse.de> wrote:
...
>> Sure, I just wanted to point out that *maybe* there are other options than
>> simply reverting that commit :-)
>>
>> Something like the patch below (completely untested!) should revert to the
>> old behaviour in filesystems that don't implement the CFR syscall.
>>
>> Cheers,
>> --
>> Luis
>>
>> diff --git a/fs/read_write.c b/fs/read_write.c
>> index 75f764b43418..bf5dccc43cc9 100644
>> --- a/fs/read_write.c
>> +++ b/fs/read_write.c
>> @@ -1406,8 +1406,11 @@ static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
>>                                                        file_out, pos_out,
>>                                                        len, flags);
>>
>> -       return generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
>> -                                      flags);
>> +       if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
>> +               return -EXDEV;
>> +       else
>> +               generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
>> +                                       flags);
>>  }
>>
>
> Which kernel is this patch based on?

It was v5.11-rc7.

> At this point, I am with Dave and Darrick on not falling back to
> generic_copy_file_range() at all.
>
> We do not have proof of any workload that benefits from it and the
> above patch does not protect from a wierd use case of trying to copy a file
> from sysfs to sysfs.
>

Ok, cool.  I can post a new patch doing just that.  I guess that function
do_copy_file_range() can be dropped in that case.

> I am indecisive about what should be done with generic_copy_file_range()
> called as fallback from within filesystems.
>
> I think the wise choice is to not do the fallback in any case, but this is up
> to the specific filesystem maintainers to decide.

I see what you mean.  You're suggesting to have userspace handle all the
-EOPNOTSUPP and -EXDEV errors.  Would you rather have a patch that also
removes all the calls to generic_copy_file_range() function?  And that
function can also be deleted too, of course.

Cheers,
-- 
Luis

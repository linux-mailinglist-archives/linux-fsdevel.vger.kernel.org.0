Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1ED31A105
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 16:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhBLPBg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 10:01:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:43894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhBLPBf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 10:01:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 014C8AC90;
        Fri, 12 Feb 2021 15:00:54 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id d8a92aa3;
        Fri, 12 Feb 2021 15:01:55 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
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
        <YCaMgtpCzPrLjw9c@kroah.com>
Date:   Fri, 12 Feb 2021 15:01:54 +0000
In-Reply-To: <YCaMgtpCzPrLjw9c@kroah.com> (Greg KH's message of "Fri, 12 Feb
        2021 15:11:14 +0100")
Message-ID: <87lfbtib31.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> writes:

> On Fri, Feb 12, 2021 at 12:41:48PM +0000, Luis Henriques wrote:
>> Greg KH <gregkh@linuxfoundation.org> writes:
...
>> >> >> Our option now are:
>> >> >> - Restore the cross-fs restriction into generic_copy_file_range()
>> >> >
>> >> > Yes.
>> >> >
>> >> 
>> >> Restoring this restriction will actually change the current cephfs CFR
>> >> behaviour.  Since that commit we have allowed doing remote copies between
>> >> different filesystems within the same ceph cluster.  See commit
>> >> 6fd4e6348352 ("ceph: allow object copies across different filesystems in
>> >> the same cluster").
>> >> 
>> >> Although I'm not aware of any current users for this scenario, the
>> >> performance impact can actually be huge as it's the difference between
>> >> asking the OSDs for copying a file and doing a full read+write on the
>> >> client side.
>> >
>> > Regression in performance is ok if it fixes a regression for things that
>> > used to work just fine in the past :)
>> >
>> > First rule, make it work.
>> 
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
>>  						       file_out, pos_out,
>>  						       len, flags);
>>  
>> -	return generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
>> -				       flags);
>> +	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
>> +		return -EXDEV;
>> +	else
>> +		generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
>> +					flags);
>>  }
>>  
>>  /*
>
> That would make much more sense to me.

Great.  I can send a proper patch with changelog, if this is the really
what we want.  But I would rather hear from others first.  I guess that at
least the NFS devs have something to say here.

Cheers,
-- 
Luis

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE580124A8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 16:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfLRPBc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 10:01:32 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41155 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfLRPBc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:01:32 -0500
Received: by mail-qk1-f196.google.com with SMTP id x129so1771837qke.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2019 07:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dksQ3sa6x+MBXi5EvTI6N5sQp4eN9RCuqeUBSUeiFHI=;
        b=QWd4WWXI10mJymRIsZ49KaESBWBDoT1eSgFAm3FN3AUlcJPTx0dDQ0nn96xIZdVGXj
         9knLtiLdO4GPhWhG5Xl3J9/1N8c1YpYCojSmcjzcJhNS0eakk2HTvyw3roD6PqMaOi8E
         0X9Lek+m7WC1gENUZrQwiHOKVXhIGiwZYvUx6sH5DHiKaJvllROZ5Y1KEWrydnGYMxKZ
         nsmCFAOJd7gm3stvh1qtuWSkAobV1K2dA+8OUnvimyKi6KTmQFUHMIK3+MFyLSukQ/FD
         bhqrstPnJimg+hCXDpxNbaAdaHefdo/a2vvkHkfoDne6K7Be45cePqZrFi8ngzb52HlL
         Z5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dksQ3sa6x+MBXi5EvTI6N5sQp4eN9RCuqeUBSUeiFHI=;
        b=h5beTLxOjGNVgVXlwOXpJqDXsKw0Fez61JKnfccqPnscas7eAbsbZc7IK9FLiMT/OA
         dXJh2+KN0iJM8ErOi0dl6/owzIM89yTC0P8c98fHmhGBLQ2u07wQHvzu1PPiydaKWSvn
         i7pO/iW3HJ+yu3Rt+JLHPvdhAuFd8E+exoHEqfOtaBEqRIPtuETumKMIiviSVoyKKBtQ
         GrjIeK6+nwmmJOI5igcWw2ikjZA8jSAZLT2TWbFMCdZK24/NbTnxZgK9hNdGEjgxG+XQ
         Va5bPqdOOK6eXkw7rel9+GFHTGJ1KYKoAkxMn/tgjhAQMUJCjZ1sN4STR0EJx/vHvc8h
         heHg==
X-Gm-Message-State: APjAAAV6xPzwsBPT8flI32gdV9cBcNxcoDsGsDUwfSnkjGKZ9lto7fb0
        1RJsAIy5VrVz6KRcO7OSmho4VtT5HG6fnw==
X-Google-Smtp-Source: APXvYqx/TzsrHeabP28pH0c9OJ4meVk6tjQeeCz0NUdpRuB6R0Q7+1s36AoSKdIGDVAWSJPIRQevKg==
X-Received: by 2002:ae9:ed53:: with SMTP id c80mr2785219qkg.445.1576681291074;
        Wed, 18 Dec 2019 07:01:31 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o9sm732800qko.16.2019.12.18.07.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 07:01:30 -0800 (PST)
Subject: Re: [PATCH v6 24/28] btrfs: enable relocation in HMZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-25-naohiro.aota@wdc.com>
 <83984f9c-4f37-4a04-daea-8169959dc09d@toxicpanda.com>
 <20191218104920.ozsa3pawkvxs2gg5@naota.dhcp.fujisawa.hgst.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b538ea95-9493-88b7-de6e-fa94dca43665@toxicpanda.com>
Date:   Wed, 18 Dec 2019 10:01:29 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191218104920.ozsa3pawkvxs2gg5@naota.dhcp.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/18/19 5:49 AM, Naohiro Aota wrote:
> On Tue, Dec 17, 2019 at 04:32:04PM -0500, Josef Bacik wrote:
>> On 12/12/19 11:09 PM, Naohiro Aota wrote:
>>> To serialize allocation and submit_bio, we introduced mutex around them. As
>>> a result, preallocation must be completely disabled to avoid a deadlock.
>>>
>>> Since current relocation process relies on preallocation to move file data
>>> extents, it must be handled in another way. In HMZONED mode, we just
>>> truncate the inode to the size that we wanted to pre-allocate. Then, we
>>> flush dirty pages on the file before finishing relocation process.
>>> run_delalloc_hmzoned() will handle all the allocation and submit IOs to
>>> the underlying layers.
>>>
>>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>> ---
>>>  fs/btrfs/relocation.c | 39 +++++++++++++++++++++++++++++++++++++--
>>>  1 file changed, 37 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>>> index d897a8e5e430..2d17b7566df4 100644
>>> --- a/fs/btrfs/relocation.c
>>> +++ b/fs/btrfs/relocation.c
>>> @@ -3159,6 +3159,34 @@ int prealloc_file_extent_cluster(struct inode *inode,
>>>      if (ret)
>>>          goto out;
>>> +    /*
>>> +     * In HMZONED, we cannot preallocate the file region. Instead,
>>> +     * we dirty and fiemap_write the region.
>>> +     */
>>> +
>>> +    if (btrfs_fs_incompat(btrfs_sb(inode->i_sb), HMZONED)) {
>>> +        struct btrfs_root *root = BTRFS_I(inode)->root;
>>> +        struct btrfs_trans_handle *trans;
>>> +
>>> +        end = cluster->end - offset + 1;
>>> +        trans = btrfs_start_transaction(root, 1);
>>> +        if (IS_ERR(trans))
>>> +            return PTR_ERR(trans);
>>> +
>>> +        inode->i_ctime = current_time(inode);
>>> +        i_size_write(inode, end);
>>> +        btrfs_ordered_update_i_size(inode, end, NULL);
>>> +        ret = btrfs_update_inode(trans, root, inode);
>>> +        if (ret) {
>>> +            btrfs_abort_transaction(trans, ret);
>>> +            btrfs_end_transaction(trans);
>>> +            return ret;
>>> +        }
>>> +        ret = btrfs_end_transaction(trans);
>>> +
>>> +        goto out;
>>> +    }
>>> +
>>
>> Why are we arbitrarily extending the i_size here?  If we don't need prealloc 
>> we don't need to jack up the i_size either.
> 
> We need to extend i_size to read data from the relocating block
> group. If not, btrfs_readpage() in relocate_file_extent_cluster()
> always reads zero filled page because the read position is beyond the
> file size.

Right but the finish_ordered_io stuff will do the btrfs_ordered_update_i_size() 
once the IO is complete.  So all you really need is the i_size_write and the 
btrfs_update_inode.  If this crashes you'll have an inode that has a i_size with 
no extents up to i_size.  This is fine for NO_HOLES but not fine for !NO_HOLES. 
Thanks,

Josef

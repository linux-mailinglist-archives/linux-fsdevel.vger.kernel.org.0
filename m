Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFB2166124
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 16:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgBTPk1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 10:40:27 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37088 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbgBTPk1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:40:27 -0500
Received: by mail-qt1-f193.google.com with SMTP id w47so3156969qtk.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2020 07:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pG5MkXxCeuCZIKIFNqO5HTyMOUbsXrUTwPXXM/d93rU=;
        b=IIFD+qdrnk8Y4oHH5PM228Hz8a6dlq39Ww6KJJBMJE874vDuWxSbReo/E1vQINgyX/
         Ue0nfI4jw3sbGyOZV1qnwVusge1jmmdiFXBB2P+/I+OuUmoXBZ7EnVeLyCt2P2Us8z4R
         LNc0lWHjF7g0hVB4ece8WvIAxkw3k1gcaTCuKBmvjkg/45CPrkxeYLARFy7WftKnFfxi
         bkI5hohvTaI1FTxciMFr46IFiqVnAdJRB1szjdFMgPldrYp7wTY/w5OEDyZrep8IfgKK
         XRvzzGmRzg5fKHqWMbqDt9dWZnNS0adwSBC9LZU0uF619zNoCzHNAKO5AqotIB0v8GJW
         8rNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pG5MkXxCeuCZIKIFNqO5HTyMOUbsXrUTwPXXM/d93rU=;
        b=XCVaTy9FVU1xP0TgwK6L6/y1z53t0CtnqEL4vCuDiH/S0Poib3kD8oi22hYDVwqWrt
         4qY+nxqCuIllqSBXfZSr8bCDmv+eS7EtIubDrTX5h2lKpejpvm1fER+ro5fzGr2mLHZB
         XXRwZJ23bzqxtG7w9jlfxtuqOil/npa7h1eX6S1CfWDMWl2P9L8WyCylguSbL8WFbOzZ
         0NEngrHXUDFwD0kGiGKoAO0zm4FdGGpeatPSQxSAfGkYDOpBYrmjPY5sEIADDa6a6uTH
         8eMYU7Gj/HAgzdKzKTSKKWL3DJOQUKjTBH/XyA7mLrJNiPdIl9lbZxD/b5hZ7Cs1hrcG
         ia/A==
X-Gm-Message-State: APjAAAUBxm9OYgD+WpECk11Ntiv2LFwDYZfz2eWi3BAfom0+6ILt4+3p
        voUIOyQ8lr/NzdFAu/ZApj0wkV1S6lo=
X-Google-Smtp-Source: APXvYqw90UWcGHdZJd3pH+52vj9OqjrkSO9+eoTy5VyjmV8zuutck5zDuQ/O62Wrhb2uY5iUP1fUSA==
X-Received: by 2002:ac8:969:: with SMTP id z38mr26231541qth.203.1582213224792;
        Thu, 20 Feb 2020 07:40:24 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l8sm1853738qtr.36.2020.02.20.07.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 07:40:23 -0800 (PST)
Subject: Re: [PATCH v2 20/21] btrfs: skip LOOP_NO_EMPTY_SIZE if not clustered
 allocation
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-21-naohiro.aota@wdc.com>
 <b8908ae0-9e4d-5086-0d4c-768d45215695@toxicpanda.com>
 <20200220095631.7rlk7lmnp7np4nvg@naota.dhcp.fujisawa.hgst.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c0829c4d-17b1-ad99-c99e-87f859f290e4@toxicpanda.com>
Date:   Thu, 20 Feb 2020 10:40:22 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200220095631.7rlk7lmnp7np4nvg@naota.dhcp.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/20/20 4:56 AM, Naohiro Aota wrote:
> On Thu, Feb 13, 2020 at 02:55:30PM -0500, Josef Bacik wrote:
>> On 2/12/20 2:20 AM, Naohiro Aota wrote:
>>> LOOP_NO_EMPTY_SIZE is solely dedicated for clustered allocation. So,
>>> we can skip this stage and go to LOOP_GIVEUP stage to indicate we gave
>>> up the allocation. This commit also moves the scope of the "clustered"
>>> variable.
>>>
>>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>> ---
>>>  fs/btrfs/extent-tree.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>>> index 8f0d489f76fa..3ab0d2f5d718 100644
>>> --- a/fs/btrfs/extent-tree.c
>>> +++ b/fs/btrfs/extent-tree.c
>>> @@ -3373,6 +3373,7 @@ enum btrfs_loop_type {
>>>      LOOP_CACHING_WAIT,
>>>      LOOP_ALLOC_CHUNK,
>>>      LOOP_NO_EMPTY_SIZE,
>>> +    LOOP_GIVEUP,
>>
>> Why do we need a new loop definition here?  Can we just return ENOSPC and be 
>> done?  You don't appear to use it anywhere, so it doesn't seem like it's 
>> needed.  Thanks,
>>
>> Josef
> 
> This is for other allocation policy to skip unnecessary loop stages
> (e.g. LOOP_NO_EMPTY_SIZE) from an earlier stage. For example, zoned
> allocation policy can implement the code below in
> chunk_allocation_failed() to skip the following stages.
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 4badfae0c932..0a18c09b078b 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -3775,6 +3854,10 @@ static int chunk_allocation_failed(struct 
> find_free_extent_ctl *ffe_ctl)
>                   */
>                  ffe_ctl->loop = LOOP_NO_EMPTY_SIZE;
>                  return 0;
> +       case BTRFS_EXTENT_ALLOC_ZONED:
> +               /* give up here */
> +               ffe_ctl->loop = LOOP_GIVEUP;
> +               return -ENOSPC;
>          default:
>                  BUG();
>          }
> 
> But, I can keep this LOOP_GIVEUP introduction patch later with this
> zoned allocator ones.
> 

Yes I'd rather they be with the real user, otherwise it's just confusing.  Thanks,

Josef

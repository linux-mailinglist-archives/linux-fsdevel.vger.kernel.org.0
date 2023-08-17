Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13EE77FBE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 18:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353591AbjHQQVS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 12:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353657AbjHQQVJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:21:09 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB33198E;
        Thu, 17 Aug 2023 09:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OsS8Mas9KAp23jcsVOoXmpRjn2+jYWyQq801JbjkoT4=; b=XoNWhO4Ge7W+lgDlg7/5UQwIMj
        EQUwJQxLewaunOhp3MMgtOld1TRMXT8VEbEqFIeShmHLsqY9IEJfhCHxOiq+9TwW4ppryLKR1fIgo
        g7gmAuojXmmhuLQBShUAiEk3sGELRVP/+usN7aOdf1CsDTf6iiB5/+s60nU3s9EvY0gmqUemGBmYo
        MIAqCZhQR4X2pciBNCbblreZkXSvkQAebN8bG5lPFhYAKIOMlF80YgHFASNwBrit+is9DZ+0dgtEW
        426CoBL8d/jjro/tS9CYUbRJJvqIPaUHeFfCNza7GJYxswhXGI5ZDfX5uOJYH2aoUWf3zJF0OklkN
        JYHCE8KA==;
Received: from 201-92-22-215.dsl.telesp.net.br ([201.92.22.215] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qWfk8-001z1K-Gd; Thu, 17 Aug 2023 18:21:04 +0200
Message-ID: <b49d3f4c-4b3d-06f4-7a37-7383af0781d0@igalia.com>
Date:   Thu, 17 Aug 2023 13:20:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] btrfs: Introduce the single-dev feature
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, anand.jain@oracle.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
References: <20230803154453.1488248-1-gpiccoli@igalia.com>
 <20230803154453.1488248-3-gpiccoli@igalia.com>
 <20230817154127.GB2934386@perftesting>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230817154127.GB2934386@perftesting>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17/08/2023 12:41, Josef Bacik wrote:
>> [...]
>> +	pr_info("BTRFS: virtual fsid (%pU) set for SINGLE_DEV device %s (real fsid %pU)\n",
>> +		disk_super->fsid, path, disk_super->metadata_uuid);
> 
> I think just
> 
> btrfs_info(NULL, "virtual fsid....")
> 
> is fine here.
> 

So just for my full understanding, do you think we shouldn't show the
real fsid here, but keep showing the virtual one, right? Or you prefer
we literally show "virtual fsid...."?


>> +}
>> +
>>  /*
>> - * Add new device to list of registered devices
>> + * Add new device to list of registered devices, or in case of a SINGLE_DEV
>> + * device, also creates a virtual fsid to cope with same-fsid cases.
>>   *
>>   * Returns:
>>   * device pointer which was just added or updated when successful
>> @@ -784,7 +814,7 @@ static struct btrfs_fs_devices *find_fsid_reverted_metadata(
>>   */
>>  static noinline struct btrfs_device *device_list_add(const char *path,
>>  			   struct btrfs_super_block *disk_super,
>> -			   bool *new_device_added)
>> +			   bool *new_device_added, bool single_dev)
> 
> Same as the comment above.  Generally speaking for stuff like this where we can
> derive the value local to the function we want to do that instead of growing the
> argument list.  Thanks,
> 
> Josef
> 

OK, will do it both here and above as you suggested. Thanks for the review!
Cheers,


Guilherme

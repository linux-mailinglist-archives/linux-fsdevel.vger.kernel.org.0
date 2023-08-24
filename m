Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1297879C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 22:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243631AbjHXU4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 16:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243630AbjHXUzq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 16:55:46 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F78199F;
        Thu, 24 Aug 2023 13:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3YQd/4pI3FjAPT+eeZM7Z9PL3COhGrtkB7spEOXmvmg=; b=UNyqD/7TLBJppu3dma3rcUvj2k
        JFNH5aB+Mz3IXeqB1F8u8BYtvv1cOlC12p8pavZVpD+EOl4XGdEQhJqeTGsTBULLLQ8hu5CUVkrtF
        k4o7HukKn/oPbg08YVJyge6I1L0xEQUhfYSBadh+uGvmKUJQa7oXTo8Kw8sJdzSR/A4ooDW7uqlzJ
        SVcpXusYLfeNig6fL7haKSI2NAY8SWIp1OIxJIqi5GjtOs6rgzepQApMYeWuM94YCaoasZWLonz/c
        W758CznU0320l1NOTIa39gRBZ469lBzfJIUWnzQF2ImDS8SFhUb1w+E8YfPVfg5JwgcjCG2EXl/Bh
        OvfU3ZmA==;
Received: from [187.116.122.196] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qZHMg-00F4bN-Br; Thu, 24 Aug 2023 22:55:38 +0200
Message-ID: <cf39f8e5-0419-3772-341e-11631af1b430@igalia.com>
Date:   Thu, 24 Aug 2023 17:55:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] btrfs: Introduce the single-dev feature
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
References: <20230803154453.1488248-1-gpiccoli@igalia.com>
 <20230803154453.1488248-3-gpiccoli@igalia.com>
 <9dae9ca5-be94-af95-e7c3-0cb1d04731f2@oracle.com>
Content-Language: en-US
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <9dae9ca5-be94-af95-e7c3-0cb1d04731f2@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Anand, first of all, thanks for the review! More comments inline below.


On 23/08/2023 13:31, Anand Jain wrote:
> [...]
> On 8/3/23 23:43, Guilherme G. Piccoli wrote:
>> Btrfs doesn't currently support to mount 2 different devices holding the
>> same filesystem - the fsid is used as a unique identifier in the driver.
> 
> fsid is for the external frontend, systemd, and udev stuff;
> metadata_uuid pertains to the actual btrfs on-disk.
>

True, agreed - but I guess my phrase is not wrong per se, right? It's
more like an "abstraction" of the concept...I'm in fact talking about
the fsid as the exposed entity to the system, like for udev, etc.

I guess I'll keep it on V3 if you don't oppose.


> [...] 
>> one of the reasons for which is not trivial supporting this case
>> on btrfs is due to its multi-device filesystem nature, native RAID, etc.
> 
> How is it related to the multi-device aspect? The main limitation is
> that a disk image can be cloned without maintaining a unique device-
> uuid.
> 

Oh okay, I'll rephrase / drop this part, you're right - thanks.


> [...]
>> Without this support, it's not safe for users to keep the
>> same "image version" in both A and B partitions, a setup that is quite
>> common for development, for example. Also, as a big bonus, it allows fs
>> integrity check based on block devices for RO devices (whereas currently
>> it is required that both have different fsid, breaking the block device
>> hash comparison).
> 
> Does it apply to smaller disk images? Otherwise, it will be very 
> time-consuming. Just curious, how is the checksum verified for the entire
> disk? (Btrfs might provide a checksum tree-based solution at
> some point.)
>

The disk image is currently 5G, NVMe device - it's usually fast in our case.

After discussing internally with the folks knowledgeable about the
update process, it seems the Desync tool is responsible for that, taking
an index chunk-comparison during the update. Based in my quick check,
seems the codes related to that are here:

https://github.com/folbricht/desync/blob/master/verifyindex.go
https://github.com/folbricht/desync/blob/master/index.go


>> +	 */
>> +	if (btrfs_fs_compat_ro(fs_info, SINGLE_DEV))
>> +		fsid = fs_info->fs_devices->metadata_uuid;
>> +	else
>> +		fsid = fs_info->fs_devices->fsid;
> 
> Below alloc_fs_device(), fsid is still being kept equal to metadata_uuid
> in memory for single_dev. So, this distinction is unnecessary.
> 
> 
>> +
>> +	if (memcmp(fsid, sb->fsid, BTRFS_FSID_SIZE)) {
> 
> David prefers memcmp to be either compared to == or != to 0
> depending on the requirement.
> 

OK, thanks - I'll experiment dropping this part, and I see you have code
present in for-next, changing this specific memcmp. So hopefully don't
need my code anymore but if we do, I'll keep the convention =)


> [...]
>> -static u8 *btrfs_sb_metadata_uuid_or_null(struct btrfs_super_block *sb)
>> +static u8 *btrfs_sb_metadata_uuid_single_dev(struct btrfs_super_block *sb,
>> +					     bool has_metadata_uuid,
>> +					     bool single_dev)
>>   {
>> -	bool has_metadata_uuid = (btrfs_super_incompat_flags(sb) &
>> -				  BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
>> +	if (has_metadata_uuid || single_dev)
>> +		return sb->metadata_uuid;
>>   
>> -	return has_metadata_uuid ? sb->metadata_uuid : NULL;
>> +	return NULL;
>>   }
>>   
>>   u8 *btrfs_sb_fsid_ptr(struct btrfs_super_block *sb)
> 
> You can rebase the code onto the latest misc-next branch.
> This is because we have dropped the function
> btrfs_sb_metadata_uuid_or_null() in the final integration.
> [...]
>> -				btrfs_sb_metadata_uuid_or_null(disk_super));
>> +				btrfs_sb_metadata_uuid_single_dev(disk_super,
>> +							has_metadata_uuid, single_dev));
> 
> I think it is a good idea to rebase on latest misc-next and add the
> below patch, as the arguments of alloc_fs_device() have been simplified.
> 
>     [PATCH resend] btrfs: simplify alloc_fs_devices() remove arg2
> 
> 

Very good idea, thanks for pointing that, will do it for V3!
Cheers,


Guilherme

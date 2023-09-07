Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F02079748E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 17:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbjIGPjx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 11:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245473AbjIGPgj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:36:39 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFCE1FEF;
        Thu,  7 Sep 2023 08:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=15P0rxQmct0H/vxkeXgXMbJboUm3Wf8cAnjBEyPzXk8=; b=mQjaRNaqtU6hXc+r/oaKH0ipIj
        yK9pXs0w+8uqMI5SYGjLaaglGoQoAemOFBz/kqBuRjnvw4wxrFrWAJ4Nlt+q3TNlW97LxTGYcL0zw
        f09VYyFofiiipJYvVQjyD6vPrboCxydNB+yLRApcltA4paVzAaMWbCP2pIv5tIBSKafCppXeP6+WQ
        tZdPgl32xnBVtPJhLXKo5pYKp9zZmsUDdyeU10K9W8jvykreVx7wcakPoKD3db7IRf96UdAQJhATH
        fvi79wYjyuOOGG0fiWS3tR+/jcVGiGOspg8g3X/9NJqA7IJRdWfjNcLHFsNbN0y8ERoZdT3iIU45D
        PF1D33Rw==;
Received: from [179.232.147.2] (helo=[192.168.0.5])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qeGaa-000YCI-PE; Thu, 07 Sep 2023 17:06:36 +0200
Message-ID: <e73ba527-52e8-4795-a2e6-33a9298a58a1@igalia.com>
Date:   Thu, 7 Sep 2023 12:06:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V3 2/2] btrfs: Introduce the single-dev feature
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, david@fromorbit.com, kreijack@libero.it,
        johns@valvesoftware.com, ludovico.denittis@collabora.com,
        quwenruo.btrfs@gmx.com, wqu@suse.com, vivek@collabora.com
References: <20230831001544.3379273-1-gpiccoli@igalia.com>
 <20230831001544.3379273-3-gpiccoli@igalia.com>
 <f700b53e-328d-cc69-937f-e4b8bfd8c37d@oracle.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <f700b53e-328d-cc69-937f-e4b8bfd8c37d@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Anand, thanks for the feedback / review, much appreciated!
You're definitely helping a lot with this patch =)


On 06/09/2023 13:14, Anand Jain wrote:
> [...]
>> Anand: the distinction of fsid/metadata_uuid is indeed required on
>> btrfs_validate_super() - since we don't write the virtual/rand fsid to
>> the disk, and such function operates on the superblock that is read
>> from the disk, it fails for the single_dev case unless we condition check
>> there - thanks for noticing that though, was interesting to experiment
>> and validate =)
> 
> Yep, that makes sense. Thanks. I have added cases 1 and 2 in an upcoming
> patch, and as part of this patch, you could add case 3 as below. Case 4
> is just for discussion.
> 
> 
> 1. Normally
> 
>      fs_devices->fsid == fs_devices->metadata_uuid == sb->fsid;
>      sb->metadata_uuid == 0;
> 
> 2. BTRFS_FEATURE_INCOMPAT_METADATA_UUID
> 
>      fs_devices->fsid == sb->fsid;
>      fs_devices->metadata_uuid == sb->metadata_uuid;
> 
> 
> 3. BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV
> 
>      fs_devices->fsid == random();
>      fs_devices->metadata_uuid = sb->fsid;
>      sb->metadata_uuid == 0;
> 
> 
> 
> For future development: (ignore for now)
> 
> 4. BTRFS_FEATURE_INCOMPAT_METADATA_UUID |\
>      BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV
> 
>      fs_devices->fsid == random();
>      sb->fsid == actual_fsid (unused);
>      fs_devices->metadata_uuid == sb->metadata_uuid;
> 
This is a very good way of expressing the differences, quite good as
documentation! Thanks for that, it makes sense for me.

What do you mean by "you could add case 3 as below"? I'm already doing
that in the code, correct? Or do you mean somehow document that? I guess
this could be kinda copy/paste as a comment or in the wiki, for example.

[Looking in the list I think I found a patch from you adding these
comments to volumes.h =) ]

> [...]
>> +		btrfs_err(fs_info,
>> +			  "device removal is unsupported on SINGLE_DEV devices\n");
> 
> No \n at the end. btrfs_err() already adds one.
> 
>> +		btrfs_err(fs_info,
>> +			  "device removal is unsupported on SINGLE_DEV devices\n");
> 
> here too.
>> +		btrfs_err(fs_info,
>> +			  "device replace is unsupported on SINGLE_DEV devices\n");
> 
> and here.
> 

Good catch, will fix that!


> [...]
>> @@ -889,7 +889,7 @@ static int btrfs_parse_device_options(const char *options, blk_mode_t flags)
>>   				error = -ENOMEM;
>>   				goto out;
>>   			}
>> -			device = btrfs_scan_one_device(device_name, flags);
> 
>> +			device = btrfs_scan_one_device(device_name, flags, true);
> 
> Why do we have to pass 'true' in btrfs_scan_one_device() here? It is
> single device and I don't see any special handle for the seed device.
>>   	case BTRFS_IOC_SCAN_DEV:
>>   		mutex_lock(&uuid_mutex);
>> -		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ);
>> +		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
>>   		ret = PTR_ERR_OR_ZERO(device);
>>   		mutex_unlock(&uuid_mutex);
>>   		break;
>> @@ -2210,7 +2210,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
>>   		break;
>>   	case BTRFS_IOC_DEVICES_READY:
>>   		mutex_lock(&uuid_mutex);
>> -		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ);
>> +		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
>>   		if (IS_ERR(device)) {
>>   			mutex_unlock(&uuid_mutex);
>>   			ret = PTR_ERR(device);
> 
> With this patch, command 'btrfs device scan' and 'btrfs device ready'
> returns -EINVAL for the single-device?  Some os distributions checks
> the status using these commands during boot. Instead, it is ok to
> just return success here.

These are related things. So, regarding the
btrfs_parse_device_options(), as per my understanding this a mount
option that causes a device scan - so, it is a mount-time operation
somehow, correct? But I'm glad to s/true/false and prevent such
scanning, if you think it's more appropriate.

Now, about "just return success" on device scans, just return 0 then? OK
for me...


> [...] 
>> +	if (single_dev) {
>> +		if (has_metadata_uuid || fsid_change_in_progress) {
>> +			btrfs_err(NULL,
>> +		"SINGLE_DEV devices don't support the metadata_uuid feature\n");
>> +			return ERR_PTR(-EINVAL);
> 
> It could right?

In theory, yes. But notice that we have a special situation with
SINGLE_DEV - we make use of the metadata_uuid infrastructure
*partially*; the in-memory structures are affected, but the superblock
is not touched. Now, to support both metadata_uuid and SINGLE_DEV, it
means for example that the user wants to mount two identical devices
(with metadata_uuid enabled) at same time, which is not currently
supported. But then SINGLE_DEV can't use metadata_uuid for that, since
this infrastructure is in use already, we'd need to have like a third
fsid entity, IIUC.

I think this could be achieved but I'm not sure the value for that, and
specially in the first iteration of the patch. I'd vote to merge this as
simple as possible and maybe extend that in the future to support
co-existing metadata_uuid, if that makes sense for some users. OK for you?


> [...]
>> @@ -1402,6 +1444,16 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags)
>>   		goto error_bdev_put;
>>   	}
>>   
>> +	single_dev = btrfs_super_compat_ro_flags(disk_super) &
>> +			BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV;
>> +
>> +	if (!mounting && single_dev) {
>> +		pr_info("BTRFS: skipped non-mount scan on SINGLE_DEV device %s\n",
>> +			path);
>> +		btrfs_release_disk_super(disk_super);
> 
> leaks bdev?
> 

Ugh, apparently yes, thanks for noticing this!


>> +		return ERR_PTR(-EINVAL);
> 
> We need to let seed device scan even for the single device.
> 
> In fact we can make no-scan required for the any fs with the total_devs 
> == 1.
> 
> I wrote a patch send it out for the review. So no special handling for
> single-device will be required.

This one?
https://lore.kernel.org/linux-btrfs/b0e0240254557461c137cd9b943f00b0d5048083.1693959204.git.anand.jain@oracle.com/

OK, seems it does directly affect my patch, if yours is merged I can
remove part of the code I'm proposing, which is nice. I'll wait David /
Josef feedback on your patch to move on from here, if that's accepted,
I'll incorporate yours in my next iteration.
--

If possible, could you CC me in your patches related to metadata_uuid
and fsid for now, since I'm also working on that? This helps me to be
aware of the stuff.

For example, looking in the list, I just found:
https://lore.kernel.org/linux-btrfs/0b71460e3a52cf77cd0f7d533e28d2502e285c11.1693820430.git.anand.jain@oracle.com/

This is the perfect place to add the comment above, related to fsid's
right? I'll do that in my next version.

Thanks,


Guilherme


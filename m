Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D9F6FBB37
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 01:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjEHXAN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 19:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjEHXAL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 19:00:11 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA23949F8;
        Mon,  8 May 2023 16:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2E8i15yyo/k4K3anSiYtS9i1+JfNMnO6qhOFwSkcwvM=; b=h6025mZM/3ZZN+lfY9m69KyupK
        FsNz2/W745dI9rp9oio4KvkVEM8Y1tSCnBlX0vG/hGhsOEiq7s6eR25Rm8VkKKl/UFNNt51/B0XoN
        AJqoix2q5EfJ3KPNhJpCe0CZxeWhvDSYXeAW7S/sA/aUmjCUUrrNu3IhyfnBhYNWMIXUovyucDUc5
        guvnRn8Wlu5ADKV2iaP97xnqF0SdZFwFpAAF6ptGaS2eF38avvBO3AU+ri/AhSDeFglqeT7ziZLhw
        5xEwiL5Gfs0RuBeaPUSzDFj8IUiBNXOn/59sjFnFd/9Z1FHa4IpcPi3FdAwWnpODGe6X1LcPHMcoW
        SK9nVjxQ==;
Received: from [177.189.3.64] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pw9pq-004HVu-Ni; Tue, 09 May 2023 01:00:03 +0200
Message-ID: <ed84081e-3b92-1253-2cf5-95f979c6c2f0@igalia.com>
Date:   Mon, 8 May 2023 19:59:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] btrfs: Introduce the virtual_fsid feature
Content-Language: en-US
To:     dsterba@suse.cz, Dave Chinner <david@fromorbit.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com
References: <20230504170708.787361-1-gpiccoli@igalia.com>
 <20230504170708.787361-2-gpiccoli@igalia.com>
 <20230505131825.GN6373@twin.jikos.cz>
 <a28b9ff4-c16c-b9ba-8b4b-a00252c32857@igalia.com>
 <20230505230003.GU6373@twin.jikos.cz>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230505230003.GU6373@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05/05/2023 20:00, David Sterba wrote:
> [...]
>> Hi David, thanks for your suggestion!
>>
>> It might be possible, it seems a valid suggestion. But worth notice that
>> we cannot modify the FS at all. That's why I've implemented the feature
>> in a way it "fakes" the fsid for the driver, as a mount option, but
>> nothing changes in the FS.
>>
>> The images on Deck are read-only. So, by using the metadata_uuid purely,
>> can we mount 2 identical images at the same time *not modifying* the
>> filesystem in any way? If it's possible, then we have only to implement
>> the skip scanning idea from Qu in the other thread (or else ioclt scans
>> would prevent mounting them).
> 
> Ok, I see, the device is read-only. The metadata_uuid is now set on an
> unmounted filesystem and we don't have any semantics for a mount option.
> 
> If there's an equivalent mount option (let's say metadata_uuid for
> compatibility) with the same semantics as if set offline, on the first
> commit the metadata_uuid would be written.
> 
> The question is if this would be sane for read-only devices. You've
> implemented the uuid on the metadata_uuid base but named it differently,
> but this effectively means that metadata_uuid could work on read-only
> devices too, but with some necessary updates to the device scanning.
> 
> From the use case perspective this should work, the virtual uuid would
> basically be the metadata_uuid set and on a read-only device. The
> problems start in the state transitions in the device tracking, we had
> some bugs there and the code is hard to grasp. For that I'd very much
> vote for using the metadata_uuid but we can provide an interface on top
> of that to make it work.

OK, being completely honest here, I couldn't parse fully what you're
proposing - I blame it to my lack of knowledge on btrfs, so apologies heh

Could you clarify it a bit more? Are you suggesting we somewhat rework
"metadata_uuid", to kinda overload its meaning to be able to accomplish
this same-fsid mounting using "metadata_uuid" purely?

I see that we seem to have 3 proposals here:

(a) The compat_ro flag from Qu;

(b) Your idea (that requires some clarification for my fully
understanding - thanks in advance!);

(c) Renaming the mount option "virtual_fsid" to "nouuid" to keep
filesystem consistency, like XFS (courtesy of Dave Chinner) - please
correct me here if I misunderstood you Dave =)

I'd like to thank you all for the suggestions, and I'm willing to follow
the preferred one - as long we have a consensus / blessing from the
maintainers, I'm happy to rework this as the best possible approach for
btrfs.

Also, what about patch 2, does it make sense or should we kinda "embed"
the idea of scan skipping into the same-fsid mounting? Per my current
understanding, the idea (a) from Qu includes/fixes the scan thing and
makes patch 2 unnecessary.

Thanks,


Guilherme

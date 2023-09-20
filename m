Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B567A7E43
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 14:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbjITMQp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 08:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbjITMQo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:16:44 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFB0191;
        Wed, 20 Sep 2023 05:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qhDsOZhFgmqNUxANoTEkfLCSDfU3tYdR/37LJ+h3On0=; b=mBofRqVRhDgejeH6pfaxIzi9lg
        fDm25WoR82FHqXKCi8xbKWiyzCCYRRSzeCS/la+OduxtfBrVqHU9umrYm7/z+nfnhMGe1Ylw6hHxC
        UIiEoRZguAcXbvCniP5UFkmn7A3fOqisuau8LLf1LaPCOLZlV9HmBN18Mn2JH2UzZETPnfFB/Lhz7
        ucpVNR41R4cMfjHghSifw0soQeXRcENSqL5qrjU+bRZ3aAzYe+xp/Fx4TSOisjdlyaOnCzeGqS3R6
        xdA5u02KZGZjIrXn43nN4KxhOS0TUx9e4DAOuAbk0rd1c10H/nXHQ+vT+sIkSVI4aP+1ydBSGbcDm
        dnLjHdcQ==;
Received: from [187.56.161.251] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qiw7o-006VBo-3R; Wed, 20 Sep 2023 14:16:12 +0200
Message-ID: <9ee57635-81bf-3307-27ac-8cb7a4fa02f6@igalia.com>
Date:   Wed, 20 Sep 2023 09:16:02 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 2/2] btrfs: Introduce the temp-fsid feature
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
References: <20230913224402.3940543-1-gpiccoli@igalia.com>
 <20230913224402.3940543-3-gpiccoli@igalia.com>
 <20230918215250.GQ2747@twin.jikos.cz>
 <cff46339-62ff-aecc-2766-2f0b1a901a35@igalia.com>
 <a5572d9e-4028-b3ca-da34-e9f5da95bc34@oracle.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <a5572d9e-4028-b3ca-da34-e9f5da95bc34@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19/09/2023 02:01, Anand Jain wrote:
> [...]
> This must successfully pass the remaining Btrfs fstests test cases with
> the MKFS_OPTION="-O temp-fsid" configuration option, or it should call
> not run for the incompatible feature.
> 

I kinda disagree here - this feature is not compatible with anything
else, so I don't think it's fair to expect mounting with temp-fsid will
just pass all other tests, specially for things like (the real)
metadata_uuid or extra devices, like device removal...

> I have observed that the following test case is failing with this patch:
> 
>   $ mkfs.btrfs -fq /dev/sdb1 :0
>   $ btrfstune --convert-to-temp-fsid /dev/sdb1 :0
>   $ mount /dev/sdb1 /btrfs :0
> 
> Mount /dev/sdb1 again at a different mount point and look for the copied
> file 'messages':
> 
>   $ cp /var/log/messages /btrfs :0
> 
>   $ mount /dev/sdb1 /btrfs1 :0
>   $ ls -l /btrfs1 :0
>   total 0   <-- empty
> 
> The copied file is missing because we consider each mount as a new fsid.
> This means subvolume mounts are also not working. Some operating systems
> mount $HOME as a subvolume, so those won't work either.
> 
> To resolve this, we can use devt to match in the device list and find
> the matching fs_devices or NULL.

Ugh, this one is ugly. Thanks for noticing that, I think this needs
fixing indeed.

I've tried here, mounted the same temp-fsid btrfs device in 2 different
mount points, and wrote two different files on each. The mount A can
only see the file A, mount B can only see file B. Then after unmouting
both, I cannot mount anymore with errors in ctree, so it got corrupted.

The way I think we could resolve this is by forbidding mounting a
temp-fsid twice - after the random uuid generation, we could check for
all fs_devices present and if any of it has the same metadata_uuid, we
check if it's the same dev_t and bail.

The purpose of the feature is for having the same filesystem in
different devices able to mount at the same time, but on different mount
points. WDYT?

Cheers!

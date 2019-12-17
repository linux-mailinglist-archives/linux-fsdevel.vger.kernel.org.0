Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7092012385B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 22:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfLQVF3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 16:05:29 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:41673 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbfLQVF2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 16:05:28 -0500
Received: by mail-qv1-f65.google.com with SMTP id x1so3451757qvr.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 13:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B/nIEgqm7OioL/7wEl1hDXcP2AhFeFFGi64i4A0ew7U=;
        b=kqhButns8pFTbsXxUKCTNp0O+N6EM28deKyUq1j7ML/wFB01sL8uwbAmo/9ezWudd9
         b1eGwLa0JEcAw3b8Dxn7ln8WJiUhSU5zUC/EWIP+JxWgCfFFmdgmnEWta84nd9bZHhcP
         PhYN3XROnmkVc4Qz/nWMt/a45o7euRkH4CNNlgqwgBRxTgcxGmuHTubEj1z2uySLwWfj
         mR8ThebdwiqJmgG6NLNZdlDMu6II++y5v35mFe61oGp0jRobX5aPVwNWwMBdVzu1hIMT
         R5VuJvV4c7CDJm8ebDjGaOugtvXSn0c1FwOyunvDg56SHqRcuGN9AtMXluTQj345RMga
         snOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B/nIEgqm7OioL/7wEl1hDXcP2AhFeFFGi64i4A0ew7U=;
        b=cK9/EZByLc7vAxs3LYJM3DXQ+MX2Jxk4PDsyOcvlmGoTwBYXojHRDHRc82JmdjuBlk
         BzvnReVoGNZT1ciwRogc6Siq5yQh23aALrCQvKy8ZPmkwCbG5cWt8mdvisR0gQtv1fjK
         89+9EreqzlMOtyk0fI24/sdkP7tqynMGcLNIoG4NxwjDB57NG55F/rn72dKVfysCt/dG
         O8w1JQUcyQ71a43gd1hu0t5QLLW4WIsE55pmsX3jysxUg42zcDD03Au0FuLTUmwNuPst
         YjDIUj4+g9mox2y4u9Res5EusdL5ez2/09m3dZt8iHj+eC8+qgiWVpk5g3EyRLgVjYB0
         pbJA==
X-Gm-Message-State: APjAAAVrukO6WWDq+4TylMMMDaPBSMdt9guavg6OdtTcIwZ8KZZan8Ni
        g6oTzcSJuGAd3HAy0IYC8TMCMz6gSSFLyQ==
X-Google-Smtp-Source: APXvYqw7J4Jh50cAaJ5d2+biAeS3jjGlBUAWwJDfqPYiJOEHT37bBuk1dYEU4Dkn1ajY/ZS54Xtp3Q==
X-Received: by 2002:a05:6214:11a8:: with SMTP id u8mr6722944qvv.16.1576616727537;
        Tue, 17 Dec 2019 13:05:27 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4217])
        by smtp.gmail.com with ESMTPSA id k29sm11395qtu.54.2019.12.17.13.05.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 13:05:26 -0800 (PST)
Subject: Re: [PATCH v6 23/28] btrfs: support dev-replace in HMZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-24-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <2157b1bb-a64b-eed3-0451-09a8480d0db2@toxicpanda.com>
Date:   Tue, 17 Dec 2019 16:05:25 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213040915.3502922-24-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/19 11:09 PM, Naohiro Aota wrote:
> We have two type of I/Os during the device-replace process. One is a I/O to
> "copy" (by the scrub functions) all the device extents on the source device
> to the destination device.  The other one is a I/O to "clone" (by
> handle_ops_on_dev_replace()) new incoming write I/Os from users to the
> source device into the target device.
> 
> Cloning incoming I/Os can break the sequential write rule in the target
> device. When write is mapped in the middle of a block group, that I/O is
> directed in the middle of a zone of target device, which breaks the
> sequential write rule.
> 
> However, the cloning function cannot be simply disabled since incoming I/Os
> targeting already copied device extents must be cloned so that the I/O is
> executed on the target device.
> 
> We cannot use dev_replace->cursor_{left,right} to determine whether bio is
> going to not yet copied region.  Since we have time gap between finishing
> btrfs_scrub_dev() and rewriting the mapping tree in
> btrfs_dev_replace_finishing(), we can have newly allocated device extent
> which is never cloned nor copied.
> 
> So the point is to copy only already existing device extents. This patch
> introduces mark_block_group_to_copy() to mark existing block group as a
> target of copying. Then, handle_ops_on_dev_replace() and dev-replace can
> check the flag to do their job.
> 
> Device-replace process in HMZONED mode must copy or clone all the extents
> in the source device exctly once.  So, we need to use to ensure allocations
> started just before the dev-replace process to have their corresponding
> extent information in the B-trees. finish_extent_writes_for_hmzoned()
> implements that functionality, which basically is the removed code in the
> commit 042528f8d840 ("Btrfs: fix block group remaining RO forever after
> error during device replace").
> 
> This patch also handles empty region between used extents. Since
> dev-replace is smart to copy only used extents on source device, we have to
> fill the gap to honor the sequential write rule in the target device.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Can you split up the copying part and the cloning part into different patches, 
this is a bear to review.  Also I don't quite understand the zeroout behavior. 
It _looks_ like for cloning you are doing a zeroout for the gap between the last 
wp position and the current cloned bio, which makes sense, but doesn't this gap 
exist because copying is ongoing?  Can you copy into a zero'ed out position?  Or 
am I missing something here?  Thanks,

Josef

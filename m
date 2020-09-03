Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A92D25C758
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 18:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgICQrE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 12:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbgICQrC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:47:02 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1B7C061245
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2020 09:47:02 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w16so3668370qkj.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Sep 2020 09:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i7aG5k6pRgcc/LcppLGEeim2es2qXnyQIVJM9eTJudM=;
        b=QWJswB/C3Cd+djAfaJ2g57w6F6kHc6Ydq1VTTz7Mvv42d07xhtC/DKEhblijbavXEZ
         R6/BUNucYuciVAc8IPmDnGFU28/zQCaMqyoigFs+qX/LaklJuk4Dk2kjM+rujxr8XC6I
         HmMgBg8nFcdSsk6n+9P6VWtZyAFvBWuB6cAzWN9cydFJOgLDsPNtxYFQFL/2T8Hp+j8N
         Ijs9vblbui2DewrfkuzylOPTiIFGTqjm9Y5p5c1xhaEwZKp0Rus/RAJpDkFayePQ5san
         aOrTo+J9JHGkf5PZRcunG9N5ri8exLI4CryVCqvum/1u23oIKR+lJ1eP4CDvvP1Fs7LR
         ozdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i7aG5k6pRgcc/LcppLGEeim2es2qXnyQIVJM9eTJudM=;
        b=r6oBr1rzyOrOlO7dx/wOny+MGOJJKe9dB2i/IEeQ7kOzcKgC73jc54KwmHUZn3YN2I
         IQQ9lv5wBKPGiXilGHyrBW9VgCZycJfjuxj2DY0VJLBSIfwmm17f5XQI2+eKBAK98NHw
         E268J1QldxCLGD66TgFjGNlK/CYnkYOPdky8CgrzkHiF0OXXkwSafQ5xRzGY3D+U32uB
         tSqJuwZnxXiekVlHbUvkDSE8aYcl1Wd/1FuEmh8iyp7DlvDyVQapJhIQfwjrzuWFiFfu
         eI9qho7AzSgslFWGpasyvcctCWQHpaqgxd4Wy9WVIB1vg2LHGkUSFWHlyqFUNtLgnvjk
         AtiQ==
X-Gm-Message-State: AOAM531AsxXNuIxiqH/FHQyRH6XQL6xeDY61tdeI/BVTETJU3Jgzsg02
        YT7Q4onFitxQC74fCP/fBx1w2gemMIcignjF
X-Google-Smtp-Source: ABdhPJyhWxkXR6H9v+NSJodcNpr97SHmsPy0lcF9LKiwbnuATlgIp/7y4vVsi44mnZPa73+R0KtPEw==
X-Received: by 2002:a37:909:: with SMTP id 9mr4051361qkj.317.1599151620746;
        Thu, 03 Sep 2020 09:47:00 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h17sm2551584qke.68.2020.09.03.09.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 09:47:00 -0700 (PDT)
Subject: Re: [RFC PATCH] btrfs: don't call btrfs_sync_file from iomap context
To:     Christoph Hellwig <hch@lst.de>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <20200901130644.12655-1-johannes.thumshirn@wdc.com>
 <42efa646-73cd-d884-1c9c-dd889294bde2@toxicpanda.com>
 <20200903163236.GA26043@lst.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <180234c3-d05c-1183-f1a6-b9b83c0d1536@toxicpanda.com>
Date:   Thu, 3 Sep 2020 12:46:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200903163236.GA26043@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/3/20 12:32 PM, Christoph Hellwig wrote:
> We could trivially do something like this to allow the file system
> to call iomap_dio_complete without i_rwsem:
> 

This is sort of how I envisioned it worked, which is why I was surprised when it 
bit us.  This would be the cleanest stop-gap right now, but as it stands I've 
already sent a patch to work around the problem in btrfs for now, and we plan to 
take up the locking rework next go around.  Thanks,

Josef

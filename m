Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87B3A15AACB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 15:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgBLOOV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 09:14:21 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46391 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbgBLOOV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:14:21 -0500
Received: by mail-qk1-f194.google.com with SMTP id u124so1625868qkh.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2020 06:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4CwApYUxhaWyVN4lPrdpKGLRSN2MrCYvh6i9irE3epY=;
        b=McB6gH1hhnmByVXnxdMODeKB2SkkXtWxN1827ATNsah6/4ZJVSvzMvnzw9Zikp9dUG
         b6jCicunVeGONIxGGXH0AGS+cSzA5xJ2btrI97IOnyXDcpR/i6dde1644QUmiK3n1xCR
         G83UOXkaiixLFcFRHh7MJRC8kO50X74mYy1zotFbxj8bbVOOHbf2awprxtp/W1juCbp1
         aYM2oyjt3STOWCicwZpE6JTEMAKEh5XmsxlDfpS7PJ4odvh9HMzWUU0Ze0OpAqd6gwmh
         8lhFYzJ2BborNJIy2VcfHxUfTduZjmtppZAA4X33muCqb1VmyyqS33WVb0+Xy10KwZTW
         aV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4CwApYUxhaWyVN4lPrdpKGLRSN2MrCYvh6i9irE3epY=;
        b=IRziwLyW4YeIFqiYcdz+OMvksIBW0H9pUjpNY8YCeGrIJXC91Izftxy+tBeawL2/Br
         lwmHHOKMdhPvN72iek9PYYzgRblBv58fEx359ckvxN8Cysc3NTe3GL1FvU0WFrfx8J8L
         uLUOrn/8YQUQFCKpaW73QknNyRNsGTdv8rlCbVN7HqkBOFpcoY8mG2n8qpS5kZJ0tkWa
         LoSuoo9hcHr2VdVCTEI9JiF0J2Qqx/dKlVr4j7BQN3kBvl59sR7/vFV5vOLwmg5oUqiw
         2BDarkLR8AkhogVCGFAu5o6T02LaCBA6aLcYwrnaD3EKwdgfY46FoEF3O9Z/1r813A9E
         Dkyw==
X-Gm-Message-State: APjAAAWhcv3xz15gJG5+1fUxuPE39ailvwqXT7ED8e1wSIyyblNdsz9D
        FoF/0JiF0WCQBqActkSHvO5U5IDLHF0=
X-Google-Smtp-Source: APXvYqxL8RVcoDXxOAzJGwomi+hOpxWo7FyokAaJ2mKlfIIo0BqHsb8pimwyhjcIv9Q2G9ZbH1tYYw==
X-Received: by 2002:a05:620a:2194:: with SMTP id g20mr7598839qka.227.1581516859632;
        Wed, 12 Feb 2020 06:14:19 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4da])
        by smtp.gmail.com with ESMTPSA id f26sm198485qtv.77.2020.02.12.06.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 06:14:18 -0800 (PST)
Subject: Re: [PATCH v2 02/21] btrfs: do not BUG_ON with invalid profile
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-3-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <dd6d248f-439c-4a68-e686-6e9c7989099d@toxicpanda.com>
Date:   Wed, 12 Feb 2020 09:14:13 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200212072048.629856-3-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/12/20 2:20 AM, Naohiro Aota wrote:
> Do not BUG_ON() when an invalid profile is passed to __btrfs_alloc_chunk().
> Instead return -EINVAL with ASSERT() to catch a bug in the development
> stage.
> 
> Suggested-by: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

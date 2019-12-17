Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10960123613
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 20:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfLQT4x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 14:56:53 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33627 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbfLQT4x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:56:53 -0500
Received: by mail-qt1-f193.google.com with SMTP id d5so8180495qto.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 11:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h+xgOYrkbJ4BY6ml9OrsMnXMWsXA6UKKNsIOK9D7wlQ=;
        b=Nk/MK2ZzXrWLiphhyNlGRzpc7Wqke/gW5jc7A1UBFpwlj9+Q28P9De7lA3yKq12mwP
         7POzemkCUWiWiYFwF4B5IHpP11bAA4mX9VV/UERxH6N43F21V51Cm943HuXisSFXb9Qp
         Qnfklp241zuYBjEtllANUjPt/eq5y20AHb8PNYGyT4h4/dyYy7B1Ft7fm6VpeS/z3yCN
         krK/zI6UXl/P290/pt2OcgY6aUIpgb8SFc1tZM2/oXWDE2ejwvuLS815+2M+CsyEy/CG
         R62dKI9HIIbKLn5Ol4TGbc7fOjAAJdmRpwIJ1841IT0oyHe404bJg8QM7ynIGmUtYpcD
         6Q4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h+xgOYrkbJ4BY6ml9OrsMnXMWsXA6UKKNsIOK9D7wlQ=;
        b=NL+WyuOnDqNSh183x35d+xQrEjhRRYa27qL8BXp+nixEqJqAjy2BHLyvtdwotDbsFQ
         ImcRdzDdI0RChFMg3RswXBF2/FKKkSlQj+RE3eaMx4vXiJCxe6b39YKhOPTJJwNIwLyy
         HFcPR5VLjR8mHU6fiUyLZKx5b7oayR6Gx1vC3prRIrMAy4WW/PoXRWEg79ANgrXE4ugH
         Otr6UmRcDuv71j5bSN23SRwTYFgpmVp4L5FGHOO5/saSW8q14j5rG8vWvdIZ34o6Fo0G
         OfRpVg11ZF5xhVngzK/MVav7tak356AvIhLWfln2TB/oFgefSmHjFFOsrfCPD9LpJ4rh
         75QQ==
X-Gm-Message-State: APjAAAX2A/qWHeMERi2gla+J23Xca5JxWMDAxPfubZ2y0DPjUS2qRxku
        mIFIj4u5pfmS5Rm4DdZy0lKG2AulPLZYaA==
X-Google-Smtp-Source: APXvYqzgzSdABrPoAehRLV20jpUGCp+P0ac1GI8NgYO3LEWzQxu74NpSHzk6OnhXj/v/30fV9yXhGg==
X-Received: by 2002:ac8:7b9b:: with SMTP id p27mr6300021qtu.2.1576612611677;
        Tue, 17 Dec 2019 11:56:51 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4217])
        by smtp.gmail.com with ESMTPSA id f42sm8507483qta.0.2019.12.17.11.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 11:56:50 -0800 (PST)
Subject: Re: [PATCH v6 22/28] btrfs: disallow inode_cache in HMZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-23-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <44cf8b1a-d5b4-dfb1-7ce7-8f40818da574@toxicpanda.com>
Date:   Tue, 17 Dec 2019 14:56:49 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213040915.3502922-23-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/19 11:09 PM, Naohiro Aota wrote:
> inode_cache use pre-allocation to write its cache data. However,
> pre-allocation is completely disabled in HMZONED mode.
> 
> We can technically enable inode_cache in the same way as relocation.
> However, inode_cache is rarely used and the man page discourage using it.
> So, let's just disable it for now.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Same comment as the mixed_bg's comment

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

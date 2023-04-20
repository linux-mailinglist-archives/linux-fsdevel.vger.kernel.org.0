Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D75D6E8D69
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 11:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbjDTJBN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 05:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbjDTJA2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:00:28 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B708A59;
        Thu, 20 Apr 2023 01:56:40 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id bi21-20020a05600c3d9500b003f17a8eaedbso2706701wmb.1;
        Thu, 20 Apr 2023 01:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681980932; x=1684572932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3oaCtnRgdVnX+/49rnLNjwqRbR+N3XhGwT33lpTGps=;
        b=bDzgPWwdKH1qMEnqSFq1A4LRveY5MJ2A7oTRSAj79iqYOFoSo1UgWtBIFW/ZB8K9e7
         JlIX1JYieMobKCujWzsrrrD38UP2oT4qFE6i25X2dd5qprIevNVD6uFCbqxKIPjpNvQK
         eKT2EGKN57YDOI5XNH4nzBaJHI+tBJMDStelAU3FY4ULn86HX5X25Z4mICFaFqgXefo9
         WTSUtInHUCZj+Fh05bdO4dq1fTX0G/fW/aVg+Q1SpToCWqUMCbPCpDKVWdCfMApJkiAE
         N819UxtdxAVq+LpkREHwxzjVw43/w3oeocx1CZL1LoAdYbZ/Yadhx5HbVzxq41UNcJtn
         5BVQ==
X-Gm-Message-State: AAQBX9fIjhWBtPnHPZU6SzPZzNWFUqBRi1FZC6ht3rIoor/UwTJ8fB+z
        Z+/Y2re/P5lqE19non0D3vi2WhaNJn6qQNNc
X-Google-Smtp-Source: AKy350bKYLeXMzDzDJ6Y6qo/aThxWX/i4drIepoJR2AxRlr5KQ8S+fMnYJCtI7ItM3tNru7pKV43XQ==
X-Received: by 2002:a05:600c:acf:b0:3f1:72e6:2a69 with SMTP id c15-20020a05600c0acf00b003f172e62a69mr740456wmr.4.1681980932068;
        Thu, 20 Apr 2023 01:55:32 -0700 (PDT)
Received: from [192.168.32.129] (aftr-62-216-205-152.dynamic.mnet-online.de. [62.216.205.152])
        by smtp.gmail.com with ESMTPSA id ip29-20020a05600ca69d00b003f1712b1402sm4669681wmb.30.2023.04.20.01.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 01:55:31 -0700 (PDT)
Message-ID: <0028b1b9-980a-4b3b-b290-099368e44f9f@kernel.org>
Date:   Thu, 20 Apr 2023 10:55:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 11/19] gfs: use __bio_add_page for adding single page
 to bio
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     axboe@kernel.dk, johannes.thumshirn@wdc.com,
        cluster-devel@redhat.com, damien.lemoal@wdc.com,
        dm-devel@redhat.com, dsterba@suse.com, hare@suse.de, hch@lst.de,
        jfs-discussion@lists.sourceforge.net, kch@nvidia.com,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-raid@vger.kernel.org, ming.lei@redhat.com,
        rpeterso@redhat.com, shaggy@kernel.org, snitzer@kernel.org,
        song@kernel.org, willy@infradead.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20230419140929.5924-1-jth@kernel.org>
 <20230419140929.5924-12-jth@kernel.org>
 <CAHc6FU6U1yZguZGeCc7BUqd1Qm4+SSRK8xbNZWBUSXTk_jjvVQ@mail.gmail.com>
Content-Language: en-US
From:   Johannes Thumshirn <jth@kernel.org>
In-Reply-To: <CAHc6FU6U1yZguZGeCc7BUqd1Qm4+SSRK8xbNZWBUSXTk_jjvVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19/04/2023 17:19, Andreas Gruenbacher wrote:
> On Wed, Apr 19, 2023 at 4:10 PM Johannes Thumshirn <jth@kernel.org> wrote:
>>
>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>
>> The GFS superblock reading code uses bio_add_page() to add a page to a
>> newly created bio. bio_add_page() can fail, but the return value is never
>> checked.
> 
> It's GFS2, not GFS, but otherwise this is obviously fine, thanks.
> 

Oops fixed in v4


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF2A2A482F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 15:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgKCOae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 09:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729571AbgKCO3B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:29:01 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67580C0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 06:29:01 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id b18so14745699qkc.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 06:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TOlkltDeMWiHpxhxjB+NtRek+OXrY4CzXqQq5l2DQf0=;
        b=1Z5fUf3igTnFYyRdWghFPecYmRHSJCNe0LOOOUafIhr4V8EhBrx/DsBP+MrhsS9l8x
         DWp61nw+MQa0yR3bkyKY5bfYj/7q6q1vZEEGUOxRfo6S5uI8qGlvAiOjMjdrQ09qylv2
         et0O0ApQ7/x3abLZrxVlpe72Qs/jad3HvF7AjHD8ePryqvF99SNLTfu5eJy5MfBuUmaC
         d5VkMbi2JnRLXWhwBPEsoyPqzxSN8l0Gsue7LfCWU5og+J8/FWEcIULMqCjhtaNo/+Ip
         V9N5hwe4WPMMkYSDkeQ7eZ0NbLBYtKZjfOL0HQc0uJBGYHGafGTKoP1Fi01N62U44dPA
         SPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TOlkltDeMWiHpxhxjB+NtRek+OXrY4CzXqQq5l2DQf0=;
        b=m5KMrr5axVX3wdqh7GlwFje3DsKQEtG9ohOetEsEThcDt3x7Z23we85ulWn4FjOMp0
         aEHiN9bIF7k3NjRJ5fj4yumBYP1bw8DW3ujwM89KrrA4MUyzv6lvC0CIR3ioftsBUOC2
         eDvkHhfo5nq8ZYezc5WF81YhTBNjFL1EcynNnOLyMLrzSd/SI0q0ZigpIkezKK8q35Qp
         8gc+MGdvTW4nWZ+QOdael0wQz/0cDKnkSNPuXPApEcRAaJmtXbD51pXLVlE5lvLNATvi
         AbNV7F/nXiaiTZbDTI7KG2hOhPxSBBKSqX6H1E/hErfjW8xVgVp2/Dt4KvrfDvVjifyC
         RsIA==
X-Gm-Message-State: AOAM531FV/BZIb264D0oOH6r09hU1IP+YK1TMA8BXZL/RJdpmvBgH32K
        OJrFnboFOkqCeVhBnyZGKzGu3p7hlm1WU1uP
X-Google-Smtp-Source: ABdhPJy7k3BKKR8Ex+ucPR35FrMI7hP23NIWikLnLZEgLna+MOMwW6fMlPz248Vz2LqfNFMELjjtyQ==
X-Received: by 2002:a37:bdc5:: with SMTP id n188mr19684610qkf.95.1604413740147;
        Tue, 03 Nov 2020 06:29:00 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m2sm5705682qtu.62.2020.11.03.06.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 06:28:59 -0800 (PST)
Subject: Re: [PATCH v9 17/41] btrfs: do sequential extent allocation in ZONED
 mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <0b0775b15f3fd97b04b3b3f1650701330e9392b5.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ac6b5232-bb16-5cfa-7683-0eaba72d7892@toxicpanda.com>
Date:   Tue, 3 Nov 2020 09:28:58 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <0b0775b15f3fd97b04b3b3f1650701330e9392b5.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> This commit implements a sequential extent allocator for the ZONED mode.
> This allocator just needs to check if there is enough space in the block
> group. Therefor the allocator never manages bitmaps or clusters. Also add
> ASSERTs to the corresponding functions.
> 
> Actually, with zone append writing, it is unnecessary to track the
> allocation offset. It only needs to check space availability. But, by
> tracking the offset and returning the offset as an allocated region, we can
> skip modification of ordered extents and checksum information when there is
> no IO reordering.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

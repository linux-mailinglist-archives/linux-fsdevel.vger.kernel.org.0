Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6512F3AC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 20:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392791AbhALTky (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 14:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391784AbhALTkx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:40:53 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58275C061786
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 11:40:13 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id h19so2382083qtq.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 11:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t/DFjpjGCjobewoVfVJhwj7XY2Y3n6U3nLJ5qpNB6Ro=;
        b=y7xsrK2adTAv2SRywD2O5IYJIzpOGonh0vE4C2WSNAqPHS29cvVIB5XiIeoW1YiMl+
         /6zA6kQ2koMn2sPZ5EYc18SxtF4rFELue7x+VjHsjwuIacnMu8Vzw7+2QderQ/DCnzl9
         F6EVLCbZEhGOqrs1ykjO2Vtda+Q7m/kCpGVDkVJ9IhTinBFxFQdCYW0rOwlDayCHQdtd
         Ip04lhiRztBqNSYnhyyV5UaT/BnnDWSCOxxzN/QtZdoSF91T2qRLphRZMcUmX7f2DXmI
         MyFGgyYO3658Ur78GzJsWsdwQ8fHaS6N4qMTPHgODFvM3wQ88Z0JkiPjOdnBKZ+V7XDX
         lhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t/DFjpjGCjobewoVfVJhwj7XY2Y3n6U3nLJ5qpNB6Ro=;
        b=iU6GBxOiWWDDN6J9fLDt/didNE6toINQ/JHvm6ifxNB6U0LpwcVpsO009+cDci++eA
         cZedJZuWIo3JXeRtQ26g95kcQhtxWXLPLIsNEdbxMynQivn0JYt083G0hWZjR/ZgApgG
         sImC8EkjhEYBYR9l4XUDUJNOuMOJQv9cT2y+lfwXswOeHA8vdEvCU4SivUaRYaW/SnuK
         pNas2DA6Zw5lA56Pj6GI7b4IbdLXo8JlQjPgywSKo1z4l82ighz9+zXOE2Qso57DSjob
         g4ogfSebsFD0QCPh/kaTq68tngk/zskn5706Ad/vY1RAkkATV1jfdrByUuI3gk+m/z2F
         ZM0Q==
X-Gm-Message-State: AOAM530nluTIuzDykEmGis3q4dDP//zZdC1XcjUeyHylwWP8T+uKAgv7
        R/wTcto9mALFpz0peYoxXN9FMQ==
X-Google-Smtp-Source: ABdhPJwJkp45/2AWyiGRBvTp9mWHlL4tBS1v5XFeWFweLY/rqOf1UHdM4GaylTRA3mSihfVR7eJQSQ==
X-Received: by 2002:ac8:6b14:: with SMTP id w20mr641903qts.320.1610480412539;
        Tue, 12 Jan 2021 11:40:12 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p13sm1912465qkg.80.2021.01.12.11.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 11:40:11 -0800 (PST)
Subject: Re: [PATCH v11 34/40] btrfs: support dev-replace in ZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <019923ef8aca1d3d8ccddb439e397df35cfe02a7.1608608848.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <aa7e4729-80c8-eeb5-9890-c901f35ac657@toxicpanda.com>
Date:   Tue, 12 Jan 2021 14:40:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <019923ef8aca1d3d8ccddb439e397df35cfe02a7.1608608848.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/21/20 10:49 PM, Naohiro Aota wrote:
> This is 4/4 patch to implement device-replace on ZONED mode.
> 
> Even after the copying is done, the write pointers of the source device and
> the destination device may not be synchronized. For example, when the last
> allocated extent is freed before device-replace process, the extent is not
> copied, leaving a hole there.
> 
> This patch synchronize the write pointers by writing zeros to the
> destination device.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

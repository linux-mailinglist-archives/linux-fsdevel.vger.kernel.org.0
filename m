Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3006E123611
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 20:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfLQT4Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 14:56:24 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45825 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbfLQT4Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:56:24 -0500
Received: by mail-qk1-f193.google.com with SMTP id x1so9298783qkl.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 11:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i9qhMJadW5tieVAHuJzdf8rrR02tOsmbrCD157GDN78=;
        b=I/FVjpnLPfoxTqv+LGPe+jYxnkBaEazZ2FAlvhpsOCTSUcTNDxABtXvKt/qs0cm96q
         TvyLAamk1w9v0Hz/QCilodbcKVQQQXUDrVOZve+mMmBs9yPSvZIa9FSYyPUql+zj1ean
         6LztcmV1LFIDTVODG0xnsanxkQ1Bc89NY3N29XLHCyilHldsD3OpEF20HJ2b/C+qhZiv
         S4UHUaWGpodAfGqOQTInQyi1eH/6/kAE9m8EgpkzZL8TQ9LeEUJ1VoSiBqKUXwRoNIul
         FBzXEPiTX71c55SLPJVN56xsVCEKPT/b65BDU8cuEJE6ooAthIy9KlPNxvvYYwEroXLc
         d08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i9qhMJadW5tieVAHuJzdf8rrR02tOsmbrCD157GDN78=;
        b=WX0OaPbXWzFtKqb6YcsNku0HAYH6E+o6wUez4g3HAUkm+1MkLENvPR9qDEX270RRrY
         z8PfSpTpVtUni7Gd4P58onsj27f/w4l//57JzYiwa4gLCsYS0i+Rnq0EDHQJlounIamQ
         TJ/x4RY5U9DUCD6AD5IEfDdgm9O7z1tNCyMWtV/SX8iOEywb0jf79UctiVp+BoM85cYM
         oSvLc8BuBQ+jkpXzi7Re6zUdhWXp+WhhGvCrnKB9Xm1IZks8d+KEpJz77FF+x3G/Hz47
         E3sDRXoK6qJzCIBCxJypS7XXO4Jw3WXqNwK1B4Wmi2EvcPV7GETgMCZ8ZEuJ3rKeBrcl
         /Wcg==
X-Gm-Message-State: APjAAAXKDL7iv7bs5soRKJCdkYOeG89xqMY+kgcH/a5LIKK1AYtcJPTx
        +UU8ODQ2YvgnCoSS7fXn18vS4idt1qmJdg==
X-Google-Smtp-Source: APXvYqyIbIz2r3M820ozpnr/GNXT5KfTLknaD7JXmA9ZeGsKxArjD7R3//OV1KXbT+L8RGrbiZF/Hg==
X-Received: by 2002:a05:620a:218d:: with SMTP id g13mr6880233qka.340.1576612582820;
        Tue, 17 Dec 2019 11:56:22 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4217])
        by smtp.gmail.com with ESMTPSA id g18sm7365663qki.13.2019.12.17.11.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 11:56:22 -0800 (PST)
Subject: Re: [PATCH v6 21/28] btrfs: disallow mixed-bg in HMZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-22-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d287a92b-796e-0f44-c177-5143f7589cb6@toxicpanda.com>
Date:   Tue, 17 Dec 2019 14:56:20 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213040915.3502922-22-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/19 11:09 PM, Naohiro Aota wrote:
> Placing both data and metadata in a block group is impossible in HMZONED
> mode. For data, we can allocate a space for it and write it immediately
> after the allocation. For metadata, however, we cannot do so, because the
> logical addresses are recorded in other metadata buffers to build up the
> trees. As a result, a data buffer can be placed after a metadata buffer,
> which is not written yet. Writing out the data buffer will break the
> sequential write rule.
> 
> This commit check and disallow MIXED_BG with HMZONED mode.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

I would prefer it if you did all of the weird disallows early on so it's clear 
as I go through that I don't have to think about certain cases.  I remembered 
from a previous look through that mixed_bg's were disallowed, but I had to go 
look for some other cases.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

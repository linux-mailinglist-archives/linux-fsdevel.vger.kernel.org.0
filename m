Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 894D415CB83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 20:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgBMT56 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 14:57:58 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45004 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgBMT55 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 14:57:57 -0500
Received: by mail-pg1-f193.google.com with SMTP id g3so3544494pgs.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2020 11:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GImlpmjaPnENHyqco9Z/rAmb4YdtKlaBQH4St2s1w7E=;
        b=RMdZsuNE8NDOLfTmeJtg9scYmCTQR/TKv+Ed3hghtgyGkxYhV5HlmRfScKZIeUqujO
         C+iHPN7MjoVfXvOOXZEROu4GL/Kx/+p3YNZLgI+Xk31fvALOXOTqJhtK7slIpML+a2hK
         XJyAqAD7PGhqN6Rh9VZ6ozHuPcO6vWJ9sekgY5dW8hZI7Hr38KYh4Asm1h+kWBxGFbbi
         gTSAALc+Bi/Qr+8v0og38eUZkBznVPxezr6QHuoVE+nMogVX5+1I2crT0vptTog7fV/S
         zeICsAQqbzY7LvZ9GaPkVwakaiptpSW7TvqI48ZW34CMrLHHCA0hqNk+LdNeLWFFKsT6
         Ffhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GImlpmjaPnENHyqco9Z/rAmb4YdtKlaBQH4St2s1w7E=;
        b=XGuj7pfyXLEVbbslSWoiyPciDahneD/8zdX1C1k5S8xENFXWlTCDodBMsotB0hXgGg
         8ItRUv/zXkei6BrbrqoBlzTDUd59w/sTZuHnI0jpNvBCUmMXO17ShwtP3xdOkZrvabnc
         8Mh/wRu02Lm/Z130B08a+1L3qCjgrkiquPDaFyOxpkkBXfpciO4QmC3WsYHTDVaZSwAV
         bVpyviUAekbRNQwvemQsfr2QLacKaMLE9dXKcndNICB6t3bNddlFIBX4xNdc/yRePzo9
         VAea+8YMiORiGRKb1kpm78DoWVgctsWXzuHO3Ztf2h640uImGEB38CcrLA5In06DkDvS
         217w==
X-Gm-Message-State: APjAAAW5Wut8eaQrFiSGBX0Nezbfa/kyJcrQ52uslCnLtU8xeNj3UYxC
        EABEMNnJ5l0Lj5V8j8W38dzPhl7czAg=
X-Google-Smtp-Source: APXvYqw/pQsTl4JnOfS2+0cnWo1LoIcuYji/Fw7X+EQyuUwDO3Qi7BSaNkyYyMltdQJyAxZveOC/eA==
X-Received: by 2002:a65:68ce:: with SMTP id k14mr19016576pgt.336.1581623876599;
        Thu, 13 Feb 2020 11:57:56 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21cf::1150? ([2620:10d:c090:400::5:249c])
        by smtp.gmail.com with ESMTPSA id 196sm4113302pfy.86.2020.02.13.11.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 11:57:55 -0800 (PST)
Subject: Re: [PATCH v2 14/21] btrfs: factor out do_allocation()
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-15-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <cb9ebc33-213f-e57c-9ffd-d6b0a65342df@toxicpanda.com>
Date:   Thu, 13 Feb 2020 14:57:52 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200212072048.629856-15-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/12/20 2:20 AM, Naohiro Aota wrote:
> Factor out do_allocation() from find_free_extent(). This function do an
> actual allocation in a given block group. The ffe_ctl->policy is used to
> determine the actual allocator function to use.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

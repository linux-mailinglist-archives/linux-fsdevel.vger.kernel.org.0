Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0127915AACE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 15:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgBLOQk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 09:16:40 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44783 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbgBLOQk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:16:40 -0500
Received: by mail-qk1-f193.google.com with SMTP id v195so2134391qkb.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2020 06:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iT/uJwxixvqnmajK1vnbzVedYbeD+kLCpAC8G79cvLs=;
        b=itOHJQm2yoVyzPJTGVFeCTl0Z6JTOBCgMh9rPsSdcgISzVFcMfPvH1aqvXDNHV3P24
         JMVzi5XmQymQ2Xu2QsYvJbHUEIJVSPZCsLYHw1GMiKZ81R0igP1rSYcG+C6tQSIJteRY
         Y01vJdyDIH07rrtzPFqPwYkgwvd+SsKY68gbEvIEoTuz6A2LaADBcFKrS99J9ZEz3zTc
         vO+VAdwZCheXfEXQDsEIa24FlY8BzvHyztQQOpQwmq1lZBwz7Akgcp3CLdqmGUxq/Hz8
         QTFIvG9d+AoMJyRmKa2+ZSWB1zJfAUGHuW9UBexxdpZAfOviJ/aUoO5KZZ4bYXS880Jc
         cfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iT/uJwxixvqnmajK1vnbzVedYbeD+kLCpAC8G79cvLs=;
        b=ZDxXnNPnDlj65uYAxkT5NTtwoHxDYFEYOTjY+n+jCAB/jWhZpwnaKK8IAqsCoK0bHN
         hS/X2r0o/A3Yt/0weIHPIphDEnvm4h+vnn3+JfUPvj88FGDiE4JtqaQXo5k/TQmR0bnN
         wqrM41jCD69wJPaEKEHbNyQ2ODYYgq/KluhIBULv5lLuQTH67yJNKu9VwvjJC0jqPUCx
         UTGBVGzhsmAX72kut+feH1sjLZSDWcJ+zqO21Bl2nhSNSCOyYjPpQtuGUZGbd3El/IAC
         +amV+nGKlXbapdRkIuFGjDgPO+oVQbJsa/uTwZieQDc8HLnIuuRA+hyg0Y2XblNXLwly
         zYXg==
X-Gm-Message-State: APjAAAWezFL9P7aqbYE2+0YpyHCkr5hFFpS8GMMbJBRPQNK74rXmZ78z
        hzXdhpBy9Hco+tWI0I13GmAghK1YH3s=
X-Google-Smtp-Source: APXvYqzIUKMoeba9Bwq1UZWvMwGAWooB5HIK/Hr3Sf3hlXwW+mtIE+xJeawnV9EZ6WVsb0LOzE+sNg==
X-Received: by 2002:a37:a844:: with SMTP id r65mr2360449qke.349.1581516999034;
        Wed, 12 Feb 2020 06:16:39 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4da])
        by smtp.gmail.com with ESMTPSA id k50sm206752qtc.90.2020.02.12.06.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 06:16:37 -0800 (PST)
Subject: Re: [PATCH v2 04/21] btrfs: refactor find_free_dev_extent_start()
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-5-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <40c07473-8897-d0e8-718e-5c1fc0331c47@toxicpanda.com>
Date:   Wed, 12 Feb 2020 09:16:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200212072048.629856-5-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/12/20 2:20 AM, Naohiro Aota wrote:
> Factor out two functions from find_free_dev_extent_start().
> dev_extent_search_start() decides the starting position of the search.
> dev_extent_hole_check() checks if a hole found is suitable for device
> extent allocation.
> 
> These functions also have the switch-cases to change the allocation
> behavior depending on the policy.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

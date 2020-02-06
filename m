Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7B7015494F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 17:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgBFQe0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 11:34:26 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40040 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbgBFQe0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 11:34:26 -0500
Received: by mail-qk1-f195.google.com with SMTP id b7so6124473qkl.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2020 08:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TwJziLlj9lhJSWv2LT4V4xc4c1KA7a/LzV66F8uVef0=;
        b=DZBMgj8yogl9lgyBw2YOoEnEvkLey2vlPVryha3ACM5hH6n1FsjCIVU2XIzmVeM2k4
         xYuhytu2/kXvMVAK+bqXI4EcEWjLU2FOdGMJB24MzfXR0sBB59ets3wtWyt10KXc2Vhv
         jcw4uWcntJfG3AbS+C+WLtBC/kzi/Z6ZxE/n5Nc3TfB3bJ+GMbz0GtHgy1o9TEirUn4v
         2ZAPEn7mhl8fV+OMlRJgTFfh3ZbQ83TLPNHwBMaPTHahy/U7PuXIb5aNIsnyaVzGg1yH
         jbI+IgViqCEFT2RKCUmJPCDCB2F+M4MXMjjz0aHbi4w3IJJkDCcq01BjBN1BnnAoYEDa
         TgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TwJziLlj9lhJSWv2LT4V4xc4c1KA7a/LzV66F8uVef0=;
        b=d9V0vVhYGmhRey3W1Kt5MUd+UhEyK7efONAAkJjczyg5So9ZmnnoTWqQxk6iVREgmB
         ULCLz/zxx/X5U542Q24qkj/sKJLnfgH9OOMvfRs+At1c7XCnkuZHpgLmRbSMwPh5KtNx
         VPM+FG+G67l0YBwdbLUx30ve3a+0bd3jr0ED7BpDd5AnfHdH8RqKHKB/GTFUDM3gEtWb
         KMkcsAbfqBh+LCFd7Fu/EKOUzWRwgM+0U4382L2WlzwJbZut8ohlauTtr199GvVfjSeQ
         4mwpaDGou7CAJycXOjuzx3OGVH4pYpTEg6LfdppX/3uXQaduSea8I3bhyDOg519mRy8B
         ONBA==
X-Gm-Message-State: APjAAAUXfpnwqcUi/1xEUO6EssqJ264BxctameCGqh3B4N1mJBWeJ/vX
        iTMeSt5gECSJz3GUYjl2L0z+g/I/jWE=
X-Google-Smtp-Source: APXvYqzSwMw8V/dEC7k1aJHMmegKawf9WVvvAsy8zY82cLlR2W0pv2PaxSxQyI3CcUyOVWNG98vvTQ==
X-Received: by 2002:ae9:c018:: with SMTP id u24mr3343134qkk.339.1581006863541;
        Thu, 06 Feb 2020 08:34:23 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y27sm2003882qta.50.2020.02.06.08.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 08:34:22 -0800 (PST)
Subject: Re: [PATCH 03/20] btrfs: refactor find_free_dev_extent_start()
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
 <20200206104214.400857-4-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1992a0f8-f355-e1c3-17b9-f75feb3a2c20@toxicpanda.com>
Date:   Thu, 6 Feb 2020 11:34:21 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206104214.400857-4-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/6/20 5:41 AM, Naohiro Aota wrote:
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

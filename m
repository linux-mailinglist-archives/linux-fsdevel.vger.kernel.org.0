Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7E3111E8CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 17:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbfLMQwL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 11:52:11 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45182 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728420AbfLMQwL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 11:52:11 -0500
Received: by mail-qt1-f193.google.com with SMTP id l12so1774283qtq.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2019 08:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z2qlFHtYeOdEzkWmV7+orI2qPuU1XWKXbXVOxhpcueM=;
        b=idgcZAgHeZgVWTjECPvBp0b0qBPYz1hSSnHlN+3h6+r8GzUo+veIziFe8nnfw/G6gu
         0aOcstCQKbwXOnJ9JlaBrjViP8b7nttNapLE0JWqUu2W/uTj3JZfY0faqZb/TFUO2s5R
         47glWXklNLojnxw1ba6dGGShA8srjcYPL+hTxTMwA9dprqEdFs/b+LsXSm/uGlHjZu+K
         QZvQoKPIMgqKqHsMLGgfV3h4sRWSpypYvQ8OXXEsCcilM7ply9UAE5LCV2Ijc9NBuFLi
         2uGk5BhCX5ftGHOcqDmke0fUSpIDkEBm5hEHCTCV2cYWw8MqPTzcUCsOqZuUeN5yUEQ0
         WJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z2qlFHtYeOdEzkWmV7+orI2qPuU1XWKXbXVOxhpcueM=;
        b=hM4mhiAuyxXKusy+g/IMB4irjtHG52ObHCf9oWCLy/Ig7ctRifnqb9TQekJhquV6tv
         KNfiDsy1gUhJG9J88PY+Itikp917ZOu1WxQQ/Fu8MWR4oB/gqTY7HlHCth7Og+YehNWg
         n7cBcUmbxk05uch+EPB7Rz8vEb0wdJoi/LOXb1wPE5LIqzyHMf0+TCT9lNEdDw39guR7
         GwtG/6spr+zTkIKk4zgAalAEQl3S8GvrefBPbaCFdnF6ZU4NacGQwQ+g1EgCl55626bi
         XzdP7fJU4FZ3kUCVFsCIhbjKjzEyss2F+tzPCr6JjuSq4tl4Mmrzmks7xdROCwEX2qwI
         iGtg==
X-Gm-Message-State: APjAAAU/pjFufYBeZgmWTlaDhHrzTjvir+Tq04C7mTqz2ZPaa+Lv+7TO
        +eZpNevWgkBLLjCWX+BlZ2oCKXw7fIG+yg==
X-Google-Smtp-Source: APXvYqwmzqeBbRja+jYcNRQC0ics2KUk9Fxj1EFb+yDlJnPafAwvOj6E28yfS5SbNL9p6NxyZHIPTw==
X-Received: by 2002:aed:2103:: with SMTP id 3mr13149411qtc.132.1576255930345;
        Fri, 13 Dec 2019 08:52:10 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4e65])
        by smtp.gmail.com with ESMTPSA id 200sm3007783qkh.84.2019.12.13.08.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 08:52:09 -0800 (PST)
Subject: Re: [PATCH v6 09/28] btrfs: align device extent allocation to zone
 boundary
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-10-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <9e8dcbe8-71e7-0f07-738d-eb2802357444@toxicpanda.com>
Date:   Fri, 13 Dec 2019 11:52:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213040915.3502922-10-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/19 11:08 PM, Naohiro Aota wrote:
> In HMZONED mode, align the device extents to zone boundaries so that a zone
> reset affects only the device extent and does not change the state of
> blocks in the neighbor device extents. Also, check that a region allocation
> is always over empty zones and it is not over any locations of super block
> zones.
> 
> This patch also add a verification in verify_one_dev_extent() to check if
> the device extent is align to zone boundary.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29EEE15CB8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 20:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387396AbgBMT6l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 14:58:41 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52466 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgBMT6l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 14:58:41 -0500
Received: by mail-pj1-f68.google.com with SMTP id ep11so2845958pjb.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2020 11:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pVH+873kZpbEbaIccLjTSfs6ZyWqtMj5dnMBUQ051i8=;
        b=tSzqhQDt/v6xIszlkxG3bNJLt6zB1TSAyDXMiI5wUoOWrpbCGb5492yRGK3OldzLx4
         PxbjkhmrM/Tx2/3f6iywoIKrZJT0BSvqQ5oDxgAr1DjUNDZauLHjovYI4ZZeKXY19Hku
         u3ytEX7t+Wn54usAJXy9YX4W5JLZzcTifDXW91q75wHmhIDiz9QRHmGChw44AzRCHZ48
         uo3LFOQmQLt4JNVK87aMFnYO1YV8P4v1wq3cjvRXro794c1Rzic1Lm7Wnh2YX3Hem+Nn
         tlL0JDjmhMUwEgLa4l5OkEkEu5eyMzzlhGRJvpyXL1LhVLxKmG3D0EmL+t7ByMPkMZK4
         r65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pVH+873kZpbEbaIccLjTSfs6ZyWqtMj5dnMBUQ051i8=;
        b=VxmW+3bELdnZv4sagnyCATiHa1cG0kEDwVXb0aa9wnGhyGdE75f4ArpewG9SEmoJtb
         S6OEbnRxn7MbQh5FkBTedEw9TLYbcJbaERPzSWB7+C7NLSoXudU+McJaQqkmU2b0foF/
         I304KQxncd/+adH9Vn6GATwJlkxRbkLR6SMvZvmiD1i12Ta8IBcgKi+19IXsx5/GAZ79
         KahwB/Xa4w0YGcKdaKA2aNv//EOxHL/VBSSx94xBnqpGoR7vOMtJOhqqglX5V5N7ZpPn
         q4/c74TtS06bqHB/F8ZiahbgP9pwSUGaeTSA+wyfPeoa24AKjhWUqqALjN7zMyATt+Wx
         o+Sg==
X-Gm-Message-State: APjAAAWIcnvCb5biw6vCSTMzGiATJBKgjqk6/0nfOhP1FYvh8+UUQmog
        fqhLHK0u7E/ErN7hWSmZXfZvyz9tDjY=
X-Google-Smtp-Source: APXvYqwUWTSiEXDjlLszbLwkr0Dr2caV+vrSZP8wXEWkrtATFjzElTuiKAOBHqvAuthuv2DOg9eeIw==
X-Received: by 2002:a17:90a:cc02:: with SMTP id b2mr6672130pju.137.1581623919971;
        Thu, 13 Feb 2020 11:58:39 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21cf::1150? ([2620:10d:c090:400::5:249c])
        by smtp.gmail.com with ESMTPSA id q187sm4028157pfq.185.2020.02.13.11.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 11:58:39 -0800 (PST)
Subject: Re: [PATCH v2 17/21] btrfs: factor out found_extent()
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-18-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d06160bc-cb90-b66e-0366-0bc9c5320fd1@toxicpanda.com>
Date:   Thu, 13 Feb 2020 14:58:36 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200212072048.629856-18-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/12/20 2:20 AM, Naohiro Aota wrote:
> Factor out found_extent() from find_free_extent_update_loop(). This
> function is called when a proper extent is found and before returning from
> find_free_extent().  Hook functions like found_extent_clustered() should
> save information for a next allocation.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

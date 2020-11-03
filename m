Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD042A4A68
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 16:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgKCPza (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 10:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgKCPza (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:55:30 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3215C0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 07:55:28 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id e5so4321094qvr.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 07:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xntI1Eh9eVZ6JRxBdXbXC8WJsIu2fowBRTDPt6GSCek=;
        b=iheDPy/1LDw3gOT5myZy8oQu83yskwZbKNqX8AM+j4cQ+K7LpyUFnWoEI3J+UTKULD
         clwl2CafijxvWOTnBR+3WmDooQbIuGbuPWk3+BUP3bNZs5FE7mQ/RFG1hbLE4s5YpdoB
         hiuTNfrPgWHYwvYl89C6l3X43K/SH6g1P0erj6oi3khX+QtkzWd1MSy2thjzoUmGr3kv
         TYMqIDa26o3MJB1ZiU+MSN/tnyurGKGXIRkos5K4y0ha2waGCV2yRZbWTGFOqiif0rWY
         36xkeRY/HtOwEj9Iwel3boqWQkfjeyEIoCVA0kA05EENw0yBzR8YQr10Xi8IL4b7TfOz
         iiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xntI1Eh9eVZ6JRxBdXbXC8WJsIu2fowBRTDPt6GSCek=;
        b=ZygrsBVfNdJsM5eIpfRXjiJnE6PZ5GEXSJEqYOnduIdLZpTPUNHuJu1fOadVGBD+5O
         NNsgBPHm0szC+reuwXzkndmWj0YefZeCWrmNgDK0pzrHEPTXxY2W4aRils+htisvH0CL
         824tzy1uGbFVyVDOuLUS2N3jeF5NLvfJaSyUrL7KU0a9hfj/v0fZaIEI187ztuZ9RfOM
         B6PfTDudtLyU+VLY7ZPLoWXr84amUtnSVbVORbfZW1SJh9zHglBAFNHgsNHPGB1F3lcV
         M00qhZKwWa4AHTquX4yaZYGq8XmX4CKeJtgGDT3YY9POOdhmNYXQxi0QRKLJ5YiI4m0j
         csRw==
X-Gm-Message-State: AOAM531D2RT5ZU+PEPjCTiE0JzGk6qZjsrmbXjXXVxoEVXJTgUjVei4n
        uZkUvWUATUXp4YUYQvPqaViO1Q==
X-Google-Smtp-Source: ABdhPJyJe7L2bBqeKx348QnpfIwy4XjQ9JkwLVS8hE4oJ3f3VKgn3OLBALKOZ5rx0RJ6IChiyFaPyQ==
X-Received: by 2002:ad4:4e34:: with SMTP id dm20mr20662286qvb.40.1604418927964;
        Tue, 03 Nov 2020 07:55:27 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q70sm10384537qka.87.2020.11.03.07.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 07:55:27 -0800 (PST)
Subject: Re: [PATCH v9 25/41] btrfs: use ZONE_APPEND write for ZONED btrfs
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <51cdc96d68f84eb93a310a96b6b7ad6e070dd1ac.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <85ca7f8a-5d7c-d00c-2f34-4d5966b332f8@toxicpanda.com>
Date:   Tue, 3 Nov 2020 10:55:26 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <51cdc96d68f84eb93a310a96b6b7ad6e070dd1ac.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> This commit enables zone append writing for zoned btrfs. When using zone
> append, a bio is issued to the start of a target zone and the device
> decides to place it inside the zone. Upon completion the device reports
> the actual written position back to the host.
> 
> Three parts are necessary to enable zone append in btrfs. First, modify
> the bio to use REQ_OP_ZONE_APPEND in btrfs_submit_bio_hook() and adjust
> the bi_sector to point the beginning of the zone.
> 
> Secondly, records the returned physical address (and disk/partno) to the
> ordered extent in end_bio_extent_writepage() after the bio has been
> completed. We cannot resolve the physical address to the logical address
> because we can neither take locks nor allocate a buffer in this end_bio
> context. So, we need to record the physical address to resolve it later in
> btrfs_finish_ordered_io().
> 
> And finally, rewrites the logical addresses of the extent mapping and
> checksum data according to the physical address (using __btrfs_rmap_block).
> If the returned address matches the originally allocated address, we can
> skip this rewriting process.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

I hate this, but I suppose its better than forcing us to wait for ordered 
extents in order of submission, and I can't really think of anything better,

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5532D720215
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 14:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbjFBMbl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 08:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbjFBMbk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:31:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7D197
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 05:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685709051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5KczTQ2AZCgTU2CpSNceVMnYBZTGZq4bWaDOnIranDc=;
        b=GvnZTX8gokzteBLXJtPsOf7qoQGvTe2CFpFIHAK0BcpDJw00RexdZP0wf677XklkLVCUnq
        DF/OgA8wz2qGsnOktY2gbmyJ06EEfpg53x6lxgaH8CiiF8PGY7+g8rH7gE/eN6rHs6wSeB
        O86+JTV5skyOeJFwQF+seEg4nA1x1eY=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-WsSII8l1Ny-VDldGiOhpAw-1; Fri, 02 Jun 2023 08:30:50 -0400
X-MC-Unique: WsSII8l1Ny-VDldGiOhpAw-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-78681dff350so570711241.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Jun 2023 05:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685709049; x=1688301049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5KczTQ2AZCgTU2CpSNceVMnYBZTGZq4bWaDOnIranDc=;
        b=Z3g3g0/hh4c2NSZGnHNpqPn52xh4vQ1E9xrMuHIBHXIZ3oCwmwTJ/+tPwBgPcvJZ5E
         952thlbAOHqT+v16l/yqfzLk5eBbKJZ+V6mWwvPP+ETMC4N0J7ARWVFtoqYUkfxYoek4
         tco2tBhmBlcFj7sI8ZL2xYXgk+C97/7Nco7Q9GDgaqEi20yqDSrqR+qGCgVphKGaNOMJ
         cQeKUE3f8YzyC7hTn3aRV55s/FBAqyi57V6zTWMxJwTQntx99qRfHGXL98aU5TOnFATb
         7ublTpgOnFRw3dY8iXGmsDYLNws9ssEnL6/WbQx2+rsZnzl9vdiJzw00y5hZk4XXuu+J
         479A==
X-Gm-Message-State: AC+VfDwYCbELz4yG5n+cDrNA3Uiyd5M8gVrIvyRFNZJOdN20E1sCkNqv
        lokNqniEEZxhCekoxabh1/9fs1cp1GbVXpcB3L6DN2Ko7W7ai+0s08t8K4XwKAcdO/u+jsi6vmo
        7dGtbY3UsWLmFELLWOyS1K4lDsULUlibLc5sd
X-Received: by 2002:a67:f1d2:0:b0:43b:1893:e41d with SMTP id v18-20020a67f1d2000000b0043b1893e41dmr1719784vsm.25.1685709049352;
        Fri, 02 Jun 2023 05:30:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6SgTq0KtUBm5AHpuTfvZ4raq0BhwLIXgG5+TFLPzO9W++o0g3RAEJ2BxE7FRGtwANDTED/xg==
X-Received: by 2002:a67:f1d2:0:b0:43b:1893:e41d with SMTP id v18-20020a67f1d2000000b0043b1893e41dmr1719776vsm.25.1685709049045;
        Fri, 02 Jun 2023 05:30:49 -0700 (PDT)
Received: from [172.16.0.7] ([209.73.90.46])
        by smtp.gmail.com with ESMTPSA id u5-20020a0cc485000000b006263c531f61sm761973qvi.24.2023.06.02.05.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 05:30:48 -0700 (PDT)
Message-ID: <4530554c-c2b3-f93b-6c2c-c411e62d1e45@redhat.com>
Date:   Fri, 2 Jun 2023 07:30:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/6] gfs2/buffer folio changes
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20230517032442.1135379-1-willy@infradead.org>
Content-Language: en-US
From:   Bob Peterson <rpeterso@redhat.com>
In-Reply-To: <20230517032442.1135379-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/16/23 10:24 PM, Matthew Wilcox (Oracle) wrote:
> This kind of started off as a gfs2 patch series, then became entwined
> with buffer heads once I realised that gfs2 was the only remaining
> caller of __block_write_full_page().  For those not in the gfs2 world,
> the big point of this series is that block_write_full_page() should now
> handle large folios correctly.
> 
> It probably makes most sense to take this through Andrew's tree, once
> enough people have signed off on it?
> 
> Matthew Wilcox (Oracle) (6):
>    gfs2: Use a folio inside gfs2_jdata_writepage()
>    gfs2: Pass a folio to __gfs2_jdata_write_folio()
>    gfs2: Convert gfs2_write_jdata_page() to gfs2_write_jdata_folio()
>    buffer: Convert __block_write_full_page() to
>      __block_write_full_folio()
>    gfs2: Support ludicrously large folios in gfs2_trans_add_databufs()
>    buffer: Make block_write_full_page() handle large folios correctly
> 
>   fs/buffer.c                 | 75 ++++++++++++++++++-------------------
>   fs/gfs2/aops.c              | 66 ++++++++++++++++----------------
>   fs/gfs2/aops.h              |  2 +-
>   fs/ntfs/aops.c              |  2 +-
>   fs/reiserfs/inode.c         |  2 +-
>   include/linux/buffer_head.h |  2 +-
>   6 files changed, 75 insertions(+), 74 deletions(-)
> 
Hi Willy,

I did some fundamental testing with this patch set in a five-node 
cluster, as well as xfstests, and it seemed to work properly. The 
testing was somewhat limited, but it passed basic cluster coherency 
testing. Sorry it took so long.

If you want you can add:
Tested-by: Bob Peterson <rpeterso@redhat.com>
Reviewed-by: Bob Peterson <rpeterso@redhat.com>

Regards,

Bob Peterson


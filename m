Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445BB70706B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 20:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjEQSHf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 14:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjEQSHe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 14:07:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2614094
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 11:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684346803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JPAKEMmoW/hN8niZpR0qHJlcpgA9MC/akmM/6a2jgQg=;
        b=bgu4QF6u+ivGqJZ2LRPGTE7S0z9kuqSHKvbeXeNwGoRgezfhCBj9qGoZK8BMJwT0nnj62S
        pxQjzVnkOoZ+wsrc79Wkr1gjOZmkIHuQ5g4RW13zWm/TwbNO714WQgAqMKMrEaFodATvQQ
        uYq5lxKxiItV8Z/QTqhAOHFPecIidLc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-XiSmhdtOO_6yC4ddxRN65Q-1; Wed, 17 May 2023 14:06:41 -0400
X-MC-Unique: XiSmhdtOO_6yC4ddxRN65Q-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3f4d7e97a37so7215531cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 11:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684346801; x=1686938801;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JPAKEMmoW/hN8niZpR0qHJlcpgA9MC/akmM/6a2jgQg=;
        b=HpCRlHQdBkZ94SWsTFUu9oqzyZJQ+mILAHU+Wrn19L22rANbwnljt5DgzFZShsARwJ
         /DtCVdVQRGrOsNONXbjs37HVIlGhEM8dVTgmR2CXMNsY3aGoCC51P563QdnzlIDg1SZp
         AE3H1G4P86G60i95hnz79eke6Ij5jSh4WAbrH+GuyQYVJEtGUFP+7PsoYfEJOM4NPCQO
         o24q3FRSvLLhzcGdqLMJolSrt1emh7IVx61ngRpZn2xq0ysec9PJVdH8maCE2K6ZIUij
         oEeZHwYBojsYj0Su4SYhOxuTnv016Kuy5IAKP28dP8sxn90w1MW9mldj4qkKmd/f4wfS
         607A==
X-Gm-Message-State: AC+VfDw5PBuUqBdiE9MHwarQ3/Zry85nC02gLrEhk5aixdxoYJxnlw8I
        9G1NggLD11ErXPfkhxsk6A5qX6M5zPVrjtjvMjw/i3iSXpBYvek9Xw+UDR3LzjKd9nMuWjpePIx
        Zdq4vSFqMRa0H0+O+tcKZ4LluGA==
X-Received: by 2002:ac8:7f88:0:b0:3f5:1bf2:8b90 with SMTP id z8-20020ac87f88000000b003f51bf28b90mr823698qtj.13.1684346801029;
        Wed, 17 May 2023 11:06:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7bKUBNvkUgo07NzXqdvUsP1kW6RU9BYMt7BII3OsWP+fRx8VumCBPBNl0Tjnzu4rkCFMPrTw==
X-Received: by 2002:ac8:7f88:0:b0:3f5:1bf2:8b90 with SMTP id z8-20020ac87f88000000b003f51bf28b90mr823675qtj.13.1684346800793;
        Wed, 17 May 2023 11:06:40 -0700 (PDT)
Received: from [172.16.0.7] ([209.73.90.46])
        by smtp.gmail.com with ESMTPSA id v11-20020ae9e30b000000b0074636e35405sm790856qkf.65.2023.05.17.11.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 11:06:40 -0700 (PDT)
Message-ID: <4b01c34d-5bdc-e72a-33f1-956864236ed4@redhat.com>
Date:   Wed, 17 May 2023 13:06:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/6] gfs2/buffer folio changes
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20230517032442.1135379-1-willy@infradead.org>
From:   Bob Peterson <rpeterso@redhat.com>
In-Reply-To: <20230517032442.1135379-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Hi Matthew,

I recently started looking into doing this, too, so this is apropos.
I'll give it a careful review and some testing. The jdata stuff in gfs2 
is very touchy, but this looks like a step in the right direction.
I'll let you know how it fares.

Regards,

Bob Peterson


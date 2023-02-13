Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4553C694BC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 16:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjBMPxR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 10:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjBMPxH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:53:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A0A1EBE5
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Feb 2023 07:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676303533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Fo7Ui1Nc8CjqUmKnBCjrLYrDjQgnmDeMH/tn21pLD0=;
        b=ahY3LGMdIhnA2mE6puQbbh2y79oVHnKTkjpP8S8Yjr0kHc2ZNxgjfvHQrQIHWBVgz4qsae
        baCKf7BuIIb0wdGlLMwU6U2wSgNS68TCJKskUs9bp+jP5SKc2HwiF7Zu/U0++2MujOsO52
        e/lh5BL72v1sfw5wmLRcJ+GgyqPDOzs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-131-e-dty7u-MrK3r7_OSPshZA-1; Mon, 13 Feb 2023 10:52:11 -0500
X-MC-Unique: e-dty7u-MrK3r7_OSPshZA-1
Received: by mail-wm1-f69.google.com with SMTP id ay19-20020a05600c1e1300b003dc54daba42so6341307wmb.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Feb 2023 07:52:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Fo7Ui1Nc8CjqUmKnBCjrLYrDjQgnmDeMH/tn21pLD0=;
        b=X100aG0kZzmf/pFfQTeDmXMXq9tA96liZgupguXu+JRjGAZSKUBQFwqVHYDdGDo362
         PRJe+FyAMAZ2ZLWoDolbD2jq7KGQVGyC1F/bb+e3uBCToQDUI97CFC6mCxU5XZrnN+yz
         3md8BMC0+KixqVMi8SjWLUj2pqeenG2l4IL11DJGmYSB7NODrRwG6sxvrhPK55GriXKl
         4sGv5LDNWn8Izpw5nHamWARHHLblIlvsbnppUlFr5tkfS0euvgfnp/k9Ozu1nUW2srwU
         H7wBTe2y+wga9MTBLLjZFLuyfPtIbuzbSSTTu/5ZsWW85vzAlFsN2hYVy+QK8HDPgleX
         KTVA==
X-Gm-Message-State: AO0yUKV4bF3hBrgm2Jed74epj+Sdb+Y0APK3XY8FXtayhsV/jFsq75wR
        7/bwLLm6rpYOAqwJizOpiIsMDLBC0xNOxA5G4fLaPhGvThO2hPYVw4+3jUtC/6vI6WoIO4TTShU
        WBRZ1Vr64x1M6lzvpjq7w24u3kg==
X-Received: by 2002:a05:600c:a694:b0:3dc:3f51:c697 with SMTP id ip20-20020a05600ca69400b003dc3f51c697mr4749408wmb.18.1676303530497;
        Mon, 13 Feb 2023 07:52:10 -0800 (PST)
X-Google-Smtp-Source: AK7set85F8cOZT0KFiY3fzKK40YD+oF9Z8F3gJ2/6lI42oq0mDsItl98By9DcQ1LzKg2GlhbwaDS0g==
X-Received: by 2002:a05:600c:a694:b0:3dc:3f51:c697 with SMTP id ip20-20020a05600ca69400b003dc3f51c697mr4749394wmb.18.1676303530262;
        Mon, 13 Feb 2023 07:52:10 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:6d00:5870:9639:1c17:8162? (p200300cbc7056d00587096391c178162.dip0.t-ipconnect.de. [2003:cb:c705:6d00:5870:9639:1c17:8162])
        by smtp.gmail.com with ESMTPSA id x7-20020a05600c188700b003cffd3c3d6csm13712133wmp.12.2023.02.13.07.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 07:52:09 -0800 (PST)
Message-ID: <f7a1bcad-f11c-26ab-debd-57b445a479a1@redhat.com>
Date:   Mon, 13 Feb 2023 16:52:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 4/4] splice: Move filemap_read_splice() to mm/filemap.c
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
References: <20230213153301.2338806-1-dhowells@redhat.com>
 <20230213153301.2338806-5-dhowells@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230213153301.2338806-5-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13.02.23 16:33, David Howells wrote:
> Move filemap_read_splice() to mm/filemap.c and make filemap_get_pages()
> static again.
> 
> Requested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: John Hubbard <jhubbard@nvidia.com>
> cc: David Hildenbrand <david@redhat.com>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


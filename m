Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5A8694B97
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 16:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjBMPs3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 10:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBMPs1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:48:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A90E1EBF7
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Feb 2023 07:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676303252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zk9ZB85N8qJ1vK9VuqUk4MadsaC7d3r9I0xTkyZcACk=;
        b=Fq8PFZYSCFcnuT7S5D0Ldv/QazvSRLpu74DdT66rRaV6CzpBpT92m0hsdCTsYrXSn5xxMB
        cKGRXNJ3okNOTj4H6bhgphe67pcKHE5IZCMI8JJK/rDVxYoRt7+V6OjpVuvjPLm1pILk3r
        yGWhRQUcPpqgCP9Iszb4/b4pXL88AOE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-473-xi8Z36coNGWDAxSJlZROwg-1; Mon, 13 Feb 2023 10:47:31 -0500
X-MC-Unique: xi8Z36coNGWDAxSJlZROwg-1
Received: by mail-wr1-f71.google.com with SMTP id l15-20020adff48f000000b002c55dbddb59so560153wro.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Feb 2023 07:47:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zk9ZB85N8qJ1vK9VuqUk4MadsaC7d3r9I0xTkyZcACk=;
        b=jMiajbM2C37THajgRZVmOIw4PCGGXfAEx3cTJ4PZliuHgHNWP2iihFpS/nau2FDVFX
         E4wK9YsX4yGKVeXIGoUXKzH2M1SROMGXCRgGdw2D6nJIFSeDif1AibBgV41xTRE3wY7F
         cM37JI3i8KilDsnAO71QT8FxNGbUIw98C1n/lCJvGdBxJIwl/qWxuap16ReGyv1b6R/A
         9cBVZYVfOqhfyy4eJmbGovUWSTI89rgZkjtrGJe31Nzl48l7gFxtL7cM0xBOCsvk7u7V
         EN6PNqNetCbKyfS3kCDZ3zVr8frMPPAh86y65YiAXgwW+M0fvL8gbxudUb5JNIuwGleF
         HTbA==
X-Gm-Message-State: AO0yUKUnK9eVwn4yp+UEIEugySsrMYwUPxSI+kBz5b8oGmfcDFkMwOEW
        4T3ky4MI+sobvORujrsKDi0B/7DGMoaNjVRBjGkjRO4ts6TNY6ZYExzmOf/794w/ROvYKZnA5NJ
        zY1EW+OSfUasF1Wjx1HX4JFj/hw==
X-Received: by 2002:adf:fcc1:0:b0:2c3:f78f:518f with SMTP id f1-20020adffcc1000000b002c3f78f518fmr18794830wrs.39.1676303249979;
        Mon, 13 Feb 2023 07:47:29 -0800 (PST)
X-Google-Smtp-Source: AK7set9kzLbhn6FVuDM3325N5rlxLs5gU4rYjW2jekddTSwamP6u7flJXRTM1zAOMwya96tpyHAZIg==
X-Received: by 2002:adf:fcc1:0:b0:2c3:f78f:518f with SMTP id f1-20020adffcc1000000b002c3f78f518fmr18794818wrs.39.1676303249742;
        Mon, 13 Feb 2023 07:47:29 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:6d00:5870:9639:1c17:8162? (p200300cbc7056d00587096391c178162.dip0.t-ipconnect.de. [2003:cb:c705:6d00:5870:9639:1c17:8162])
        by smtp.gmail.com with ESMTPSA id k1-20020adff5c1000000b002bff574a250sm10959411wrp.2.2023.02.13.07.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 07:47:29 -0800 (PST)
Message-ID: <5f3d8009-7579-32e9-ab24-347f71fa5ce6@redhat.com>
Date:   Mon, 13 Feb 2023 16:47:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/4] splice: Rename new splice functions
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
 <20230213153301.2338806-2-dhowells@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230213153301.2338806-2-dhowells@redhat.com>
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

On 13.02.23 16:32, David Howells wrote:
> Rename generic_file_buffered_splice_read() to filemap_splice_read().
> 
> Rename generic_file_direct_splice_read() to direct_splice_read().
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


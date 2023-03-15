Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE31E6BBCD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 19:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjCOS7Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 14:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjCOS7W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:59:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F4BC178
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 11:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678906713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kwq97ii9j4Uobk/QWp3tFh+rm8HJDcqt7MfCwBpcIz0=;
        b=JioCehB3zRqQtsPPWyVl1sH8PJdBa2ToiHojgWvzuGWmQUsSRlCb0dSkfxvg7OhtrpXUH+
        dh2T8o+hDDIE+DFo+oqAPQq4Df4ucJxdWM1aBuWUn1I69SxxVWdufQq3Tj1Gqhkdwfv7Cn
        q++JPAcnpBfQ/d6wptol+QkJrsikldo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-BFw4UqL_P_yG_EwtiGa5ag-1; Wed, 15 Mar 2023 14:58:24 -0400
X-MC-Unique: BFw4UqL_P_yG_EwtiGa5ag-1
Received: by mail-wm1-f71.google.com with SMTP id o31-20020a05600c511f00b003ed2ed2acb5so1416271wms.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 11:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678906703;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kwq97ii9j4Uobk/QWp3tFh+rm8HJDcqt7MfCwBpcIz0=;
        b=XGtvLOHcYHGRl7hssEKSqRC5UD6I//bmz+DgP38Ln1AjJvUJkySEhjtfByBnr2Hkng
         IJzlFuV7CFdnMTMJqaclvYgTVm/+1y5yDgpZeUmku5B6EZtmcTaRbEAyJpH5QDFHTd+T
         Bu7hz2OdVx8iqSYyUtMrLCsoO0ca/qKbzvIGDMLw4n3ABoeCAjXbdsYVuNSi7GYcQyis
         gV+hrec9KQBDo1+fokoU56MPE9B3bEKk6ZTsiI5lkrJb7c0UaRi/XVPikvcSHmf/VNCA
         obtYvdELxi9R7REEtHJc07z2zv2yh0zgEY/Kehfb3e3zYimML0KE5Nwrc5aI7b53LamB
         CPvw==
X-Gm-Message-State: AO0yUKVpgFBIFaCg6QOcSx/ihjPO3k3Cz1HiLF430uS39NECyd0Fl9Z9
        cg/w0mM6Qs/P4C2XeJKWu8ml1xqMPHxB0N+gK/qRTflFp2ziM8SaMWv00O8nS85ZVuPtpc0R4RS
        9EHARRHs3t27TGZD6/vVnoh4c2Q==
X-Received: by 2002:a05:600c:3591:b0:3e2:1dac:b071 with SMTP id p17-20020a05600c359100b003e21dacb071mr15684805wmq.13.1678906703225;
        Wed, 15 Mar 2023 11:58:23 -0700 (PDT)
X-Google-Smtp-Source: AK7set9wHxtbJeJaGu+TUflUL+yBb+lhiGSDGexB3h7ZOMkBv9oBaMw6khZUH1IgPgUBcAEXtdGuIg==
X-Received: by 2002:a05:600c:3591:b0:3e2:1dac:b071 with SMTP id p17-20020a05600c359100b003e21dacb071mr15684794wmq.13.1678906702944;
        Wed, 15 Mar 2023 11:58:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:2f00:2038:213d:e59f:7d44? (p200300cbc7022f002038213de59f7d44.dip0.t-ipconnect.de. [2003:cb:c702:2f00:2038:213d:e59f:7d44])
        by smtp.gmail.com with ESMTPSA id k26-20020a7bc31a000000b003eb596cbc54sm2862421wmj.0.2023.03.15.11.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 11:58:22 -0700 (PDT)
Message-ID: <c1006976-8166-ca52-33db-d2eda8d8792e@redhat.com>
Date:   Wed, 15 Mar 2023 19:58:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v19 01/15] splice: Clean up direct_splice_read() a bit
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
References: <20230315163549.295454-1-dhowells@redhat.com>
 <20230315163549.295454-2-dhowells@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230315163549.295454-2-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 15.03.23 17:35, David Howells wrote:
> Do a couple of cleanups to direct_splice_read():
> 
>   (1) Cast to struct page **, not void *.
> 
>   (2) Simplify the calculation of the number of pages to keep/reclaim in
>       direct_splice_read().
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: David Hildenbrand <david@redhat.com>
> cc: John Hubbard <jhubbard@nvidia.com>
> cc: linux-mm@kvack.org
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


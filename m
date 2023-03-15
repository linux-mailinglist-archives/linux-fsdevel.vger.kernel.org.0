Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EF96BBCDE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 20:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjCOTAB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 15:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjCOS74 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:59:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACE8664D0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 11:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678906750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3pRuFXv24zO9iZj6MhHQgS7pRqlQAfg3F2hO5yqQOu0=;
        b=R6IPpvsUomXLW17NQM8ZOudFIxUvbB72dV4LmClxR/WrGn5PjULcUjK00iJ+11lCVNdkrG
        KWh91vMqsXbyZY0HBH/DOFkNs5JzVDwqHTGmEaKlsprKM9A6u2HTDNAjhT6Y/hSkmLasYD
        QsLq3DSYLIjAzUlVdQNJzpAb+YpmYBo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-XdAgX2c_PMeo9zoP_rWU2w-1; Wed, 15 Mar 2023 14:59:08 -0400
X-MC-Unique: XdAgX2c_PMeo9zoP_rWU2w-1
Received: by mail-wm1-f71.google.com with SMTP id k18-20020a05600c1c9200b003ed2a3f101fso1385053wms.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 11:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678906747;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3pRuFXv24zO9iZj6MhHQgS7pRqlQAfg3F2hO5yqQOu0=;
        b=3lsmHOCx027jF0cfrItvRxvFHdRl6uUBk9HJqqbdvbHlxr1tQlPMlL5uXaLNDRokjp
         S9HZlLRDgtJn+2NUT90PQ586N0udfhcY8hnSt0NEJfpwkpMS6fEwDbHW9/WkPjuVQaH3
         7sltO1L9X3Zwj7Ic4qHzGxwWSQybE9RkA8m2IdszI+8KauqgRHXhLi8/GzIxId1h+Yi2
         c/2mEIR3lhJbIm4jf5JGqZd+gFp/YZOb1phRdmf/74S49GAKxf/kcMZ29jaaoUmxM+59
         gI2ppqr9ezdxXamXJiTIhX+4VQc7ywZmxlDX2XwpB3cH0dFCQOgsM1YhM6qH5OyshIwi
         O2vw==
X-Gm-Message-State: AO0yUKXbIxYxEy1bd8SWJg9p1kuZOQeBsHu2JkX7lHme/exv4lGZ6frh
        a8J14CPGj9Cya5mHOXgz5m2xIjeAhqR412R85N+t5nSglIoZzCLnDDVbIXo7o2iwX5RsrafFhs1
        6zhZWg//4rzBB5Lqi440mWPKEt8E6xEX7dw==
X-Received: by 2002:a5d:452b:0:b0:2cf:ec84:b63a with SMTP id j11-20020a5d452b000000b002cfec84b63amr2499472wra.43.1678906746989;
        Wed, 15 Mar 2023 11:59:06 -0700 (PDT)
X-Google-Smtp-Source: AK7set/id0A51e2uD6Xav4KlpzhQfvsr1WBJ6M12HWKP+dMN7x79MowOlKwVntfM4m25nbOzwjbzYQ==
X-Received: by 2002:a5d:452b:0:b0:2cf:ec84:b63a with SMTP id j11-20020a5d452b000000b002cfec84b63amr2499453wra.43.1678906746804;
        Wed, 15 Mar 2023 11:59:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:2f00:2038:213d:e59f:7d44? (p200300cbc7022f002038213de59f7d44.dip0.t-ipconnect.de. [2003:cb:c702:2f00:2038:213d:e59f:7d44])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d45ca000000b002ca864b807csm5451460wrs.0.2023.03.15.11.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 11:59:06 -0700 (PDT)
Message-ID: <0064f021-ac21-8bbc-5156-90328da61b8f@redhat.com>
Date:   Wed, 15 Mar 2023 19:59:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v19 02/15] splice: Make do_splice_to() generic and export
 it
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
        Miklos Szeredi <miklos@szeredi.hu>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-unionfs@vger.kernel.org
References: <20230315163549.295454-1-dhowells@redhat.com>
 <20230315163549.295454-3-dhowells@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230315163549.295454-3-dhowells@redhat.com>
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
> Rename do_splice_to() to vfs_splice_read() and export it so that it can be
> used as a helper when calling down to a lower layer filesystem as it
> performs all the necessary checks[1].
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> cc: Miklos Szeredi <miklos@szeredi.hu>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: John Hubbard <jhubbard@nvidia.com>
> cc: David Hildenbrand <david@redhat.com>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: linux-unionfs@vger.kernel.org
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> Link: https://lore.kernel.org/r/CAJfpeguGksS3sCigmRi9hJdUec8qtM9f+_9jC1rJhsXT+dV01w@mail.gmail.com/ [1]
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


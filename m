Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA0167D9E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 00:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbjAZXpl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 18:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjAZXph (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:45:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6019D2F7AA
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 15:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674776653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PI+Jsv2TxAR9Abf8MJO7xLLwXDlmnNTYN30oeKtKeeI=;
        b=dIlMMFkFEBFWOVxwhIoC9pT29F+Cz5bsCiPvddrNLaoujetSHGdEIoqPFrlE5+sXfFC2sN
        5OVmZK11uqE981VTIFapTGuMXSeyVrA4slHX+W5mtZkOQQkGWaEA+f2L55+/+rq34YXuXB
        wKL4tHICrbE8lF0PvAPq7RzOvmLy6HU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-202-BKb-jtI4MdKbb907OU_R6g-1; Thu, 26 Jan 2023 18:44:11 -0500
X-MC-Unique: BKb-jtI4MdKbb907OU_R6g-1
Received: by mail-wm1-f69.google.com with SMTP id l19-20020a05600c1d1300b003dc13fc9e42so1843000wms.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 15:44:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PI+Jsv2TxAR9Abf8MJO7xLLwXDlmnNTYN30oeKtKeeI=;
        b=YQNQ/mYtzNzHk4NGVAtCwAWlgg4WMCnDIXchwQ6JVtrWPTuCykTCpdksv8r08TqKhc
         FcWPtpVMzZ89aK0FICpBwY5GlDsOZWpYu3VI8ZuwcfX3uAAwjWruzc4AlYSfKsjGGX5s
         bNueZSGPJpDHTeH3At2+8v5Mo2I7EF8UhnE2XPDmOd9MiWRISqq4juwbhyH5qokdIioA
         Y/zm2GZu3JC7u7Tr/N02SBT8qHOCuGXC3YNNqvR8pWDDcUOfq05CLgZ+TarJxHQjLF1L
         3LgkIBl5w2ih1h+1URyz7Wb5UIcDmWEulwd9JQfQ4AvC7e4f8ZGwsue80s4VSNAbafM7
         FVyw==
X-Gm-Message-State: AFqh2kpEoFV0yb+dNut3jgg/7raSs2IwHODvJk6NXQzeeFq1VpTHMZUh
        YITg1iDXiWserR9JdqksGqVMbqtozbnMdtMAEaXAVPRlXCxY7RZGJ6EPXI4q/WqfgasBEvnUh5M
        givddUHrXLxJmBltS0GZ0E03DqQ==
X-Received: by 2002:a05:6000:12cb:b0:2bd:bf44:2427 with SMTP id l11-20020a05600012cb00b002bdbf442427mr35492165wrx.42.1674776650686;
        Thu, 26 Jan 2023 15:44:10 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuYtrgOl2m3LqcTWZWXs2ZqSVi93PYCMVoVdhFMM1NnPQJAUnmGCmIU/Ns6kWli+3InjkeYcQ==
X-Received: by 2002:a05:6000:12cb:b0:2bd:bf44:2427 with SMTP id l11-20020a05600012cb00b002bdbf442427mr35492148wrx.42.1674776650370;
        Thu, 26 Jan 2023 15:44:10 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:5e00:9e97:86d:5ed5:bb95? (p200300cbc7075e009e97086d5ed5bb95.dip0.t-ipconnect.de. [2003:cb:c707:5e00:9e97:86d:5ed5:bb95])
        by smtp.gmail.com with ESMTPSA id d3-20020adfe2c3000000b002bc7fcf08ddsm2385220wrj.103.2023.01.26.15.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 15:44:09 -0800 (PST)
Message-ID: <ba3adce1-ddea-98e0-fc3a-1cb660edae4c@redhat.com>
Date:   Fri, 27 Jan 2023 00:44:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v11 2/8] iov_iter: Add a function to extract a page list
 from an iterator
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
References: <20230126141626.2809643-1-dhowells@redhat.com>
 <20230126141626.2809643-3-dhowells@redhat.com> <Y9L3yA+B1rrnrGK8@ZenIV>
 <Y9MAbYt6DIRFm954@ZenIV>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y9MAbYt6DIRFm954@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26.01.23 23:36, Al Viro wrote:
> On Thu, Jan 26, 2023 at 09:59:36PM +0000, Al Viro wrote:
>> On Thu, Jan 26, 2023 at 02:16:20PM +0000, David Howells wrote:
>>
>>> +/**
>>> + * iov_iter_extract_will_pin - Indicate how pages from the iterator will be retained
>>> + * @iter: The iterator
>>> + *
>>> + * Examine the iterator and indicate by returning true or false as to how, if
>>> + * at all, pages extracted from the iterator will be retained by the extraction
>>> + * function.
>>> + *
>>> + * %true indicates that the pages will have a pin placed in them that the
>>> + * caller must unpin.  This is must be done for DMA/async DIO to force fork()
>>> + * to forcibly copy a page for the child (the parent must retain the original
>>> + * page).
>>> + *
>>> + * %false indicates that no measures are taken and that it's up to the caller
>>> + * to retain the pages.
>>> + */
>>> +static inline bool iov_iter_extract_will_pin(const struct iov_iter *iter)
>>> +{
>>> +	return user_backed_iter(iter);
>>> +}
>>> +
>>
>> Wait a sec; why would we want a pin for pages we won't be modifying?
>> A reference - sure, but...
> 
> After having looked through the earlier iterations of the patchset -
> sorry, but that won't fly for (at least) vmsplice().  There we can't
> pin those suckers; 

We'll need a way to pass FOLL_LONGTERM to pin_user_pages_fast() to 
handle such long-term pinning as vmsplice() needs. But the release path 
(unpin) will be the same.

-- 
Thanks,

David / dhildenb


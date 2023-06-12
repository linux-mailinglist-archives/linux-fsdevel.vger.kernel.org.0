Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40F472C54C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 15:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbjFLNAz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 09:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235840AbjFLNAp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:00:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED836C7
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 05:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686574799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7MHUCM5KT8vM2xB13XAxxl/4rNAKHKdVp2VNq4kQ1aI=;
        b=PJnTVZGLzRDFQrJKTLrDpK6mIKC+UfhBybrW/1JTHQ98Voeo5WwrTYkEd8lholoXclkpL/
        vQUSnjs8j5/XP/+hQUbIPX7M80VwO8peaiJIg6EluiiU0l4bobmDCypPjFINv3rPv7wQtY
        jqA1EeK7UO7jMcrm7I8QTKodNwQyQsk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-OfnxWizsOligJGE38yzhCg-1; Mon, 12 Jun 2023 08:59:57 -0400
X-MC-Unique: OfnxWizsOligJGE38yzhCg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f81bdf4716so3716585e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 05:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574796; x=1689166796;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MHUCM5KT8vM2xB13XAxxl/4rNAKHKdVp2VNq4kQ1aI=;
        b=OwcwXksSWj4RjJHvqFHUUX4l/NPSrXghSvf3UVWirxQYM2pxACsMGiZN0sYUSEweFA
         dJco3cRyNNSVej5VoVM1B2ziX2xCsGAG39TnHgphmrINzgC/eZMpAmWVBq9h91YnnLap
         M5AnBL0qvn9KaetTdjmkuJp5dsBS1Y9amM6Dxzy3zG1L9zlo0qHnFtZdWOeRWBa5ksWE
         p91rbL4Mh+FzmUGRJ+5G6ZetZBVVE8Zd8ayd5hZ0bwyvpSu/fNukHqiMiXWDP0ieRXBa
         Bp0zy9dkC2uEwYCBpxqPcixKmXmyEWGUN5cmTswGd7Jl5eHDF9tba1gS1ibi8hGWw4o0
         OvKw==
X-Gm-Message-State: AC+VfDx/3d3q0p5+u/Yq2lkUipF5I6R8TKBb9vIcvNLGZ4Pe6nrLiR5/
        +VGQaCPQ5Www4wZ0RsOdzF4yYBssPmLNg5n6PD6d/tDMDUhZkh2iiFupTPzOiY9zidsCPY17uRX
        TggEiXT5Do6RWFEPfWg1INPyeMg==
X-Received: by 2002:a05:600c:254:b0:3f7:16dd:1c3b with SMTP id 20-20020a05600c025400b003f716dd1c3bmr9611742wmj.10.1686574795971;
        Mon, 12 Jun 2023 05:59:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7t7eCEsEhz8aFffMmzZUfTSv7eBfjsqj66k61LJGWeNANSXO2kcMvJLq8CANmmXe5IWR0rCA==
X-Received: by 2002:a05:600c:254:b0:3f7:16dd:1c3b with SMTP id 20-20020a05600c025400b003f716dd1c3bmr9611730wmj.10.1686574795586;
        Mon, 12 Jun 2023 05:59:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e? (p200300cbc74e16004f6725b23e8c2a4e.dip0.t-ipconnect.de. [2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c22ca00b003f427687ba7sm11309701wmg.41.2023.06.12.05.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 05:59:55 -0700 (PDT)
Message-ID: <080538f2-defc-2000-c9f2-fb520448c93c@redhat.com>
Date:   Mon, 12 Jun 2023 14:59:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [axboe-block:for-6.5/block] [block] 1ccf164ec8:
 WARNING:at_mm/gup.c:#try_get_folio
To:     David Howells <dhowells@redhat.com>,
        kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
References: <202306120931.a9606b88-oliver.sang@intel.com>
 <108491.1686573741@warthog.procyon.org.uk>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <108491.1686573741@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12.06.23 14:42, David Howells wrote:
> The attached test reproduces the problem on a loop-back mounted file
> containing a UDF filesystem.  The key appears to be the consecutive DIOs to
> the same page.

The first DIO messes up the refcount (double-unpin?) such that the 
second one detects the refcount underflow when trying to pin the page again?

-- 
Cheers,

David / dhildenb


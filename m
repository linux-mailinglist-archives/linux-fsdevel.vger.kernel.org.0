Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2908A6F4A37
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 21:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjEBTSt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 15:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEBTSq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 15:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B2B198D
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 12:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683055079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WtdaH0LPeSw9dc2vy9g3O4k7nCC9DNn+smmkDs0/Hqw=;
        b=ONYEMX3mdnIlp95+DJUE0zH6Py1dzWWxjkfWreRh3u4o6PzSAewuc8rvYo0/A5FoxJ3aYY
        Mw0rh3Ubr609Nf0rcVZBULXTdXBIlXqpYcYzk+HDdQE48t9+3JQOuWSknxpu483JuSxBVV
        3iDFqmpc+lj7aF0K2CdQfWh5svpJNxI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-n5iLcKQTNgiJL19HJV2k2w-1; Tue, 02 May 2023 15:17:57 -0400
X-MC-Unique: n5iLcKQTNgiJL19HJV2k2w-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-2f8c2258b48so1222106f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 May 2023 12:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683055077; x=1685647077;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WtdaH0LPeSw9dc2vy9g3O4k7nCC9DNn+smmkDs0/Hqw=;
        b=FJIQhxFPrRGJS46wQsby5kxs8D8vptm4bcv4AAkO5bFDD031i5bJCIBGpqPg+bAc1J
         lvXJ9Bgbw9EHPaBaz1/BsavV+l1zYveqNIaSqQyq17uxfy5pcoilRkUqEWzmCtE0d8VC
         Y2eBOgZz6xZWFdwvipSVqpFCMvBei5h3VzMr50YiI+T6MDYDCSQnh738A70szYq1ycr0
         4QkFasWDd4e+u5NfdAM059svPML6RBOw+3gyvUOTbiVj5blu6gW7KHhJz+0XcN3wDIzW
         qoCzsMsJURyvn0ISfvVJP9sQZpHFPMTBv3XeHclcpnOuN1FZzaOBSn9BbW2MbRNMhK+V
         vTkw==
X-Gm-Message-State: AC+VfDwKkczIf4hVFXTjKkLQjbk48n+6H+l3ymN4bG/De69NDgNMfprA
        IJXHcyrenjDmqxc49vXyj9ZixYOUGWX/LdmH6WKm2glF52rWCIm9ifHin5H+50AvZ7z+NFY2Gb9
        YYQpD941Za3uRiYaBd+MyAqQ/sg==
X-Received: by 2002:a5d:638c:0:b0:2f6:35c3:7752 with SMTP id p12-20020a5d638c000000b002f635c37752mr12336052wru.57.1683055076736;
        Tue, 02 May 2023 12:17:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7q1hw0mtMOej2U52Id4Urx2ErDM6rX7/+WSKxI/ttqG032vRWoBcwZc9nSAYRAqTsdpxhqRA==
X-Received: by 2002:a5d:638c:0:b0:2f6:35c3:7752 with SMTP id p12-20020a5d638c000000b002f635c37752mr12336023wru.57.1683055076363;
        Tue, 02 May 2023 12:17:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:2400:6b79:2aa:9602:7016? (p200300cbc70024006b7902aa96027016.dip0.t-ipconnect.de. [2003:cb:c700:2400:6b79:2aa:9602:7016])
        by smtp.gmail.com with ESMTPSA id n17-20020a5d4c51000000b002d6f285c0a2sm31727959wrt.42.2023.05.02.12.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 12:17:55 -0700 (PDT)
Message-ID: <505b7df8-bb60-7564-af28-b99875eea12a@redhat.com>
Date:   Tue, 2 May 2023 21:17:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v7 3/3] mm/gup: disallow FOLL_LONGTERM GUP-fast writing to
 file-backed mappings
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Topel <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Mika Penttila <mpenttil@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>, Peter Xu <peterx@redhat.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
References: <cover.1683044162.git.lstoakes@gmail.com>
 <b3a4441cade9770e00d24f5ecb75c8f4481785a4.1683044162.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <b3a4441cade9770e00d24f5ecb75c8f4481785a4.1683044162.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +static bool folio_longterm_write_pin_allowed(struct folio *folio)
> +{
> +	struct address_space *mapping;
> +
> +	/*
> +	 * GUP-fast disables IRQs - this prevents IPIs from causing page tables
> +	 * to disappear from under us, as well as preventing RCU grace periods
> +	 * from making progress (i.e. implying rcu_read_lock()).
> +	 *
> +	 * This means we can rely on the folio remaining stable for all
> +	 * architectures, both those that set CONFIG_MMU_GATHER_RCU_TABLE_FREE
> +	 * and those that do not.
> +	 *
> +	 * We get the added benefit that given inodes, and thus address_space,
> +	 * objects are RCU freed, we can rely on the mapping remaining stable
> +	 * here with no risk of a truncation or similar race.
> +	 */
> +	lockdep_assert_irqs_disabled();
> +
> +	/*
> +	 * If no mapping can be found, this implies an anonymous or otherwise
> +	 * non-file backed folio so in this instance we permit the pin.
> +	 *
> +	 * shmem and hugetlb mappings do not require dirty-tracking so we
> +	 * explicitly whitelist these.
> +	 *
> +	 * Other non dirty-tracked folios will be picked up on the slow path.
> +	 */
> +	mapping = folio_mapping(folio);
> +	return !mapping || shmem_mapping(mapping) || folio_test_hugetlb(folio);
> +}

BTW, try_grab_folio() is also called from follow_hugetlb_page(), which 
is ordinary GUP and has interrupts enabled if I am not wrong.

-- 
Thanks,

David / dhildenb


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647827062CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 10:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjEQI2Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 04:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjEQI1w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 04:27:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14838524C
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 01:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684312022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BhjK5yazou5RvTWn30tpmSdINFxSKMIDQ661jcxLjOE=;
        b=Hdfs3ZyuzW17C5O28jpqFd56YDik0Ryg9x3VOJymCYphVmj3AduM7G5Os37yWIF7bkea9q
        0nwj2utkmc0Q3PyObVwlECLImOOW63eShhFmoNj3mGxB2bqqkafNS/ZvzOOAw+j9fPgoG5
        KMVzOQJSfUse2PNxPWvD2Cxow3OWDsA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-joiNmLNuPuyDHS_fvFNJRQ-1; Wed, 17 May 2023 04:27:00 -0400
X-MC-Unique: joiNmLNuPuyDHS_fvFNJRQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f4dd7f13d0so2053525e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 01:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684312019; x=1686904019;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhjK5yazou5RvTWn30tpmSdINFxSKMIDQ661jcxLjOE=;
        b=T/ZVZi99Se1QPNp6JEIggr3zMIycu6If7b3cPRq7B/mc/R95dm0LmtE0RMq9+FOfbQ
         zF3Oj8hXYHJMRTOZzMW/IZhSAUrx7/l4rUxwi83/+2343ap2GsQDo+QPl3Wn9OTMyEq5
         O+LTCkaFEp1BNbZkyQL/pI357jhjL72YGZlh4Itm3arqbRr6wZoDohE+3BFhDo/2mEhD
         8ctywSMxQKB42jrzhEsA6PxshJ5mEQyQ/ju8djp1SuT+oxEKyASpahGIexVBHrh3guZ+
         r4NHkuaWb/K7Xjgb0hqN/DFBp9YjXG2r37lKAsOBOkv4Q7kVGDuJwLUW88wnPNGTXl/4
         rRWg==
X-Gm-Message-State: AC+VfDyCNZXOz2NnV9dncdohnE9e91+CB6DbRzmwmzUzKhCMxe7nnt+T
        QOYTkB6/pe63f/wECAccX6WEQ/r0U12HKs87Fxd7BP/GoBeIT1DnH5nc35VICuQQr3sS5vnBPrl
        CGXde1tj/vWXsRp/cWIbuQHJrJA==
X-Received: by 2002:a05:600c:2141:b0:3f4:fd67:6d7c with SMTP id v1-20020a05600c214100b003f4fd676d7cmr9063707wml.40.1684312019278;
        Wed, 17 May 2023 01:26:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5xa065nZ/uQiaIJKC7O793u58obHvly4Gk+TYkCEFKD9upiESKtIAlN64oMtp1eokU88QqYA==
X-Received: by 2002:a05:600c:2141:b0:3f4:fd67:6d7c with SMTP id v1-20020a05600c214100b003f4fd676d7cmr9063676wml.40.1684312018895;
        Wed, 17 May 2023 01:26:58 -0700 (PDT)
Received: from [192.168.3.108] (p4ff23b51.dip0.t-ipconnect.de. [79.242.59.81])
        by smtp.gmail.com with ESMTPSA id a3-20020a05600c224300b003f17848673fsm1416580wmm.27.2023.05.17.01.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 01:26:58 -0700 (PDT)
Message-ID: <3c11455b-3af4-eeaa-9f43-49d4d70348fd@redhat.com>
Date:   Wed, 17 May 2023 10:26:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
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
References: <cover.1683235180.git.lstoakes@gmail.com>
 <0eb31f6f-a122-4a5b-a959-03ed4dee1f3c@lucifer.local>
 <ZGG/xkIUYK2QMPSv@infradead.org>
 <59c47ed5-a565-4220-823c-a278130092d5@lucifer.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v9 0/3] mm/gup: disallow GUP writing to file-backed
 mappings by default
In-Reply-To: <59c47ed5-a565-4220-823c-a278130092d5@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 15.05.23 13:31, Lorenzo Stoakes wrote:
> On Sun, May 14, 2023 at 10:14:46PM -0700, Christoph Hellwig wrote:
>> On Sun, May 14, 2023 at 08:20:04PM +0100, Lorenzo Stoakes wrote:
>>> As discussed at LSF/MM, on the flight over I wrote a little repro [0] which
>>> reliably triggers the ext4 warning by recreating the scenario described
>>> above, using a small userland program and kernel module.
>>>
>>> This code is not perfect (plane code :) but does seem to do the job
>>> adequately, also obviously this should only be run in a VM environment
>>> where data loss is acceptable (in my case a small qemu instance).
>>
>> It would be really awesome if you could wire it up with and submit it
>> to xfstests.
> 
> Sure am happy to take a look at that! Also happy if David finds it useful in any
> way for this unit tests.

I played with a simple selftest that would reuse the existing gup_test 
infrastructure (adding PIN_LONGTERM_TEST_WRITE), and try reproducing an 
actual data corruption.

So far, I was not able to reproduce any corruption easily without your 
patches, because d824ec2a1546 ("mm: do not reclaim private data from 
pinned page") seems to mitigate most of it.

So ... before my patches (adding PIN_LONGTERM_TEST_WRITE) I cannot test 
it from a selftest, with d824ec2a1546 ("mm: do not reclaim private data 
from pinned page") I cannot reproduce and with your patches long-term 
pinning just fails.

Long story short: I'll most probably not add such a test but instead 
keep testing that long-term pinning works/fails now as expected, based 
on the FS type.

> 
> The kernel module interface is a bit sketchy (it takes a user address which it
> blindly pins for you) so it's not something that should be run in any unsafe
> environment but as long as we are ok with that :)

I can submit the PIN_LONGTERM_TEST_WRITE extension, that would allow to 
test with a stock kernel that has the module compiled in. It won't allow 
!longterm, though (it would be kind-of hacky to have !longterm 
controlled by user space, even if it's a GUP test module).

Finding an actual reproducer using existing pinning functionality would 
be preferred. For example, using O_DIRECT (should be possible even 
before it starts using FOLL_PIN instead of FOLL_GET). That would be 
highly racy then, but most probably not impossible.

Such (racy) tests are not a good fit for selftests.

Maybe I'll have a try later to reproduce with O_DIRECT.

-- 
Thanks,

David / dhildenb


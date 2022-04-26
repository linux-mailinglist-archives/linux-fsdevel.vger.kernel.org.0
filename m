Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3616510A8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 22:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355019AbiDZUgw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 16:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354997AbiDZUg2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:36:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14A881AB8DA
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 13:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651005193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Av2XJWYSmxJiVQjp5kZR1hfhT+pdVskMA4VQgdFQOaM=;
        b=WK9VxpmjoLLrOX/Z94nx1NOwSqYuPD0Yy/ZDXQDXPjHYre1pneNPBH0Hauo0Y0QWpGvTMb
        +K4zJNZYPIhpKXbzbgtxr2VRbkT9VR/kKBbD8wAeyRO3uTBOSr+R6v9VOtV+ttKZXF/l0E
        10bXil0mPPSh/OJtaTuyPSU4bMqq85c=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-Rx5b3kYxM9qHbny6CJDfBQ-1; Tue, 26 Apr 2022 16:33:12 -0400
X-MC-Unique: Rx5b3kYxM9qHbny6CJDfBQ-1
Received: by mail-io1-f69.google.com with SMTP id l132-20020a6b3e8a000000b00657a80b60fdso31139ioa.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 13:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Av2XJWYSmxJiVQjp5kZR1hfhT+pdVskMA4VQgdFQOaM=;
        b=gp4sHEK2pRcfPJqgN+7mWmjx0TeFZj3py0XXMSgj0r+mMkKDARozXL+yD7dAedP2FL
         nSR9lxHJ4dgAj13RpSrU8Dk6X1+5rLp/FBHsjBIIm6ISRqQQ5TURwTaT0+uUSTFNRt3K
         qJnYxA+dwU7oQgsNNbb/WxtXUOhATscx5E+wP4h69lLHDKTzJnstiJ6hu34i/PCT733a
         M5lxK/FdEK12HIyy80M819eiGus4h9Op05lGh7lKi8n5kOU47KPt/LEcX7f1kOfpXTsn
         hiI7jdh3SvkFQhNQEKYAOC3worByif8B34Rlqu6yhLvY+1P9fTyYrVo7Js3NYRd4VVTx
         vQOQ==
X-Gm-Message-State: AOAM533+0FFvJPmIRdPucdqr+UcF/xDZorR04M+mflcSgAHDpLwKT2N3
        aWUhJ4/SXb0pwWGvmB0yyDYL7mvVaE8uznRWkjnuQ2lZSh9QlAfkzbwqnLKtAq2YMWoxx6Pp+Ls
        PBqUmCOFE9zZn8jlQpUk1X0Mj/Q==
X-Received: by 2002:a05:6638:272c:b0:32a:f95b:fc77 with SMTP id m44-20020a056638272c00b0032af95bfc77mr4011879jav.179.1651005191544;
        Tue, 26 Apr 2022 13:33:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxd4CFNten6nl0jATzOU1yCBTY6Y58j8Espgob7sbvIFYcRfIXeg+IqFoDNsZPO7cKZaJ3nww==
X-Received: by 2002:a05:6638:272c:b0:32a:f95b:fc77 with SMTP id m44-20020a056638272c00b0032af95bfc77mr4011865jav.179.1651005191365;
        Tue, 26 Apr 2022 13:33:11 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id e18-20020a92d752000000b002cd6dae980fsm8497051ilq.13.2022.04.26.13.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:33:11 -0700 (PDT)
Date:   Tue, 26 Apr 2022 16:33:08 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/6] selftests: vm: add hugetlb_shared userfaultfd
 test to run_vmtests.sh
Message-ID: <YmhXBHFrXKT/Jqkd@xz-m1.local>
References: <20220422212945.2227722-1-axelrasmussen@google.com>
 <20220422212945.2227722-2-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220422212945.2227722-2-axelrasmussen@google.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 22, 2022 at 02:29:40PM -0700, Axel Rasmussen wrote:
> This not being included was just a simple oversight. There are certain
> features (like minor fault support) which are only enabled on shared
> mappings, so without including hugetlb_shared we actually lose a
> significant amount of test coverage.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


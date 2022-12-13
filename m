Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEAC64BBD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 19:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbiLMSWO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 13:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbiLMSWC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 13:22:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAC718B
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 10:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670955679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QjyiHNIdmhKwg9rHfoK9KFaos5MRsLUNqAqOWwzEA8I=;
        b=AkbHGZAYwlRwp61laO7Q37xF+ihwJ0mzNnPmJJcyojItF9TA9JUc0n2g53vlpVObQHdacD
        jggRjWEvDwctaZug5NYzYWi1NA1FD6zZlpiWlIqoXsOTD/vo2VPkZ/5Iyi0R7/aJQwAQES
        mIFDSWh8WnJeTJs6+XPCuApHIf+R5cA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-341-rcZJpAg2MeuX1W0MIO3qRA-1; Tue, 13 Dec 2022 13:21:17 -0500
X-MC-Unique: rcZJpAg2MeuX1W0MIO3qRA-1
Received: by mail-wm1-f71.google.com with SMTP id r129-20020a1c4487000000b003d153a83d27so5205060wma.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 10:21:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QjyiHNIdmhKwg9rHfoK9KFaos5MRsLUNqAqOWwzEA8I=;
        b=cQBVgPBCj3FMZionfg9Q/Rvu84DEI41wCJlWrrF5NxjhTSpZL6FxgwMLAic9C2Fp6o
         aFMleX8WifYPT7MoEGwE87BOt21V17hhhhacilthwZ+UWXAwRvJyoU/W2c5yFXewIA8/
         s6YV+udBFxHVAOdYKo3DrVsVRMQpHyvAQBZbQ+DJ2o0PpRqKG94aQky1ZFl1RUwEfPeq
         y714UBIrnK89NqbF0WTHHdBwGX/SjmHEuyeL6UffZyHGY925I9ORswywk9EmelPim2r4
         0Vqz/jwea6cnekXN4aJxJ1J0XCt5YsSW1/Dl1k6lyppABNpY1M0e/jgSzDMSgqH+X7nt
         6Xbw==
X-Gm-Message-State: ANoB5pmBaGXvGXJtHC9LZKF4lejMUk4aREK4d03pdD0EC/ziCMPPCE0A
        HKiyj2NrtI/yyKDjuJz+2g0Sa6rRLbqvdULv+UQGOiEPPy3Zl57x28hpbvtJ+kn8CGAurlhY6f0
        fNfGGwZGjLKxqFHr17xmTA/XShw==
X-Received: by 2002:a05:600c:4f89:b0:3cf:d0be:1231 with SMTP id n9-20020a05600c4f8900b003cfd0be1231mr20583539wmq.13.1670955676488;
        Tue, 13 Dec 2022 10:21:16 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5ZnpHaUGXySaaFWtU/+Thtjn+t37/nCIv7KkFOCsVSMV5B2vIdj/GJOi7WMuTR1tq67ihHmA==
X-Received: by 2002:a05:600c:4f89:b0:3cf:d0be:1231 with SMTP id n9-20020a05600c4f8900b003cfd0be1231mr20583526wmq.13.1670955676300;
        Tue, 13 Dec 2022 10:21:16 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-97-87.dyn.eolo.it. [146.241.97.87])
        by smtp.gmail.com with ESMTPSA id ay13-20020a05600c1e0d00b003c6bd91caa5sm14173911wmb.17.2022.12.13.10.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 10:21:15 -0800 (PST)
Message-ID: <229be448e2979258a7c2c84d808360618f5095a9.camel@redhat.com>
Subject: Re: [PATCH v3] epoll: use refcount to reduce ep_mutex contention
From:   Paolo Abeni <pabeni@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jason Baron <jbaron@akamai.com>, netdev@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>
Date:   Tue, 13 Dec 2022 19:21:14 +0100
In-Reply-To: <Y5gVJz+qDfw0tEP1@sol.localdomain>
References: <1aedd7e87097bc4352ba658ac948c585a655785a.1669657846.git.pabeni@redhat.com>
         <Y5gVJz+qDfw0tEP1@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Mon, 2022-12-12 at 22:01 -0800, Eric Biggers wrote:
> I am trying to understand whether this patch is correct.
> 
> One thing that would help would be to use more standard naming:
> 
> 	ep_put => ep_refcount_dec_and_test (or ep_put_and_test)
> 	ep_dispose => ep_free
> 	ep_free => ep_clear_and_put

Thank you for the feedback. 

I must admit I'm not good at all at selecting good names, so I
definitelly will apply the above. I additionally still have to cover
the feedback from Jacob - switching the reference count to a kref - as
I've been diverted to other tasks.

I hope to be able to share a new revision of this patch next week.

Thanks,

Paolo


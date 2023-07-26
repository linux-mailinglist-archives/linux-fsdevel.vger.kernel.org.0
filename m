Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D370763073
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 10:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbjGZItz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 04:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbjGZIt0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:49:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9271759D2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 01:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690360912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d/oTrLa3wfV0i253XfKhTyT1CTpeukEXI1z5KYmU9f8=;
        b=B1DA7dpdEoOIoctpb1fAQhCeZL6P+ShUh7mbvZRWJHxQPmEq9u4S+z1XgXZXqN/PQdchkJ
        9GNOp5cRA0rzA/L8voWg8sMvZaxBMoXt1MCEjenxkp9YefQE0kRGDoCZO7+mQuy5/CkUIb
        ZMWk/omkmsmEfRHvlNmnmJC1wiAT/yo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-dBAKzojIPFCmGPV9s8Djaw-1; Wed, 26 Jul 2023 04:41:48 -0400
X-MC-Unique: dBAKzojIPFCmGPV9s8Djaw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C29781010427;
        Wed, 26 Jul 2023 08:41:47 +0000 (UTC)
Received: from localhost (ovpn-12-99.pek2.redhat.com [10.72.12.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D339B4094DC0;
        Wed, 26 Jul 2023 08:41:46 +0000 (UTC)
Date:   Wed, 26 Jul 2023 16:41:43 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>, akpm@linux-foundation.org,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] proc/vmcore: fix signedness bug in read_from_oldmem()
Message-ID: <ZMDcR6wKn3Dz6NJy@MiWiFi-R3L-srv>
References: <b55f7eed-1c65-4adc-95d1-6c7c65a54a6e@moroto.mountain>
 <ZMC1jU7ywPGt1QmO@MiWiFi-R3L-srv>
 <c770613e-1f11-4bff-bc5f-9bc6f07a4da5@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c770613e-1f11-4bff-bc5f-9bc6f07a4da5@kadam.mountain>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/26/23 at 09:03am, Dan Carpenter wrote:
> On Wed, Jul 26, 2023 at 01:56:29PM +0800, Baoquan He wrote:
> > 
> > Thanks for this fix. Just curious, this is found out by code exploring,
> > or any breaking?
> 
> It's from static analysis, looking at when error codes are type promoted
> to unsigned.  I pushed the Smatch check for this yesterday.

I see, thanks for telling.

> 
> https://github.com/error27/smatch/commit/a2e6ca07e2ef83a72c9ffa3508af1398a6ecc7ed
> 
> regards,
> dan carpenter
> 


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630E44C82D7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 06:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiCAFIj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 00:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiCAFIi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 00:08:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D6CD3BA40
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 21:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646111274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vlgiMOTcMFuWjlU/kYz9NUh93Lw07HNBV3j58qzJq4U=;
        b=ZqYHz16VpA4Wb+RAZsBMu/ZsGkvVYAI3EdvzsZGo9hPuBhdFwO/E+2sOzRf2cw083rV5Kw
        ipP4OmI5pqREI4W2QQ5KKG8DZHkKm8+EUUoQTKSBQykbcWOpBRUVz4+BTqaUdCVblaIwIf
        x2d7PHskO4hxdz/zGWuHTmFJCI1h38s=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-E1F3fzHLN4CXf3nybJHqng-1; Tue, 01 Mar 2022 00:07:52 -0500
X-MC-Unique: E1F3fzHLN4CXf3nybJHqng-1
Received: by mail-pg1-f199.google.com with SMTP id bj8-20020a056a02018800b0035ec8c16f0bso7880851pgb.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 21:07:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vlgiMOTcMFuWjlU/kYz9NUh93Lw07HNBV3j58qzJq4U=;
        b=ZM/+9z3H18OO8zgCNJ84FY6JXJJUmtL8GOg4EqhVr2uwznjeRvE600tzzPQ4Cq5vQo
         8CdBHaxFVpSJ6XwqGfM8Care/tEPH0KPJ+SBCM61KpJz32cQ5sMi6RX9E26F53WU1X9L
         FoTY74z2bK0uYegs0+ib1wRD9NNerZ0TLBVGZXRP1SCIbWLj8CmOPH+MG2cE/UKT7mJZ
         3T5X4ZxU5rpX/5Z9xBoZiSYrQs55bYdudtmtMwoG81/wMXh8uypkpfTZjJ1eFwVbgu0I
         SVEFt8bzByBFwCLeEXRMwzS2Iy5sZtI3F9HqC6zv52nyE06fZa52gBCUCqwlZWzEdguZ
         8hBg==
X-Gm-Message-State: AOAM533f9/qrH3bsWOMSNKJjW5iUgN2CyiRQ2CGgLxFsK9TFlmzCunmk
        PIQKwa968OE8C+diiCcFMDKT79BgRvnz6r2W/NjjRf240p68ZqsI//F++sD09D0SkUZnGS0yZOK
        eUyYQv1WtgXOLgxO8Tudu2plIoA==
X-Received: by 2002:a17:90a:fa95:b0:1bc:509f:c668 with SMTP id cu21-20020a17090afa9500b001bc509fc668mr20178128pjb.189.1646111271502;
        Mon, 28 Feb 2022 21:07:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwpWy4HUgxZrmcVNuxA49DZr6RGtDz1nFMnVlTkwtXe5piwCyDrG+ElImiz3DW22yqWJyL/vA==
X-Received: by 2002:a17:90a:fa95:b0:1bc:509f:c668 with SMTP id cu21-20020a17090afa9500b001bc509fc668mr20178109pjb.189.1646111271251;
        Mon, 28 Feb 2022 21:07:51 -0800 (PST)
Received: from xz-m1.local ([94.177.118.144])
        by smtp.gmail.com with ESMTPSA id a16-20020a056a000c9000b004f0f8babedfsm15379890pfv.29.2022.02.28.21.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 21:07:50 -0800 (PST)
Date:   Tue, 1 Mar 2022 13:07:42 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Yun Zhou <yun.zhou@windriver.com>
Cc:     akpm@linux-foundation.org, corbet@lwn.net,
        tiberiu.georgescu@nutanix.com, florian.schmidt@nutanix.com,
        ivan.teterevkov@nutanix.com, sj@kernel.org, shy828301@gmail.com,
        david@redhat.com, axelrasmussen@google.com, linmiaohe@huawei.com,
        aarcange@redhat.com, ccross@google.com, apopple@nvidia.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [v2][PATCH] proc: fix documentation and description of pagemap
Message-ID: <Yh2qHgA+689dq+5i@xz-m1.local>
References: <20220301044538.3042713-1-yun.zhou@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220301044538.3042713-1-yun.zhou@windriver.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 01, 2022 at 12:45:38PM +0800, Yun Zhou wrote:
> Since bit 57 was exported for uffd-wp write-protected(commit fb8e37f35a2f),
> fixing it can reduce some unnecessary confusion.
> 
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu


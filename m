Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A1557A8EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 23:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239312AbiGSVXx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 17:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238395AbiGSVXt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:23:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E944061713
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jul 2022 14:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658265828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V5XmcYFINzq7Zfp1ZH6JYE8dP3xg797dDa/g7sWMt+4=;
        b=cwsYvJlBcbdf7cBDRDtV3M8G5jVQ2YhYIyA3tfZmktiZlZRuJzfuY5qs+D8hQpgIsgJrRj
        4UgQyqSbJw5NQ9VPoTTOybvUWlY/QUD3xhJcRV0pEVTiNFzbcNnuIEVtDnWMCiOsO3mlrC
        koM5LmYnYXt/EqiXl/qzpSK3P2KqvVU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-G372HEJGOYyb32lUgQRprg-1; Tue, 19 Jul 2022 17:23:45 -0400
X-MC-Unique: G372HEJGOYyb32lUgQRprg-1
Received: by mail-qt1-f197.google.com with SMTP id v6-20020ac87486000000b0031ee0ae1400so7725619qtq.14
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jul 2022 14:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V5XmcYFINzq7Zfp1ZH6JYE8dP3xg797dDa/g7sWMt+4=;
        b=TQcCWbEg5r/0ty2n0mizFjGYvtBF1babCvGAQEZ94UnXyH8p2wtdlx0k1wms7bFm+E
         0g/1vvuLF6wtFPQHzqXSU5HAod5+tm5EpD65snewZCwDWv48LhvEVL4nCf2v1N8kJNvM
         Y8WqaQYdU9l8yAz+OUYpi2YztXfZwST8mjVM/+gzu/c6CLadQZQ0B867qZMdTLogNB33
         CDu3Qk4abOaOo2pwOkXk3JQq7clRR28l1zJ4d4EVZbSUMUwuoqhIq6VI1ZBrK4nrO5/l
         JX3HB1M+85HSFlqON40srWSsfMfS43WjEGG1ue9uG6qDwx9MPUlfG/haGkGs5MQ6eqeu
         SApw==
X-Gm-Message-State: AJIora+qu4+uPm0msb3903MLep6WoJvHdUKr5gsybv1DYNPfsePdOXf9
        hSb7KAgvgt2MjGib22nxPdKQJLHA1xd6pGcKe3ul6pMFNJ0Ui+5wkMj/KH5rUnzEM4fp8aIiVqi
        AE60y2cBpbbu5SorbbzPhhj63Lw==
X-Received: by 2002:a05:6214:761:b0:472:f5f3:5139 with SMTP id f1-20020a056214076100b00472f5f35139mr26406585qvz.48.1658265824304;
        Tue, 19 Jul 2022 14:23:44 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uD5oB/LS6Ijqi8ckx7ZKbBD1V1rO23/Qvo6+97DahMzdhsOQVRGFH0eTyNrHtcanbtwn2H7A==
X-Received: by 2002:a05:6214:761:b0:472:f5f3:5139 with SMTP id f1-20020a056214076100b00472f5f35139mr26406569qvz.48.1658265824116;
        Tue, 19 Jul 2022 14:23:44 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-37-74-12-30-48.dsl.bell.ca. [74.12.30.48])
        by smtp.gmail.com with ESMTPSA id s5-20020a05620a0bc500b006b555509398sm15545231qki.136.2022.07.19.14.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 14:23:43 -0700 (PDT)
Date:   Tue, 19 Jul 2022 17:23:41 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v4 4/5] userfaultfd: update documentation to describe
 /dev/userfaultfd
Message-ID: <Ytcg3Q5lcJcajpPI@xz-m1.local>
References: <20220719195628.3415852-1-axelrasmussen@google.com>
 <20220719195628.3415852-5-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220719195628.3415852-5-axelrasmussen@google.com>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 19, 2022 at 12:56:27PM -0700, Axel Rasmussen wrote:
> Explain the different ways to create a new userfaultfd, and how access
> control works for each way.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


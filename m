Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED3574B193
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 15:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjGGNQh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 09:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjGGNQf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:16:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A17D1FEC
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 06:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688735750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/scmW41nRLEVCcvmVFRaHD3MznC8NV7fH9vmMT3xxpU=;
        b=XKz+z5z+XaIBEKxFucvEi7DBUwmuvpqt4f3Bd/5X/j5dqZc23qSfkFJX9hDeC6wk67KOlQ
        EaELiesjnetegZnBmi7O7GOGJpMVkggoK46SBEWk9oXXpCOD5RtFOWal5DNRh1mn7v7PIi
        N5oJxzHfj4YA2JHNYOPvr5RoIkxrhCY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-ktqH_rL_OuqeXser8TxqNA-1; Fri, 07 Jul 2023 09:15:49 -0400
X-MC-Unique: ktqH_rL_OuqeXser8TxqNA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-765ad67e600so39015985a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jul 2023 06:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688735749; x=1689340549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/scmW41nRLEVCcvmVFRaHD3MznC8NV7fH9vmMT3xxpU=;
        b=M95U1H5whW/e3+OMk/d1ON6kBUn6X0lXDsKpeo/vXbqJ51L+oj1RjV/MdaEH5U8OyF
         De9xzWP9tPIcqC/XoQj4R3FB0vNJoE+y2Nh73u7WR2M4La8UI/pOp18hRCDZxtwFM7my
         lrSY7hV1Q5Cx5r9Ea8VRx/JncHR4S/IQJ2fW/dfw0F1JlJvqnPySFU65lycHAwrVt24a
         TxbMjzlaqz5MjfLO2dCDy7JDGME/Mt8yBqtAOBL5hix4yFRKJAYsLQqRN4udBN/ZJLBL
         1zXsZwtnnk1DUb1cmg+HF0kJJCs2p6HrVrNlbnxHl8jat6lXS5Ip+aMsSvQMA/WmeOO0
         lA+g==
X-Gm-Message-State: ABy/qLZneoj2/QKh+8fGYQQe1BrfSW1VVW25DjtqHQ5sPb13qyWGMk7H
        1zMD+vGkqZlpAzd+DatG2NgM3tUVhsr8mTRXNEDwzUeG3LmfbiocGs8c4yjhd+u1t96ODUwBt2E
        4kXBRe/F36ETDRCSEa3SsDUB5FQ==
X-Received: by 2002:a05:620a:1908:b0:765:a957:f526 with SMTP id bj8-20020a05620a190800b00765a957f526mr5626668qkb.3.1688735748814;
        Fri, 07 Jul 2023 06:15:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHGcT7o9U4nGwCRjHqy1oj78ajsK+fO3PKeth2RE5DnD0ZtdR5yHIs+kzadtUDYBH9DWM2VOg==
X-Received: by 2002:a05:620a:1908:b0:765:a957:f526 with SMTP id bj8-20020a05620a190800b00765a957f526mr5626622qkb.3.1688735748545;
        Fri, 07 Jul 2023 06:15:48 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id c11-20020ae9e20b000000b0075cebaa1540sm1797911qkc.58.2023.07.07.06.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 06:15:48 -0700 (PDT)
Date:   Fri, 7 Jul 2023 09:15:44 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Geffon <bgeffon@google.com>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Yu Zhao <yuzhao@google.com>,
        ZhangPeng <zhangpeng362@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/8] mm: userfaultfd: extract file size check out into
 a helper
Message-ID: <ZKgQAKIst4DH3lgw@x1n>
References: <20230706225037.1164380-1-axelrasmussen@google.com>
 <20230706225037.1164380-4-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230706225037.1164380-4-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 06, 2023 at 03:50:31PM -0700, Axel Rasmussen wrote:
> This code is already duplicated twice, and UFFDIO_POISON will do the
> same check a third time. So, it's worth extracting into a helper to save
> repetitive lines of code.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


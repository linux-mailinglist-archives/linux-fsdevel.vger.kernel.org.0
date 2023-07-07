Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF6E74B1ED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 15:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjGGNkN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 09:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjGGNkH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:40:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C970210A
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 06:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688737154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VkzChLY9HdEu6d357XN/H6AgzScXOhRLRhZBoNRXs5Q=;
        b=iK4qhFAThVY/Lj7ifZevuRswFV+XqzT/Hv9P1X67/e8DKgogHuQQ195bko7pxjj240Btzt
        3tsZbg8x9sAi38aFFO83B2VOeLyDWzyzp7fCig1VDN/qA/VHHhakFC4hQ23byjZOrenOLl
        8sUm4PeOj4ac4lygtA9YRs7aI5dZcnw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-yhlhBVGyP3-EyF_wfKC1rQ-1; Fri, 07 Jul 2023 09:39:13 -0400
X-MC-Unique: yhlhBVGyP3-EyF_wfKC1rQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-76721ad9ed7so38000285a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jul 2023 06:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688737153; x=1691329153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkzChLY9HdEu6d357XN/H6AgzScXOhRLRhZBoNRXs5Q=;
        b=Od/9ETrMi2F8gXgRVN+GSEd7wW459N90W0hgPwTbS0gnq7JevxrvnbBSiGlItC/hk3
         qTnOwxg3aAQWXsiIXr10FK7vx1GtWlnvivpHFLcUiTndGKPuItDFdLX6Lij4pN7RDV7j
         RiiiyyTBNYmm0WClM7rm3uVvvFtxuFwhlx/CTBwSiSFzDtERY15HCcjR3BiJi7dESxHp
         D1NyxLPz/zIEaujOFftQBFOJa9ke15XXYwdnRFeBkp5gdrA/71AwZfmyBfnfGDu4kG1W
         wlC23CnXSHoYLjq26abr5UHxnXDqjk7NAumxYqzhXluqhJHeWF7r0eVgaagw7E6islKW
         x23A==
X-Gm-Message-State: ABy/qLYGe3LQFRK/b+Panl+RJFFGwbbaCvTlQZSuvxYemNGiUbLWZ42J
        10ZNLlunggw79nBEU1xdh1WTPN9KxyAJX/LloqKnWXCBZxniZ/i2i6ThwfBznXrmVttyVwDZlTn
        8xeYAgZsFGq/BpeGdbshzW3lDQw==
X-Received: by 2002:a05:620a:46ac:b0:75b:23a1:69ee with SMTP id bq44-20020a05620a46ac00b0075b23a169eemr5751065qkb.5.1688737152801;
        Fri, 07 Jul 2023 06:39:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHisqRU4zty/LgSeJhrGlLL7Qi/Onw5W451/3DenbEb2/djgvkWY3dMDPa+N5YkDQdPGuIvlA==
X-Received: by 2002:a05:620a:46ac:b0:75b:23a1:69ee with SMTP id bq44-20020a05620a46ac00b0075b23a169eemr5751018qkb.5.1688737152545;
        Fri, 07 Jul 2023 06:39:12 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id g25-20020ae9e119000000b0075b168fcde9sm1808290qkm.77.2023.07.07.06.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 06:39:12 -0700 (PDT)
Date:   Fri, 7 Jul 2023 09:39:07 -0400
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
Subject: Re: [PATCH v3 5/8] mm: userfaultfd: support UFFDIO_POISON for
 hugetlbfs
Message-ID: <ZKgVe/tYlQ2w67RO@x1n>
References: <20230706225037.1164380-1-axelrasmussen@google.com>
 <20230706225037.1164380-6-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230706225037.1164380-6-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 06, 2023 at 03:50:33PM -0700, Axel Rasmussen wrote:
> The behavior here is the same as it is for anon/shmem. This is done
> separately because hugetlb pte marker handling is a bit different.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


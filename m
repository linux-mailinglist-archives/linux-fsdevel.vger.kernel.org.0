Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5E374B190
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 15:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjGGNPI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 09:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGGNPG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:15:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5BD1FE9
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 06:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688735659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6vnw9WeYBMqYt9YWOLp+S5fHsLpKwmQh+j83UzoShuI=;
        b=XB+2hyqX+RgG0KF7POd4w1+nySTTVymLEO7kr/t+09EBuSHf879ReoDc2tfWn05IUFNWel
        SBUFvLLHIArfJ2Wchv27PrkaTi2BJRF1KkCci8B+UMHzGbqAmCtwctmD53Ki4wydDebGD1
        /JrCpFenTvMECtJdVT0BVad/gj+DB8Y=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-le-zBlenNrmXmi_Ej7JypQ-1; Fri, 07 Jul 2023 09:14:18 -0400
X-MC-Unique: le-zBlenNrmXmi_Ej7JypQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7672918d8a4so48441585a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jul 2023 06:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688735657; x=1691327657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vnw9WeYBMqYt9YWOLp+S5fHsLpKwmQh+j83UzoShuI=;
        b=SyBu3tceYqEsdEshmL2L0fWpkOUTvBa/C4qakM9tY8qkEH5uP+MUKJn8CABOSn6Qkn
         RXUmWUqM3Mc22rwze5+N+C7s/bVDIrymajcBe5GL0+Q/ZSwenK9t/TsD+EEiiYWiGFIJ
         h0uYO6k75FGZnw1/CKBfL2CWFQnueVAIxTueisWEP65VEXtZjO/czyNbYJJAhNuoSR0W
         w8o+o4zYmChBXbSjCqPs6hcMaBQ0KKB2djXXuhiTqLqFdc+DC9QxETPgPk4yErZkHGhf
         T7zpYQub5k5S0rlwk8o69vICEz4bgF4iyxXWEhlnofkKV2Gt8QEdSefqNejf3DGvhJj6
         SQdQ==
X-Gm-Message-State: ABy/qLaOdXbAFe4JP49stX55zo8w+cG6T/tB4uh5zbVllc3KHGy8kNIk
        KQm4c/8yIbRWiL3Kxdcf0i+pYFoMtUjYsdQIjTC0o35L+9Lsj9jjB6AxX6AEWt4eNapXVY0JKUL
        gFA5IjqIPktWO9oZSArFl9r3mDg==
X-Received: by 2002:a05:620a:444c:b0:767:1573:d36e with SMTP id w12-20020a05620a444c00b007671573d36emr5602289qkp.3.1688735657710;
        Fri, 07 Jul 2023 06:14:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFM9ujXAoIaW0G5RqfQhUiyk9Pp98RfcrEYp1lty1Ca8TCUHVClMKEuALmkLm8iW1IpWPaeUA==
X-Received: by 2002:a05:620a:444c:b0:767:1573:d36e with SMTP id w12-20020a05620a444c00b007671573d36emr5602241qkp.3.1688735657399;
        Fri, 07 Jul 2023 06:14:17 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id a22-20020a05620a16d600b007671678e31fsm1800467qkn.86.2023.07.07.06.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 06:14:17 -0700 (PDT)
Date:   Fri, 7 Jul 2023 09:14:14 -0400
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
Subject: Re: [PATCH v3 2/8] mm: userfaultfd: check for start + len overflow
 in validate_range
Message-ID: <ZKgPpkx0l7mZ6s5E@x1n>
References: <20230706225037.1164380-1-axelrasmussen@google.com>
 <20230706225037.1164380-3-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230706225037.1164380-3-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 06, 2023 at 03:50:30PM -0700, Axel Rasmussen wrote:
> Most userfaultfd ioctls take a `start + len` range as an argument.
> We have the validate_range helper to check that such ranges are valid.
> However, some (but not all!) ioctls *also* check that `start + len`
> doesn't wrap around (overflow).
> 
> Just check for this in validate_range. This saves some repetitive code,
> and adds the check to some ioctls which weren't bothering to check for
> it before.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


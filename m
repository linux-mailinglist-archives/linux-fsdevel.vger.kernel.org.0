Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C2974BE08
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jul 2023 17:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjGHPDZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jul 2023 11:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjGHPDX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jul 2023 11:03:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBEF10CE
        for <linux-fsdevel@vger.kernel.org>; Sat,  8 Jul 2023 08:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688828557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T3GRnokqrPVaYV/THcdBGlJffY7BDH+AcPJHejmPSVM=;
        b=bUPOe8ftgS9nqFxx2l8gM7jwZ65gPpqg/kYq/npOY6e3L8n7uZpfCL17yfqIWUrg7ySeJw
        R8kNfgTwhWW96uyC14G/81eHqoZ5HOsp5sp1hvTaDVvyH9SSzOlUtpgbWTjgP02DE+OP49
        LZC2b6BPz98CVMjucr2wmv4UWfqB7f0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-00jNi3UrPeCbG_OC1nG_mA-1; Sat, 08 Jul 2023 11:02:36 -0400
X-MC-Unique: 00jNi3UrPeCbG_OC1nG_mA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-402fa256023so6088851cf.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Jul 2023 08:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688828556; x=1691420556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3GRnokqrPVaYV/THcdBGlJffY7BDH+AcPJHejmPSVM=;
        b=bAtsM7qDNo2SMeUlsM/vI0svBA+EaU9XLNIynqSmFImBDOqBUWSqxTXtjk8Udp5msc
         Zp+0WWmN7GdZFYs7EIp4ww2BbBqd3pzl97ljaB7fd6/rNsPTwd6irmMJL2kQ/UoDUVDD
         CkmyETNNYfNfskaypINO6YWY2A1PUAqD9D/hlSKbNS6EU2Ae0UtzFoqWty/G6bqmWg5/
         0ZSP5NjP6odteviTUV15gLNG/wQYRFGPCc4N64khmpO6fb0sS0V5jZZfM5lQSF2NNJDW
         gOwFvz7k3eNdYB9QWM1nIIOKqOzd1Cy01KxWtxi2aSZC/cfBOY8BcsSD/sCkPAGf3eQe
         Y3hA==
X-Gm-Message-State: ABy/qLbGKdXcBzBJnNEdl9HvK6QYa2XOZ/OEuG+DhwK3fmNMQtTict2m
        3yuM4U2q2V0L95m/npAyBPIrdeFL1pgc6CXjZ4Cn+fzGHWKyBfg7iY1UvjZSUxPZhU9g12zVlqH
        0K02xsKdadQ0AFu9Yx0xs3Kvd6w==
X-Received: by 2002:a05:6214:b65:b0:634:cdae:9941 with SMTP id ey5-20020a0562140b6500b00634cdae9941mr8767606qvb.0.1688828556024;
        Sat, 08 Jul 2023 08:02:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGj53IzcQAPmiI/v43Lyk7eh+euAZZXrSV8HTK/l4O/V2y1GtOUmoqfRyODcRL3zSDwxMPZhQ==
X-Received: by 2002:a05:6214:b65:b0:634:cdae:9941 with SMTP id ey5-20020a0562140b6500b00634cdae9941mr8767568qvb.0.1688828555801;
        Sat, 08 Jul 2023 08:02:35 -0700 (PDT)
Received: from xz-m1.local (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id i4-20020a0cf484000000b0063013c621fasm3417890qvm.68.2023.07.08.08.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 08:02:35 -0700 (PDT)
Date:   Sat, 8 Jul 2023 11:02:33 -0400
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
Subject: Re: [PATCH v4 7/8] selftests/mm: refactor uffd_poll_thread to allow
 custom fault handlers
Message-ID: <ZKl6ie4s/94TPCgm@xz-m1.local>
References: <20230707215540.2324998-1-axelrasmussen@google.com>
 <20230707215540.2324998-8-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230707215540.2324998-8-axelrasmussen@google.com>
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

On Fri, Jul 07, 2023 at 02:55:39PM -0700, Axel Rasmussen wrote:
> Previously, we had "one fault handler to rule them all", which used
> several branches to deal with all of the scenarios required by all of
> the various tests.
> 
> In upcoming patches, I plan to add a new test, which has its own
> slightly different fault handling logic. Instead of continuing to add
> cruft to the existing fault handler, let's allow tests to define custom
> ones, separate from other tests.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

PS: please remember to update manpage after it lands.  I still have a plan
to update but not yet happening; if you happen to update before mine please
feel free to update for whatever is missing.

Thanks!

-- 
Peter Xu


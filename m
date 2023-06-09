Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093BC728E5F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 05:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjFIDOy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 23:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFIDOx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 23:14:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FD630F2
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 20:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686280448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xIgL9i3w0AdAhUryhJlWnRJCq0oGm95s0fdioQLwB1I=;
        b=W1vpGzcKwhhgLnY5BpMMoOmVvojpU8kr83rwXGm9WJnzfV1LgxJiKW4hRKPsTbWB/RprcQ
        0T/kWoq2+WjKVPgrPdZdsdGdYGR403JFve8s3SQBxL0uuTh9bZZmj68QMbLBGAZ9E2izRU
        yZXKzDISeKXw2DaZZ/TRUIQv09Ujjzg=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-KVGdqCRqM-a_EUPKjl0yug-1; Thu, 08 Jun 2023 23:14:07 -0400
X-MC-Unique: KVGdqCRqM-a_EUPKjl0yug-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-463982ca6f2so31559e0c.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jun 2023 20:14:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686280446; x=1688872446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIgL9i3w0AdAhUryhJlWnRJCq0oGm95s0fdioQLwB1I=;
        b=PcxWE8mC1baV692nPGNxp8dsoLNIuLbQO7IvrJmbCYJ46wx90lzrGitNfmOSNuUbM9
         H1DQUMvQOKsOc5W5FiFy52XSXRvgBuiZzKfOj//2aSHyd4vUzy6EiScQXSUSaOOYufi/
         KDTgv94BIgGZ/YD+vozYytIeBNHFZsASIyQzP+7yce+NMQ/nQdZw7j6fhx7/eEeEhNxd
         XEBHPzFnSGC92FQlxMyDrEXPOSvmfDbV7ii5phqhtymZPw2OlNZwlqvWSU0PsgdIt2r7
         RtSE52d9DzMz0xzNSt+fpWQA90SXHLpWtLHzm/sdK6LTYJaKyuM6wk2ITsYK47nlGFyI
         UpMQ==
X-Gm-Message-State: AC+VfDzp6xm1pBw9BoeWbhmAwj6CowoA2E00WBkbfMYEcI0QYBGAz+FZ
        BDEXlxZIkrYttd/8Zucew3nZyhviv8ObwRTjaqnQZS1n4NofhX95z5Pweqc+66FFbfTCooF5Ubj
        2zvVx9myHwuWZsyKE/ur27JaWYXYetOvuATlCeOxsqWDZGQQOqwJWK2RJxA==
X-Received: by 2002:ac5:c858:0:b0:457:3a45:38d2 with SMTP id g24-20020ac5c858000000b004573a4538d2mr203788vkm.1.1686280446396;
        Thu, 08 Jun 2023 20:14:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5++K06QbioYKyQ9Uyh0Xp/3wGCUXlqXahKVRmOXmWm5nsxWpaViogeMufGtgI6Ae4jvfzUyKzwBfawuTdRgb0=
X-Received: by 2002:ac5:c858:0:b0:457:3a45:38d2 with SMTP id
 g24-20020ac5c858000000b004573a4538d2mr203780vkm.1.1686280446144; Thu, 08 Jun
 2023 20:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230609005158.2421285-1-surenb@google.com> <20230609005158.2421285-2-surenb@google.com>
 <877csdpfcq.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <877csdpfcq.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Fri, 9 Jun 2023 11:13:55 +0800
Message-ID: <CAFj5m9K-Kyu-NV1q3eGeA8MOcC1XYgYyENnti-Qd8Mj-A6=Q5Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] swap: remove remnants of polling from read_swap_cache_async
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        willy@infradead.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        peterx@redhat.com, david@redhat.com, yuzhao@google.com,
        dhowells@redhat.com, hughd@google.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 9, 2023 at 9:58=E2=80=AFAM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> + Ming Lei for confirmation.

Good catch, it isn't necessary to pass the polling parameter now.

Thanks,


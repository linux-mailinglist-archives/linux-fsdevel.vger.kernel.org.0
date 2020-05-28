Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB4C1E5CB9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 12:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387662AbgE1KJK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 06:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387597AbgE1KJI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 06:09:08 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE354C05BD1E;
        Thu, 28 May 2020 03:09:07 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id m1so7010945pgk.1;
        Thu, 28 May 2020 03:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aNL4rrbHRBiHzlIt6XKjh1SWIm34V5I2S8EBeVbO3Z0=;
        b=HJSrLMIIanLw1HMAG8ROB7qcD3+KlHBCN411s7WgKjiBPhymzTFUzYA0nnbPwikIwp
         vHBtvlImlO43CkpGhFeOHp8PNUdxQ2ZOlBMoBB4aUA2jkV3wmyhftHmFCNl6f8MdXuhP
         ebjEJnB4s+kaz+xnXzTg957gqcJbreoGhMMDb9XnTk8Jtu/m/pMi0dzpxf3hbVHqPhTL
         kGfpEtzle/b+T8YG4EI/eo/qtdzhsTPBn4/aQUPq14qkdGum+VSYsrIfAHqgPn6Gmp93
         Io9Rn6NYBDRpIioPam9P4UMsYODyg6C8i7nRsfvJix8T8QgSMzLd/BHlIIE7Jni+5VZL
         P0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aNL4rrbHRBiHzlIt6XKjh1SWIm34V5I2S8EBeVbO3Z0=;
        b=TKWfkodWzOeJzXDv2IEMe1nc1L2TsOydcYGOMseq5pKKn1FGxwP8CuQY4MNijA+esC
         LDuqAAa3Ki9gqSdAKTYzXaUhfb05CGD1BLvqLnJDVs5flJPCkFkloxi81MheRDoDWDBN
         2QGiTfz6SBDlvAx4ZrnU0waUReBeKBrbnl4r99ZkKqiJgic1bOygXTPjz0refGGUn6mX
         t5TvlMqbkefPtz3B98Bu6g1jYzLyCPKjteZ4qrAwGxBH9rm5B0UF0jvd57/P89bL9IWs
         Qzoa2nZkwcctse7B8xWcxcZR1By2jKlokHY3cxGrzG3Zbgc7KpTxDsgY+0bWGtb9nzEH
         Q7vg==
X-Gm-Message-State: AOAM5333+fuTamtxFqsDntAUN5GbtwvY5CDBZJVT+oHM49qAPhpOc7g0
        F1jTsQZZ4dUfi+St2vCXHDEZmkW9HZM=
X-Google-Smtp-Source: ABdhPJxX3CR2VS66Sg0ylHR9qDL1Vu5o/xb1qcb1Qnnr+H020EQ88Jx2pMo+Pmm2WfQ4Gux0oDrI7Q==
X-Received: by 2002:a65:6550:: with SMTP id a16mr2152926pgw.183.1590660547178;
        Thu, 28 May 2020 03:09:07 -0700 (PDT)
Received: from ?IPv6:2404:7a87:83e0:f800:295a:ef64:e071:39ab? ([2404:7a87:83e0:f800:295a:ef64:e071:39ab])
        by smtp.gmail.com with ESMTPSA id j24sm4158533pga.51.2020.05.28.03.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 03:09:06 -0700 (PDT)
Subject: Re: [PATCH 4/4] exfat: standardize checksum calculation
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        'Sungjong Seo' <sj1557.seo@samsung.com>,
        'Namjae Jeon' <linkinjeon@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200525115052.19243-1-kohada.t2@gmail.com>
 <CGME20200525115121epcas1p2843be2c4af35d5d7e176c68af95052f8@epcas1p2.samsung.com>
 <20200525115052.19243-4-kohada.t2@gmail.com>
 <00d301d6332f$d4a52300$7def6900$@samsung.com>
 <d0d2e4b3-436e-3bad-770c-21c9cbddf80e@gmail.com>
 <CAKYAXd9GzYTxjtFuUJe+WjEOHSJnVbOfwn_4ZXZgmiVtjV4z6A@mail.gmail.com>
 <ccb66f50-b275-4717-f165-98390520077b@gmail.com>
 <015401d634ad$4628e4c0$d27aae40$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <780793fc-029a-28a6-5970-c21ffc91268b@gmail.com>
Date:   Thu, 28 May 2020 19:09:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <015401d634ad$4628e4c0$d27aae40$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> I'll repost the patch, based on the dir-cache patched dev-tree.
>> If dir-cache patch will merge into dev-tree, should I wait until then?
> I will apply them after testing at once if you send updated 5 patches again.

I resend patches for boot_sector.
However, the dir-cache patch hasn't changed, so I haven't reposted it.

BR

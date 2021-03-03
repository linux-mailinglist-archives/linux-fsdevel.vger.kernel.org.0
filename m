Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413A032C533
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446697AbhCDATm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358412AbhCCMGT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 07:06:19 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1B3C0617A9;
        Wed,  3 Mar 2021 02:43:55 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id o16so5842965wmh.0;
        Wed, 03 Mar 2021 02:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PgwT9droUAx+uKTWrWPCHSLR4SLfHYSyusjr/F/kZq4=;
        b=q6RC5n3oKhbYY1sx6cKN0UGvK6qCSa5W+zBFufHpKisu8L3kmH0xDUY4oZPor/Z8kc
         R2B7HxEY+0zg1DP/dBUvDgvOscTPCXUiXNH9EFSkwY78zu5oouCdszqFjjqU7OlL68IJ
         Nlzq63WJTrnNL7R14c57Li4cD+fCjN6QpT18e7o/wGnLxC14YRwnzDywwlnR72urmlfv
         DjkQ7YEP/c2EZRAlxWLrDQUI+iOC7ZAM9ImYVwZkyAmo8tDuazWsg6547K65JKoc/TP7
         E/WK46SRW+RQdCSZngJ3BSXsEliG8m8jJLZybFgLYH2Rd980ff3SW3DCjsbvvVxiiA7+
         pCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PgwT9droUAx+uKTWrWPCHSLR4SLfHYSyusjr/F/kZq4=;
        b=N21yyydXEl8kQhxQKSzMNh/0MOS72UXZgS+U6P/mOUU4Ku7yKZ61p0LwYAhT4myBQ2
         rrBXR//B6FMsXtlFfzuAJZI4st/qGqm9EAyDQfxgi7fP5iGHn8/6fKlTDO0MfzgOtaHE
         w/IRUexEuZgBdeHEkeiTrduFH0CEUHU4+kAQRnDCiGAg/UGqBVf9gaEGz/1fh0b3gpNx
         4A5irRzV1O3bPDFt3UHTs7CNS+Tc1UCSo+UAlANJz79hXcG7AVmy1rtRjmzgnmr8Ak6e
         flwlVPJPP6oaxCDMt+0Wnw1jUaV33t/XN9sp64qbVPhjvivHNILcMStLpR/9P2mh7syG
         Aqfw==
X-Gm-Message-State: AOAM530X10pvShLxT7QrpxZ9uaWTGYkOj4DcufdJhel72RvE4Bo2jVOo
        LjMo60Hbt8rcjybmVbL/jzfjavXm7P1R0Dlh
X-Google-Smtp-Source: ABdhPJxM9Lby412bEqIBX7NezdIFCNwizwket4RtkZB6yfemGIq2z2wzCqkaK9sOF4fyJV6qVNs/TA==
X-Received: by 2002:a7b:c755:: with SMTP id w21mr8728296wmk.89.1614768234396;
        Wed, 03 Mar 2021 02:43:54 -0800 (PST)
Received: from localhost.localdomain (bzq-79-179-86-219.red.bezeqint.net. [79.179.86.219])
        by smtp.googlemail.com with ESMTPSA id u137sm5504454wmu.20.2021.03.03.02.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 02:43:54 -0800 (PST)
From:   Lior Ribak <liorribak@gmail.com>
To:     akpm@linux-foundation.org
Cc:     deller@gmx.de, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Lior Ribak <liorribak@gmail.com>
Subject: Re: [PATCH v2] binfmt_misc: Fix possible deadlock in bm_register_write
Date:   Wed,  3 Mar 2021 02:43:30 -0800
Message-Id: <20210303104330.100557-1-liorribak@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210302164119.406098356cdea37b999b0b0a@linux-foundation.org>
References: <20210302164119.406098356cdea37b999b0b0a@linux-foundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Looks good to me.
> 
> I assume this is an ancient bug and that a backport to -stable trees
> (with a cc:stable) is warranted?

Yep, it exists since the "persistent opened binary handler" commit 
948b701a607f123df92ed29084413e5dd8cda2ed was introduced in version 4.8, and yes i think the patch
can be backported to the stable trees

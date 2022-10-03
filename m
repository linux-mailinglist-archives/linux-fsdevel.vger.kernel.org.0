Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C6A5F3971
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 00:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJCW6T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 18:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiJCW6R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:58:17 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CA332EEA;
        Mon,  3 Oct 2022 15:58:16 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c3so6601349pfb.12;
        Mon, 03 Oct 2022 15:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:content-id:mime-version:references:in-reply-to:cc
         :to:subject:from:from:to:cc:subject:date;
        bh=h/EH2yCpn2b6STRSxqNywEbQQtPrQkhdBeHGG9IxaAM=;
        b=ckqyOpc/y1/7vbRRjFwF2lf4hzXWDrFJ8ttxx6c2610jELPSBc/0rUR0DPycRh1nnz
         bU7oCVzEecKNDyYrnJUlf/77RfVom2gvxQnDwpZrhkCINI216DgEWKc4kSYMJDdwg6tJ
         B/RiZV37W6gX7BOAQ0XCU3LL8gZbeQijpYFKBb10tkUyxMKQQUprga5q079KudbHPoUz
         8jUmBx2rC0wZguH0ERDDPTLjgLmIXrpbH5eGJTMil9wNZpbI4EtLFXw4gwPyI2PCw473
         UEOvcFooJ4NRUkG2A/t86BSmusM1eC+17HLXaaFrL8kIo3C3ynwQzLycI/clOzzPrCcO
         l/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:content-id:mime-version:references:in-reply-to:cc
         :to:subject:from:x-gm-message-state:from:to:cc:subject:date;
        bh=h/EH2yCpn2b6STRSxqNywEbQQtPrQkhdBeHGG9IxaAM=;
        b=LdKWmbEahw/ART8s33ZaARn6P2yekFZnZg+zO07hfLMiHJm6clrQY4wrhDbLZV0AU3
         GkyZn1okhVEzmOklpLxjHEmkb1t9ut/f8o6H7w7owAIYGOZw3XutxmsQYslw92K1GbtX
         YK8pXWPJMMKkceawApNNyZ7NfxuMFp5ECHyRAcEVnp1TxI17xM6envtKx3fSJd8W+DcT
         1l2Z/WOlPXyVUM1kRswLto4BfyqpUMBpWTnwu2qUUaIrsxuecV19m8dXUljVP707JJc5
         eIK7DzIjbCSEx1kIR3irsaNQaXqo5mQ7Tdkml+V7t8DLvg78UF4/exw73Iy3qWtVxIZc
         9MLw==
X-Gm-Message-State: ACrzQf2JiReyjrWhDbwWZSYtlfDvCaMp5ceEozZE7WUYyestTXe7OEqA
        norkhsuTcsAyn8chmqOmA/Q2lcILorU=
X-Google-Smtp-Source: AMsMyM6vB8SmaZLNSLKdD+t53xTGLXsp3ES3vsa9WFM/QF1mF8JlVgVDAzK/jJroJSqxGA+LNjyvfA==
X-Received: by 2002:a05:6a00:1342:b0:545:4d30:eecb with SMTP id k2-20020a056a00134200b005454d30eecbmr24206264pfu.69.1664837896404;
        Mon, 03 Oct 2022 15:58:16 -0700 (PDT)
Received: from jromail.nowhere (h219-110-108-104.catv02.itscom.jp. [219.110.108.104])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090332c200b0016f8e8032c4sm7772410plr.129.2022.10.03.15.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 15:58:16 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=jrobl) by jrobl id 1ofUO6-00012i-Uu ; Tue, 04 Oct 2022 07:58:14 +0900
From:   "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: [PATCH][CFT] [coredump] don't use __kernel_write() on kmap_local_page()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <YztfvaAFOe2kGvDz@ZenIV>
References: <YzN+ZYLjK6HI1P1C@ZenIV> <YzSSl1ItVlARDvG3@ZenIV> <YzpcXU2WO8e22Cmi@iweiny-desk3> <7714.1664794108@jrobl> <Yzs4mL3zrrC0/vN+@iweiny-mobl> <YztfvaAFOe2kGvDz@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4010.1664837894.1@jrobl>
Date:   Tue, 04 Oct 2022 07:58:14 +0900
Message-ID: <4011.1664837894@jrobl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro:
> Argh....  Try this:
>
> fix coredump breakage caused by badly tested "[coredump] don't use __kernel_write() on kmap_local_page()"

Thanx, it passed my local test.


> * fix for problem that occurs on rather uncommon setups (and hadn't
> been observed in the wild) sent very late in the cycle.

If the commit was merged in RC versions, I guess someone found the
problem earlier.


J. R. Okajima

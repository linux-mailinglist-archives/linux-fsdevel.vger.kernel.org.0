Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BCE741BC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 00:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjF1Wkz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 18:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjF1Wky (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 18:40:54 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAD9213C;
        Wed, 28 Jun 2023 15:40:50 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31409e8c145so55013f8f.2;
        Wed, 28 Jun 2023 15:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687992049; x=1690584049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xd9lgc6PLBmPQSqD89EJuhExTG4ZNDOxV1oSD8XCTdw=;
        b=EksH2w9qA3Hk5srADDlldVdyNdNsX6wlhjD6CXXWrAJbIB8YzuU4P6t+DXQGQkhk/5
         oKpN7+SEj/3GUEVTrLsWfo311az5uwl9nCZfVVBKYGCdCSCKI25XTy7lqb34fSBbB51r
         VhN4SUH3Q65llOFzcQGXWMz9JnijyjQRUbhAgfZ3b4rKII/GcP4tconTTBftjMh5NF3T
         vTlOumt0CSwcqHyeFOrRYXP7Z7toQnIFiYu6GgJDUJdJQ/SZfthUxOQw68xK4v8R4O3K
         XlWnqtCxcNNlD/beaE6B7Zln9i5HppKCp50WkNSCKz7XfbgknfgkJIDwm0bThfY/KBzV
         lmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687992049; x=1690584049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xd9lgc6PLBmPQSqD89EJuhExTG4ZNDOxV1oSD8XCTdw=;
        b=hYvy1xZyPmYS2ZWlGihVG1SX2AQlIWXUoX8L0wSo8/IOJ8UcQtstuU5x0vsxNmaIpj
         CZBrCHE4/XTYQH8UZ5jPJUxICaTpJaS3Bkoo50gOz9P9yZG2UD1aRwQkAoESLm9kSvsQ
         488+Kmcc/8fJhlj6Eq5/rcU26CnNjfyRBcKGi3S4bkHkU09WbVkhQ6d7qtdvrxUQkstd
         oS0u/PSh2fQnApV9+9Qfq1qNig2bVZneBCeD0lwWl/zlE+1VruepnDhplqYLpBBvAmFs
         z8vvoSzdSEGmCTdMlPxUlQiUo3532zghQI9ZaWNIDnAMWswU6RgYe9CJmrQo3oz3Y5ww
         bRzA==
X-Gm-Message-State: AC+VfDzj+K18eHhEyZKeofM58kF5xBTH/+IbDBYsQnVDOF3pet8AjjAG
        DY8WqX4TFBLK07AQhNK2BNISQmyRBYM=
X-Google-Smtp-Source: ACHHUZ44cdTDqFORZpXEvTYChMpsEyNQSzT04y9ewX8+0ZotQl8V/VTLSzpmjOaHfSDnOefEQC7nIA==
X-Received: by 2002:a5d:474a:0:b0:313:f676:8340 with SMTP id o10-20020a5d474a000000b00313f6768340mr7010872wrs.47.1687992048397;
        Wed, 28 Jun 2023 15:40:48 -0700 (PDT)
Received: from suse.localnet (host-87-3-108-126.retail.telecomitalia.it. [87.3.108.126])
        by smtp.gmail.com with ESMTPSA id b2-20020adfde02000000b0030c4d8930b1sm14311929wrm.91.2023.06.28.15.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 15:40:47 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Sumitra Sharma <sumitraartsy@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>, Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] fs/vboxsf: Replace kmap() with kmap_local_{page, folio}()
Date:   Thu, 29 Jun 2023 00:40:45 +0200
Message-ID: <2882298.SvYEEZNnvj@suse>
In-Reply-To: <6924669.18pcnM708K@suse>
References: <20230627135115.GA452832@sumitra.com> <ZJxqmEVKoxxftfXM@casper.infradead.org>
 <6924669.18pcnM708K@suse>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On gioved=EC 29 giugno 2023 00:23:54 CEST Fabio M. De Francesco wrote:

[...]

>=20
> Shouldn't we call folio_lock() to lock the folio to be able to unlock with
> folio_unlock()?

Sorry, I wanted to write "If so, I can't find either a folio_lock() or a=20
page_lock() in this filesystem.".

=46abio
=20
> If so, I can't find any neither a folio_lock() or a page_lock() in this
> filesystem.
>=20
> Again sorry for not understanding, can you please explain it?
>=20
> >  	return err;
> > =20
> >  }





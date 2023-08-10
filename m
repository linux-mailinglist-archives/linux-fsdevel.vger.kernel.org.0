Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D8F7778F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 15:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbjHJNBm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 09:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjHJNBl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:01:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6263F2691;
        Thu, 10 Aug 2023 06:01:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01DA665BB2;
        Thu, 10 Aug 2023 13:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F141C433CC;
        Thu, 10 Aug 2023 13:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691672500;
        bh=L8v0r9doqZel/J2v7dujLyNos+92a27rf2u0qXW1J3s=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=buHrPopGvpa2PXQH2ihgGLWcE3tKpdzREf7fOef2SobndHttHp3mY7Zbo+pWmSjd2
         KMTnXejW6RxtiMq2GmdVWrfMASOuIkFWsGWFylNvcdafpUac7PYBKCmkXvU2g62wb8
         rM8BUTgNjphg88x1gT8UKtdTVA4JxWWEDKJN9wr7DBaWdsX/CszZDkjC6SQ/RTprXt
         7kxeMpaYIOPZVbmujFI2QewnZtkhD6cYZAhyC/PFUYrPDYv/GpspXeiAQURb6Rzuwg
         cbT6Ns2vdWIMXD6/0aKBc8h9zcEY7xvoVtSJHa2tZhrEbnYoLfZPZXTBqDOOpDDHWb
         8+hyUXgwVQJwg==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1c0fa9dd74fso278977fac.3;
        Thu, 10 Aug 2023 06:01:40 -0700 (PDT)
X-Gm-Message-State: AOJu0YyVIRrSKR8fyBz8TNv3lwa/oGU8Hrl2y6V1T4arRU68I/TjfUb7
        2keRBRF/oSkzqE+k+CFrsdm5Zvv9byEVqjp/OYY=
X-Google-Smtp-Source: AGHT+IHGXX8j5FtK2vAGECuIYYeKRL8lP5vqMAg+4bwDrvliN//5tmNM3DXELlLFKcDyM4MBXQs+Ek4XnYl/S6pN5ZI=
X-Received: by 2002:a05:6870:239b:b0:1bf:ce5b:436 with SMTP id
 e27-20020a056870239b00b001bfce5b0436mr2584340oap.58.1691672499477; Thu, 10
 Aug 2023 06:01:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:482:0:b0:4e8:f6ff:2aab with HTTP; Thu, 10 Aug 2023
 06:01:38 -0700 (PDT)
In-Reply-To: <20230809220545.1308228-10-hch@lst.de>
References: <20230809220545.1308228-1-hch@lst.de> <20230809220545.1308228-10-hch@lst.de>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Thu, 10 Aug 2023 22:01:38 +0900
X-Gmail-Original-Message-ID: <CAKYAXd80rJ6v4=b-=i4XUi_0d9JNqEothmh3614FSxPg1apitA@mail.gmail.com>
Message-ID: <CAKYAXd80rJ6v4=b-=i4XUi_0d9JNqEothmh3614FSxPg1apitA@mail.gmail.com>
Subject: Re: [PATCH 09/13] exfat: don't RCU-free the sbi
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2023-08-10 7:05 GMT+09:00, Christoph Hellwig <hch@lst.de>:
> There are no RCU critical sections for accessing any information in the
> sbi, so drop the call_rcu indirection for freeing the sbi.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks!

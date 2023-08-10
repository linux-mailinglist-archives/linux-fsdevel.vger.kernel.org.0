Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567957778FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 15:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbjHJNCN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 09:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjHJNCM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:02:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4587E5D;
        Thu, 10 Aug 2023 06:02:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69D1E657F1;
        Thu, 10 Aug 2023 13:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF34C433CA;
        Thu, 10 Aug 2023 13:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691672530;
        bh=fWjzqbfyq3dqLOBOt3ZEPD08+Rztcs8+WqFfJPdEYEE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=KVljWqOSmgio0hTSn1uej4374CX8MDSt/O/tCgjlhsWVgnNaEgFiLUjkc1sldi/Bq
         vZNpntkTioSt/xNG5VieQzLVex9KsclxtZLK0IfThtfs90UvPRz3Nsyro8wF+8smoD
         lWu5m4gCjWky2VB/92CHijaBdHMTzKQVQ4Vxqth5V+ArmH6zNMzHTwFxyU0iDTXwnN
         8IJsv2fvTEu4Q0+gZpZW+fDcYiVOf4yUpdrKcDYkE7lHtc10FFKMG7g18JatGYSZO/
         lEmN9e13BUh6NEdLG2oSFkQf+TQ5jzQe5g0dMSwkP/AX4koskZk0EG52tyKRAcnyEj
         CbZ4HbnWd1OsQ==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1bef8f0904eso805736fac.2;
        Thu, 10 Aug 2023 06:02:10 -0700 (PDT)
X-Gm-Message-State: AOJu0YxpKoZ9QLUB4JE3i95QGtb7Z26txO1t5t6dflMEYR2g8mYJKz2K
        I2Qiu7qPdvpyVo0jWnSj4QZP7cAp78dPGeHoMN8=
X-Google-Smtp-Source: AGHT+IGqdLSse0MyFayFMx2um0Jvds45aRF5j4EF+uhq5gWdDfwz037RnQXgHT8V4WMer8tSRo8i0DRENFNLRBLWqKE=
X-Received: by 2002:a05:6870:70a6:b0:1b3:f1f7:999e with SMTP id
 v38-20020a05687070a600b001b3f1f7999emr2426297oae.45.1691672530035; Thu, 10
 Aug 2023 06:02:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:482:0:b0:4e8:f6ff:2aab with HTTP; Thu, 10 Aug 2023
 06:02:08 -0700 (PDT)
In-Reply-To: <20230809220545.1308228-11-hch@lst.de>
References: <20230809220545.1308228-1-hch@lst.de> <20230809220545.1308228-11-hch@lst.de>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Thu, 10 Aug 2023 22:02:08 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9TaQnWja4vrHqzjA2FSoGhkJThv1FvOBbmcoR8x2ybXw@mail.gmail.com>
Message-ID: <CAKYAXd9TaQnWja4vrHqzjA2FSoGhkJThv1FvOBbmcoR8x2ybXw@mail.gmail.com>
Subject: Re: [PATCH 10/13] exfat: free the sbi and iocharset in ->kill_sb
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2023-08-10 7:05 GMT+09:00, Christoph Hellwig <hch@lst.de>:
> As a rule of thumb everything allocated to the fs_context and moved into
> the super_block should be freed by ->kill_sb so that the teardown
> handling doesn't need to be duplicated between the fill_super error
> path and put_super.  Implement an exfat-specific kill_sb method to do
> that and share the code with the mount contex free helper for the
> mount error handling case.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks!

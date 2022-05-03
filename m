Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36E6517D3D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 08:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiECGSt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 02:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiECGSs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 02:18:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4195CBCF
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 May 2022 23:15:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 842CC61589
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 May 2022 06:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02E0C385B2
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 May 2022 06:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651558512;
        bh=z7EijqrE3d5VjY35BMeH+t4YsXimOOv7VTpHoW6GE1w=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=O4+Ofb4+KNQ9xBTYKLlZblaINIZSCJz/cccgC+/Pig3cg67c5koYAAmE2DehhuFFp
         H+gntwo3y9G3MarB+gexQ/LweM36nmLX5sSP6B8JSt55O/O56fsOhydK+KmRH0WTyT
         z+dGmi+N43XKddpvKjdwiK4OmJer/sZ0In574kt2X8zTa4Eu63KOPiDAAIAkQa/s0R
         cEEiDK4bKQyGiWO/IWU18xMRtdBKxPpqIJSN5APY4U2A/oJvIk7skNb8j6p4mTvRsl
         22w3u43JiW0//9I0eYU7BiwlHOKxNewlu06d8NhHZ/tt12oloZmQUjSjkWaxNzjlXJ
         qXgSPy+KOlOcw==
Received: by mail-wm1-f46.google.com with SMTP id ay11-20020a05600c1e0b00b0038eb92fa965so701350wmb.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 May 2022 23:15:12 -0700 (PDT)
X-Gm-Message-State: AOAM5311j1BRhWzNSq75XNE/2cL2OgDwcegfmWNmIWIc8M3lZAKaSAr4
        T6VID6aqIFO/tav5t6VFRjhXRsPqs0KcnrSAp8U=
X-Google-Smtp-Source: ABdhPJx6ppSJSx3kZIrU1OUbZLvsNKGTUGinUkr7ddRvDFpf/Md6SAgjSOobi33gFdRE1l3WTHPWDHicAjitZdXLkn8=
X-Received: by 2002:a05:600c:19d2:b0:393:efff:7c26 with SMTP id
 u18-20020a05600c19d200b00393efff7c26mr1980269wmq.9.1651558511066; Mon, 02 May
 2022 23:15:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:4571:0:0:0:0:0 with HTTP; Mon, 2 May 2022 23:15:10 -0700 (PDT)
In-Reply-To: <20220429172556.3011843-20-willy@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org> <20220429172556.3011843-20-willy@infradead.org>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 3 May 2022 15:15:10 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-XzbDQEU3OCv82qF6a3Kvc-e2rqtJes06a4PVq41kDaA@mail.gmail.com>
Message-ID: <CAKYAXd-XzbDQEU3OCv82qF6a3Kvc-e2rqtJes06a4PVq41kDaA@mail.gmail.com>
Subject: Re: [PATCH 19/69] ntfs3: Call ntfs_write_begin() and ntfs_write_end() directly
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Kari Argillander <kari.argillander@stargateuniverse.net>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev,
        Kari Argillander <kari.argillander@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-04-30 2:25 GMT+09:00, Matthew Wilcox (Oracle) <willy@infradead.org>:
> There is only one kind of write_begin/write_end aops, so we don't need to
> look up which aop it is, just make ntfs_write_begin() and ntfs_write_end()
> available to this file and call them directly.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks.

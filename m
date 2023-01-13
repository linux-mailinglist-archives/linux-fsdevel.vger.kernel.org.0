Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79762668AE8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 05:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjAMEgf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 23:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjAMEgA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 23:36:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB291AA34
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 20:35:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A41662222
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 04:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76392C433F1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 04:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673584557;
        bh=y97WtSgkqHwv8+RerxBqsrLQ+bjnOkoPXM2knaaKy5w=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=hBV1PeaZAuTy9ff1aeyjtE2ylIBUrP/XhLeyYGqCOo9ef3NbGPwdU3IbfQKlcjvO7
         Ii3170CS2VaNTtMle8BQakDznep4fITsOmQvcjvm7PBZhBY7++j5SxPNSemBtcB4nY
         ztO/dEGJnqPq/DUJb8MevuQ0QIwAsWTcTR6qQ6tJZc+krbGCkym7zIBy6FGVwKrhEn
         k9/h6YPJbM7jWEjvcxyM43ve7swqiL/u/mRO8nDKUDUP2kWEGSdCu10aHzLY1LbA8o
         YzRI6ZiWQQBZNJ47vqjp3GlBNIFe/iCFNQOGgN32b3OPxI5/OKM0MBRoPuFk5zt2mI
         gfjhq0mDwpcKQ==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-15027746720so21142120fac.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 20:35:57 -0800 (PST)
X-Gm-Message-State: AFqh2kpwzLyhsLFOf+jEPrpP/V+gyqDOte6BWffcKlTDYF+oQjQbExdX
        si/l8M57H82/jfRvpUdQtDaUHACPPhJDqkgA5TI=
X-Google-Smtp-Source: AMrXdXuxvegGP+qoEQUKLhpEuyylq46Z6/7aumLMQD43NeT4KVTFisi/yIUap0y7kkhBYqQijlEyk7dh5HvBztU1D/A=
X-Received: by 2002:a05:6870:4b49:b0:150:9da1:7316 with SMTP id
 ls9-20020a0568704b4900b001509da17316mr3357553oab.215.1673584556518; Thu, 12
 Jan 2023 20:35:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6802:191:b0:48f:4f77:6cb1 with HTTP; Thu, 12 Jan 2023
 20:35:55 -0800 (PST)
In-Reply-To: <PUZPR04MB63165533693F8FD12046D19581C29@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20230112140509.11525-1-linkinjeon@kernel.org> <PUZPR04MB63165533693F8FD12046D19581C29@PUZPR04MB6316.apcprd04.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 13 Jan 2023 13:35:55 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8p8mmSaXLNjkzDH=AmrOyhA5DYsjuKEA7=c+1pYfY5AQ@mail.gmail.com>
Message-ID: <CAKYAXd8p8mmSaXLNjkzDH=AmrOyhA5DYsjuKEA7=c+1pYfY5AQ@mail.gmail.com>
Subject: Re: [PATCH v2] exfat: handle unreconized benign secondary entries
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Wang Yugui <wangyugui@e16-tech.com>,
        =?UTF-8?B?QmFyw7Njc2kgRMOpbmVz?= <admin@tveger.hu>,
        Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2023-01-13 11:36 GMT+09:00, Yuezhang.Mo@sony.com <Yuezhang.Mo@sony.com>:
>> +	if (!(flags & ALLOC_FAT_CHAIN) || !start_clu || !size)
>> +		return;
>
> From '7.9.2.2 NoFatChain Field' of the exFAT spec, flags can also be
> ALLOC_NO_FAT_CHAIN.
>
> The NoFatChain field shall conform to the definition provided in the Generic
> Secondary DirectoryEntry template (see Section 6.4.2.2).
This is to check the AllocationPossible field. We can probably add
ALLOC_POSSIBLE macro to avoid confusion.
>
>> +		if (exfat_get_entry_type(ep) & TYPE_BENIGN_SEC)
>> +			exfat_free_benign_secondary_clusters(inode, ep);
>> +
>
> Only vendor allocation entry(0xE1) have associated cluster allocations,
> vendor extension entry(0xE0) do not have associated cluster allocations.
This is to free associated cluster allocation of the unrecognized
benign secondary entries, not only vendor alloc entry. Could you
elaborate more if there is any issue ?

>

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D63544C33
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 14:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245385AbiFIMff (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 08:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236095AbiFIMfe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:35:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3215F22BCF;
        Thu,  9 Jun 2022 05:35:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFBA3B82D89;
        Thu,  9 Jun 2022 12:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E30EC341C0;
        Thu,  9 Jun 2022 12:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654778130;
        bh=MPcMQ41HLrc/IOjg0nu4+FGIsqHgomusGWnWSPlu8rs=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=S0lPxoEeUYlxxGn7ul/0YW2mp0NYFEuIHb0tv7qTdyFh9g+R3YA9A9RJRSd6UYPji
         /REsQXJhcG1Ub1rPHKtbxuqg3nM7aVRP7inCVKkefd2Heo2WJMPA0WV2s6JX50yxdj
         C/+kqAVWnq3nvpOrrdi1+AuJQPDOv8qCNPtpfZS1X1YmDddj827lq3yU1SeJnKNUU4
         vL2v8XrmmmIeSHD7XhPXuoojw1CgEBcPJnC4Cux+DrjuOJZVkJl/roGR1FQsgo0jIB
         sO+Lt4Y1zKnAYwOoqiArO6W3J7dwUQ41c1G8PLYMCj9EvC1gijb7B6ncZPWVQaQMny
         zh9XUyUf7d9Hw==
Received: by mail-wr1-f43.google.com with SMTP id a15so23702734wrh.2;
        Thu, 09 Jun 2022 05:35:30 -0700 (PDT)
X-Gm-Message-State: AOAM53020sVMGuRaVUT3jn/itiC2BXmbZCDgWv5Ve2dLIEbi5A7PBtV5
        MiBg5pzVpA+n716/FrvYkMhRNLRLEgCqSl4I9Zk=
X-Google-Smtp-Source: ABdhPJzWmxxxSbqiI1wPb6ox88dsOK65z29Pli+VzltNwa/NX2TcBjJ8wz3i/w4MrUE9k30MHgq1RyVmZcnEVCMk/g0=
X-Received: by 2002:a5d:43d2:0:b0:218:3fe6:4127 with SMTP id
 v18-20020a5d43d2000000b002183fe64127mr21421249wrr.62.1654778128805; Thu, 09
 Jun 2022 05:35:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:4c4a:0:0:0:0:0 with HTTP; Thu, 9 Jun 2022 05:35:28 -0700 (PDT)
In-Reply-To: <20220608020408.2351676-1-sj1557.seo@samsung.com>
References: <CGME20220608020502epcas1p14911cac6731ee98fcb9c64282455caf7@epcas1p1.samsung.com>
 <20220608020408.2351676-1-sj1557.seo@samsung.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Thu, 9 Jun 2022 21:35:28 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-8HsO71kvwkuF0u56i2JigR5sF58s+ufh4rH7vKUDkCA@mail.gmail.com>
Message-ID: <CAKYAXd-8HsO71kvwkuF0u56i2JigR5sF58s+ufh4rH7vKUDkCA@mail.gmail.com>
Subject: Re: [PATCH] exfat: use updated exfat_chain directly during renaming
To:     Sungjong Seo <sj1557.seo@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-06-08 11:04 GMT+09:00, Sungjong Seo <sj1557.seo@samsung.com>:
> In order for a file to access its own directory entry set,
> exfat_inode_info(ei) has two copied values. One is ei->dir, which is
> a snapshot of exfat_chain of the parent directory, and the other is
> ei->entry, which is the offset of the start of the directory entry set
> in the parent directory.
>
> Since the parent directory can be updated after the snapshot point,
> it should be used only for accessing one's own directory entry set.
>
> However, as of now, during renaming, it could try to traverse or to
> allocate clusters via snapshot values, it does not make sense.
>
> This potential problem has been revealed when exfat_update_parent_info()
> was removed by commit d8dad2588add ("exfat: fix referencing wrong parent
> directory information after renaming"). However, I don't think it's good
> idea to bring exfat_update_parent_info() back.
>
> Instead, let's use the updated exfat_chain of parent directory diectly.
>
> Fixes: d8dad2588add ("exfat: fix referencing wrong parent directory
> information after renaming")
>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Applied, Thanks for your patch!

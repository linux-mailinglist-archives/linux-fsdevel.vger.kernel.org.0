Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B5265940B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Dec 2022 02:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbiL3Bdd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 20:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiL3Bdb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 20:33:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E39615FE9;
        Thu, 29 Dec 2022 17:33:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9F6961A10;
        Fri, 30 Dec 2022 01:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AB6C433F2;
        Fri, 30 Dec 2022 01:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672364010;
        bh=R2ggU7hkGkDA6n5glwcXKgKBSHo0MSt6JBTURx27KRg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=YfR1Av79iuxH4jFEH+/pGrRq7M7hxLTwdIkhYLJLc15Wv28m09ahkhA3+vRX+LNdS
         I/CS8Oq5ZgI7XYAgGcMU95V+bm0v93jc+cD6fFYAD7mmjnEeytBLlN9CjaDHD5TG6d
         EdSEk7CEY2i7jj9fl2jC9M9GMuFJq7z9EkXgKhIPMxEhm4Bg6BT64wKdSsDNmtv2Oj
         s0A4emcWjNdx9/7QW7eY8uPrw+lNxmVQhI04cqfYw3ytLQI0ko+PShF1l/YhHvjxt3
         15mn7R0gkGgXgEGCFrws0qRQfDaqq6AbNxSqwhD478bhHVsmLO3nMT+ixGT03+N7yE
         nIEBrDdfzCIig==
Received: by mail-oi1-f170.google.com with SMTP id u204so17995742oib.7;
        Thu, 29 Dec 2022 17:33:30 -0800 (PST)
X-Gm-Message-State: AFqh2kpAZvd+xH8uwNdmzIZhq58Kyq0l0KRcSYd2mp4nOOV/Ey/WwWzo
        BTg2xMpW3O8A7a9nLbIKzhIzQ1cSiAajwlDR438=
X-Google-Smtp-Source: AMrXdXvG0Tg97yPXw6ZNxkN6SgbukujOhgWfZmyGclrqrgF5C19eWtGL0EK/juwT7UY/OPcDHXPqxVgG0sl3jZ/+0pg=
X-Received: by 2002:a05:6808:d2:b0:35c:2424:667b with SMTP id
 t18-20020a05680800d200b0035c2424667bmr2206163oic.257.1672364009449; Thu, 29
 Dec 2022 17:33:29 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6838:2d06:0:0:0:0 with HTTP; Thu, 29 Dec 2022 17:33:29
 -0800 (PST)
In-Reply-To: <PUZPR04MB6316182889B5CE8003A5324981EC9@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB6316182889B5CE8003A5324981EC9@PUZPR04MB6316.apcprd04.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 30 Dec 2022 10:33:29 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9QLm29mR_FMhEriozHRczkx3A=9CmVWC1KOPGJDwhitQ@mail.gmail.com>
Message-ID: <CAKYAXd9QLm29mR_FMhEriozHRczkx3A=9CmVWC1KOPGJDwhitQ@mail.gmail.com>
Subject: Re: [PATCH v1] exfat: fix unexpected EOF while reading dir
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        Wang Yugui <wangyugui@e16-tech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-12-26 16:23 GMT+09:00, Yuezhang.Mo@sony.com <Yuezhang.Mo@sony.com>:
> If the position is not aligned with the dentry size, the return
> value of readdir() will be NULL and errno is 0, which means the
> end of the directory stream is reached.
>
> If the position is aligned with dentry size, but there is no file
> or directory at the position, exfat_readdir() will continue to
> get dentry from the next dentry. So the dentry gotten by readdir()
> may not be at the position.
>
> After this commit, if the position is not aligned with the dentry
> size, round the position up to the dentry size and continue to get
> the dentry.
>
> Fixes: ca06197382bd ("exfat: add directory operations")
>
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Andy Wu <Andy.Wu@sony.com>
> Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
> Reported-by: Wang Yugui <wangyugui@e16-tech.com>
Applied, Thanks for your patch!

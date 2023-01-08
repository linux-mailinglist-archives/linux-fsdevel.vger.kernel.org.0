Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0293E6612D6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jan 2023 02:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjAHBGb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Jan 2023 20:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAHBG3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Jan 2023 20:06:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B6E1789E;
        Sat,  7 Jan 2023 17:06:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CBECB808CD;
        Sun,  8 Jan 2023 01:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D823BC433EF;
        Sun,  8 Jan 2023 01:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673139985;
        bh=N2nedIp9EppLzj5qpV+Pejcq2JaZc2ixQTVV7tDg0Fc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=cn7WAlBynqbqLiJdJLe4VE6zV5p4sJovJcc+mRLOD9z5pDLxIRUNFkab70XfW/jjD
         7Dt547MDLKBFlzCO8fwoSzOqv3sPLEj4Mxn7FsTusF9vQeJJw0TRRy/svvfclI9gLA
         M5g9s/bzA886/rHCtHsnQY8Gpc6dw/iw2cDLy4WlWDnMhpUqRXf46WZEVK11wRZSRp
         Jg/szGzCDcQfeTVS6xDYnvX4IslHCkjltb8hhePi5i3kCW5cvo23xPd1KSkghsGhlh
         8N61RQUeUqkKbHGWuXFoDoX2ECoie2wULy40mwg4Y7R83kMOtFPQx+F+pPswbCnznO
         Xjdn4QMbjksKw==
Received: by mail-il1-f174.google.com with SMTP id o8so3220271ilo.1;
        Sat, 07 Jan 2023 17:06:25 -0800 (PST)
X-Gm-Message-State: AFqh2koxqpnlJRZgVQGBqb8ytBGDqyc3rRSzPCF6r739HvaZjEJlFdwN
        me4kNChZYSz6fJiS5a5SIFPIcEpnxo2QVn33beA=
X-Google-Smtp-Source: AMrXdXvnckrrmwltGLrC9Ohc+v4R5S1pd+YbyoUZhWn13eX3GqWmufi14uVQEFMLywfxVH8gKaV8xP4A5ezjcdDdtws=
X-Received: by 2002:a92:cac4:0:b0:30b:f4af:87bd with SMTP id
 m4-20020a92cac4000000b0030bf4af87bdmr4801312ilq.254.1673139985065; Sat, 07
 Jan 2023 17:06:25 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ad5:4f0a:0:b0:2a7:1320:aa34 with HTTP; Sat, 7 Jan 2023
 17:06:24 -0800 (PST)
In-Reply-To: <1891546521.01672360201726.JavaMail.epsvc@epcpadp3>
References: <CGME20221229115257epcas1p27195844dc54cf09608dad9967808530a@epcas1p2.samsung.com>
 <1891546521.01672360201726.JavaMail.epsvc@epcpadp3>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sun, 8 Jan 2023 10:06:24 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-+3eRwJTNRiP6Rcpusd9ZRxQdq1NpG=yNOHngsx3pnVw@mail.gmail.com>
Message-ID: <CAKYAXd-+3eRwJTNRiP6Rcpusd9ZRxQdq1NpG=yNOHngsx3pnVw@mail.gmail.com>
Subject: Re: [PATCH] exfat: redefine DIR_DELETED as the bad cluster number
To:     Sungjong Seo <sj1557.seo@samsung.com>
Cc:     pali@kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuezhang Mo <Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-12-29 20:52 GMT+09:00, Sungjong Seo <sj1557.seo@samsung.com>:
> When a file or a directory is deleted, the hint for the cluster of
> its parent directory in its in-memory inode is set as DIR_DELETED.
> Therefore, DIR_DELETED must be one of invalid cluster numbers. According
> to the exFAT specification, a volume can have at most 2^32-11 clusters.
> However, DIR_DELETED is wrongly defined as 0xFFFF0321, which could be
> a valid cluster number. To fix it, let's redefine DIR_DELETED as
> 0xFFFFFFF7, the bad cluster number.
>
> Fixes: 1acf1a564b60 ("exfat: add in-memory and on-disk structures and
> headers")
>
> Reported-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Applied, Thanks!

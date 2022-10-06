Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27745F670B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 14:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbiJFM7d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 08:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbiJFM71 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:59:27 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BBCF000
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Oct 2022 05:59:20 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w18so2596012wro.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Oct 2022 05:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=lWPeU58iRjRyoDqwaFtxQGqfl9KnL32cM4cRmo8vYs4=;
        b=T+zTF1Tl5sDJwMTkiMCxkdQT8khtIFd/7B7mhXM6ZtZiuT+zRWCODove36KmJtU9rC
         TKb+TmBDlSZDHn/48XLKotY0Sgq81mN3DIlZq/jxem97KPpW/0WJ/1bThUMpfN11CrL7
         Y8dIEUAeX8BPl4L+XiX+m2LXfzZBDInq7RPYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lWPeU58iRjRyoDqwaFtxQGqfl9KnL32cM4cRmo8vYs4=;
        b=Nbo0dMHSzuSyxaPoPBMj/wmsI4UQVxFCbept4d/8aQs/TTgiFeLQl8BlYkx3z62IqZ
         Raqk39uDtu04PDTugKCeLtosqvhzr5vRmiDS/JOVIrBfG5rog73M7/NQrHwLslrVM3l1
         yEvZSGFpWuxTtCUluBYYRz1A+IV/tv8Vr28idiEEuBU44C4ogw49I5eku2GOrumvLRtA
         r/HYuW2r2/wtulbinoWkm1iDUY986DU3/8ob0Ar83LIn73s01ayEmVkCFxhCd6duj1yy
         sSKkYeaeMYOytxUXA4GAgpaJKaxFFQ43OKxbvVGrJlFcwxwLOw1i3JD9Pg/1X1+OK+be
         mlBQ==
X-Gm-Message-State: ACrzQf1gIDG2Q2xUbFRzjGbYe/nrzM6/UMDzTBn3zkSQ2V2JdwUMHild
        bXKydFJpQJqMBL1vXI5PPTKPYYR75vZarkUZ5SwMGWjeNTk3qw==
X-Google-Smtp-Source: AMsMyM6j4TxIuyGrnoFijdlbKg7HT/nBqquZCHrQTmJmn0BEpysVBCEKSx/VbZt8FZ/qviUZukTtcd+y8QcDHJIw674=
X-Received: by 2002:a17:906:4fd1:b0:787:434f:d755 with SMTP id
 i17-20020a1709064fd100b00787434fd755mr3774303ejw.356.1665060616356; Thu, 06
 Oct 2022 05:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220929153041.500115-1-brauner@kernel.org> <20220929153041.500115-24-brauner@kernel.org>
In-Reply-To: <20220929153041.500115-24-brauner@kernel.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 6 Oct 2022 14:50:05 +0200
Message-ID: <CAJfpegu3_pDK2HTrwJ=ehBkBXYdTjF_DFd=oVF9M-k887sKkrA@mail.gmail.com>
Subject: Re: [PATCH v4 23/30] ovl: use posix acl api
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 29 Sept 2022 at 17:31, Christian Brauner <brauner@kernel.org> wrote:
>
> Now that posix acls have a proper api us it to copy them.
>
> All filesystems that can serve as lower or upper layers for overlayfs
> have gained support for the new posix acl api in previous patches.
> So switch all internal overlayfs codepaths for copying posix acls to the
> new posix acl api.
>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

Thanks,
Miklos

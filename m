Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D224C8F12
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 16:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbiCAP2C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 10:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbiCAP1v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:27:51 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFBD8A6EB
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Mar 2022 07:27:10 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id t11so18779159ioi.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Mar 2022 07:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=++vpopTMOTFX7gKCPV+9eb8vmC8m3vkNtcFm7icwfQU=;
        b=oFxRvA6Cse0SqTs+tDFo5fdhQx8+3S5D38fh5lhF6aAbz0nteHDhgHk8jvKvimJ1qI
         9R5WLOll1wXhVsEEKL55wT12eFCCGsFtHlo7DjyK8WIOMisQ3Wa+vqxnPIDBadjjlV7Z
         YG/PSHSQdOAAGuFaTfDFoc9ye4zaFlwEylHn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++vpopTMOTFX7gKCPV+9eb8vmC8m3vkNtcFm7icwfQU=;
        b=fuMkPP6TU2MFIYCjbTZGuuwGRcONkc6nGXaKKZvap/03n8lwtGXvRnn8AO1j0x/y4j
         9PPk1ExdE4HP8WTFsHxUrigqfOdPZxCxMSgyVOnWc6gCMJMnubB+KDTGHhcyKZccnfPj
         o86Y8FTZeC4g+QH/QyFqQlO4eaNwMCZ1ofr+se/TJOK+yymMl1RTy/IQGibo0JdCCXdL
         I6PB8Eau3b1rKiTe5zgIEsxfvHNNKGow2o8rU/CjTo+cJgSBTO8skJLKVU6TNs9ZNIGe
         30ecU/c+W9F60++PEHjB5tslsxzqWUH1GO2LTcFpKdmKpWoGc41AK0FPEBCLeCx/0Yv5
         evOA==
X-Gm-Message-State: AOAM531SMY1pyXkJ2a7bUQ+9gpth55M7EvnLtnaT7jTvRrGv+bFFk+B/
        Sp3xaOJhS0ilF+7TcGaIIjFVBWz+iC2mpIXALBAqGw==
X-Google-Smtp-Source: ABdhPJymm40dO5/mW/EF4q7B/WekzWsj3uj6xjaRt+yud6q7En7uGXuM3c8TSQkHEdJmHwJtEE01ZzSXCTpaI4zI/no=
X-Received: by 2002:a05:6602:1656:b0:641:958b:d90f with SMTP id
 y22-20020a056602165600b00641958bd90fmr19443727iow.51.1646148429741; Tue, 01
 Mar 2022 07:27:09 -0800 (PST)
MIME-Version: 1.0
References: <20220224032337.19284-1-dharamhans87@gmail.com>
In-Reply-To: <20220224032337.19284-1-dharamhans87@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 1 Mar 2022 16:26:58 +0100
Message-ID: <CAJfpegu4L6s9vR0FUuVuHfNpBM_PJuR8XJQsQnwRVFkZD4KJEQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] FUSE: Implement atomic lookup + open
To:     Dharmendra Singh <dharamhans87@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 24 Feb 2022 at 04:27, Dharmendra Singh <dharamhans87@gmail.com> wrote:
>
> FUSE, as of now, makes aggressive lookup calls into libfuse in certain code
> paths. These lookup calls possibly can be avoided in some cases. Incoming
> two patches addresses the issue of aggressive lookup calls.

Can you give performance numbers?

Thanks,
Miklos

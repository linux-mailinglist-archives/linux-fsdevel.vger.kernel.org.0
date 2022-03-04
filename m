Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D88F4CD7CD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 16:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240301AbiCDPbh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 10:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiCDPbg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:31:36 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82C41C57E6
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Mar 2022 07:30:46 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id t11so9898230ioi.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Mar 2022 07:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=urMVucwlWR5FRqYC/6kukBTMZNkdS2cul4Key5n37rY=;
        b=HbQ+YQ4RX+OtL4FtazHuTxvlgbbyjD/DpOrpuHaK3IglO5hpvrrudz1L2EaG8FnCam
         m0tNmDevDxWP05QeKar9MVPwaubWq9BHnyX8McUZ8FLMiin5gz6Lo2q86cyan23Ac5wn
         DscALyuwQdDWrpcJDnzB5YuyNEGxF/J3+vwTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=urMVucwlWR5FRqYC/6kukBTMZNkdS2cul4Key5n37rY=;
        b=IeH8tSBcHZVzpfMxfkerwJ/SYN+oJlpN1wVWW1BmiYdBU2sbOmcCpNcTBfHO0lbviL
         s9nHFvtRONJMjP/v3yoa55PHgnfFt2ETerUOos19vcAc8/cmN+whvF5/N8FE39F7qSec
         3UYW/VKsuu+zAhvVGzP0+lzz26rnPbvSbWfsyPrNQrDE7U+r92YUg6EaO/vXuNqJm6i3
         XaEquPJ0DTUU5ngqk6aFgoZYAT21Uj5enosJft6rn//h4tYDordXth3XrT/kB3HCBy0a
         jAZ2d/AxsV1namx/S5OM57DTmxDOccNHh/J6Iav1SjYHqEsViBSYr6jftY7DhdwVMCrT
         7uvA==
X-Gm-Message-State: AOAM530PJajwMX+2hnpoeQrYFBiDO0IZ0QRQaTY5ipsiDRVXfmFlhm5u
        2WxPvolVcPpKLDEOu1ks/qKmaMbUt7MN9mdkWMXrDg==
X-Google-Smtp-Source: ABdhPJw+dFFjq75F6XEy7g4PoJweVV8sFX4PStg9LnTWdIUWspEvsbDm16NbBGTDWpGzOcX7hRSRYbn4zrO6JqQdDXU=
X-Received: by 2002:a05:6638:3049:b0:317:9a63:ec26 with SMTP id
 u9-20020a056638304900b003179a63ec26mr436902jak.273.1646407846083; Fri, 04 Mar
 2022 07:30:46 -0800 (PST)
MIME-Version: 1.0
References: <20211229040239.66075-1-zhangjiachen.jaycee@bytedance.com>
 <YhX1QlW87Hs/HS4h@miu.piliscsaba.redhat.com> <CAFQAk7gUCefe7WJhLD-oJdnjowqDVorpYv_u9_AqkceTvn9xNA@mail.gmail.com>
In-Reply-To: <CAFQAk7gUCefe7WJhLD-oJdnjowqDVorpYv_u9_AqkceTvn9xNA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 4 Mar 2022 16:30:35 +0100
Message-ID: <CAJfpegt=9D1wAdxbr82br-cCnikNTiEZ=9NfPo02LAbTPMNb2Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] fuse: fix deadlock between atomic
 O_TRUNC open() and page invalidations
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xie Yongji <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 4 Mar 2022 at 07:23, Jiachen Zhang
<zhangjiachen.jaycee@bytedance.com> wrote:

> I tested this fix, and it did pass the xfstests generic/464 in our

Thanks for testing!

> environment. However, if I understand correctly, one of the usages of
> the nowrite is to protect file truncation, as said in the commit
> message of e4648309b85a78f8c787457832269a8712a8673e. So, does that
> mean this fix may introduce some other problems?

That's an excellent question.  I don't think this will cause an issue,
since the nowrite protection is for truncation of the file on the
server (userspace) side.   The inode lock still protects concurrent
writes against page cache truncation in the writeback cache case.   In
the non-writeback cache case the nowrite protection does not do
anything.

Thanks,
Miklos

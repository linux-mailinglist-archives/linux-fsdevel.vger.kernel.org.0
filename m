Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4993F4B4BEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 11:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344445AbiBNKHx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 05:07:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345987AbiBNKHW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:07:22 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5FD74DF2
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 01:49:54 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id j201so1401443vke.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 01:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7lP7KkY7WglFp6yGiwkOhLiozvfB0ZH/G4CrcK1Rg68=;
        b=ia3Vn1awKDyQXk3Bh1iKVHm4m12nuETI44kPapMGK7Aomo/gwj6mW2N7Ruwe4b0m2d
         IO/Rb9P7X1u6xgepVWmVvr0gPhPGeJOBOmsxTBZFgzgv8Ue0SXJUWGECV2BPJgcqPQu+
         Bi9B8CUJYyeaUz56iYDCb4s7F2Ri5xL3Kwm/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7lP7KkY7WglFp6yGiwkOhLiozvfB0ZH/G4CrcK1Rg68=;
        b=4czJNrt+HEm87sUGUVFtK+MZjnRtvel8YPjuTFTSvUQ/SHWLwWkXzZkp2UgEQyOmC3
         wbl9R5ehCIOYnFQX8iCq2e6B6VOvPSZY1MboskcoP3DQvbnsYeZ/aH7FdUU0/+z7DBs3
         5c8zjTDKKBmAV5Xm0D2aMCNKY04ZfMHfLLPPnAoEg2o4Y/bkygByygOl+7QqCkqUiSx1
         iFKCqnBN7qNW/yMS3WyKSGq9UU/TQVkkwiEK5PIvCT65uEk/64eTmejjbyL8TI+I+QoY
         jCuyzsWgAOZah8Wrk0y5TelPh25QhY9DmzHOA7bNGVzfcR7YR7LTaKp0qIem0s2L05MK
         q/vA==
X-Gm-Message-State: AOAM531KKoY+hr887mvdRtLaK1Y/2cTSazG+o8kOQChaVc9nFJMe0Eci
        ElO7Rqx0X0n8SjZRADqyA91CaL/eygMZT9GqpkjROkjpgaUeYw==
X-Google-Smtp-Source: ABdhPJybCGG43KBQZBGj3xKfxePsERUvO/AeYSMIO7uCVd9WU7Iag1BzeXAtVevcGIRqN1509xH0fGk2PLDc4VIv2AA=
X-Received: by 2002:a05:6122:550:: with SMTP id y16mr3706750vko.31.1644832193888;
 Mon, 14 Feb 2022 01:49:53 -0800 (PST)
MIME-Version: 1.0
References: <6da4c709.5385.17ee910a7fd.Coremail.clx428@163.com>
In-Reply-To: <6da4c709.5385.17ee910a7fd.Coremail.clx428@163.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 14 Feb 2022 10:49:43 +0100
Message-ID: <CAJfpegtQHk887yMDXU9s2Rm+iO1sR0-hq=abW3TJg43t_aE-5w@mail.gmail.com>
Subject: Re: Report a fuse deadlock scenario issue
To:     =?UTF-8?B?6ZmI56uL5paw?= <clx428@163.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 11 Feb 2022 at 14:55, =E9=99=88=E7=AB=8B=E6=96=B0 <clx428@163.com> =
wrote:
>
> Hi Miklos:
> I meet a dealock scenario on fuse. here are the 4 backtraces:

Which kernel is this?

Commit 4f06dd92b5d0 ("fuse: fix write deadlock") was added in 5.13 and
backported to some (but not all) affected stable trees.

Thanks,
Miklos

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C9C5FC6BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Oct 2022 15:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJLNvJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Oct 2022 09:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJLNvI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:51:08 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE27C7078
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Oct 2022 06:51:06 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id q9so33583146ejd.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Oct 2022 06:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v5YUZj2preUeh9QTI6ueyx+iJV4FKrSrouAkmiMJdSE=;
        b=JerlzHUNFpL509UfrBoY2mMGhtVuc6daN7sp4Gk+s2hlIIcsYbx8ygP60vLtgvRyWd
         ZN0AJ4g2MaQIuvuGDCLBvji/aB51RrKDa8kl9XrIi0K61zMBbTV5T0aRPFfB5kmEpkAp
         aqz03VOaOYuGDyJOuYZmgL2YEV0GrVfcQ9ybw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v5YUZj2preUeh9QTI6ueyx+iJV4FKrSrouAkmiMJdSE=;
        b=ZCwkKSC9tEAu1ydzdstOrvOI6N1QDNXLDrpaGFrZza8yq7uj8/VMa0XDiBfF9ddotd
         IwhYvU8GpcUoCKsElCEdZEEpFXkCkK5QoZ6/qvFSvDoYq6iDximKxWxVzmV+wNjHNGOA
         ETb1HxKclmAgvFxWKX9nJuSwCQNI7fsodhQBKkxhoFuzflTSmpOkmgwRpWysSMS87joW
         pJkHovcoclTOcK62sl7pRObuCtizVnF0597O9NTa8qmm3/neW0nAm8KnYS+huYmRUzCM
         dveksAwufmS29q7/q3QNar/nQ/IwSs1ZbE66MOJCo7cNCn8r04K73UpR3SzGh61agNEj
         RDmA==
X-Gm-Message-State: ACrzQf1bPZiPxFoFd9+4Nne9h1aTvmLk9+5TYvVQy8h+Uvm+LTm9Fd+h
        1rzarUB6Wsfn9tLjY6sn6LTRDt3JFTvUBGuFgATlbQ==
X-Google-Smtp-Source: AMsMyM5PlsAdkYM7Hv6NTbG3Prb4EoPknhlg2TtlxfGkE9Y0vlB/NYqoumzLWAMVNZ6HIAtJpKMFAqBV2cv/+0kAmdA=
X-Received: by 2002:a17:907:62a1:b0:781:b320:90c0 with SMTP id
 nd33-20020a17090762a100b00781b32090c0mr22056168ejc.255.1665582664889; Wed, 12
 Oct 2022 06:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220928121934.3564-1-zhangjiachen.jaycee@bytedance.com>
In-Reply-To: <20220928121934.3564-1-zhangjiachen.jaycee@bytedance.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 12 Oct 2022 15:50:54 +0200
Message-ID: <CAJfpegsNeeuCoF8M9TuvG3YY_Tv1pgqasR5Av0xsa3jxsnJZqA@mail.gmail.com>
Subject: Re: [PATCH] fuse: always revalidate rename target dentry
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Tianci <zhangtianci.1997@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 28 Sept 2022 at 14:20, Jiachen Zhang
<zhangjiachen.jaycee@bytedance.com> wrote:
>
> The previous commit df8629af2934 ("fuse: always revalidate if exclusive
> create") ensures that the dentries are revalidated on O_EXCL creates. This
> commit complements it by also performing revalidation for rename target
> dentries. Otherwise, a rename target file that only exists in kernel dentry
> cache but not in the filesystem may result in an EEXIST.

"...will result in EEXIST if RENAME_NOREPLACE flag is used."

Applied with the above change.

Thanks,
Miklos

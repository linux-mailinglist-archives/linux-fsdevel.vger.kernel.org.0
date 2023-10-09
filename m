Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657827BD7B6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 11:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345863AbjJIJyA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 05:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346010AbjJIJx6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:53:58 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A5B94
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Oct 2023 02:53:54 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso789646666b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Oct 2023 02:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1696845233; x=1697450033; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4T7SYiMmv73e/6ApSex0rmCrWvfOhJoVCXxcz+wzbuc=;
        b=LbypXGSJuMOdTrznGNDHx6X+E7YEJdZR26t1jaHPV0Y+diLy8aqcUVVEg3HuW/B8TD
         Kfq1k1/o1GkB9VOhJAwYUkfvbPz/qn6cWfwE6chCTSYL5d4wixMKsUoy6XrXFj/IUQ1D
         a3q84J64bC96REGU3nh5nBmBewhmAONanIF/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696845233; x=1697450033;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4T7SYiMmv73e/6ApSex0rmCrWvfOhJoVCXxcz+wzbuc=;
        b=KAJvsapYkrp82PZJVMq+IpD0VCa/3VwfOpSq4QLAOLyJ1d59TNv9mAGfztnceqrTUL
         NMx3y8/G5QgQcfr9884wdV9OaDyyKze/nIvgDom7Il1XoPB59P8QyaiiHDbI+HH45pEE
         gkSBpEUhHWj/vEiF9xM5eLpDTdSwUSdA5hj+QQ2QLaIPHcfw6th1B2nvHN05Yi+babJ5
         aFidB9sexaTm8Ms+mmFat/ceY3nf997WBmioWKaen9Wuuveg07nw7tkmf1VUL/y4UQPv
         SO7MUqwnt+rnPSfDOC43zVt6TZFrdtvw4k1m71v7sM9PkVJNNZPrK2XOUDR6c+SMnw5n
         lEIQ==
X-Gm-Message-State: AOJu0YxLSgIEDzvgxwl4/mEUYxAeHWQ/R1K7J3ilT4nxrGSxX9UyqOET
        CKd4G/WhzUsd/qc6pUV1gT2EAmo9fRizOgNCrCvm/w==
X-Google-Smtp-Source: AGHT+IEgbSJiw0YRjct9A5M3oGPxrc3SeoYEiRYma6nvL+Ft3EmwrAayn12DJZbSu3u6DQb7E+y/HFiNukzI0BPBIjY=
X-Received: by 2002:a17:906:ce:b0:9a6:426f:7dfd with SMTP id
 14-20020a17090600ce00b009a6426f7dfdmr11590275eji.66.1696845233260; Mon, 09
 Oct 2023 02:53:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231005203030.223489-1-vgoyal@redhat.com>
In-Reply-To: <20231005203030.223489-1-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 9 Oct 2023 11:53:42 +0200
Message-ID: <CAJfpegspVnkXAa5xfvjEQ9r5__vXpcgR4qubdG8=p=aiS2goRg@mail.gmail.com>
Subject: Re: [PATCH] virtiofs: Export filesystem tags through sysfs
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        stefanha@redhat.com, mzxreary@0pointer.de, gmaglione@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 5 Oct 2023 at 22:30, Vivek Goyal <vgoyal@redhat.com> wrote:
>
> virtiofs filesystem is mounted using a "tag" which is exported by the
> virtiofs device. virtiofs driver knows about all the available tags but
> these are not exported to user space.
>
> People have asked these tags to be exported to user space. Most recently
> Lennart Poettering has asked for it as he wants to scan the tags and mount
> virtiofs automatically in certain cases.
>
> https://gitlab.com/virtio-fs/virtiofsd/-/issues/128
>
> This patch exports tags through sysfs. One tag is associated with each
> virtiofs device. A new "tag" file appears under virtiofs device dir.
> Actual filesystem tag can be obtained by reading this "tag" file.
>
> For example, if a virtiofs device exports tag "myfs", a new file "tag"
> will show up here.
>
> /sys/bus/virtio/devices/virtio<N>/tag
>
> # cat /sys/bus/virtio/devices/virtio<N>/tag
> myfs
>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Hi Vivek,

This needs something under Documentation/.

While the interface looks good to me, I think we need an ack on that
from the virtio maintainer.

Thanks,
Miklos

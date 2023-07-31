Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FB076A387
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 23:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjGaV6R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 17:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjGaV6O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:58:14 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F6FE8;
        Mon, 31 Jul 2023 14:58:13 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe110de46dso29448045e9.1;
        Mon, 31 Jul 2023 14:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690840691; x=1691445491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JW14MFDPt7O1rcxZlX3cjPvtcLYMaz4AwpOhoYK6iUw=;
        b=NoikV3xA1O/NOK72COlWGTe4BOUUrbAnvaSMxJnyaErguIfABUUDmVFL0Ow82LSF/t
         61OTPKrb8YnO0RQKXRQ0611KfYzRdXVGvLjA4Xjs7hurhUpAOx3hk3CZ6xwRv7hPqiRL
         6oPir5NA51VhlU2/utl9iABuVnWBZsTcGCsYo25fPwJxFlxr+fUF5nUnQXLQq3VYGq+Q
         W+hb2YpYga6Bmvpe4b/11q5EfKejbxyey5u4GfJBPJwrwOhhivqGygsK8rCUjB5E/z7J
         IHa5gPpVlZ6DCv2O4EW8BCoYhi8MMP/e1tC8J+4MmAOccCtzmp+uCsiHbd3NCjYyBuqs
         YrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690840691; x=1691445491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JW14MFDPt7O1rcxZlX3cjPvtcLYMaz4AwpOhoYK6iUw=;
        b=MTAsS06W7Thc6DZ41nE0n4HPHpON7HWovqYdwSYrZKk76grH22pV8sZvu0wAZkcB1z
         v8hioUAJWBF4JVH44xh0qgF5HdAUagOJeZOwA/oyaZQAZO+x77xCZHHgEkPtM2yp5t6Y
         2VAHDCeLTHvWp3JVtO9LzS037RX0xl6ex469GWrjzc+ScPSVBKf/m9WXO4Vi52sgotJj
         U0qvL0XITXHSFOZAeC6yQgjP0RV3LYxp3q9zUi/IFOz9tBUgF8XaQser7RJdudkVtdSk
         q+Hxmy1sIgkS5wJmlgiVAO3/UEquFawp0DDkCPMNvVm/1JARaGRj/gtHij6AHDTQ0ooB
         x2Eg==
X-Gm-Message-State: ABy/qLbZY4e1CrYgFttlRfU6wSt16LCR4qx56/RFhZy7ThTU7OY8dC5k
        sC5d6LG/mGnHc/e/cP17Fls=
X-Google-Smtp-Source: APBJJlFi0UY75YZJevKOpFRyWSmg2oW4GKvdcQMMibjE0tT9Qjx44yT4rtUcFE8PJ2qzc1bU//TrpA==
X-Received: by 2002:a7b:cc11:0:b0:3fe:1d34:908 with SMTP id f17-20020a7bcc11000000b003fe1d340908mr840278wmh.17.1690840691157;
        Mon, 31 Jul 2023 14:58:11 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c028800b003fb225d414fsm14945629wmk.21.2023.07.31.14.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 14:58:10 -0700 (PDT)
Date:   Mon, 31 Jul 2023 22:58:09 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>, Baoquan He <bhe@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v8 1/4] fs/proc/kcore: avoid bounce buffer for ktext data
Message-ID: <27ad89fe-1b69-4d62-916f-d494b32c8ddf@lucifer.local>
References: <fd39b0bfa7edc76d360def7d034baaee71d90158.1679566220.git.lstoakes@gmail.com>
 <ZHc2fm+9daF6cgCE@krava>
 <ZLqMtcPXAA8g/4JI@MiWiFi-R3L-srv>
 <86fd0ccb-f460-651f-8048-1026d905a2d6@redhat.com>
 <f10f06d4-9c82-41d3-a62a-09c62f254cfc@lucifer.local>
 <32b8c5e4-c8e3-0244-1b1a-ca33bd44f38a@redhat.com>
 <b8b05bb6-3d23-4e90-beb0-a256dbc32ef2@lucifer.local>
 <ZMgazd69Dj6Idy6H@krava>
 <ZMgjqJycJFsgvWOD@murray>
 <ZMgsnkax+SAt1zbl@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMgsnkax+SAt1zbl@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 31, 2023 at 11:50:22PM +0200, Jiri Olsa wrote:
> > Ummmm what? I can't! What repro are you seeing on x86, exactly?
>
> # cat /proc/kallsyms | grep ksys_read
> ffffffff8151e450 T ksys_read
>
> # objdump -d  --start-address=0xffffffff8151e450 --stop-address=0xffffffff8151e460 /proc/kcore
>
> /proc/kcore:     file format elf64-x86-64
>
> objdump: Reading section load1 failed because: Bad address
>
>
> jirka

Locally I don't see this issue. How odd. The bug doesn't manifest as a 'bad
address' in the arm64 repros either. I wonder if this is something unrelated...

In any case I have a candidate fix for the bug at
https://lore.kernel.org/all/20230731215021.70911-1-lstoakes@gmail.com/ which
should hopefully address the underlying issue with minimum change.

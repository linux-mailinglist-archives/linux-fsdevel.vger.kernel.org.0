Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CDB786671
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 05:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbjHXD6E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 23:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240221AbjHXD50 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:57:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6B91FEB;
        Wed, 23 Aug 2023 20:56:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A0326313A;
        Thu, 24 Aug 2023 03:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FB3C433CA;
        Thu, 24 Aug 2023 03:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692849357;
        bh=f2MaMPDKau4stYbi7cF7voUFa5rnept8FYUDhQEpDjk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kCLPKRO3vG/kuskcO78aF4I2B+ZHsVDyhx4pglVcybTlSRpTye+rjGFamSLTzVRYO
         EPncaOZmEd0Fwju5Ltvpf9oUa3MrVhaqAq03GY4G6tSyPn/0iomgWmU4zn8Bp6ronS
         /EltsMz8pT0bvxVqHXHcZC2sawSeu7lDQoAn3puyt7NhGolHvAvrqvXmxtlJYeqQqG
         Rsy+jwbp0W8VfEE3cp06B0X1Cwm5eb4WY8kq0RlCXi4EkUqVexiuRvM/VJWkDPxOlL
         7RfD7OL6eB3hsl8vMlrrxDFDQh8+PXnfRrNOrIhEhHm6hMpk515ADUwbSfjI0vw0jw
         M8ZoETD2Et57g==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4fe1b00fce2so9700074e87.3;
        Wed, 23 Aug 2023 20:55:57 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzvg7juYH+Q7Z8AaVB39djcYvoEQalyG8+AyZs/TzfJckApfWky
        0pNUxI1Nzyvpo1ezBj9M5+ZtYMblEydb7k2QBmI=
X-Google-Smtp-Source: AGHT+IHuPZ7LQJYjDMh9tonSINdmDBfMCDY6LWrqBjg7Q97XRVSQa1B8RpocHaT6h5lvN+tGGshVdDO1BJNhwZf8398=
X-Received: by 2002:a05:6512:3241:b0:4fe:25bc:71f5 with SMTP id
 c1-20020a056512324100b004fe25bc71f5mr8521870lfr.11.1692849355644; Wed, 23 Aug
 2023 20:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com> <20230824034304.37411-26-zhengqi.arch@bytedance.com>
In-Reply-To: <20230824034304.37411-26-zhengqi.arch@bytedance.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 23 Aug 2023 20:55:42 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4Tp3XPF349q8-BcEpaNSn23Rp10Wba=uoKy6Xtix29Gw@mail.gmail.com>
Message-ID: <CAPhsuW4Tp3XPF349q8-BcEpaNSn23Rp10Wba=uoKy6Xtix29Gw@mail.gmail.com>
Subject: Re: [PATCH v5 25/45] md/raid5: dynamically allocate the md-raid5 shrinker
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 23, 2023 at 8:47=E2=80=AFPM Qi Zheng <zhengqi.arch@bytedance.co=
m> wrote:
>
> In preparation for implementing lockless slab shrink, use new APIs to
> dynamically allocate the md-raid5 shrinker, so that it can be freed
> asynchronously via RCU. Then it doesn't need to wait for RCU read-side
> critical section when releasing the struct r5conf.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> CC: Song Liu <song@kernel.org>
> CC: linux-raid@vger.kernel.org

LGTM!

Reviewed-by: Song Liu <song@kernel.org>

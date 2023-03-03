Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A1B6A9E4A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 19:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjCCSRI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 13:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjCCSRG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:17:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF6E126D5;
        Fri,  3 Mar 2023 10:17:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 442A4618C8;
        Fri,  3 Mar 2023 18:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1E8C433EF;
        Fri,  3 Mar 2023 18:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677867423;
        bh=z9o+Fj7F9hEekeJkNgNCjr/Inru7KzeAHF1ZoYV9Iio=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fGnupNl/GToRAtlMLq9m8ln/B5DL44++CWBlS1wMXnhq2cHhCoiWQpag4X05/OiJd
         s+p3PX7NvYBFBoFJnwt68FNzmZwUfxHGHvpKaW0etLYAT+E3VksbmVZbwNcj00kbix
         l9BEGRabR2FaOcP0r2SQvznMAviaOVz3EkGqaoxUXFpvaR+EFpp8VmrAxLFnHW9Omg
         85lhunN9jTFzSqc3gNCLlaviCh526S0Bpfr2Oeao6Ud/QzQdGsgd6tAin5Hqrsi2iI
         ifBaA922aUhZicKDUUrEHd2NsgXm9V4xJZsDgBDrc/9TY/OrtG/vUQOaJ6lm7ZmCgz
         H8fe0MXisTGyg==
Received: by mail-ed1-f49.google.com with SMTP id o15so13624050edr.13;
        Fri, 03 Mar 2023 10:17:03 -0800 (PST)
X-Gm-Message-State: AO0yUKX6oDaimFGkd/7+u+2WA7Pa4jU2XZPWHxiajjjauSVMEoJMLBGv
        XKTmZeEcKwXwxhqbYL8a9ttEhuU2FPDXWEmfA6g=
X-Google-Smtp-Source: AK7set8+TKohTy6ON4qynrd6qM7FwtWsRtV8zfmEmFF5syO7UhwA/Y8VS4hyO7ZdSGW9G+CTTREWUsKalOtJ4y3BnUw=
X-Received: by 2002:a05:6512:3c83:b0:4d8:86c2:75ea with SMTP id
 h3-20020a0565123c8300b004d886c275eamr3273736lfv.3.1677867401669; Fri, 03 Mar
 2023 10:16:41 -0800 (PST)
MIME-Version: 1.0
References: <20230302204612.782387-1-mcgrof@kernel.org> <20230302204612.782387-5-mcgrof@kernel.org>
In-Reply-To: <20230302204612.782387-5-mcgrof@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 3 Mar 2023 10:16:29 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4k1hpLDWcQGCtEeR6LEgSboTY+tqbiPp+30_2T+rFezw@mail.gmail.com>
Message-ID: <CAPhsuW4k1hpLDWcQGCtEeR6LEgSboTY+tqbiPp+30_2T+rFezw@mail.gmail.com>
Subject: Re: [PATCH 4/7] md: simplify sysctl registration
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, minyard@acm.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, robinmholt@gmail.com, steve.wahl@hpe.com,
        mike.travis@hpe.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, jgross@suse.com, sstabellini@kernel.org,
        oleksandr_tyshchenko@epam.com, xen-devel@lists.xenproject.org,
        j.granados@samsung.com, zhangpeng362@huawei.com,
        tangmeng@uniontech.com, willy@infradead.org, nixiaoming@huawei.com,
        sujiaxun@uniontech.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 2, 2023 at 12:46 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> register_sysctl_table() is a deprecated compatibility wrapper.
> register_sysctl() can do the directory creation for you so just use
> that.
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Acked-by: Song Liu <song@kernel.org>

Thanks!

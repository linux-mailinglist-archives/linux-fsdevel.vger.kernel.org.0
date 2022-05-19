Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4D252D3AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 15:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238540AbiESNN6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 09:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238086AbiESNNx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 09:13:53 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BFCC6E5F
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 06:13:51 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id tk15so9876506ejc.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 06:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ABD0ZCZzk6/rDV7fRx/jwgpu1GPtQwsEFN4C6UN6MEo=;
        b=q3grboCQq6GN18wZpshIHKTxPmmbScxb0uN9zgqSQzBNHBnGWd4JhKgVaY5/sT3MID
         1OuA4xXvLa9davt3/26E8OP+x+nad0SFYrj6UWRHt0FAuoOT0arDSj7NFT8/vzMCDY6s
         cENvjNurbAV9y0TJ7h06b9QrNhUrVn3urB5WU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ABD0ZCZzk6/rDV7fRx/jwgpu1GPtQwsEFN4C6UN6MEo=;
        b=A4u9hbIU79Zat+Cn8OzbUtYyA2gEqasnYzPnUpdo9oXMWCsoVfCPvn74v/TlqPuKyY
         SmdXCgZyCVma3lElikNhTbO9QuewaRrltW96uHFTz5LTHjRinHk/wwtGCcChsec/0Bor
         VVRaLWhVVH7cE8AMyOabxrZAYZ8JeXB8/vmfzpsv00jEKR1oU9VbPFeVHK0H4Uq9umPO
         5QnAJHf3+YsYhqfn4IoFVCQuI85EgWFOannrEWOtQrSoWOPA0HPkCjL7RMESKWBX6IH0
         gk3yk85gQoGZ+G3pxG5URZGYrY13YegiNiO9m8Be9WUWh4tuc55YwgUL7Y9/EqrIiHov
         7bsg==
X-Gm-Message-State: AOAM532DG9Pkmm/dmng8I7eWD0+oGgPmALcRMpOULn6kiShJaLi2N1UU
        8ZEjT8clbC+t91QISTSgyXzn3r2DT3xtjEJvZukqwA==
X-Google-Smtp-Source: ABdhPJxB1NaudJ/GbhumUoLIwywBx8UlXQvhtgTCLbpiR08KfQyoCq62oz080Dkju6g7pJM9SsQSqzfuHaE0n8C9oII=
X-Received: by 2002:a17:906:58d1:b0:6f4:6e61:dae with SMTP id
 e17-20020a17090658d100b006f46e610daemr4231902ejs.468.1652966029810; Thu, 19
 May 2022 06:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220517100744.26849-1-dharamhans87@gmail.com> <CAJfpegsDxsMsyfP4a_5H1q91xFtwcEdu9-WBnzWKwjUSrPNdmw@mail.gmail.com>
In-Reply-To: <CAJfpegsDxsMsyfP4a_5H1q91xFtwcEdu9-WBnzWKwjUSrPNdmw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 19 May 2022 15:13:38 +0200
Message-ID: <CAJfpegvpdms4QpecBWyu88mpKRcofDFLVtRQbcRs+4RiNoM6Ug@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] FUSE: Implement atomic lookup + open/create
To:     Dharmendra Singh <dharamhans87@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 19 May 2022 at 11:39, Miklos Szeredi <miklos@szeredi.hu> wrote:

> Apparently in all of these cases we are doing at least one request, so
> it would make sense to make them uniform:
>
> [not cached]
>    ->atomic_open()
>       CREATE_EXT
>
> [cached]
>    ->d_revalidate()
>       return 0

Note to self:  invalidating a valid positive dentry would break things.

Revalidation would need to be moved into ->atomic_open(), which is a
bigger surgery.  Oh well...

Thanks,
Miklos

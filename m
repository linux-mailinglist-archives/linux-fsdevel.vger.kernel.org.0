Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C74582327
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 11:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiG0JcP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 05:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiG0JcN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:32:13 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE01192A7
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jul 2022 02:32:10 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z22so20639769edd.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jul 2022 02:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pDxU8UpTzIwC16C1Npz7pNPhe0tD3l3qzIZ1ONOmOR4=;
        b=NeR96LvHqZ4iiknwkBuU1u7f6VpIPcxOlNjDmhTTE13tFIrwW1ooRsTz3eqVihjsyc
         3eAZu96HSAb+QSXpsLzFY/XbevcakwU3HospbNRqWamftyFqJ9rJUq7bokpML3GHzzYI
         J/RgaW3DRCBmVFGpG7D1IlGH0KS4EmS0DsZwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pDxU8UpTzIwC16C1Npz7pNPhe0tD3l3qzIZ1ONOmOR4=;
        b=Azm/GCdtwhmdcI6wPBy2IdzcD1tHw8eVEOsE0YycRjQ0DrL0WAj7eBP9dOVaeqS6+L
         BfW7Bhw5pYbprZNazAsowF/wkBWBL4Gkrl0ATHePy6ac61i5DV6TeQJGCD0vEeat2CwP
         0l317wGz7J6yABrIAs+qSoBXItIx8m1ipcx/b8YoheGJgm0xp2eBKhehdz38nVP3ganS
         QMwSvjfuav7/dcl/GD9eSkzcFcofKzIVbrl7OpVFRTIvwlJOe5KshpTz5qEpRx68XajN
         Mju+nBkNDcEBOIr6PU/xNUiaI7H/Ps+eUPIFxt3dtHDkgGN/zdnl2iGj5ycgQsIpxGN2
         hCQw==
X-Gm-Message-State: AJIora8p6CxbPHEwfHkLLpStkxHsWfGzmyiT8WJKum1J/v5rbcNoCHoo
        Vf2jA5WKW8ClzBciTpIpFYhrZWmiNZeVQD/e9i2IuA==
X-Google-Smtp-Source: AGRyM1tJ8HEDSa4exKeP0jeZ8ob6/irEJZGScgGGiNY/DmF9Cae3HXrXiVrDHvSw2pqtwtxp5E9OZ3rP1Mmkszoy/rI=
X-Received: by 2002:a05:6402:e96:b0:43a:f21f:42a0 with SMTP id
 h22-20020a0564020e9600b0043af21f42a0mr22730535eda.382.1658914328760; Wed, 27
 Jul 2022 02:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220727064425.4144478-1-dlunev@chromium.org>
In-Reply-To: <20220727064425.4144478-1-dlunev@chromium.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 27 Jul 2022 11:31:57 +0200
Message-ID: <CAJfpegvN8vKVMqqBYX+WyYKSEC5y5avTZ2qCUvJGjBDAHBUUEw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Prevent re-use of FUSE block-device-based
 superblock after force unmount
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 27 Jul 2022 at 08:44, Daniil Lunev <dlunev@chromium.org> wrote:
>
> Force unmount of fuse severes the connection between FUSE driver and its
> userspace counterpart. However, open file handles will prevent the
> superblock from being reclaimed. An attempt to remount the filesystem at
> the same endpoint will try re-using the superblock, if still present.
> Since the superblock re-use path doesn't go through the fs-specific
> superblock setup code, its state in FUSE case is already disfunctional,
> and that will prevent the mount from succeeding.

Applied, thanks.

Miklos

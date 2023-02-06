Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4F468C6D4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Feb 2023 20:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjBFTcb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 14:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBFTca (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:32:30 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4679535A2
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Feb 2023 11:32:29 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id dr8so37209529ejc.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Feb 2023 11:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/2ldZJ25PDZXwhJ16vO/80H+7cdh/CqtwC42vZviYQ=;
        b=qKBtRH5Teac8nFUMoHFLxSqtrrpPDPleOTN2RvPuzW4R1MfxwXyhZqo3rhc9BK7xIF
         /6U5clXoJhabWCaiozvN50Wa0sGeU7LR7F6QQUr9zMYDTbd+oIi/MlguNhPW83y+DZs+
         Y3UXLQXDFF6PQODMbDidFoPJ/dsfcnkCznNZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/2ldZJ25PDZXwhJ16vO/80H+7cdh/CqtwC42vZviYQ=;
        b=B5ncom/V914oJgM7D4ECvB6ZkHiOzfA1zDZeYnzZrAt7AQC9iCXTZgJYkqmpGpLuNw
         ByUwLk9tf3PH1z8GZUyahUklF+nRVxtiDE3Lt97EV163KqVgBKrrXrEd5o5Xr2EGRadR
         jz45RynMmod9mkdRWlMhD4fK2TNNMF7AJEG1hkiXE0RTW4UHP80OE3EZzsKp23NpjQVD
         BNREBW2BiFNcr2L8GtT59gOBn/UObJG0V0Pv012hZN5tmAsSsf0Ek8YVBRl3r2GD7zhj
         JdjYu3U8nRfo4IDWEkC2K5HHuFHLoGUzm8WTAKW6r8VcP+hqhoSj5que7stG3xP6YZl1
         xWfg==
X-Gm-Message-State: AO0yUKU49MxmiMjn4ydP4gKlZAgj8upCSCkqc44IFSCagNduqDJ5aSq7
        FYhCb0wZ2KeIE1ZalGjOzfJl7oYZP6m84a1XdAuD3w==
X-Google-Smtp-Source: AK7set8ET2HF0RB/HxTmY7RtA1k9SmP6VqIvZdhbv3JFGi1V/ewnfNaUCnezESzTlAKclqA4CzyQIOW4xvur0LsJzgs=
X-Received: by 2002:a17:906:7242:b0:889:a006:7db5 with SMTP id
 n2-20020a170906724200b00889a0067db5mr153916ejk.138.1675711947888; Mon, 06 Feb
 2023 11:32:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674227308.git.alexl@redhat.com> <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
 <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
 <b8601c976d6e5d3eccf6ef489da9768ad72f9571.camel@redhat.com>
 <e840d413-c1a7-d047-1a63-468b42571846@linux.alibaba.com> <2ef122849d6f35712b56ffbcc95805672980e185.camel@redhat.com>
 <8ffa28f5-77f6-6bde-5645-5fb799019bca@linux.alibaba.com> <51d9d1b3-2b2a-9b58-2f7f-f3a56c9e04ac@linux.alibaba.com>
 <071074ad149b189661681aada453995741f75039.camel@redhat.com>
 <0d2ef9d6-3b0e-364d-ec2f-c61b19d638e2@linux.alibaba.com> <de57aefc-30e8-470d-bf61-a1cca6514988@linux.alibaba.com>
 <CAOQ4uxgS+-MxydqgO8+NQfOs9N881bHNbov28uJYX9XpthPPiw@mail.gmail.com>
 <9c8e76a3-a60a-90a2-f726-46db39bc6558@linux.alibaba.com> <02edb5d6-a232-eed6-0338-26f9a63cfdb6@linux.alibaba.com>
 <3d4b17795413a696b373553147935bf1560bb8c0.camel@redhat.com>
 <CAOQ4uxjNmM81mgKOBJeScnmeR9+jG_aWvDWxAx7w_dGh0XHg3Q@mail.gmail.com>
 <5fbca304-369d-aeb8-bc60-fdb333ca7a44@linux.alibaba.com> <CAOQ4uximQZ_DL1atbrCg0bQ8GN8JfrEartxDSP+GB_hFvYQOhg@mail.gmail.com>
 <CAJfpegtRacAoWdhVxCE8gpLVmQege4yz8u11mvXCs2weBBQ4jg@mail.gmail.com>
 <CAOQ4uxiW0=DJpRAu90pJic0qu=pS6f2Eo7v-Uw3pmd0zsvFuuw@mail.gmail.com>
 <CAJfpeguczp-qOWJgsnKqx6CjCJLV49j1BOWs0Yxv93VUsTZ9AQ@mail.gmail.com> <CAOQ4uxg=1zSyTBZ-0_q=5PVuqs=4yQiMQJr1tNk7Kytxv=vuvA@mail.gmail.com>
In-Reply-To: <CAOQ4uxg=1zSyTBZ-0_q=5PVuqs=4yQiMQJr1tNk7Kytxv=vuvA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 6 Feb 2023 20:32:16 +0100
Message-ID: <CAJfpeguq2BH_4WQDb=eGkoVGOUVhNhMRicT4b_PN-t6FTBFUoQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Larsson <alexl@redhat.com>, gscrivan@redhat.com,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@fromorbit.com,
        viro@zeniv.linux.org.uk, Vivek Goyal <vgoyal@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 6 Feb 2023 at 18:16, Amir Goldstein <amir73il@gmail.com> wrote:

> it's not overlay{erofs+erofs}
> it's overlay{erofs+ext4} (or another fs-verity [1] supporting fs)
> the lower layer is a mutable fs with /objects/ dir containing
> the blobs.
>
> The way to ensure the integrity of erofs is to setup dm-verity at
> erofs mount time.
>
> The way to ensure the integrity of the blobs is to store an fs-verity
> signature of each blob file in trusted.overlay.verify xattr on the
> metacopy and for overlayfs to enable fsverity on the blob file before
> allowing access to the lowerdata.
>
> At least this is my understanding of the security model.

So this should work out of the box, right?

Thanks,
Miklos

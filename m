Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AB068D152
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 09:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjBGINd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Feb 2023 03:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBGINa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Feb 2023 03:13:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA94237F01
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Feb 2023 00:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675757556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EpmSrtgFfbQ+TZ4qkvh9qoMoUozMirL90dqOtbhTOC8=;
        b=KKiCZ1wIwr/AfnbWosKbwEjRfCIKZxwIxW+bi/FV9TWkvF8OPwT0oyPVgyQWj2r3yA3FQX
        gwx9Wg5Y7EDYCw+X2kb1WTQkmsUpC1bHry/Zes2E/ZT9dxa1E+XU2K90iJYVVuzjfF/uOF
        J+MyJjXYT6KNNcJUxbh0t1+wn/LS188=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-491-EqEwXKJYPVS_yAZpAroUqA-1; Tue, 07 Feb 2023 03:12:35 -0500
X-MC-Unique: EqEwXKJYPVS_yAZpAroUqA-1
Received: by mail-il1-f199.google.com with SMTP id p18-20020a92d692000000b00313bc1cbec3so4722244iln.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Feb 2023 00:12:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EpmSrtgFfbQ+TZ4qkvh9qoMoUozMirL90dqOtbhTOC8=;
        b=rqr4m4X3fHab41Cg60OVodBJ++OZA5Fu7V1sdnls8I6IQ25gk7v1js9Kbcre83GgX9
         Pl5/+vnZfixM2+oUcF3hqUJuTPsAIdq6P1IUUK7cbQ6PrKZBQqrKzgIC9LIOM4wceD07
         /tgeIUfbepW7rlNBUOcUvX1sqlfnclLttcHlUO8zAAMrF+Z6fkeSAyHLD3M4Qh5xe8FZ
         1veOOnFEzVl1JglAZf4q3u5OyO2VgztzNNfV7pQN0Lxwfyra7w0Ouvd2xrQYgZHx2qtR
         q7+3sQWGxUc+jymhKqh5JTuKmdjOTPphLNmfkth4yH8ro6SZmom+5FMGbIEtiRyLUuOG
         XvOg==
X-Gm-Message-State: AO0yUKWcpa7U1WJQfcUC+zsZBOwoX3W9pxuZG5AbwDrn26mdw5Ss6o+v
        BYoWhkn5RrBIQNRjwjdlKWCA37v3fssxWhPyPWnYCa7eqkV9rcvftB8FiNpKe4kYkqYV+BC6NIN
        pQXzkYsYZcX/k230CBNLnbyltp9i705fY0qCg9JSPsQ==
X-Received: by 2002:a05:6638:e86:b0:3b0:2509:603 with SMTP id p6-20020a0566380e8600b003b025090603mr1821956jas.77.1675757553920;
        Tue, 07 Feb 2023 00:12:33 -0800 (PST)
X-Google-Smtp-Source: AK7set8TRRXEr3GWBL30sB7Icjl6s/wrjdDAmQAflqIZcxc5vHOQr/NfFdiyMhNN1KfmIid3bojH15ljukDU7szJ/GA=
X-Received: by 2002:a05:6638:e86:b0:3b0:2509:603 with SMTP id
 p6-20020a0566380e8600b003b025090603mr1821943jas.77.1675757553710; Tue, 07 Feb
 2023 00:12:33 -0800 (PST)
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
 <CAJfpeguczp-qOWJgsnKqx6CjCJLV49j1BOWs0Yxv93VUsTZ9AQ@mail.gmail.com>
 <CAOQ4uxg=1zSyTBZ-0_q=5PVuqs=4yQiMQJr1tNk7Kytxv=vuvA@mail.gmail.com>
 <CAJfpeguq2BH_4WQDb=eGkoVGOUVhNhMRicT4b_PN-t6FTBFUoQ@mail.gmail.com> <CAOQ4uxhHnvznz_wN7OdaYeF0WSMV-S87Az4uLRoREPe8oTM8eQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxhHnvznz_wN7OdaYeF0WSMV-S87Az4uLRoREPe8oTM8eQ@mail.gmail.com>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Tue, 7 Feb 2023 09:12:21 +0100
Message-ID: <CAL7ro1H-g27GKNg8fC-mS4H-G-Zsowtut+bNMCqt3P7Bv7yteg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, gscrivan@redhat.com,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@fromorbit.com,
        viro@zeniv.linux.org.uk, Vivek Goyal <vgoyal@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 6, 2023 at 9:06 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Feb 6, 2023 at 9:32 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Mon, 6 Feb 2023 at 18:16, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > > it's not overlay{erofs+erofs}
> > > it's overlay{erofs+ext4} (or another fs-verity [1] supporting fs)
> > > the lower layer is a mutable fs with /objects/ dir containing
> > > the blobs.
> > >
> > > The way to ensure the integrity of erofs is to setup dm-verity at
> > > erofs mount time.
> > >
> > > The way to ensure the integrity of the blobs is to store an fs-verity
> > > signature of each blob file in trusted.overlay.verify xattr on the
> > > metacopy and for overlayfs to enable fsverity on the blob file before
> > > allowing access to the lowerdata.
> > >
> > > At least this is my understanding of the security model.
> >
> > So this should work out of the box, right?
> >
>
> Mostly. IIUC, overlayfs just needs to verify the signature on
> open to fulfill the chain of trust, see cfs_open_file():
> https://lore.kernel.org/linux-fsdevel/9b799ec7e403ba814e7bc097b1e8bd5f7662d596.1674227308.git.alexl@redhat.com/

Yeah, we need to add an "overlay.digest" xattr which if specified
contains the expected fs-verity digest of the content file for the
metacopy file.
We also need to export fsverity_get_digest for module use:
https://lore.kernel.org/linux-fsdevel/f5f292caee6b288d39112486ee1b2daef590c3ec.1674227308.git.alexl@redhat.com/

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D8578AF6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 14:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjH1MC1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 08:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjH1MBz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:01:55 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A30D120
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 05:01:52 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9936b3d0286so420922566b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 05:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1693224111; x=1693828911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rWh7froRuFsEZu5GGYQ0ZieEkdzmRXh5lFFZo26gQyk=;
        b=h7CroPH0QCwV1MzQIbWdNu+joFIS28MDF9W58t96ePqb4Vj7jLNqYIkec5ByK2/vWI
         gYvvBgTNNWdYxBLiVLqkSNRAVI5e86snBPYAN1vY9YHjpMwJ4Sws1EQuWOhuLRBDLnYO
         dQfIiyJattFbm2/RXJyU7TP4I9C1hhKp1uIjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693224111; x=1693828911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rWh7froRuFsEZu5GGYQ0ZieEkdzmRXh5lFFZo26gQyk=;
        b=HriKFjDzTLxpINNq/amWP2panjzRMlTzRG5YDRy3/iPLu9L1NmmhLjDBl+LTxcctbc
         FSvzHx/7zCjAUjSx1DpVE1V4L9x/rJM1sVd/5G6f2g3aHiUUItliFtuFC9DY7iG0rX2H
         a0zgq5yQh8UcoCw+HfWBQph7TAIWOvSihkJXbC0qdjDOysCasoxFdfWTVpvou0lHzkq4
         hbT7qPnxCsYmaEUnxRVRHUTLzkr6IAXWU16QUFBvQDm869WRVahtdo/6g14GJ12Bliy5
         aLNilSkC+mVZU9pgnQF8h7IQowHaXM9JulmHdnYr4A3V3odmTZPn9wVnEeIEA3q6Lkc/
         x1AA==
X-Gm-Message-State: AOJu0Yy7gSxVsZ7ghhjGqicMi95xMU0j3GL54VLIzgVMQ/xAH+PDvphD
        NZmb9xB4vm1/3zVjRD5ELYDajbiQ4YG1TybyTBs4lg==
X-Google-Smtp-Source: AGHT+IFs5WUBE5wq621GBfzL6kdWy/b4T24X4KNHl9LYys184EJt87m80l0dmjPSEYsnth4sWJ9tCAGYeDpOCwC2c9k=
X-Received: by 2002:a17:906:535d:b0:9a2:1df2:8e08 with SMTP id
 j29-20020a170906535d00b009a21df28e08mr7270072ejo.45.1693224111078; Mon, 28
 Aug 2023 05:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230824150533.2788317-1-bschubert@ddn.com> <20230824150533.2788317-6-bschubert@ddn.com>
In-Reply-To: <20230824150533.2788317-6-bschubert@ddn.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 28 Aug 2023 14:01:39 +0200
Message-ID: <CAJfpegvQpnAOCO9yVyRg6J7uCH6Pj_nwG8+1uAwSV-1kkVW1Ow@mail.gmail.com>
Subject: Re: [PATCH 5/5] fuse: Remove page flush/invaliation in fuse_direct_io
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        dsingh@ddn.com, Hao Xu <howeyxu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 24 Aug 2023 at 17:07, Bernd Schubert <bschubert@ddn.com> wrote:
>
> Page flush and invalidation in fuse_direct_io can when FOPEN_DIRECT_IO
> is set can be removed, as the code path is now always via
> generic_file_direct_write, which already does it.
>
> Cc: Hao Xu <howeyxu@tencent.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Dharmendra Singh <dsingh@ddn.com>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

Thanks,
Miklos

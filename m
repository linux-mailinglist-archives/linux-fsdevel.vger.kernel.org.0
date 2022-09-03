Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878F55AC02C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Sep 2022 19:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiICRio (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Sep 2022 13:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiICRiX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Sep 2022 13:38:23 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F88543FD;
        Sat,  3 Sep 2022 10:38:18 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id b19so5232784ljf.8;
        Sat, 03 Sep 2022 10:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=XIAWHihpR6QwqgJNOUnH9+J9hxcC7HnY/D9h72CaivA=;
        b=iwt/wbMtnp/q0jVwHZiE00ed484O19jfhyipFrnvrNDTORiNZ1YXFxifJnNfs+VIu9
         ZTzJdY3uSO7qeUpTw2k1eYh0iMaaR6rQ8FuxoMwtiryw0IEKTNIkNHct1rD+slZ4Tw3r
         2OJU6WtHfNa9JKbDME7ah4hIZPU0j1jGPO6PMrWVJGeSkDHa//D/ignX3illfN2ha+TJ
         H+1EyPYXY67aUIRp/z/7mkQ/sL95sVYevI1LF1OzGgAjd0Pv/Gsr8c9VZ3+AuDk1sG2J
         r1O9wMojCiVxZphiPxfZs3xs1ZBF71kfoIwvvHBoqJxzYkmzLzcX+xnqdBb0Y9xkMCKf
         tUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=XIAWHihpR6QwqgJNOUnH9+J9hxcC7HnY/D9h72CaivA=;
        b=Nu+zhDqCmhMi9VPTwHh+HSK9AagjIffWUt4jptm83BIqLfWgD0uNTRgQX+2MfrCEpV
         4MVrFq5zRcArzk5rEaFFE9QQivLs2MT0H1lUjrHRLHu0qFy8+IFxGOhFnnv+ZZc/2yHm
         zSVqTK/L9Nd47gMysYIaQge0a8WXYq7TrU393VUDaaK/nKrqhiYdYtZae3eBr5fEtXet
         ULcCBBtYWcV7sLaQdf3Uf2pM/effx5TjXEd/Xde4OjMjh7xb3mLAPUq1DDt3MpblWKKd
         A3a55eG9/CCRtJsfrx+g93tfw1bXhQRPpaXfLu/9Yw4nU0xYv/50Er1G5SiuIeGTHJFx
         Sh6Q==
X-Gm-Message-State: ACgBeo3geEm1jnEreFmsuNN2vLvKzg0MWvTjMsv92WnecBifnznsvjPK
        pHT1OUjxEnDXwxUz/Tw2S+JuAQIORoiONNrovko=
X-Google-Smtp-Source: AA6agR40XmT8zh4h31HtNMSrlBjKkdISLmyOpZLVSDQyaRAj4ei/rdAVMIwBkrqkTVTS5Uf2en5n9Pvu5S7dwteMLrc=
X-Received: by 2002:a2e:508:0:b0:263:32c3:9a32 with SMTP id
 8-20020a2e0508000000b0026332c39a32mr9959731ljf.315.1662226697047; Sat, 03 Sep
 2022 10:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220901220138.182896-1-vishal.moola@gmail.com> <20220901220138.182896-23-vishal.moola@gmail.com>
In-Reply-To: <20220901220138.182896-23-vishal.moola@gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sun, 4 Sep 2022 02:38:00 +0900
Message-ID: <CAKFNMokhm5TTVn7yGEtwchpb5rk5pur6zog-uCWZGQJmAupoVQ@mail.gmail.com>
Subject: Re: [PATCH 22/23] nilfs2: Convert nilfs_clear_dirty_pages() to use filemap_get_folios_tag()
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 2, 2022 at 7:14 AM Vishal Moola (Oracle) wrote:
>
> Convert function to use folios throughout. This is in preparation for
> the removal of find_get_pages_range_tag().
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  fs/nilfs2/page.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi

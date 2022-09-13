Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE005B64ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 03:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiIMBJa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 21:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiIMBJ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 21:09:28 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6DD1EE;
        Mon, 12 Sep 2022 18:09:26 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id j17so3418575vsp.5;
        Mon, 12 Sep 2022 18:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=/XsoyqrT3QB1JAOnynnNk+cD1xAIdvUlxSJ4ed6XIdU=;
        b=LCh/26aAbGHkKGewKjn73gLlX++zCf8OLBwVxFWLa64tYPDq/i2er1PmrVmMkGAwOI
         L2JRUzDqv2lK9NaVniFYm7FpYuNBfqGBIhKFyEiUvFh3AU/Pe1+xUEezdDuC7oEtVTzK
         z4RnpgRLFEs/kpx/XTpDhcz1YZja3m4TBuvwqk20rCqQfNxg0OTn6cKh89klQ8JdP/d5
         mnV6dtRYDuEjIzD+gV8Sy+Z00atObjJcdT1rQhqSoQ9ZBHA1slMzLmqb42wvp3Fbbjrj
         PcbYe5zgwlygD5zetriqBhKy83A9Y3Tj1nqXRBKeJ829uuOZ6L5Y1UNj+nuZ18uhaFr1
         0FCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/XsoyqrT3QB1JAOnynnNk+cD1xAIdvUlxSJ4ed6XIdU=;
        b=smhry8Ohh3CAsDJCIuHX+g+kEYZDpKnGLPG5ueYx2dpA4FDu/7n8YoCNXJJi+9Cslh
         sW64GTrh+lr/Pg0w23sgSAsF2RF8P0b3SAi9SV+8olqk4wPGru6G9gnfylRX5flnxfDo
         R35kq0wsskD6fD9qkwaikUBV79617SETWliJMP9T+BiYJjqukD17LazLeUI4q90An0IS
         ha9UkUclefFpZF07ZgzpguRfCfypVgRLQZqQDjmqO9iQAfiXHbgmcrplzUrf53JgrLAc
         EFerFmJ31Pn+oK6ksIW3KmvFxM0RNsjWI7z0gZUfba3Is8YPLXtP9FnnyNv+mlLeySxY
         0wNg==
X-Gm-Message-State: ACgBeo0DVuYcr56hjzjG/0oHzgklLQJKgLhtdQCp/8pA8r8wbwP8e4T8
        esqBGmFONurv/6HOrZZKfVTof0YHkb5LEsMTIGJhCL0DnPnQyw==
X-Google-Smtp-Source: AA6agR4EqnqQ8u4MAgskdLzYc7FBqMGiJOS2HCVnpmnuXUvK+QJK2TMCY2lWLmDeQ8q/znqGKGcFd82tz2HFf86kF7E=
X-Received: by 2002:a05:6102:5709:b0:390:e360:88e8 with SMTP id
 dg9-20020a056102570900b00390e36088e8mr9131856vsb.22.1663031365543; Mon, 12
 Sep 2022 18:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220912182224.514561-1-vishal.moola@gmail.com> <20220912182224.514561-19-vishal.moola@gmail.com>
In-Reply-To: <20220912182224.514561-19-vishal.moola@gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Tue, 13 Sep 2022 10:09:08 +0900
Message-ID: <CAKFNMokZ02Ax9J3Ns_Q2PO8oeg+G7kgqQS7kMJMxSiX92_Vwzg@mail.gmail.com>
Subject: Re: [PATCH v2 18/23] nilfs2: Convert nilfs_lookup_dirty_data_buffers()
 to use filemap_get_folios_tag()
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

On Tue, Sep 13, 2022 at 3:30 AM Vishal Moola (Oracle) wrote:
>
> Convert function to use folios throughout. This is in preparation for
> the removal of find_get_pages_range_tag().
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  fs/nilfs2/segment.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Looks good.   Thank you for reflecting the previous comment.

Ryusuke Konishi

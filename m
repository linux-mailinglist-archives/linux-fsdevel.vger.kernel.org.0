Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658925E7EB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 17:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiIWPnJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 11:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbiIWPmt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:42:49 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C07147F1C
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Sep 2022 08:42:14 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id dv25so1473871ejb.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Sep 2022 08:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=LvRNv3O4fqyinC0IcRuaETm3vbUt2mVqZQJpZayG2F0=;
        b=KJTsMWeDujPxbKK/mHf6YGS7nQagBn4v7xNSidU2kdEffpuinoLHkAlrrVWgnI4NYu
         G7ShT+Rfx9Y0BYrLV/jMPvC1dW+bT65F53UX5A46Iztndqh91ozKSeHM495xIG28toZw
         Cr6rfDh/hfMi4vk6a/s6ry/dYPagWJPSRjS4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LvRNv3O4fqyinC0IcRuaETm3vbUt2mVqZQJpZayG2F0=;
        b=TXG0B5d5hcYHRnOktbd8lr45k3lgm3ONKD+HBQQvNi6sXYiDqoavCjHg2MvQAZYMkl
         GhcYcNy9uvWYTF6qIaRfz0pyG5FeNex7AOSJdGx2icDZNxykMh3VerOlsPKofwtr6BJL
         fm/Nemim5xPnFr6f7fsSyVMfOvQv2gv7ihRILjGbmeB3pRGklcPFtCNsMb/CT1ceUyDg
         /uIEp3gW6H5VCH7TuqaVGVGCgi+SuLfocCz0lXPmfY2VgaH11ocnBPF14/xrSq6R7gWa
         uCG19Wpq+pAvs9iOZiQFuOLu/AWlSbPwluUqgvbYAKOtVHtnqWOEZlCsXD+VKtO4hpS4
         leAQ==
X-Gm-Message-State: ACrzQf0tay5ZwhVOV+2HQGj2AMZmA26bAXHkqofE7mAUEg0q4xjx5s+j
        4uBp4Jrc+UzDC7ghU0F0vVN7V7GpQCn9fXkhjoz2bw==
X-Google-Smtp-Source: AMsMyM65TLFzcMWSJbleGSM8JiKcPDBOMooW7jOIOIW7NDp88Y0PKSJP3wL64AMGR/9mcbzmt7brxHQYYw2JHGhDNdQ=
X-Received: by 2002:a17:907:7fa5:b0:781:4add:3a21 with SMTP id
 qk37-20020a1709077fa500b007814add3a21mr7745380ejc.267.1663947733038; Fri, 23
 Sep 2022 08:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220922084442.2401223-1-mszeredi@redhat.com> <20220922084442.2401223-5-mszeredi@redhat.com>
 <YyyLyY3TUG6IaU3Y@ZenIV>
In-Reply-To: <YyyLyY3TUG6IaU3Y@ZenIV>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 23 Sep 2022 17:42:01 +0200
Message-ID: <CAJfpegsEi8VSZOXJDbFatvHsKMjuXPCm42GApRG_s1EZobdCAg@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] cachefiles: only pass inode to
 *mark_inode_inuse() helpers
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 22 Sept 2022 at 18:22, Al Viro <viro@zeniv.linux.org.uk> wrote:

> I would rather leave unobfuscating that to a separate patch,
> if not a separate series, but since you are touching
> cachefiles_unmark_inode_in_use() anyway, might as well
> get rid of if (inode) in there - it's equivalent to if (true).

Okay, pushed updated version (also with
cachefiles_do_unmark_inode_in_use() un-open-coding) to:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#fuse-tmpfile-v5

Thanks,
Miklos

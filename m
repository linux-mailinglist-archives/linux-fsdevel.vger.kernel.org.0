Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4DF76D60E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 19:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjHBRuT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 13:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbjHBRtt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:49:49 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A85469D
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 10:49:08 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so607581fa.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Aug 2023 10:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1690998544; x=1691603344;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N/atbRrJvFhx5d5vFoJ0yq7ylgCUwIFL8deRDGsjQdg=;
        b=FCijXPlODzBx1L4NBs8AmdoiALGwfJRWeNKtvNAbD1+X+Ezn/YkteTxCQlVTxtIXw+
         JK0hb2QAl/jOngkp9/dJ4OPcwCQzHjKDWOGfwCaDhi/yspMId2l1tXjeph7hAXUQj2Qx
         +m9LbJpKWjc71DASA6eladoXzcOyqipDuVJ9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690998544; x=1691603344;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/atbRrJvFhx5d5vFoJ0yq7ylgCUwIFL8deRDGsjQdg=;
        b=FBl3F1c6j27Ddr5+5Vvph72kY+Zfo+P2+t8uN6hCFPw6kR3sXooxquHm8Axknwp5bm
         GNg6W4s/h0emL9c3tTRiN8hkh9hW7UMR46dI5AMHudDrffWvLrrJMyE0pLoyuGlJwUhr
         7CSnd0nbYOglTfi/D8ovn83PFW2jfT2yijsK31MYHqksbEBOWOIeWmgjlJgrKR9AEfGz
         C1WSb0wDnedYJTvyDm+VqjcN/maF+2ANxkfIa41Xr2BrFmcWgycMa2wG8QK1oXddR9ZM
         GyX3uy4v9vyxJQQwAqj/cntCosuFkvGT0V+cBLF7+B2zMpprRms0JZ41Do/kkmLlOS5s
         5uQQ==
X-Gm-Message-State: ABy/qLYGmWSf0V/wJgC1VH415jy1rKzFFIt0l+FkIW0i1LqzghXQS313
        Y99WBUIqHxLtRgpRVhBCXLPop24PsB01rTqM5nnfqw==
X-Google-Smtp-Source: APBJJlH16DqaYnO6qsyFMIY2SbMO9UU/RxPUm/nRAD9vPJZ7geCUAt7lBZivX4gUnhhTCWQnSD0oo9nsC3FBj/UgLRM=
X-Received: by 2002:a2e:8ec3:0:b0:2b9:ec57:c330 with SMTP id
 e3-20020a2e8ec3000000b002b9ec57c330mr5604991ljl.7.1690998544118; Wed, 02 Aug
 2023 10:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <87wmymk0k9.fsf@vostro.rath.org> <CAJfpegs+FfWGCOxX1XERGHfYRZzCzcLZ99mnchfb8o9U0kTS-A@mail.gmail.com>
 <87tttpk2kp.fsf@vostro.rath.org> <CAJfpegvbNKiRggOKysv1QyoG4xsZkrEt0LUuehV+SfN=ByQnig@mail.gmail.com>
 <87jzudqzcq.fsf@vostro.rath.org>
In-Reply-To: <87jzudqzcq.fsf@vostro.rath.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 2 Aug 2023 19:48:52 +0200
Message-ID: <CAJfpegsuBi6nFgpOapzCi73ZJo215eXp-yxkHvOb46mH5oD=Xw@mail.gmail.com>
Subject: Re: [fuse-devel] Semantics of fuse_notify_delete()
To:     Miklos Szeredi via fuse-devel <fuse-devel@lists.sourceforge.net>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        miklos <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2 Aug 2023 at 16:43, Nikolaus Rath <Nikolaus@rath.org> wrote:

> Will think about how to best fix that. The problem is that LOOKUP for
> the ctrl file name always succeeds (no matter the directory), so we'd
> have to issue an additional NOTIFY_DELETE for every directory *and*
> there'd still be a race condition with LOOKUP(ctrl_file) being called
> in-between.

Only need to issue the NOTIFY_DELETE if the ctrl_file has actually
been looked up.  If it has, then yes, an extra NOTIFY_DELETE needs to
be done.  After having done NOTIFY_DELETE(ctrl_file) the
LOOKUP(ctrl_file) can just fail with -ENOENT.

Thanks,
Miklos

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54A15C0087
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 16:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiIUO60 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 10:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiIUO6J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:58:09 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763359A69A
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 07:56:13 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r18so14191154eja.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 07:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=0ITPpwaet69MlIxTXSlLV3rP/LPBh0vMkdbcjTwMT2k=;
        b=BsWjFCVn/PEqH3AmFD85Qzy2dFEjvdp8bku7r+pTRo47oDTFC4pS37MhXO43HtQNAQ
         7GLqsIvo/rHxAnqs1qddx+DWlUhxJfIRce9hgR/NVeyHow5Mpu4N1Drd/3tvM6+9ZyU+
         0KkACxjQZKABzRkbvNRULKomc8AyfmzDv12XY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0ITPpwaet69MlIxTXSlLV3rP/LPBh0vMkdbcjTwMT2k=;
        b=LjZ/shfOMhN5oobmEMxq2Kd0zau8LlbDt3xIktaqbDe/VcqaACZh/p092bABPu9SHZ
         vZrMl16/1Vh13/9y+PzwuoxHa5tAU7xZFtRsfXubc0gpj1GNWdnZ5gosqGjBJAWqfV5t
         irlaQSeVoE4gv16H1JVkHXfD6pE3AtlBwWZK3KbohMD06Cp2WQHnjGHu6UinkWmZ6ybG
         s9+GJd2zqDy2Xl/eaZ07O20HilHX10dxkfhbppNjDZwsIiODYnD/CHWqfCFTNNh6sCYe
         3bd+5+KoVH6NAWytiC94DPi8hJ6HguRPqplVYoVevb/rnXkY6iXfzkEpyubMp/rjF3gt
         pLIg==
X-Gm-Message-State: ACrzQf0mF8Dg2CF0cf4D1PDQtguoCA3coYJ3xKksxLdpir/0OnXUpkTb
        g9IxlPNj9tXuYOdBcU2LfS1WLU1hlqz1q0tSQI1ZHQ==
X-Google-Smtp-Source: AMsMyM4Z1k4vtjo5Dc37G5SmL/why8aZVCoARfUtdZh/rSVoUxkzQIg+cnfQj2hmTdfd0h1DBBT1OxLbNJAGg1R92BE=
X-Received: by 2002:a17:907:97c2:b0:780:6a13:53 with SMTP id
 js2-20020a17090797c200b007806a130053mr21481870ejc.187.1663772171868; Wed, 21
 Sep 2022 07:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220920193632.2215598-1-mszeredi@redhat.com> <20220920193632.2215598-8-mszeredi@redhat.com>
 <20220921090306.ryhcrowcuzehv7uw@wittgenstein>
In-Reply-To: <20220921090306.ryhcrowcuzehv7uw@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 21 Sep 2022 16:56:01 +0200
Message-ID: <CAJfpegsEbwQhgZbXTsAzcMTcwVvA_U4r+JEDLcYSAezC6hYq5g@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] vfs: move open right after ->tmpfile()
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
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

On Wed, 21 Sept 2022 at 11:03, Christian Brauner <brauner@kernel.org> wrote:
>
> On Tue, Sep 20, 2022 at 09:36:30PM +0200, Miklos Szeredi wrote:


> > +/* Helper for the simple case when original dentry is used */
> > +static inline int finish_open_simple(struct file *file, int error)
>
> It would be nice if the new helpers would would be called
> vfs_finish_open()/vfs_finish_open_simple() and vfs_tmpfile_open() to
> stick with our vfs_* prefix convention.
>
> It is extremely helpful when looking/grepping for helpers and the
> consistency we have gained there in recent years is pretty good.

Agreed.  However only finish_open_simple() is the new one, and naming
it vfs_finish_open_simple() makes it inconsistent with
finish_open_simple().    I'd just leave this renaming to a separate
patchset and discussion, as it's hard enough to make progress with the
current one without expanding its scope.

Thanks,
Miklos

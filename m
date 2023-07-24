Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF74F75FC8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 18:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjGXQv1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 12:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjGXQv0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:51:26 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E387E65
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 09:51:25 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fb7589b187so6850289e87.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 09:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690217483; x=1690822283;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F1PcgD4KNACPIHRzby9gkRic2d4smXVPIn37UpHTR9A=;
        b=WRlPdejRXuqwClLsrc073yiX/16IWeF7XMgJS0/Wo4b+CwQgUlRMEjnNRecDn8J7AL
         0nG8VjYkNh7qfzJrBdMsuNTnHkCcGUk6djL5vfTv5a76/dCjeHHSZz+J46T96cR3GbBz
         eDVift+Ljn6opZHIYkkbTiWqVeK/5uKDlfRuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690217483; x=1690822283;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1PcgD4KNACPIHRzby9gkRic2d4smXVPIn37UpHTR9A=;
        b=hCv3JT2FZeGkVqj4J5YGfuj4ulkxkSNmnp6a8vwkmVAAWBfFoK0YDl8dnLpq7cKn+H
         NSs5SQCcx5cvz6uFDDBcZ4HANtyxq0scjwE1U4Te8k3frzwizwUGWY7OKNa4WOCoe83z
         /g5ubUYGXQVbGwsJx1FSuJXpWbldBHdyUaEQuZgBbfAJHG9LNcfsm/+NlGmYPg7mNe7E
         /i7Ez05yWom3sG6My+EpLjycOat+zdixjugkexCoTaWUVyE+NN2G/bMA0RVFlMJ5XE8r
         lMVCMdvfFdOJYhYLZWBvJRmHdscy8jR7f+wXT8Chg5pvC8GCHJ9atkymHRGQoUonseJZ
         +LEQ==
X-Gm-Message-State: ABy/qLYO6X9EzCz4OVBjLPAuiV5X60+Wz4stMLJSUMx/EJN/WPfnM6QL
        e98CQju0EyLLfLxPRb4zDOV3Nwwu244NyvscZT5pCw==
X-Google-Smtp-Source: APBJJlEHWDc1ipxk2hd5i4HK43Ms3OGb6RSoOKOFJwNUbxapNwzy8l5GeNlKI09jtmTHSkuERrb8tA==
X-Received: by 2002:ac2:4f05:0:b0:4f8:5696:6bbc with SMTP id k5-20020ac24f05000000b004f856966bbcmr6600372lfr.29.1690217483540;
        Mon, 24 Jul 2023 09:51:23 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id v17-20020a1709067d9100b0098d2261d189sm7050152ejo.19.2023.07.24.09.51.22
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 09:51:22 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-99364ae9596so801541766b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 09:51:22 -0700 (PDT)
X-Received: by 2002:a17:906:292:b0:999:37ff:be94 with SMTP id
 18-20020a170906029200b0099937ffbe94mr10526397ejf.71.1690217482084; Mon, 24
 Jul 2023 09:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
 <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
 <20230724-scheren-absegnen-8c807c760ba1@brauner> <CAHk-=whwUTsixPwyBiuA25F2mAzARTU_-BijfmJ3MzkKLOYDmA@mail.gmail.com>
In-Reply-To: <CAHk-=whwUTsixPwyBiuA25F2mAzARTU_-BijfmJ3MzkKLOYDmA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Jul 2023 09:51:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=whtPzpL1D-VMHU9M6jbwSqFuXsc5u_6ePanVkBCNAYjMQ@mail.gmail.com>
Message-ID: <CAHk-=whtPzpL1D-VMHU9M6jbwSqFuXsc5u_6ePanVkBCNAYjMQ@mail.gmail.com>
Subject: Re: [PATCH] file: always lock position
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 24 Jul 2023 at 09:36, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> There are magic rules with "total_refs == inflight_refs", and that
> total_refs thing is very much the file count, ie
>
>                 total_refs = file_count(u->sk.sk_socket->file);
>
> where we had some nasty bugs with files coming back to life.

Ok, I don't think this is an issue here. It really is that "only
in-flight refs remaining" that is a special case, and even
pidfd_getfd() shouldn't be able to change that.

But the magic code is all in fget_task(), and those need to be checked.

You can see how proc does things properly: it does do "fget_task()",
but then it only uses it to copy the path part, and just does fput()
afterwards.

The bpf code does something like that too, and seems ok (ie it gets
the file in order to copy data from it, not to install it).

kcmp_epoll_target() -> get_epoll_tfile_raw_ptr() looks a bit scary,
but seems to use the thing only for polling, so I guess any f_pos is
irrelevant.

               Linus

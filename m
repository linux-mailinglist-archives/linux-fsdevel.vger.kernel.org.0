Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B775FBAF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 21:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiJKTDu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 15:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiJKTDb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:03:31 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F46895C6
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Oct 2022 12:03:11 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id nb11so33508049ejc.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Oct 2022 12:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uB6bldokknuAaLKJsybg3s1dZctnS1g1CUW11xWU7Sg=;
        b=DYh+N3iLHrEdO7VKsZ3VKV1ODGFRp+D18MPAmXteYjfllxhT+xcLmhKDc14QrLrJyz
         26rsTRmzTfjus7K8A7r5KhWobF6veY8s4JHO8cqZZVuuOnmca0dFWZuE6HFVZ998jfGK
         XpOMBdfxqmlGG6x890JB2ujOiqQqpe4yOC+EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uB6bldokknuAaLKJsybg3s1dZctnS1g1CUW11xWU7Sg=;
        b=bqMPHXHc10KCs2EHAQKVynkXjBZnxtD8VNpivKI9xsY8tKbsilONS5XjYDHDjlNazZ
         ZpLcFBEmFVDtpvEXlHmXFIJ3+v1UyfjXH8ApyQT8KgphGo6vvXxQlroBys9cVToT+zX4
         EKwM7848OALsR16o/NFRdiAT2ysqmBdmfkiXb0W3iVBdktoa25Josbvg4QwCbI2MJZlh
         7q5X6BGgPLOKLn+8cx6MO8CVtf+owq4+gEWO3DP/qjr836GxAxUCgdTOsxtKJ0tt9E3W
         CySAlcjZTUyR3kTnI199EVXy+wQFTMA3n0Mtej4xVPqx23548fGaq0dLfB4M/Hd12/PG
         MZoQ==
X-Gm-Message-State: ACrzQf1HHsEcZTPitKOY5gNkck1cMYZJvMNeP8DRA1/MR1jymmIOeAGs
        DjQrrW1gNHTMgDINdn+X9PHk9kfETN//NOCmmmJinQ==
X-Google-Smtp-Source: AMsMyM6wzyObwD9/cQhMyvqN03QS9Mtj4DNwEd5zsF1rv9wqSdwTM8bO8KvYvlAT5uttE7E55w5+WeCon0YnA1TOgM8=
X-Received: by 2002:a17:906:4fd1:b0:787:434f:d755 with SMTP id
 i17-20020a1709064fd100b00787434fd755mr19354322ejw.356.1665514990307; Tue, 11
 Oct 2022 12:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <Y0Wv6qe3r8/Djt7s@ZenIV>
In-Reply-To: <Y0Wv6qe3r8/Djt7s@ZenIV>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 11 Oct 2022 21:02:59 +0200
Message-ID: <CAJfpegsgtke1X7FGpMSgTGdDsOxU7kqPqf2JbOAnqgMj0XFoSQ@mail.gmail.com>
Subject: Re: [RFC] fl_owner_t and use of filp_close() in nfs4_free_lock_stateid()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Jeff Layton <jlayton@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 11 Oct 2022 at 20:04, Al Viro <viro@zeniv.linux.org.uk> wrote:

> Another interesting question is about FUSE ->flush() - how is the
> server supposed to use the value it gets from
>         inarg.lock_owner = fuse_lock_owner_id(fm->fc, id);
> in fuse_flush()?  Note that e.g. async write might be followed by
> close() before the completion.  Moreover, it's possible to start
> async write and do unshare(CLONE_FILES); if the descriptor table
> used to be shared and all other threads exit after our unshare,
> it's possible to get
>         async write begins, fuse_send_write() called with current->files as owner
>         flush happens, with current->files as id
>         what used to be current->files gets freed and memory reused
>         async write completes
>
> Miklos, could you give some braindump on that?

The lock_owner in flush is supposed to be used for remote posix lock
release [1].   I don't like posix lock semantics the least bit, and in
hindsight it would have been better to just not try to support remote
posix locks (nfs doesn't, so why would anyone care for it in fuse?)
Anyway, it's probably too late to get rid of this wart now.

The lock_owner field in read/write/setattr was added for mandatory
locking [2].  Now that support for mandatory locking has been removed
this is dead code, I guess.  Will clean up in fuse as well.

Thanks,
Miklos

[1] v2.6.18: 7142125937e1 ("[PATCH] fuse: add POSIX file locking support")
[2] v2.6.24: f33321141b27 ("fuse: add support for mandatory locking")

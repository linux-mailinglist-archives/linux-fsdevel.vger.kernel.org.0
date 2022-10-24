Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02385609CE6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 10:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiJXIiW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 04:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJXIiV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:38:21 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E9560485
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 01:38:18 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id a13so28544924edj.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 01:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I7q4jjZ/11oP0wYx/mP/f1FCsbis6J0C3E07mdpbVVw=;
        b=YA02PVXDKsrn9ltaGQq1rVpRNSuTE6y3ch/XBF/kmoNgtADrk+uPVI/iJH7R1txxp5
         F0tTK9YMUuDLc6sWPMFcOq13dBSvSF3Kv+jIpzPWAWe+7ltapD+hT0p7do5PG0u8NnEr
         pQqXFIVu6tXpa8hi8fVni1bPC4VS0mzauSS4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I7q4jjZ/11oP0wYx/mP/f1FCsbis6J0C3E07mdpbVVw=;
        b=DPoblemQXZ2vtqSm+v098gTqwMThiTOsG9BmR7IU4TMP0yhp2kekWqDVLd5hxU2vdF
         yoh8TNw2tdZGDJS0N/ebyVdpuyaoTt0JP/L3al4539zXlRVTLKy45jcNys+YOAiYM3fn
         5ua8O/603BePhf8pBAOUs4AOtrr+Oyf0VeSdTfFt2HP8U+ovIviiSzdH4Ji6jrxVsZA9
         beQDrIAyN1e2V/gtQSWZLXzn5rjebUbiloL/VnS48e+8vulvwYFUg4Orzs37EbsfKRhy
         UMlJ+AeGMeSc94JSp2yHzmz7Gqd4CsM6WzyGZ2Di9yvySJLC9FTiJOUE1NMJZNmilaWx
         XwzQ==
X-Gm-Message-State: ACrzQf1P6Kl7d4P8LzThl9FlWwvAZETPLqFrjGDg4DRTlLsRAfy6rAE1
        BlAFcqVg0JZmgUgmDel1hNeqGn6IGUqJmVgiYMDDMQ==
X-Google-Smtp-Source: AMsMyM6cwWOYmOvAUbrctm2+2xxYfn9PiStTPWchMHlzL+E1TfVKSg06irPVtNqV4V9c2R6o5ri/Ukv7AEtCCeQzUVI=
X-Received: by 2002:a17:907:b1c:b0:797:983a:7d97 with SMTP id
 h28-20020a1709070b1c00b00797983a7d97mr19041019ejl.267.1666600696615; Mon, 24
 Oct 2022 01:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <166606025456.13363.3829702374064563472.stgit@donald.themaw.net> <166606036967.13363.9336408133975631967.stgit@donald.themaw.net>
In-Reply-To: <166606036967.13363.9336408133975631967.stgit@donald.themaw.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 24 Oct 2022 10:38:05 +0200
Message-ID: <CAJfpegts1pqM1Qi4sEAB22W1qBzZaAkgpY+LjBp65=Ns+KHB3w@mail.gmail.com>
Subject: Re: [PATCH 2/2] kernfs: dont take i_lock on revalidate
To:     Ian Kent <raven@themaw.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Minchan Kim <minchan@kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 18 Oct 2022 at 04:32, Ian Kent <raven@themaw.net> wrote:
>
> In kernfs_dop_revalidate() when the passed in dentry is negative the
> dentry directory is checked to see if it has changed and if so the
> negative dentry is discarded so it can refreshed. During this check
> the dentry inode i_lock is taken to mitigate against a possible
> concurrent rename.
>
> But if it's racing with a rename, becuase the dentry is negative, it
> can't be the source it must be the target and it must be going to do
> a d_move() otherwise the rename will return an error.
>
> In this case the parent dentry of the target will not change, it will
> be the same over the d_move(), only the source dentry parent may change
> so the inode i_lock isn't needed.
>
> Signed-off-by: Ian Kent <raven@themaw.net>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>

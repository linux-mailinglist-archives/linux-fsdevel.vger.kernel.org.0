Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB45609D23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 10:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiJXIvL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 04:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiJXIvH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:51:07 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42F44F65F
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 01:51:03 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id a5so15480350edb.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 01:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=48RogcYAddblRnrwwegwTV8L7KkpXpBRUanF9H4ZX04=;
        b=Mt4BNTviARWRqeEoVFmvLXAErFK2+IHQQ8hrJWYLW4IAjOmj8YOZjI2mcJYnFm9PG7
         B30YYlX0Cip1NK7gxjfWE7B8qymm72JXogMpRH6sD5/QtmK5daJQo03sC5lDDl6hvahp
         ggpMlxtLLPqnbjAYF6cN3yclnYgt2zm2qdRiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48RogcYAddblRnrwwegwTV8L7KkpXpBRUanF9H4ZX04=;
        b=d7naBin98jhWgC88Qv4XaDTP18+SOXjlGrVnGGG8k/2Hib5XAKXEAvzWrczUzriCg4
         5a0MYKyW5SwX4BoS5O7MyACR34JCQB/4cwQgCllveuHvb56TEiJjAq0pXRyFKHJ3YUtI
         xdLfd0cv3Id25SgYpVDfV/HDtTEewCsD8e5sZ30OAf/K7Bm4FxWHT7brWh7h+hI1LI5q
         T7zk+u2aTI3MUTmeNmOKLZH1U18nWglNEjwRl8vFTGuiGqGS1iW9EwwQ4F2bEZ7vynhS
         u8C7lGWtQpVdZ2chekdQ6Y4ZT/qlnn6UhkhA+PD87ViIbDexEcJHJNmt277Yn46snh3A
         mVYg==
X-Gm-Message-State: ACrzQf34zUmNZO8cEgNWDlAWZRw0b5YltYJNmLOnsM1nfLknxvszao/o
        rxzd6CtstYCKfEmZNRIpkH4PoDG9bjW+nIrIZTz44g==
X-Google-Smtp-Source: AMsMyM6iH131rcAchW3ZShlH0w+uAPCPW3uuAwqryut5H5gN8dmdqS5j27qGCV73XiNvasRcqV71S1SQk1ja+nYjvck=
X-Received: by 2002:a05:6402:370c:b0:453:9fab:1b53 with SMTP id
 ek12-20020a056402370c00b004539fab1b53mr30540317edb.28.1666601462322; Mon, 24
 Oct 2022 01:51:02 -0700 (PDT)
MIME-Version: 1.0
References: <166606025456.13363.3829702374064563472.stgit@donald.themaw.net> <166606036215.13363.1288735296954908554.stgit@donald.themaw.net>
In-Reply-To: <166606036215.13363.1288735296954908554.stgit@donald.themaw.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 24 Oct 2022 10:50:51 +0200
Message-ID: <CAJfpegsciAuJD-UAcW3Ns43G5m1G466opq6_Y6RG1G4iVHwcHQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernfs: dont take i_lock on inode attr read
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
> The kernfs write lock is held when the kernfs node inode attributes
> are updated. Therefore, when either kernfs_iop_getattr() or
> kernfs_iop_permission() are called the kernfs node inode attributes
> won't change.
>
> Consequently concurrent kernfs_refresh_inode() calls always copy the
> same values from the kernfs node.
>
> So there's no need to take the inode i_lock to get consistent values
> for generic_fillattr() and generic_permission(), the kernfs read lock
> is sufficient.
>
> Signed-off-by: Ian Kent <raven@themaw.net>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>

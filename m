Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD0A5B6B58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 12:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbiIMKEB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 06:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiIMKDo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:03:44 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE3B5E67E
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 03:03:27 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r18so26246610eja.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 03:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fFLsFoWXtlA3crTk098b9SVmLbRpZxA8MmGskV3jQMs=;
        b=kh0Ap5NpnCkmozBzRllILRQlA15t1oytJZzPHHU89zE5to0C/4aXuifNx1E2ItAV2Q
         /tLuozzkwCW7oVuITQ8AeKr1MmSZiF8mCL/CMoOSrGNMMxFMxXXt+8BaDk2r+CBoJaDt
         UjyjJHz6cvHOh0W9ONtJU27mszQ8vsgcsIyIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fFLsFoWXtlA3crTk098b9SVmLbRpZxA8MmGskV3jQMs=;
        b=ujR/OobgrViDGsn6kPvB/uICZ4KGOUG+DpdgwddV3Ggp35Ht2CGnx9DYDcaDtA6kFN
         UsDbryyb3fkiU6HWBJmaKa/9idijFH4yBiyEcghgnc5hQkkndqmCVUVkkZHn2DdHfr6H
         +ZWV/N5O35Z8E01Q9fFErwqm715XCH2PiiUfmbMfTJVg7+N1/jkjM3aZAU206LX9WBj3
         w1aQUThi8gsA0tqxUUKbBZXI1NANO/zPcTeLYBtHws5FfKjw8kvhewh+gQW5SIpXb/A0
         UyaWDZFlG0FcRFeAOwhEl9YWPwONsQC7hf0pu5VInSGjsWhyX3OjYMoXCIOF1YUUjJWC
         KHjQ==
X-Gm-Message-State: ACgBeo3TghqrZrgfX64qdNLO36BYhJ9qBIdBHHXYFtDuZie5jNSOR3PQ
        esv22UY05uIz0b+DlQmRaPHguPpe4YfX6EEyB4pn+Q==
X-Google-Smtp-Source: AA6agR5YFfnfM4R4hSHM76SwsDTjlW+I/a5isHGgTXE7zoC2l5XsCnPpAUg6BDTE9Q54L0pWN5syL90oM7aVMVDzxOg=
X-Received: by 2002:a17:907:9495:b0:734:e049:3d15 with SMTP id
 dm21-20020a170907949500b00734e0493d15mr22015772ejc.187.1663063405725; Tue, 13
 Sep 2022 03:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220221082002.508392-1-mszeredi@redhat.com> <Yx/lIWoLCWHwM6DO@ZenIV>
 <YyAHDsGiaA/0ksX8@ZenIV> <CAOQ4uxiz32Srdg=c7g_49TFnxT9VN-j_V9u2ZHsxU10gCDXWVA@mail.gmail.com>
In-Reply-To: <CAOQ4uxiz32Srdg=c7g_49TFnxT9VN-j_V9u2ZHsxU10gCDXWVA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 13 Sep 2022 12:03:14 +0200
Message-ID: <CAJfpegvw02yrWE3xWPtp7JLmbw9U236c6vqtpakUYbPH1SdHeg@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: fix link vs. rename race
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Xavier Roche <xavier.roche@algolia.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 13 Sept 2022 at 10:02, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Sep 13, 2022 at 7:38 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Tue, Sep 13, 2022 at 03:04:17AM +0100, Al Viro wrote:
> > > On Mon, Feb 21, 2022 at 09:20:02AM +0100, Miklos Szeredi wrote:
> > >
> > > [digging through the old piles of mail]
> > >
> > > Eyes-watering control flow in do_linkat() aside (it's bound to rot; too
> > > much of it won't get any regression testing and it's convoluted enough
> > > to break easily), the main problem I have with that is the DoS potential.
> > >
> > > You have a system-wide lock, and if it's stuck you'll get every damn
> > > rename(2) stuck as well.  Sure, having it taken only upon the race
> > > with rename() (or unlink(), for that matter) make it harder to get
> > > stuck with lock held, but that'll make the problem harder to reproduce
> > > and debug...
> >
> > FWIW, how much trouble would we have if link(2) would do the following?
> >
> >         find the parent of source
>
> Well, only if source is not AT_EMPTY_PATH

The problem is not AT_EMPTY_PATH, but a disconnected dentry gotten
through magic symlink.    Theoretically link(2) should work for those,
but I didn't try.

>
> >         lock it
> >         look the child up
> >         verify it's a non-directory
> >         bump child's i_nlink
> >                 all failure exits past that point decrement child's i_nlink
>
> No need to bump i_nlink.
> Sufficient to set I_LINKABLE.
> and clean it up on failure if i_nlink > 0.

Bumping i_nlink seems hackish enough, currently all i_nlink
modification is done by filesystem code.

Setting I_LINKABLE seems safe for filesystems that have tmpfile, not otherwise.

Thanks,
Miklos

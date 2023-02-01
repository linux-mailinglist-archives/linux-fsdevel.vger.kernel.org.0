Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3020C686AE4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 16:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjBAPzX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 10:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbjBAPzI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:55:08 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9477751A
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Feb 2023 07:54:33 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ud5so52752940ejc.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Feb 2023 07:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bXWqBgMOKv5SnbTsUMFlWPl1mxwCaGFXLbhg+69mJBo=;
        b=Sqps5nHkF4vfpjGc70sbUfCvx2Zc88TDnLNGyx0VmKmTxcv6JhSgWBbqee2E0+Q0KH
         yEM4HUxIchphwRzb5/SMvgThKH7jdGa7pafz04o1GUcvwGaMyejbgk4PWSeN+stZoGUm
         XTcTPqYBDzKAwpYXi5GPegLxK/7GH8Bf2kmv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXWqBgMOKv5SnbTsUMFlWPl1mxwCaGFXLbhg+69mJBo=;
        b=4goTU2hYKbgp0+dWqxUaqd8ZQwLDCcajIpo5hhmh9oYXf8ytWDEpQp0B7DN/u5P36m
         nRmCHq/aryjoaDR/ngP+YGZTKbPwJCJ/aJn3e4nalnPnPE9K5t+x0VwAcPjmZZ05fcP/
         lG4ZGPT/qqMTlqFnJRYHrFDobyvIvGz0eGO4JdnZeULAVXRIqqUTgoKv32sEkW9b+2hb
         gs+kDRvePdK0MN8fxqJG6GQ76DAESVhjlBs++rN3OPbR7caYUpjwoS+irKez92dR9HxI
         8klaXueT1k9uHinEt1vRSAzzS3o9uvPPy0vPb+0kpiGV8f+Id+4Gt2NNbKEKOizddJb+
         3ClA==
X-Gm-Message-State: AO0yUKUQ9Va5l+h5+NT0ACLqem15M0r9YMhqyr4pRlaKGoSuU2LdbefA
        XAoEY9zYzgULRkSaYubEyooG2LSDn7lpPm9zrp8K3w==
X-Google-Smtp-Source: AK7set8r8OoF7qrGxnNKdUpD+LKehxKmaT8vY+FzeL9YI2CliNZodxhhagWUKTRdSPk3WuV2thOqVJYqKrXrhfb22XI=
X-Received: by 2002:a17:906:709:b0:88d:5c5d:6a6f with SMTP id
 y9-20020a170906070900b0088d5c5d6a6fmr855247ejb.236.1675266872159; Wed, 01 Feb
 2023 07:54:32 -0800 (PST)
MIME-Version: 1.0
References: <20221111093702.80975-1-zhangjiachen.jaycee@bytedance.com> <CAFQAk7isS3AgkU_nMum8=iqy8NgLdGN5USq4gk_TE8SUzRr4tQ@mail.gmail.com>
In-Reply-To: <CAFQAk7isS3AgkU_nMum8=iqy8NgLdGN5USq4gk_TE8SUzRr4tQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 1 Feb 2023 16:54:21 +0100
Message-ID: <CAJfpegtqGDt4fnDsLtLEhg3ysw5TtfPamJ18TGSpSJve94KNzQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: initialize attr_version of new fuse inodes by fc->attr_version
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 17 Nov 2022 at 09:52, Jiachen Zhang
<zhangjiachen.jaycee@bytedance.com> wrote:
>
> On Fri, Nov 11, 2022 at 5:37 PM Jiachen Zhang
> <zhangjiachen.jaycee@bytedance.com> wrote:
> >
> > The FUSE_READDIRPLUS request reply handler fuse_direntplus_link() might
> > call fuse_iget() to initialize a new fuse_inode and change its attributes.
> > But as the new fi->attr_version is always initialized with 0, even if the
> > attr_version of the FUSE_READDIRPLUS request has become staled, staled attr
> > may still be set to the new fuse_inode. This may cause file size
> > inconsistency even when a filesystem backend is mounted with a single FUSE
> > mountpoint.
> >
> > This commit fixes the issue by initializing new fuse_inode attr_versions by
> > the global fc->attr_version. This may introduce more FUSE_GETATTR but can
> > avoid weird attributes rollback being seen by users.
> >
> > Fixes: 19332138887c ("fuse: initialize attr_version of new fuse inodes by fc->attr_version")
>
> Ping..., and the Fixes tag should be:
>
> Fixes: fbee36b92abc ("fuse: fix uninitialized field in fuse_inode")

Do you have a reproducer?

Thanks,
Miklos

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D9F7331D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 15:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344757AbjFPNFx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 09:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343593AbjFPNFv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:05:51 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6802D79;
        Fri, 16 Jun 2023 06:05:50 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-555508fd7f9so396215eaf.3;
        Fri, 16 Jun 2023 06:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686920749; x=1689512749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tK8wLCi3af6jsEqrkD/MXLL1+C0wikgHbAi3OROsDs=;
        b=oH5+RDzeiX4QI9IucvHRIxhHYAvdmwVih4VsEI9vnUqd9rG+jSo4GV79BFmspBWYbX
         9iK5j96Cqzxo7vWzghAa25QwPn+CubEfWLWg0WSJOpROtvJQk2CfyC8M38JCggx1eQrk
         Yu2bN9embTCGcmvpyczVsex1XobLrkxSDeMT+bItk8/XaFAepmRjB3BMOUsTgkJXJFYf
         Vge7qWzoWsjOtxjSYgA2+i5+Xgd4nAnyFkd2EH3XX/6vSuFxdEOtktDkV9VHu7mVgka8
         oR3TbMzaHOcPk7ctUffcaMDz5YWkVjLrsVaiNbOG6dTHeSIhAIgsmG0mfghPcRTrGExp
         dewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686920749; x=1689512749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5tK8wLCi3af6jsEqrkD/MXLL1+C0wikgHbAi3OROsDs=;
        b=g7QTAKnT/QCimpiYDpaAsrJQM/1pOQGXRQLFLRLRonLih3OfNWmXdEoPk8eRTm6rF/
         pgwd8TTjUaMQ0vDDU9WKu43acyPShrODpaNOxA5HjY+0FtjlfYbxqyDFJ97Cbd5loTQU
         DLPKIxohT2oy0N/Ccr2q53798e+G6ywTAU/xwOVAzgjScRvMkF0pWzp2MYBL0CJj9D7A
         j7Z2x9iHdKjigV0noTxEkZOMGrooeYv1FBHiLNqXKBv580uVX+AMOqCO6lzmSA8hnmhf
         GnbKCFP/cKEXLNnu9yAbwfyO3e3WGsPbPgRMUJkY22WuUP7+LQZVkxo9PmgDYuJW5r3P
         68qg==
X-Gm-Message-State: AC+VfDyu70bWbW7QYOeOKHXlrG6d/99ROQQ431UPjKOFo6X8rAQF0BD0
        Y6itn5voQuKfRQp3cGgatYi0q2H/xrfGHn+ViwrtS/HIXzQ=
X-Google-Smtp-Source: ACHHUZ511yDQ1kilsGuc7oFI82rXmpGSZTQ0w5t8U1P4qYulpklas41F52o1lQNt37NzYmwNtv5tAPW7cELHq0njTW4=
X-Received: by 2002:a05:6358:6117:b0:12b:e47a:8191 with SMTP id
 23-20020a056358611700b0012be47a8191mr466226rws.16.1686920749467; Fri, 16 Jun
 2023 06:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230616-fs-overlayfs-mount_api-fix-v1-1-b6710ba366ea@kernel.org>
In-Reply-To: <20230616-fs-overlayfs-mount_api-fix-v1-1-b6710ba366ea@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 16 Jun 2023 16:05:38 +0300
Message-ID: <CAOQ4uxj2dcP-Uj76ez629kkWh=nAVKDTv0_yV2z7Xcgx+YPLRA@mail.gmail.com>
Subject: Re: [PATCH FOLD] ovl: fix mount api conversion braino
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 16, 2023 at 1:28=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Cleanup sb->s_fs_info when ovl_fill_super() fails before setting
> sb->s_root. The logic is a bit convoluted but tl;dr: If sget_fc() has
> succeeded fc->s_fs_info will have been transferred to sb->s_fs_info. So
> by the time ->fill_super()/ovl_fill_super() is called fc->s_fs_info is
> NULL consequently fs_context->free() won't call ovl_free_fs(). If we
> fail before sb->s_root() is set then ->put_super() won't be called which
> would call ovl_free_fs(). IOW, if we fail in ->fill_super() before
> sb->s_root we have to clean it up.
>
> Amir reported an issue when running xfstests overlay/037 which made me
> investigate and detect this.
>
> Fixes: fc0dc3a9b73b ("ovl: port to new mount api")
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>
> ---
> I would just fold this into ("ovl: port to new mount api"). The patch
> here is mostly so we have a track record of the issue.

Folder (with commit message) and applied to
https://github.com/amir73il/linux/commits/fs-overlayfs-mount_api

I've split out two prep patches, so "port to new mount api" patch
is now as clean as it can be.

>
> Passes both
>
> sudo ./check -overlay overlay/*
> sudo ./check -overlay -g overlay/union
>
> I somehow must've missed the earlier failure of overlay/037.

No failures on my tests so far.

Thanks!
Amir.

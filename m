Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF605A7AC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 11:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiHaJ7K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 05:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiHaJ7G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:59:06 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FD6D11DA
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 02:59:02 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y3so27323922ejc.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 02:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=q329QUVxvNqdpUYaruWm2KhnSKZsr+jne9a4wWXF2ME=;
        b=bbQFkarSZzpP6mjJZ0SA6kW8MzLT6TTbO+IhuUDiV7PTXGZgkWzt0MiET5eKaGtHna
         gwwch3Ohp7KSmVciQJ4QmnqZADrK29U0mD/3GdwkgpEQd1E0HHAMgVNKxKasFahIneGG
         Oj2Ug2I7k0PKXkWofm7kQ8JQodHtDitySRYb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=q329QUVxvNqdpUYaruWm2KhnSKZsr+jne9a4wWXF2ME=;
        b=X+PZci/U3gF/McSlH11JNfssAgqitJIpyd29mt4K+5H19N4ILaPibe52l+MsDtMq0j
         VTcgeMAehdL/Vqm9pFldrdk24mpJBJMA3lXSCsMiMX2wMoiu1yN5hpi51JJgGURzC/be
         Ib4IZwCK9IDcutGoegOR1QSY6Tjnkye8AG/yekDTmmljGkRz5rsNsc4W7+jueejqBB3W
         DbF5DirCLOtbji8dt6lG9HuGtoLhIFYpcW2GZ4+ADH1ZGJD2/ysY6MD296LMNyZ0m/zn
         vcPUzXWEbvv5/uTUjtgNuYhDl9DLuNyMso/CuMeodIW6iJkPWxWuMHn8BD4x85DkqZTG
         U7ZQ==
X-Gm-Message-State: ACgBeo3Hfd1lrUjrUbfuCDyy0PWODT4xfuAywZUWTg8q2eVUBt6Pyp5y
        r6vkzrt+PXSpCbGdLnqoZqfX5Q7Y1nu76OfI/ev5oA==
X-Google-Smtp-Source: AA6agR6sHC+sDrPx6BgumZNbmI6Lqv51V522qwkgAvmgxrfXm/MPuiyXKCwC85XXAj4jDkJjDN8sM/VV6xhHQlebn4s=
X-Received: by 2002:a17:906:8a4e:b0:740:2450:d69a with SMTP id
 gx14-20020a1709068a4e00b007402450d69amr15591282ejc.523.1661939941278; Wed, 31
 Aug 2022 02:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ16EqgEd-BP3XStsR_Cm88Qw2=CTppZo7Ewqv9se+YyzrbzCQ@mail.gmail.com>
In-Reply-To: <CAJ16EqgEd-BP3XStsR_Cm88Qw2=CTppZo7Ewqv9se+YyzrbzCQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 31 Aug 2022 11:58:50 +0200
Message-ID: <CAJfpegugtmfjkW9ysDobNJGZM=G0Y_wrK1uHwANjSnKX1K++SA@mail.gmail.com>
Subject: Re: question about fuse livelock situation
To:     =?UTF-8?B?67CV7JiB7KSA?= <her0gyugyu@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 30 Aug 2022 at 03:58, =EB=B0=95=EC=98=81=EC=A4=80 <her0gyugyu@gmail=
.com> wrote:
>
> I found fuse livelock situation and report it for possibility of problem.
>
> [Environment]
> 22.04 5.15.0-43-generic ubuntu kernel.
> ntfs-3g version ntfs-3g 2021.8.22 integrated FUSE 28 - Third
> Generation NTFS Driver
>
> [Problem]
> I bumped on livelock and analyze it. and concluded that it is needed
> to be fixed.
> it happends when 3 operation concurrently progressing.
>
> 1) usb detach by user. and kernel detect it.
> 2) mount.ntfs umount request & device release operation
> 3) pool-udisksd umount operation.
>
> [Conclusion]
> 1. mounted target device file must be released after /dev/fuse
> release. it makes deadlocky scenario.

Shouldn't this be reported to ntfs-3g developers then?

Thanks,
Miklos

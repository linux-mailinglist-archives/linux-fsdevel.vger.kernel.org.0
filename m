Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82D77B9FD5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 16:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjJEOaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 10:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbjJEO2c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:28:32 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24A720E4B;
        Thu,  5 Oct 2023 03:26:20 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7abda795363so346066241.0;
        Thu, 05 Oct 2023 03:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696501577; x=1697106377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojyjucqL/lMI79N9rhj0UU8Wn1cTd7IMM6zNwMFF2vw=;
        b=U9x92UjZjLngTZS5MuFuIFBj8u0yhRLD4gmnMwYvZB84xUs1A++SXQtk3m/WO23Kf6
         nCDHVPReuNxgri3tUM/3fnJuY7KQLpcTv7+NbAXxJ7YGGplQVcjgVh3rUEakIAhScMhR
         tJSmCVCl8fZZGnp3+9MoCAT6KoBYwYF8bCILpBwA4Elfe5Lo2CuHbTMssZ7B1Da/NDRq
         /wCJiLn3jpw4E+4S58zlBmaqCKA94dECEW+tuGBHA2jJDXAhHAPHgW6OQLnnGXZNchS6
         +lCXxDlpuLYj4CVFF8Mwj+JsfeCSCjH5Zf/85UkZxBwDEm+IcWE/0ylmONmeGMpOxSMZ
         +8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696501577; x=1697106377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojyjucqL/lMI79N9rhj0UU8Wn1cTd7IMM6zNwMFF2vw=;
        b=MrGWRxo1FbkWCNz+V9nZrI/t4Spn10GHpNqz867h/FN7zvhlSgdtzwd270QjQYeZLC
         eZf1UdrEB+844zPnxkPooayzKghHtgpdbj1mu89cW6VZejfjETmdaBAjPdnjE/WDeMuU
         BrDc0FrqUVfeD7/lICfNqoZba/6wNbZIYDuttbh3nNi3AJKP1yudj5XHjWSAiIOZlGTi
         RqP5nbsZHK7X7jW83OvzfjoFa2kHEIhn4wkVrF4H6YEw+0YeNhbeBvqZKVAbrtqfUP2i
         Hwrhfv1BmstBcgSpwiSGjXeqaWre+bx7j7NuZBh8s3u7y4FlOopo0gGdOa5XgxexvVrZ
         9Mjg==
X-Gm-Message-State: AOJu0YzS2x7pjmeeQNXP2PGMOwzAFCX555IzM1G+NY2L2IUnAVIjJ+/U
        BfjxmvyDpEj1plcZkReqYn2cr3t196Io6gp0VoQ=
X-Google-Smtp-Source: AGHT+IGJsrV9RkmMzWmfkR4OgAmorQIZaUVdA2scJ8UavK9XfvC/A2sEdES1seCTlG7zPicZkGtVPJcs863auJjEP3A=
X-Received: by 2002:a05:6102:904:b0:452:8423:e957 with SMTP id
 x4-20020a056102090400b004528423e957mr4957971vsh.28.1696501577288; Thu, 05 Oct
 2023 03:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxhbNyDzf0_fFh1Yy5Kz2Coz=gTrfOtsmteE0=ncibBnpw@mail.gmail.com>
 <0000000000001081fc0606f52ed9@google.com>
In-Reply-To: <0000000000001081fc0606f52ed9@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 5 Oct 2023 13:26:06 +0300
Message-ID: <CAOQ4uxjw_XztGxrhR9LWtz_SszdURkM+Add2q8A9BAt0z901kA@mail.gmail.com>
Subject: Re: [syzbot] [integrity] [overlayfs] possible deadlock in
 mnt_want_write (2)
To:     syzbot <syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com>
Cc:     hdanton@sina.com, linux-fsdevel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, mszeredi@redhat.com,
        syzbot@syzkalhler.appspotmail.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, zohar@us.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 5, 2023 at 12:59=E2=80=AFPM syzbot
<syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot tried to test the proposed patch but the build/boot failed:

My mistake. Please try again:

#syz test: https://github.com/amir73il/linux ima-ovl-fix

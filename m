Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECF1405DB0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 21:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245751AbhIITnD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 15:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344702AbhIITnC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 15:43:02 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A8EC06175F
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Sep 2021 12:41:52 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id l18so4726958lji.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Sep 2021 12:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MiAwSJkdlM3q7lW+2NIC84mnJlfIO/+1BlMfwRFcbeE=;
        b=J6FGIE9uwbqL0+rvyHSZgUsLZy+pRuAap5jTMgiujb4M3LUmi8mHutaAPxSCTMSL1o
         phmkIqJVCwT62rAPr92VTQRpZapgWuL8kTorowvcKtvXLMsOYh2HHK2YZi36zROAidpW
         GaQ7cWDOf/cROEeVmcFUg4BpmB3F39KDNox2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MiAwSJkdlM3q7lW+2NIC84mnJlfIO/+1BlMfwRFcbeE=;
        b=sZRDRTvnKEopg4yPWag4xqWwvGcpDBk79RShqGk/m+td6aUcx2RkCApJhGqZ2fVMqf
         Pm8nptqRZ4aeSPnky1YJuL43d/agpZTokGI3OcyIYUv2nQf87E3Q499uOF3cpQSER1fB
         rZc9nmjbIxWRxdewzqO1b6uVokXSrr1RajXHhyz5Gk9C+PyIzGoFVwa77tjkykJheDT5
         EIFp/L/dReXsg2oTvkAnVX1YmWSS9FZzsCLpQ0E056Y3YXKhDJjCfISCC40OhiMvaMZT
         W8Cohu6VeVBcKZQRjq5XbKTcWwLzn73mhUUKn5QZNQddp3utWOKXTrgHs2D2+HgdKAxS
         NKRg==
X-Gm-Message-State: AOAM5307+lOEgbcCyvGP7PA2ORs0YN4dj1LV3iP/n6ctw3SKsHSOWHgH
        ibpjfybsOfrdX4yxT6g5yrfAYtrqZnMmf/JaG+4=
X-Google-Smtp-Source: ABdhPJwO9zlfl6vDE4dj2Q35zK6wdeszUCCbw2ASVDYgkl8IfxGISFZK/U9MzgkEh8qG9voLPu2ubg==
X-Received: by 2002:a2e:858e:: with SMTP id b14mr1199312lji.508.1631216510624;
        Thu, 09 Sep 2021 12:41:50 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id e11sm292312lfs.263.2021.09.09.12.41.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 12:41:49 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id n2so5951409lfk.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Sep 2021 12:41:49 -0700 (PDT)
X-Received: by 2002:a05:6512:114c:: with SMTP id m12mr1152936lfg.150.1631216509673;
 Thu, 09 Sep 2021 12:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <YTmNE6/yK5Q+OIAb@zeniv-ca.linux.org.uk>
In-Reply-To: <YTmNE6/yK5Q+OIAb@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Sep 2021 12:41:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjOch3=4Nh4tmiAO9UYJZVEeO0UUq8Hegh3JK+pnM9Upg@mail.gmail.com>
Message-ID: <CAHk-=wjOch3=4Nh4tmiAO9UYJZVEeO0UUq8Hegh3JK+pnM9Upg@mail.gmail.com>
Subject: Re: [git pull] gfs2 setattr patches
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 8, 2021 at 9:27 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.gfs2
>
> for you to fetch changes up to d75b9fa053e4cd278281386d860c26fdbfbe9d03:
>
>   gfs2: Switch to may_setattr in gfs2_setattr (2021-08-13 00:41:05 -0400)

Explanation for what this series actually does?

I can see the shortlog, I can look at the commits, but I really want a
summary in the pull request.

                Linus

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA04E7152
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 13:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfJ1M16 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 08:27:58 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34167 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfJ1M15 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:27:57 -0400
Received: by mail-lj1-f195.google.com with SMTP id 139so10941132ljf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2019 05:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lGx03eBCF/ZR/TJOysj+IjW5mFyYp/9PThI32ukvUbA=;
        b=TlTg/tPa+Cb2+B62nozWpbPUhV8ULgTksO+p1fl72Kr55S79U99txmRCJ60LBlWifg
         3f15B172AD36UWaHBr3vrgBAc9IpQ2hR+Y793XsAT5c3FmiBK+BJ3mLyHFGO7kplB+ms
         x7VgD3i+NS30ikRDRUeMZ55lKRiyMQEhf4pU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lGx03eBCF/ZR/TJOysj+IjW5mFyYp/9PThI32ukvUbA=;
        b=CrobmC0HwHZUcRxWFk6UHKgVcNVm15TWCMLJW2Q9L4b5hQ/jhHRJHDP3d3gzzrGv2H
         vbn02ueE++8G8xplqOb5nIZ7JPcJF+k3G6mFCzOFvlIlCBU68NXFxlRaRFHKRN80pyn+
         YLtpCgfQiZsjtgepF1pxx+nDtwoC2UQrNr1z7ad+8wSVFcLMFQWwt7Diz0vKaQi2j2xu
         8ECJqpyzdK5NZthTtEXw+HbYKxlYRXNNBc62/jQ7Te0/AyICSoAXAtCGv8NRyXWQIVeP
         1R9tPfHWUVLZZoNep1BlckpjRbHrgYGcsDVNbOW7a1MEVUElX3Tv94yNADyDWtaid0Tu
         aBqg==
X-Gm-Message-State: APjAAAWo6YTL+wWznnsgbneveTuFMw2JX2m5YfKkzfGtxxwPHsfr7Jc6
        U3LGI2R+HwU3hwHssl9fkqrsM/8kFinjyg==
X-Google-Smtp-Source: APXvYqx56ydxrF2uJaNMisiw3xwRfHnU0xLR58uP86Emm8zhUcwie9axWp6q+rYWIYyRDmUmXlgi2g==
X-Received: by 2002:a2e:9bcb:: with SMTP id w11mr11340776ljj.11.1572265675454;
        Mon, 28 Oct 2019 05:27:55 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id m78sm1649873lje.73.2019.10.28.05.27.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2019 05:27:50 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id s4so10230479ljj.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2019 05:27:48 -0700 (PDT)
X-Received: by 2002:a05:651c:154:: with SMTP id c20mr4826222ljd.1.1572265668380;
 Mon, 28 Oct 2019 05:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <157225848971.557.16257813537984792761.stgit@buzz>
In-Reply-To: <157225848971.557.16257813537984792761.stgit@buzz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Oct 2019 13:27:32 +0100
X-Gmail-Original-Message-ID: <CAHk-=wiCDPd1ivoU5BJBMSt5cmKnX0XFWiinfegyknfoipif0g@mail.gmail.com>
Message-ID: <CAHk-=wiCDPd1ivoU5BJBMSt5cmKnX0XFWiinfegyknfoipif0g@mail.gmail.com>
Subject: Re: [PATCH RFC] fs/fcntl: add fcntl F_GET_RSS
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 28, 2019 at 11:28 AM Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
>
> This implements fcntl() for getting amount of resident memory in cache.
> Kernel already maintains counter for each inode, this patch just exposes
> it into userspace. Returned size is in kilobytes like values in procfs.

This doesn't actually explain why anybody would want it, and what the
usage scenario is.

             Linus

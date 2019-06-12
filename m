Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C56AB41944
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 02:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392164AbfFLAIv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 20:08:51 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33053 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392155AbfFLAIv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 20:08:51 -0400
Received: by mail-lf1-f68.google.com with SMTP id y17so10645080lfe.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2019 17:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h7bjlWA9RPjCrQknFfrxGmOZfe86lgEMXjZF4z0CIJc=;
        b=fACiGCalUO2XSCLIBqg5eKgX23LDEppJOn1sLWj5OXk7jBgNISpvutaLkABFagi12N
         W/z8jn7RtYmkS92dS7UHIwRIxM4EhwbjYq30tqcfX1wuH3cSfTceWerOIKncQ8qkyEln
         cT3/XK6EKWmz6n0E+0+qfrxxDZoAmJ95SztMv48Yc+5SGACW97XTzi1u7vrGoW3b88g3
         a/LfDf+AybhIe9h5dgfsKGc7HDpjmwS7/oAk99rYtF73bGlJT5FgshMUeogSysQhYLRt
         Q8CSrkXJ00/oVrzIwNfRfJvaG4aasPHQOXsIhGcOJrrSu7SmqiHYrbvzgPX0ItJGJ6zA
         nMrQ==
X-Gm-Message-State: APjAAAXmVeDonrS79zFR9Vb+mQlH/73IRJqGtyZ/Lqj58ZjGwoCysmCW
        Qc9BHcaU3yVUYIy8wLi1/A5/B7lI8Jzzd9KKLDo84A==
X-Google-Smtp-Source: APXvYqxFzgjcCWfgMQCGnFILHZZZFt+K2PbIk6ee1UmnlWOWCRs6XovMn177R/Z1IbC6Jj1CsbPXegUVXlXEWHtGkDc=
X-Received: by 2002:a19:ed07:: with SMTP id y7mr41426226lfy.56.1560298129355;
 Tue, 11 Jun 2019 17:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190608125019.417-1-mcroce@redhat.com> <20190609.195742.739339469351067643.davem@davemloft.net>
 <d19abcd4-799c-ac2f-ffcb-fa749d17950c@infradead.org>
In-Reply-To: <d19abcd4-799c-ac2f-ffcb-fa749d17950c@infradead.org>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Wed, 12 Jun 2019 02:08:13 +0200
Message-ID: <CAGnkfhyS15NPEO2ygkjazECULtUDkJgPk8wCYFhA9zL2+w27pg@mail.gmail.com>
Subject: Re: [PATCH net] mpls: fix af_mpls dependencies
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Ahern <dsahern@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 12, 2019 at 1:07 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 6/9/19 7:57 PM, David Miller wrote:
> > From: Matteo Croce <mcroce@redhat.com>
> > Date: Sat,  8 Jun 2019 14:50:19 +0200
> >
> >> MPLS routing code relies on sysctl to work, so let it select PROC_SYSCTL.
> >>
> >> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> >> Suggested-by: David Ahern <dsahern@gmail.com>
> >> Signed-off-by: Matteo Croce <mcroce@redhat.com>
> >
> > Applied, thanks.
> >
>
> This patch causes build errors when
> # CONFIG_PROC_FS is not set
> because PROC_SYSCTL depends on PROC_FS.  The build errors are not
> in fs/proc/ but in other places in the kernel that never expect to see
> PROC_FS not set but PROC_SYSCTL=y.
>

Hi,

Maybe I'm missing something, if PROC_SYSCTL depends on PROC_FS, how is
possible to have PROC_FS not set but PROC_SYSCTL=y?
I tried it by manually editing .config. but make oldconfig warns:

WARNING: unmet direct dependencies detected for PROC_SYSCTL
  Depends on [n]: PROC_FS [=n]
  Selected by [m]:
  - MPLS_ROUTING [=m] && NET [=y] && MPLS [=y] && (NET_IP_TUNNEL [=n]
|| NET_IP_TUNNEL [=n]=n)
*
* Restart config...
*
*
* Configure standard kernel features (expert users)
*
Configure standard kernel features (expert users) (EXPERT) [Y/?] y
  Multiple users, groups and capabilities support (MULTIUSER) [Y/n/?] y
  sgetmask/ssetmask syscalls support (SGETMASK_SYSCALL) [N/y/?] n
  Sysfs syscall support (SYSFS_SYSCALL) [N/y/?] n
  Sysctl syscall support (SYSCTL_SYSCALL) [N/y/?] (NEW)

Regards,
-- 
Matteo Croce
per aspera ad upstream

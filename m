Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7A93CA6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 13:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404180AbfFKLw0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 07:52:26 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51197 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404175AbfFKLw0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 07:52:26 -0400
Received: by mail-it1-f195.google.com with SMTP id j194so4393577ite.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2019 04:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Rnl+iv878Jbd5yCAXuEFcxBsr6AC4Z7Q26Ty1H00uQ=;
        b=HQtANcgMFRytOvbSTwSjIfJ8BxF95qiHKWOo73rFifB37lQdNF6obb3FoYqoilaRrH
         b7duEikwgALL+TnLznPIpCHPol4S1xW6N7PPH6KR+wTmk2ed9V0UNj83zbPHTyaJTFMe
         uHCgYjoOIUVa27dJRIQSu4wBGf9a1L1yki5U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Rnl+iv878Jbd5yCAXuEFcxBsr6AC4Z7Q26Ty1H00uQ=;
        b=OTGa+1JtduCOS491eaHFdpNOyGgiF5A82eI4LAxVgCRgJqT14zcJKrHVpUYK6Jbvcc
         fmHFb4qt0eeYOWkkUbhfugBU24jiJE+1m6d7EzhK42yYEr4fblXz6OjV5W3KEB4ikEam
         LJfTg4kSULPH0ytRLv0TPq3I4pNU0AGreXNSxgfnrQ7UEFGCAq01pdGnc/7upcTVnvJu
         LG2dVL+qTHC3d/RO/Qw/HbelDJ/1zXJSNYyApGaHJGZMe+VJbTaRy/25QGV6xHixzQmI
         nDgHPWEnrDtvMFHSUCcnM6VHvs5tW5eKC8m/WXo1HdfzCkuwRh0+sYopIav7+8P+7uL4
         3uXg==
X-Gm-Message-State: APjAAAW+iRiu4wxaFHhJq0kQuy4+FmqIF478RtxP4Qp1M7XMukUy9dqh
        8VgZRh/UBNMSKydD/Ke/q6tt0AVFOLDEgIX9gsSAiQ==
X-Google-Smtp-Source: APXvYqyBqb2mf4EIhWTha2V0Nr+epAc/RrG6INwplSgR+9kR5PXgvLBJYF2E1ctg/yS1B7vB6IQcvJkG/kFgqfIavZg=
X-Received: by 2002:a24:292:: with SMTP id 140mr18945217itu.57.1560253945573;
 Tue, 11 Jun 2019 04:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <876aefd0-808a-bb4b-0897-191f0a8d9e12@eikelenboom.it>
In-Reply-To: <876aefd0-808a-bb4b-0897-191f0a8d9e12@eikelenboom.it>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 11 Jun 2019 13:52:14 +0200
Message-ID: <CAJfpegvRBm3M8fUJ1Le1dPd0QSJgAWAYJGLCQKa6YLTE+4oucw@mail.gmail.com>
Subject: Re: Linux 5.2-RC regression bisected, mounting glusterfs volumes
 fails after commit: fuse: require /dev/fuse reads to have enough buffer capacity
To:     Sander Eikelenboom <linux@eikelenboom.it>
Cc:     Kirill Smelkov <kirr@nexedi.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        gluster-devel@gluster.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 11, 2019 at 1:03 PM Sander Eikelenboom <linux@eikelenboom.it> wrote:
>
> L.S.,
>
> While testing a linux 5.2 kernel I noticed it fails to mount my glusterfs volumes.
>
> It repeatedly fails with:
>    [2019-06-11 09:15:27.106946] W [fuse-bridge.c:4993:fuse_thread_proc] 0-glusterfs-fuse: read from /dev/fuse returned -1 (Invalid argument)
>    [2019-06-11 09:15:27.106955] W [fuse-bridge.c:4993:fuse_thread_proc] 0-glusterfs-fuse: read from /dev/fuse returned -1 (Invalid argument)
>    [2019-06-11 09:15:27.106963] W [fuse-bridge.c:4993:fuse_thread_proc] 0-glusterfs-fuse: read from /dev/fuse returned -1 (Invalid argument)
>    [2019-06-11 09:15:27.106971] W [fuse-bridge.c:4993:fuse_thread_proc] 0-glusterfs-fuse: read from /dev/fuse returned -1 (Invalid argument)
>    etc.
>    etc.
>
> Bisecting turned up as culprit:
>     commit d4b13963f217dd947da5c0cabd1569e914d21699: fuse: require /dev/fuse reads to have enough buffer capacity
>
> The glusterfs version i'm using is from Debian stable:
>     ii  glusterfs-client                3.8.8-1                      amd64        clustered file-system (client package)
>     ii  glusterfs-common                3.8.8-1                      amd64        GlusterFS common libraries and translator modules
>
>
> A 5.1.* kernel works fine, as does a 5.2-rc4 kernel with said commit reverted.

Thanks for the report, reverted the bad commit.

Thanks,
Miklos

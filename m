Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01DE510935C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 19:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfKYSRM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 13:17:12 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:36506 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbfKYSRL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 13:17:11 -0500
Received: by mail-il1-f195.google.com with SMTP id s75so15105333ilc.3;
        Mon, 25 Nov 2019 10:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XNvmuvfR13K+bepkBmPkJQDh2DcCBvXY1vhlGmjrkSQ=;
        b=cfpPCKztKRoWFw9gU0+NsNuYAetbF3Z/a4D/7R0eDl7/zhS7+oVdMGW62X2CKXoRwH
         jfeDbMcGYFyGsRJ6DY2ACog0bpH++4TlJeHXHBbAN4UTbjWyCzBQOXQbTfmBkqtOFffb
         L2cifP060mBBHiocqRCzV7sTnJb+CGEp+hkt1h3OVURv+kRe5ddgiaA9SmZHEE81PHly
         QFY3FDXZswnaPgB3kqmMJLdTbghNw5MNntz8P7mTwEDUej5pr5fNq7+7+T/gEczCO+XN
         hXUjtj70mm5RIC5G7pb1J875Gpr+43Ed3rWK7wCi71W4StwsMwzr1exl4jD5rBlvyT65
         qTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XNvmuvfR13K+bepkBmPkJQDh2DcCBvXY1vhlGmjrkSQ=;
        b=RTZFKUoPhSyaEotRxD0LhOf5eqAJnPS0pGPg2sd80SmZUCxYrx9D/tTVEMkIWUx4Lj
         9gOaupdnWNvMNB4PEvOJn/fnHX8fcmYdV114hQHaUsIyHtWvXLqncDnGx+JD3lVQKoyP
         sOcPEa3S8VONXifC36D6Eo/ymlYDP+KOV3F/Sp1ljcDtnoLx3JNSFLE+looVxZy+qgaV
         TcjIcKmlLUSPVIMw+aFthbp1xvgn1LU6dp1O1FOkal13Ky0pBXpMzlH7ojelIlo37/XL
         jnHppFXsJbmX77hRF7w2VHOiBdv6GmVUuynHQEU/cvs2TnQqZC2Y3Cnt/gQiP+2bCUMl
         uo1A==
X-Gm-Message-State: APjAAAWWV5wOgEhpjW4mLVo4s+hHQKgvD9Q0vhUGT+wxH3PPTyA8tltZ
        9oTuW1zEiAB6XFd57kej1uuNmkwrWTinAKRZdyM=
X-Google-Smtp-Source: APXvYqw78v3arYJMRZHIVLUyH0UknW8rGs2UZ5LBxnpquKgU2PPRG0oB/krijAz/74tFXtSGiOCOUuYep3Lc7hWfR5U=
X-Received: by 2002:a92:d390:: with SMTP id o16mr34224478ilo.110.1574705830800;
 Mon, 25 Nov 2019 10:17:10 -0800 (PST)
MIME-Version: 1.0
References: <20191124193145.22945-1-amir73il@gmail.com> <20191125164625.GB28608@fieldses.org>
In-Reply-To: <20191125164625.GB28608@fieldses.org>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Mon, 25 Nov 2019 10:16:57 -0800
Message-ID: <CABeXuvo3pToaexO26JarHHkQBWO9355YEyO=NeZh-36KciJu6Q@mail.gmail.com>
Subject: Re: [PATCH] utimes: Clamp the timestamps in notify_change()
To:     "J . Bruce Fields" <bfields@fieldses.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Jeff Layton <jlayton@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 25, 2019 at 8:46 AM J . Bruce Fields <bfields@fieldses.org> wrote:
>
> On Sun, Nov 24, 2019 at 09:31:45PM +0200, Amir Goldstein wrote:
> > Push clamping timestamps down the call stack into notify_change(), so
> > in-kernel callers like nfsd and overlayfs will get similar timestamp
> > set behavior as utimes.
>
> So, nfsd has always bypassed timestamp_truncate() and we've never
> noticed till now?  What are the symptoms?  (Do timestamps go backwards
> after cache eviction on filesystems with large time granularity?)
>
> Looks like generic/402 has never run in my tests:
>
>         generic/402     [not run] no kernel support for y2038 sysfs switch

You need this in your xfstest:
https://patchwork.kernel.org/patch/11049745/ . The test has been
updated recently.

And, you need a change like for overlayfs as Amir pointed out.

-Deepa

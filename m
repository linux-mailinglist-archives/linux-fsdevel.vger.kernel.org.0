Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7E218B836
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 14:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgCSNkv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 09:40:51 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34072 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgCSNkv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:40:51 -0400
Received: by mail-io1-f68.google.com with SMTP id h131so2294933iof.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2020 06:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6tZoDH+S4pKybL9z+J1imqJhHGx0DnzzHHYGZCA73Xs=;
        b=QP+O14xpd6ei/T2pkgz5vVkXlj/jRjAvdjUW/8xUI4N8VGhP5wpGHeeP5MwiwxzkGi
         mRjfSClkGcoVUJF2YLSo32u8zvPuURllUemVTBkZhSYACW97+Tp/oeBzyBEVSNZIQxEk
         Le8zreeIFUQUpIhPO+Jz6+zBV08cur/E77Moc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6tZoDH+S4pKybL9z+J1imqJhHGx0DnzzHHYGZCA73Xs=;
        b=nSqhNcsMWku5/gjw+zi5pOohgvw3HToej65t9NbAyNbiBFuIIrMnsIYxiMSMAR3Vdv
         ujRW12THS1YUlxTmx0yCL3Qfx1UigmP7xJLIJLoSwEaFl3g7+qex8NyOn5/N5SATz1Xb
         EuhBXpIQGaiog1ouL2bzqqp9fZsGPrSGaqys86FEQDZgCKEHU27v28M8hBzYau1yHLeZ
         CkSDYS8BPuefAOiJUR2UudxX30GSuUv8QChEmJZJ+bDdV0RWv1AnSimmEUKZ67DH/Bd6
         NUShZK0Yr7Df230R3f1X/wtgY2uFK4idI1Bd2Bu0Ii7mY9K6XDlPDZGj+SKxZtB0tKrB
         1UHw==
X-Gm-Message-State: ANhLgQ27xx2H0i2b//s8Zbg6TEvS6MDJcDT7cqNqPukIKYPi5HAZ5wlW
        Mqyiqh5heJ+Su736Y7RwIpHWlFBzZ1pP0FmCc0jHZpmofx0=
X-Google-Smtp-Source: ADFU+vsYK+ujNjOhdrmLIqruoqgzpPNdidGY+hbZASVW/wCIpOni99oahetVvaA8Rroxlg2kUuMF2C/jvj6c3ZfrauA=
X-Received: by 2002:a05:6638:1241:: with SMTP id o1mr3043799jas.11.1584625249293;
 Thu, 19 Mar 2020 06:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200221173722.538788-1-hch@lst.de> <CAHc6FU5RM5c0dopuJmCEJmPkwM6TUy60xnSWRpH2qHdX09B1pw@mail.gmail.com>
 <20200317145744.GA15941@lst.de>
In-Reply-To: <20200317145744.GA15941@lst.de>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 19 Mar 2020 14:40:38 +0100
Message-ID: <CAJfpeguvn5QQp00Xkz2u-8_PKPK++1wsmGF++mtLREgRVgraVg@mail.gmail.com>
Subject: Re: [PATCH] fs: move the posix_acl_fix_xattr_{to_from}_user out of
 xattr code
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 17, 2020 at 3:57 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Mar 03, 2020 at 02:42:50PM +0100, Andreas Gruenbacher wrote:
> > Miklos,
> >
> > On Fri, Feb 21, 2020 at 7:01 PM Christoph Hellwig <hch@lst.de> wrote:
> > > There is no excuse to ever perform actions related to a specific handler
> > > directly from the generic xattr code as we have handler that understand
> > > the specific data in given attrs.  As a nice sideeffect this removes
> > > tons of pointless boilerplate code.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >
> > can you please review this change from an overlayfs point of view?
>
> ping?

To me it looks like these need fixup:

fs/overlayfs/dir.c:
-    err = posix_acl_to_xattr(&init_user_ns, acl, buffer, size);
+    err = posix_acl_to_xattr(current_user_ns(), acl, buffer, size);

fs/overlayfs/super.c:
-        acl = posix_acl_from_xattr(&init_user_ns, value, size);
+        acl = posix_acl_from_xattr(current_user_ns(), value, size);

Thanks,
Miklos

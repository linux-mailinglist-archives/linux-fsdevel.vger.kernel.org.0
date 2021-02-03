Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E8B30DC66
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 15:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhBCOO0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 09:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbhBCOOV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:14:21 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146E9C061786
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Feb 2021 06:13:41 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id x201so5453364vsc.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 06:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oU/93QWt8YD3nG8PHbG11kP76EWEDbpdRCYhJ3RyBck=;
        b=CygF7dll1G/EwG+5W21ESZpamAdSlACPUFFLe2p4fkqUqTCWph28NUWHtSaiWo3Rxz
         176M5KpldgkGY8hxk7MapWqHFed12+0rnJQEYCAeYkExDwgVm0A3cm50zNQHtoyGCNLN
         HaeaVLW1ZeZtSqfZOSi4e1NCP9cWgSGl0mr6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oU/93QWt8YD3nG8PHbG11kP76EWEDbpdRCYhJ3RyBck=;
        b=pWxl6xIrttes01XfdKMsPEe2lA8JZJzmvarFlihR4i2usaxFiCyK04iVIVQbrzEB9c
         3n6nIKSZ7ZIRCGkjHQVM99LzH4TYCRf2RLbHZ9ub4/mjwOXaTH7hpQxvWkApCeGYwPSF
         IJ/SqtTrclrMbadUL8HR5bbbL6bdSuANIL9fjC64vPyjGh661a16GIEbT3kYwn0/JagZ
         t7EwiZL+LjzcJhqLIRmL+NvqDxV1QQFbmZePRDszzLZUOdAK/7PcIG0I5Z1ux2JJOGPu
         q7TaoNpbuOt9Vg3pvKjiog7VZcBUy2WWk7wDj6M1M2lTLgjpwcRtlL3v2zUCZQWNKyrs
         ROmg==
X-Gm-Message-State: AOAM5331yJuxyxKnqF4qzBakhv29dHIBUiIU97N8SWVJju29RYJEFGPS
        bm4Nho6kQV1p5fv9wHPhfJV4kVPPfy7sdLysjzQESA==
X-Google-Smtp-Source: ABdhPJxlAevD2fHZxIrX0U8Fn6wG9CNNASVAX+XdxlFkf+8NhyoTK/DaYvyPKuoYvls2PXAUx9+TV01qLOO4lMFYwgU=
X-Received: by 2002:a67:ea05:: with SMTP id g5mr1576931vso.47.1612361620214;
 Wed, 03 Feb 2021 06:13:40 -0800 (PST)
MIME-Version: 1.0
References: <20210203124112.1182614-1-mszeredi@redhat.com> <20210203130501.GY308988@casper.infradead.org>
 <CAJfpegs3YWybmH7iKDLQ-KwmGieS1faO1uSZ-ADB0UFYOFPEnQ@mail.gmail.com> <20210203135827.GZ308988@casper.infradead.org>
In-Reply-To: <20210203135827.GZ308988@casper.infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 3 Feb 2021 15:13:29 +0100
Message-ID: <CAJfpegvHFHcCPtyJ+w6uRx+hLH9JAT46WJktF_nez-ZZAria7A@mail.gmail.com>
Subject: Re: [PATCH 00/18] new API for FS_IOC_[GS]ETFLAGS/FS_IOC_FS[GS]ETXATTR
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger@dilger.ca>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Joel Becker <jlbec@evilplan.org>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Richard Weinberger <richard@nod.at>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Tyler Hicks <code@tyhicks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 3, 2021 at 2:58 PM Matthew Wilcox <willy@infradead.org> wrote:

> Network filesystems frequently need to use the credentials attached to
> a struct file in order to communicate with the server.  There's no point
> fighting this reality.

IDGI.  Credentials can be taken from the file and from the task.  In
this case every filesystem except cifs looks at task creds. Why are
network filesystem special in this respect?

Thanks,
Miklos

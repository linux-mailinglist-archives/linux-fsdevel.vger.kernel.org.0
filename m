Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 918FA14EFC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 16:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgAaPip (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 10:38:45 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:33662 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbgAaPip (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 10:38:45 -0500
Received: by mail-il1-f193.google.com with SMTP id s18so6521821iln.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2020 07:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=46S1L/Fr2OaAYBi+gQ6U/X2dMBzkNkSrL5I3ADHH34Y=;
        b=P+56vbpjy9arzNUOUGlRxnZlFRq3z+7woJuw9mvdXGsQAUBgmsIpbDa/dFOfsZUWmy
         Ikd0AAvjwEykU+VS8hpvHR9s6wrU9vV6XyppnUAbE66h4Po876JU1xKI2Z4bUFTFECyI
         k5iMIxVShfinfb7+B7IGxjypu2vvgTV2OCnOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=46S1L/Fr2OaAYBi+gQ6U/X2dMBzkNkSrL5I3ADHH34Y=;
        b=joBU0L8emXGLl5TaYwDRLdz1VS3Doyt7rORfdstUyFkm1Mw3nFWB9q7UWCkjsOy+uE
         wr6ifHQoRoLCOT/mEAmCHerdllKRjvNRVLDIaIRNkITAggEyi00YQrskDewaDDfQJ7sR
         fOCi3ICA4OJcWKIPUDUzDoV/BVQqmD+FD8XbLeAqhmBOyX5thYuFszS4L4p0kXlXkfV2
         kg+HkWnKkqYMrw5ni2n65ATCjkD9OocQDYIS8HUn+6YzZ69BHaehkvC2llzIUgx5sPk4
         TGfxl1ryiyXE5268cXeQ+DsyaKeucPXH/9UDF/YtoaPO+538JPopLx0Ms27sJnzzKC3j
         smOg==
X-Gm-Message-State: APjAAAW2qPLgCrsC1omq3oIqHmrmq8kRIC16kV2GM1hKh+WWL/w31xoD
        oHSZxBqvCIYN/Byr1mmRR54p1QvHYjuXCBFsTNcMFFYu
X-Google-Smtp-Source: APXvYqwwWX+2KKEll78rpV4fbd4o4omNYbJeY32yB8vH9xNP8HNGg0uvOxQs+Uihl0iRsF4rUY4bhhqIB/UzGqIPsBk=
X-Received: by 2002:a92:c0c9:: with SMTP id t9mr10212110ilf.174.1580485124724;
 Fri, 31 Jan 2020 07:38:44 -0800 (PST)
MIME-Version: 1.0
References: <20200131115004.17410-1-mszeredi@redhat.com> <20200131115004.17410-5-mszeredi@redhat.com>
 <CAOQ4uxgV9KbE9ROCi5=RmXe1moqnmwWqaZ98jDjLcpDuM70RGQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgV9KbE9ROCi5=RmXe1moqnmwWqaZ98jDjLcpDuM70RGQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 31 Jan 2020 16:38:33 +0100
Message-ID: <CAJfpegvMz-nHOb3GkoU_afqRrBKt-uvOXL6GxWLa3MVhwNGLpg@mail.gmail.com>
Subject: Re: [PATCH 4/4] ovl: alllow remote upper
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 31, 2020 at 4:30 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Fri, Jan 31, 2020 at 1:51 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
> >
> > No reason to prevent upper layer being a remote filesystem.  Do the
> > revalidation in that case, just as we already do for lower layers.
> >
>
> No reason to prevent upper layer from being a remote filesystem, but
> the !remote criteria for upper fs kept away a lot of filesystems from
> upper. Those filesystems have never been tested as upper and many
> of them are probably not fit for upper.
>
> The goal is to lift the !remote limitation, not to allow for lots of new
> types of upper fs's.
>
> What can we do to minimize damages?
>
> We can assert that is upper is remote, it must qualify for a more strict
> criteria as upper fs, that is:
> - support d_type
> - support xattr
> - support RENAME_EXCHANGE|RENAME_WHITEOUT
>
> I have a patch on branch ovl-strict which implements those restrictions.

Sounds good.  Not sure how much this is this going to be a
compatibility headache.  If it does, then we can conditionally enable
this with a config/module option.

>
> Now I know fuse doesn't support RENAME_WHITEOUT, but it does
> support RENAME_EXCHANGE, which already proves to be a very narrow
> filter for remote fs: afs, fuse, gfs2.
> Did not check if afs, gfs2 qualify for the rest of the criteria.
>
> Is it simple to implement RENAME_WHITEOUT for fuse/virtiofs?

Trivial.

> Is it not a problem to rely on an upper fs for modern systems
> that does not support RENAME_WHITEOUT?

Limited r/w overlay functionality is still available without
whiteout/xattr support, so it could turn out to be something people
already rely on.  Can't tell without trying...

Thanks,
Miklos

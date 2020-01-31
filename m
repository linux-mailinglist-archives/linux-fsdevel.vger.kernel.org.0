Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 328C514EF56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 16:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgAaPPk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 10:15:40 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40525 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbgAaPPf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 10:15:35 -0500
Received: by mail-io1-f68.google.com with SMTP id x1so8491685iop.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2020 07:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qNOGVIc+75M2s1F0an171FX0kOJfthBjK3mNSx0gzqs=;
        b=nTUFJOyW7qYZNnkYpIbPOkVP7TA/Wzpc9oqvr6kwxfh5EE3sc79xfb0jn/s31Xr1wB
         ZMFqdCwtRt/j8pszVtXHN/TdA6T3WJdIXua66BIHfnBQXVyDpxDUEDgvS3Tt29r0MJtQ
         97vNyAFx1wGq4eeWocyS70tdeaUtXT8jRVkk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qNOGVIc+75M2s1F0an171FX0kOJfthBjK3mNSx0gzqs=;
        b=jZ6EcmDuczLEVk8OFxiCcOPvyCsX9578xnlY/YWZlHQ6ctYFYScYnVyB60mrUqXvHr
         mX7FCTTT4EVMNdemGCrDerpoQGJRhQYo/jrschSQFRKwoTb4rfkJQXqySTE0mV2CFmfl
         AEOHbo2WwSlc9Wx+fsiZpbSYnBZRi46cMcHmpQA84feQABjXmabIOBesmDRq+rtKrpjK
         rcfyoYAYvhns2mrbex9dtUqVaX4wphdKNXFYdjVYTJS4SbDNt/kezIrSN9mNYnlJhUOR
         FgWdzpy1H90/kKrIxLdO1IyPHJUCqC/ehIRjLwJqVBEW9WL6dIWoJO+wQdb5V5Dz1IKl
         radg==
X-Gm-Message-State: APjAAAX/OjoJB9uOwIFlLmfeUsiq4ZzHtUl/ElBqw3QMsVUg/L9CTkAi
        oveYYsEJbCg5y3SpEgRMF/LmI7O5ToFrBkyvzcvYyw==
X-Google-Smtp-Source: APXvYqw6nhm24Myv1X36IeuA9xaHU4a25zpyNDyg+RpiU0BrKWDJUY9DMs7AjvpIPABAKLghFPkSuU3rflo28vHTLVc=
X-Received: by 2002:a5d:9a05:: with SMTP id s5mr8776299iol.252.1580483734425;
 Fri, 31 Jan 2020 07:15:34 -0800 (PST)
MIME-Version: 1.0
References: <20200131115004.17410-1-mszeredi@redhat.com> <20200131115004.17410-4-mszeredi@redhat.com>
 <CAOQ4uxjR+6wqWMKf18qOEKk-VndVaHPtttPf6c06yK=9OphB8Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxjR+6wqWMKf18qOEKk-VndVaHPtttPf6c06yK=9OphB8Q@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 31 Jan 2020 16:15:23 +0100
Message-ID: <CAJfpegsek1OM+XGA5mHMTuZ_r37hp_e_YkQkgaXjWJu=dvpONA@mail.gmail.com>
Subject: Re: [PATCH 3/4] ovl: decide if revalidate needed on a per-dentry bases
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> > index 67cd2866aaa2..3ad8fb291f7d 100644
> > --- a/fs/overlayfs/util.c
> > +++ b/fs/overlayfs/util.c
> > @@ -90,10 +90,19 @@ struct ovl_entry *ovl_alloc_entry(unsigned int numlower)
> >         return oe;
> >  }
> >
> > -bool ovl_dentry_remote(struct dentry *dentry)
>
> Removed too early. It still has users.
> Otherwise looks ok.

Thanks, fixed ones pushed to @ovl-remote-upper-v2.

Thanks,
Miklos

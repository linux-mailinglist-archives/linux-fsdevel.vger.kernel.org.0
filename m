Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165BB3F246D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 03:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbhHTBtq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 21:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbhHTBto (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 21:49:44 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4CBC061575
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Aug 2021 18:49:07 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id p4so15940642yba.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Aug 2021 18:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cfA42dYUBZY6kxKenPYN1PDY1E3ZRSIEN7D/AlYpFrE=;
        b=cuViM2TUQIsTEtgf9kRqZyKiDbpZFnU+scXYX5sxzQymd23QuAMJQP+YDwZb0YqGUo
         BXEwztG0qbBX9IXZokrLgXD5ayOgRBxC8c60FZDoTayrn+FTBq+WVKHZEbbC9zO3QVlZ
         sNIv1Qkr11WRifxzg97obqjeTuN4aeDZezpwaQYtC7hIAy0w6mm94GFbOsFDpYGAkSnL
         ilNwr97j9+CkEo1QSp4YmUqtj/vMx4WUJGYKTVqAdggkzaNRvt07LA9uE4ulmUgy1sLV
         1KYUCrbucoX8GX6yUmOO9AJen85v9eS3B/CoO+eRuBKHHRSAFTsYCd0VcB30tC41f6D2
         S6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cfA42dYUBZY6kxKenPYN1PDY1E3ZRSIEN7D/AlYpFrE=;
        b=gxYiqmVOCkYOjBU7u8mOANchDxUHD96Rav2GLHE7CxhEwbZKbHPIWlUUGs+lSvvxBI
         rfzJ8V6fduX/A8iBPH7TytDoPqQ8prOUPoRR8a7a53JyVy3aqONKr/86cc41qCiyqUf/
         s8pSjNBYnp6ZfdAz7JSFGsoauAmfwUukMNWDdd+ycG2YIkr3gf81QzQ8Ep/1ghFYEkXb
         YjLWNKHY+SEfbEZTA2xNZ7VpRuYmF0mhtQUpHK/e6hSIqlX3DO9Qs604FOgp8Qup86sL
         cwchU6/6DUPLUFmvJAOdrj4tHeDazAZ/lHykhY1jtYwqmKa5Ps9ncN2r5gr6YRqkGU/r
         7FpA==
X-Gm-Message-State: AOAM532tlFIwG+XShOAWFH6F5TIrh9Lu4dAnvt8zYJogOHHWWMb+pIg/
        wFrOmeEHeRhR75arybKUbuc/BnZMAkv+73CKe9B5u3fjoa8=
X-Google-Smtp-Source: ABdhPJwEgUaLGLBXDnG+J06MbaLtrnsU1e/xUAHzg39aFbWIEdGKM5k5OkOIFw3txmAYe8ZngH+DYboH0+BJCG3jeLY=
X-Received: by 2002:a25:49c3:: with SMTP id w186mr582252yba.383.1629424146438;
 Thu, 19 Aug 2021 18:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAPm50aLNUNGo94u1yVKSJwy3rehRP84ha8YmbOdMyehFeVah0w@mail.gmail.com>
 <CAJfpeguDzHO9rx4eVRi4Lvjj0O9-oT8SEN7JAfWtsNj-6M_YAA@mail.gmail.com>
In-Reply-To: <CAJfpeguDzHO9rx4eVRi4Lvjj0O9-oT8SEN7JAfWtsNj-6M_YAA@mail.gmail.com>
From:   Hao Peng <flyingpenghao@gmail.com>
Date:   Fri, 20 Aug 2021 09:48:42 +0800
Message-ID: <CAPm50a+0UK-CvBHZXxjxXpGns3AXpewWyviPyTaq8oQLHcs99Q@mail.gmail.com>
Subject: Re: [PATCH] fuse: Use kmap_local_page()
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>On Tue, Aug 17, 2021 at 11:42 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, 17 Aug 2021 at 05:17, Hao Peng <flyingpenghao@gmail.com> wrote:
> >
> > kmap_local_page() is enough.
>
> This explanation is not enough for me to understand the patch.  Please
> describe in more detail.
>
Due to the introduction of kmap_local_*, the storage of slots used for
short-term mapping has
changed from per-CPU to per-thread. kmap_atomic() disable preemption,
while kmap_local_*()
only disable migration.
There is no need to disable preemption in several kamp_atomic places
used in fuse.
The detailed introduction of kmap_local_*d can be found here:
https://lwn.net/Articles/836144/
Thanks.
> Thanks,
> Miklos

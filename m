Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE565311545
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 23:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhBEW04 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 17:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbhBEOTm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:19:42 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90627C061B3F
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Feb 2021 07:56:06 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id t11so1138890pgu.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Feb 2021 07:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JwvNzK6nDq5Er9R9/mIvhs7c3RrwWuEVZBZei4KWYqY=;
        b=FMNnzyNhGvGrRmFsvBh607EIWOmz7XwcD84qO4dbG0OfIZQ0Ly+R721iqPk5P8MV86
         5bW3X9IDgkObEdvoef79Va2EZHc1DurM//VSGsQ+T7xfQX+MFVNr23ufVGXse+lWb45b
         CjihLHzKNQJElOM/0y5B6qcBDRhSH7swANtjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JwvNzK6nDq5Er9R9/mIvhs7c3RrwWuEVZBZei4KWYqY=;
        b=SF8jx1HkPF40y9rQrQosTV3rBJC8TVl9nFB4ca/7Pxi0+dl7VoWoW7VzqRhqgvfH2T
         sSXHBeGrmNSmCEaQzJrgDZRxBDBszvbggJHD13Yktd4OKA+MFJvo6tOInPSoXD2JeXzx
         mt1FggBzy6s8kIqSu4J4/KZ7EHHzoupCoSvsZ+F0f39LmHxh8r2GUyyVCjG9ePjHyYPZ
         ag7mUrzxR8OZzftpJ+sGDk649HzWc4sjmvdH6/ldAijjDgCaSUDSSvXxG5wjiIeXmIcd
         ikmiwS1SdQKG+HGUaujDzr4spp7E5E+wMUT2R2NTpyicbUUaRLIKb2LTDjuZWPs0Rx2+
         C8AA==
X-Gm-Message-State: AOAM531AAUEWqpokiJ5W0Bj+Tok5gc2aSE8CoKI4wksSV73tSf6+eJ9/
        eLGW4ZoIizgIrEHvXkXYM4BJmmZi9oQKJkCsWy8NwEsn+Qo=
X-Google-Smtp-Source: ABdhPJxpiAIajbp/96HYuphp6BimXqFpSrJVysECPVTL0775RsCWnYLm38EXKrqHWjQJX0xMQP5kjhre7scrOTH2TCo=
X-Received: by 2002:a67:a404:: with SMTP id n4mr3263723vse.0.1612538770907;
 Fri, 05 Feb 2021 07:26:10 -0800 (PST)
MIME-Version: 1.0
References: <20210203124112.1182614-1-mszeredi@redhat.com> <20210203124112.1182614-4-mszeredi@redhat.com>
 <20210204234211.GB52056@redhat.com>
In-Reply-To: <20210204234211.GB52056@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 5 Feb 2021 16:25:59 +0100
Message-ID: <CAJfpegv+dtVZWJ1xmagaZsGfg3p9e0Svj_qFXiWYQ3ROvGPHLg@mail.gmail.com>
Subject: Re: [PATCH 03/18] ovl: stack miscattr
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 5, 2021 at 12:49 AM Vivek Goyal <vgoyal@redhat.com> wrote:

> > +int ovl_miscattr_set(struct dentry *dentry, struct miscattr *ma)
> > +{
> > +     struct inode *inode = d_inode(dentry);
> > +     struct dentry *upperdentry;
> > +     const struct cred *old_cred;
> > +     int err;
> > +
> > +     err = ovl_want_write(dentry);
> > +     if (err)
> > +             goto out;
> > +
> > +     err = ovl_copy_up(dentry);
> > +     if (!err) {
> > +             upperdentry = ovl_dentry_upper(dentry);
> > +
> > +             old_cred = ovl_override_creds(inode->i_sb);
> > +             /* err = security_file_ioctl(real.file, cmd, arg); */
>
> Is this an comment intended?

I don't remember, but I guess not.  Will fix and test.

Thanks,
Miklos

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF4132ED6B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 15:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCEOsX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Mar 2021 09:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCEOsO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Mar 2021 09:48:14 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02DBC061574
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Mar 2021 06:48:13 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id d25so1066683vsr.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Mar 2021 06:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=37W8TGaMYq9fdsSZ/oWmvBfLa7Md34iai9k20+Je5v8=;
        b=Ke6uANZjKR7vA/CtgRdIzIJXRk582DxKVDqpGSzjylquDV86pphvXTewuyAjurdHmZ
         y6GchW4zzV9z5NkmfE37HBY5EupivsmScUdp3s7ZwoHEb25eRSZ/Dit3jVLoG8I+CNFm
         4C15d6S6/qIcOhaXfQMCa0EM8rDc6SgewQixs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=37W8TGaMYq9fdsSZ/oWmvBfLa7Md34iai9k20+Je5v8=;
        b=YrF8Vy1WC71A0bfJLdcLl+/UnMd33aDiB3nsHzsMcbfysCPtejBGt1KKsYMyCzW3ER
         uaAYMstEn3QQ195elD+EZgAlJ4Ezy/NsJd25wYOxaz5zeDGahobtGZuKIVH2RVywAZGP
         CKD5ynuCEVlGQpiBV49hJVAnC35gjWYDygpKhKw0IOeQ0hiFITrOVfCh308PUqNkqa1e
         sedc4MnOijWVXQvZ10H/TihQGS1gLbFsLZWAm9zgFglI1kp26y196W8wVfkg6NtjDaTH
         YlDBEYR8Dc9gHnPWfeqlrHvlXbQVJEjjaSLlghAqwWhgmsARWGWN7zY2XwSLGz+y/Cwf
         eXsQ==
X-Gm-Message-State: AOAM533AOGPPpmoCIiytoq+7v174ISz94fIdxu36xbwuUozUzoLKVvo6
        lMCZPTEcMNE84n54LNFNCyE610MEWBn4Eaxxo8iZ2w==
X-Google-Smtp-Source: ABdhPJxLqFb4GRSUG2242Vb2y5H6eZMVJCR4nE5VMZyxxWTfNaBcAll11X2rtONq+ZojNoi1hHvf9M7MXr4Y9memdco=
X-Received: by 2002:a67:c992:: with SMTP id y18mr6763594vsk.7.1614955693024;
 Fri, 05 Mar 2021 06:48:13 -0800 (PST)
MIME-Version: 1.0
References: <20210209224754.GG3171@redhat.com> <20210305133401.GA109162@redhat.com>
In-Reply-To: <20210305133401.GA109162@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 5 Mar 2021 15:48:02 +0100
Message-ID: <CAJfpegs9uCd8666YKjuhSd_0=_tqLNEmrtQEtX44=+AdcEHVdA@mail.gmail.com>
Subject: Re: [PATCH] virtiofs: Fail dax mount if device does not support it
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 5, 2021 at 2:34 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Tue, Feb 09, 2021 at 05:47:54PM -0500, Vivek Goyal wrote:
> > Right now "mount -t virtiofs -o dax myfs /mnt/virtiofs" succeeds even
> > if filesystem deivce does not have a cache window and hence DAX can't
> > be supported.
> >
> > This gives a false sense to user that they are using DAX with virtiofs
> > but fact of the matter is that they are not.
> >
> > Fix this by returning error if dax can't be supported and user has asked
> > for it.
>
> Hi Miklos,
>
> Did you get a chance to look at this patch.

Thanks for the reminder.  Pushed out now.

Miklos

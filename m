Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA7A3FDDF5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 16:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhIAOsW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 10:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhIAOsW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 10:48:22 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B36C061575;
        Wed,  1 Sep 2021 07:47:25 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id r4so5612233ybp.4;
        Wed, 01 Sep 2021 07:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gaaeEOi0bhDqggteyHeoGNL0ZCIMTenxJIng5Ga8K5k=;
        b=bWxnuRet33EwnEkLNmJ9b5SGs6HO5gjXRDIScxuIAcSjjUBN7EN5DJiTzj3jB3Gfnn
         mEPVa2G+mCD6GaDC8MtJ7iHmeT4+WVcbATg5jtMMQ05A9jt2+iV0uzCLfy6S4q8I/qdi
         cWJNUQC3+g5jQff5q4zUVxrY2gIaQlczVcRqEv80GrCdypyRKRzPi2cSzmcVkZobHNbO
         p063C+VtU7leFUrxGOd3Xm6zXBNLfqs9EX4ehfZe1Jg4EMpbXBrMLpkp3tqCGKBEOYJ7
         k3eLxZi9K7MM9hCawK5zQ3JHrrfBKCKrl19j8gfXwp4ZIfZvxNoKskSSPF8Zat85d5Is
         aWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gaaeEOi0bhDqggteyHeoGNL0ZCIMTenxJIng5Ga8K5k=;
        b=kLmHTWrVosk4+s/sIjvO/gJo7+VSwro6AOI8LZ+2gt0p4R/V3izhsLXd0s9zuetp8v
         9LXhlljAzi/piJtta1a+sOWNHgKNtPVqWqdThBT42dSxLFizLf6eFXluKfomFykIrd1A
         eSOXpkuU1cU5SDobj6x8W8+HVJf2EuCMwPT5incF1+LHY7Yz1TITR1r0VF6Sq/KrbLa0
         6UamaKPgs5VqtgReTfDKHJjhcs/WcxZCt7pXSEnBzxc4H96tjhFrxAXrMeJq4b39CvdB
         BkCy2XPlgy1Z89bst2SQ+c/H8U4KfgbX+AiVWyHin3sr0df3cNq3Ea7eikH+5uMjhoO9
         AmlQ==
X-Gm-Message-State: AOAM531rckTZ0ChKKlUf4gByKoC989MF+UQ/Ie5KQzbet7IOdCVpjSK8
        XL+mXOaDG62yCukxM8K45uef/2o4SceGSppa/do5+6g2vhrotQ==
X-Google-Smtp-Source: ABdhPJz+53TYVHuMXXz8XS5OBaYErl91gFXzAfHbQESrAdtCqVKlMoGFNHjvd382o/DHRzKyKmF9OsNmOkrZUC+weuU=
X-Received: by 2002:a25:c005:: with SMTP id c5mr35786298ybf.168.1630507643915;
 Wed, 01 Sep 2021 07:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210901001341.79887-1-stephen.s.brennan@oracle.com>
 <CAOKbgA49wFL3+-QAQ+DEnNVzCjYcN0qmnVHGo1x=eXeyzNxvsw@mail.gmail.com> <YS9D4AlEsaCxLFV0@infradead.org>
In-Reply-To: <YS9D4AlEsaCxLFV0@infradead.org>
From:   Dmitry Kadashev <dkadashev@gmail.com>
Date:   Wed, 1 Sep 2021 21:47:12 +0700
Message-ID: <CAOKbgA44BW824W_OqL8LO1FcaWdomrsYsr-kMHSj3cV1daJ4fg@mail.gmail.com>
Subject: Re: [PATCH] namei: Fix use after free in kern_path_locked
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 1, 2021 at 4:13 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Sep 01, 2021 at 02:35:08PM +0700, Dmitry Kadashev wrote:
> > Ouch. Thanks for taking care of this, Stephen. I guess
> > filename_parentat() should be killed, since kern_path_locked() was the
> > only place it's used in and it always results in danging "last",
> > provoking bugs just like this one. I can send a patch on top of this if
> > you prefer.
>
> Yes.  And then rename __filename_parentat to filename_parentat, please.

I see why you want it to be renamed - and I'll send the patch.  The only
problem I have with the rename is with __filename_parentat() there is a
nice uniformity: filename_* functions consume the passed name, and
__filename_* do not. So maybe it's something nice to have. Maybe not.

Anyway, as I've mentioned, I'll send the patch and it can be either
picked up or ignored.

-- 
Dmitry

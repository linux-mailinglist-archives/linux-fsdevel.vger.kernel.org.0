Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACB53A0A36
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 04:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbhFICss (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 22:48:48 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:37379 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbhFICsr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 22:48:47 -0400
Received: by mail-ej1-f49.google.com with SMTP id ce15so35924422ejb.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jun 2021 19:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dMJAIATDxck3lPc2v/vOyqYIyHEjWVevdw28uBnRll8=;
        b=vJCu8FkaI6OA/S5WUg8dM66mAya65Fay5hA/eiMY3Lre1NFLuBR0GAu7PbHt8SbNuJ
         3YxhvjAdYnFhw3cd6RDn4UKhXeuZzOKQfLKns9hAAtwpeDi3dt518h/j2QA7MZh7MYCi
         vwgUF+67Jw+sjHIq0nD6k7r7cSn48p3v2T3HFi/z6QgtAUEyMPZtkav5Wy80oAsGLE2O
         PqFJsyaViE7igCLWDnI6QZn7CKnYPtKIF0UpZAGwaHYcuD7wWL6x/HpU0U7WGvfkeOsL
         OJftkhEHQH1/uRA5GDUWCh9MO6LuUVLaWWbhUiCd702ZrvrmQYQuxElBUN2sztqmw+RA
         3+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dMJAIATDxck3lPc2v/vOyqYIyHEjWVevdw28uBnRll8=;
        b=mEe5Vz0dKhK8aJOB/HwiXxVYDXCEbomSaUHpegZjcX2rOtbeqh7yZ7tiXZ8PPJQGWZ
         XxpsmG6rQipWiUIJ9RS7XO9TErohodHBReLIzw8K2ynkPOsOpj5j1FGiEPeK2fDMaHD4
         rVHS2beoS/Su/aELQZgfpki126DWGuW6Chs7PPIfQqjLsn2NY3peA9KXMcMS7aSgeFc9
         hY5w99tMV4DKyfUJ3Jb0GgcuO27Ok+mob+5/XSsDZ15QvTULxH5LDwbW2pYrbHv0tR65
         nA1+AWQmzcOBI9tgrL8mciylDYWFTCTINJ/q+xflaqwMeErZdnt+9FSQPO2JZyIjhpJF
         KjUA==
X-Gm-Message-State: AOAM532Dnc+VXvAU7SzH7vJ3eoMK7x+ikU62wvPQ1/1zfa7alt6byZpM
        nhkOBvvFGXAIdyhfK8sFpj0N7jdaFWctOnXrmIuk
X-Google-Smtp-Source: ABdhPJzL9fIDlYNo3jdwZcRjedeaqhqbGqBRlphCAKBf6dCq1NoGxNou4DjDXOr7lSmB1qXBkGhxlEz2kFZPkYJnhXQ=
X-Received: by 2002:a17:906:4111:: with SMTP id j17mr25998733ejk.488.1623206738453;
 Tue, 08 Jun 2021 19:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTr_hw_RBPf5yGD16j-qV2tbjjPJkimMNNQZBHtrJDbuQ@mail.gmail.com>
 <3a2903574a4d03f73230047866112b2dad9b4a9e.1622467740.git.rgb@redhat.com>
 <CAHC9VhRa9dvCfPf5WHKYofrvQrGff7Lh+H4HMAhi_z3nK_rtoA@mail.gmail.com> <20210608125504.GA2268484@madcap2.tricolour.ca>
In-Reply-To: <20210608125504.GA2268484@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 8 Jun 2021 22:45:27 -0400
Message-ID: <CAHC9VhQg5WBF72UUyb32s9zB+9G41=DfdouPnudY+vL1g9bAjg@mail.gmail.com>
Subject: Re: [PATCH 1/2] audit: add filtering for io_uring records, addendum
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 8, 2021 at 8:55 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> I should have been more explicit.  The intent was to have the fixes
> incorporated directly into your patches since they aren't committed in
> any public tree yet, exactly for bisect reasons ...

No worries, thanks for the clarification Richard.  I just wanted to
make sure since the contribution format was a bit unusual given the
context :)

Regardless, thanks again for the feedback, I'll get this incorporated.

-- 
paul moore
www.paul-moore.com

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15FC3F9F57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 20:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhH0S63 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 14:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhH0S62 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 14:58:28 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E674C0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 11:57:39 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id o10so16275756lfr.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 11:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YxxLEk/XSr4w+re4v3pBg80KnJK57H4H8Qpi3MkYDbY=;
        b=Jg8UhP0MumuEF16XC/BDdN6h3G2VkliI2bln+XsceyJl5CxwtTks5T4jpFevEkg9i3
         nYPVQeA/fchkKPRtZkeWbC5DEUI0BBrFHkejQEBbuSjJWlprvPb5zJUMeUfXr9H45g6k
         2NmKyRGKrZm3y5Du+xJe6JyQX79ON09SLUbKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YxxLEk/XSr4w+re4v3pBg80KnJK57H4H8Qpi3MkYDbY=;
        b=s/81PkD3PH8VczaMC/UXuKf6MpPU+0OL0baHWxs1LFsYf/YtP8Zogc2kDUgWL+2B7X
         Q+6s7QC1MjFz9HRcwsABoqY8QmW0+8XN1g92cjMZnoECd3rj+ekAZTmQasdpm0DpfwTv
         RK/5HHZy+VMriUibgqr4/qEXthWIVxt3BDNKtrdjDwkWaqDdOcMFnc0cVAQS0X7GahcX
         C0eyCfNyQZ+hL2kK4ZB+Z4RzzvA6FN7H1ukQWItNap6kwsjRvkRfoShs/3HRY3tPJ/au
         /8IkLjAX7IVSsGAEwk263bXSurQp6xOrjxWa0U4ktOXQUAe7P/QCuXjMcQEeD+oL+irD
         gCMg==
X-Gm-Message-State: AOAM533IZeXJzCZvKDuuuZaKiuNUkRdgtfC1rJTwDME5a429qVCrzABX
        /Fm9uLZ6QqgR0JDqzTKhoJDgPEyQU77qsTIl
X-Google-Smtp-Source: ABdhPJyPJwXwo958KilNSfqKGWXR7v8tKQUg8KGEd4yg4tCoT9nqIlkXngrtn5xWZqFhXbSULUGJVw==
X-Received: by 2002:ac2:4e0c:: with SMTP id e12mr5480360lfr.561.1630090656806;
        Fri, 27 Aug 2021 11:57:36 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id v5sm825332ljg.117.2021.08.27.11.57.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 11:57:36 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id l18so13065994lji.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 11:57:35 -0700 (PDT)
X-Received: by 2002:a2e:944c:: with SMTP id o12mr8723398ljh.411.1630090655578;
 Fri, 27 Aug 2021 11:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210827164926.1726765-1-agruenba@redhat.com> <20210827164926.1726765-5-agruenba@redhat.com>
 <YSk0pAWx7xO/39A6@zeniv-ca.linux.org.uk>
In-Reply-To: <YSk0pAWx7xO/39A6@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Aug 2021 11:57:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj8Q6PtnQqamACJU1TWpT4+nr2+YGhVwMTuU=-NJEm5Rg@mail.gmail.com>
Message-ID: <CAHk-=wj8Q6PtnQqamACJU1TWpT4+nr2+YGhVwMTuU=-NJEm5Rg@mail.gmail.com>
Subject: Re: [PATCH v7 04/19] iov_iter: Turn iov_iter_fault_in_readable into fault_in_iov_iter_readable
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 11:53 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> I really disagree with these calling conventions.  "Number not faulted in"
> is bloody useless

It's what we already have for copy_to/from_user(), so it's actually
consistent with that.

And it avoids changing all the existing tests where people really
cared only about the "everything ok" case.

Andreas' first patch did that changed version, and was ugly as hell.

But if you have a version that avoids the ugliness...

             Linus

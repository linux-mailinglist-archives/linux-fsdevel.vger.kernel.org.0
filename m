Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBEA477A24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 18:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240017AbhLPRNb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 12:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239821AbhLPRNb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:13:31 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E40C06173E
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Dec 2021 09:13:30 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id y22so18657358edq.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Dec 2021 09:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NDlVC7K2J17hzYvXNGm7cNY1/KwjC4f0j/S6KBI3XWs=;
        b=PxNTueayzydirKFNX/aZFqvh4eZHQBO97bcxKPIYWoWoCvbu8Ge53zcL9pNJMa/zLp
         r8ZbkaBEnzyU6SZUXscNGuO+CsXsHd4v11HNOvdiZ/be6hs23tOkhRInYjl8q5WBjzE2
         BB1MRornTquTrS71dnLK/z/ae3fGLJSGif8LI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NDlVC7K2J17hzYvXNGm7cNY1/KwjC4f0j/S6KBI3XWs=;
        b=2X/LaZ8fJUWjMrmy0HOaR4YQXJLOA34SEhb5w07Siyxlgh1T/GwgdskuI4eXInp9KA
         YM50oJAUYMw8Eb9P+o8MIzTAuPIs8jiypR2bJcII3yN+rAT2/08SXw+q7U0wKCYsluch
         k96E58rT5LfFFEerQTk7CPWdgy2E/iJydu+F06JXOmDg2wxlnNq9xecgfN5Xoo81rxjv
         h+wB/3t3m0DwP0jYCA4qyU+BxLv5yWU2A7x/Zzz8KFy6dv1n4f7zgOHSYr+HW+SfTEWq
         AIGBc1qiN7sahuO1AuvZ6NNrjElfDy6fTrUFD1639h+Fos7ty1ZPDtuXtb5lRYb9K2xy
         WbIw==
X-Gm-Message-State: AOAM532OymJ43lMMXGh0czCmYbfqLQ22WiwYnPH4WjTz9dBjpjMk+0rU
        sKQh1DpMsKT+9NHCu027me6CxyVPOlRU1zltDoo=
X-Google-Smtp-Source: ABdhPJyH+xqhwoHzdUUBOHCqyTRM/5toiYVITkgAn1+tl1eKicc4lJup5eSQaoOwh64MVIqxkQ1YUQ==
X-Received: by 2002:a17:907:a0d4:: with SMTP id hw20mr16410582ejc.16.1639674808664;
        Thu, 16 Dec 2021 09:13:28 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id hc20sm2128499ejc.221.2021.12.16.09.13.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 09:13:27 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so1745567wmb.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Dec 2021 09:13:27 -0800 (PST)
X-Received: by 2002:a05:600c:1914:: with SMTP id j20mr5920009wmq.26.1639674807647;
 Thu, 16 Dec 2021 09:13:27 -0800 (PST)
MIME-Version: 1.0
References: <759480.1639473732@warthog.procyon.org.uk>
In-Reply-To: <759480.1639473732@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Dec 2021 09:13:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiB+Q+KbMBXtZZyMChdg8E8fBL8uipJn4j_rFxbAXangA@mail.gmail.com>
Message-ID: <CAHk-=wiB+Q+KbMBXtZZyMChdg8E8fBL8uipJn4j_rFxbAXangA@mail.gmail.com>
Subject: Re: [PATCH] afs: Fix mmap
To:     David Howells <dhowells@redhat.com>
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey E Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 14, 2021 at 1:22 AM David Howells <dhowells@redhat.com> wrote:
>
> Could you apply this patch please?  Note the odd email address in the
> Reported-by and Tested-by fields.  That's an attempt to note Auristor's
> internal testcase ID for their tracking purposes.  Is this a reasonable way
> to do it?  It's kind of modelled on what syzbot does.

Yeah, this looks sane to me.

I don't like bare bug tracking IDs that don't tell anybody else
anything, but the "embedding it in the email" trick means that it now
(a) gives a contact for it so that it contains meaningful information
and (b) also acts a "namespace" for the testcase ID.

Applied.

            Linus

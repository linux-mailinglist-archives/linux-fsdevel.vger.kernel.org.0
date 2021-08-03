Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098FC3DF5E0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 21:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240247AbhHCTno (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 15:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240220AbhHCTnn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 15:43:43 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D95C06175F
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Aug 2021 12:43:31 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a26so400828lfr.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Aug 2021 12:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nGXjTo8qo5IxOBBXxPEhxEW50sCDdvHfqLDIjlbW7zc=;
        b=Tzy/hx7F5mnewk1vS/7V4ybuSt+vmB2LEQ0yzKr2aV7qAqeiieIyOicRnnhZvCpzH6
         7YXOAuXieVkzX2sYRnI5mcVQquPVzK1oXd+di0HKJ2tiJg1jbXq7LOf8/21Qb7b9hjN0
         5Z7+yHwApTuxrMSGTLtEaTC0PJ6UyA7bgfBdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nGXjTo8qo5IxOBBXxPEhxEW50sCDdvHfqLDIjlbW7zc=;
        b=IjzfI81y4XRGoCVuSOqJ5XysonQNLW9wCGaQcaaaf73mUW4DqNAvwJJbjrDmJte0lt
         xgztWyNTCfaw5vKKlgIgvQdIJz9h6aTnryyR0MvGXmuEaK5LJAG3jRZy3jfGbplU5lEj
         Ju6NLQYBIePs1htg8vagpBSntNpU7XTtLx/CepRFCheTMFmcup/u9SZO4SBXF18kCdlg
         fiO1cwL7PQ02vz0qpJkLyv9gWxsZq+f7V6JSeFDpAkbKvvPOMgiuAubYa8cZSU4ZIwNL
         kT2/A3cfG4XZd2u/8MJPHlhFp20W4ZuH6QaWnhqDHXnG0uXsgzutPGiCFKv5M1dHBTch
         D9XA==
X-Gm-Message-State: AOAM5328QFf1ENE/ySC9uazQ8enfx7WVWe/v88qYcn7SKNahJ0TvyaOr
        RJibNRFLP6LP57eV7il3i9zXyjIUa6x26szn
X-Google-Smtp-Source: ABdhPJyrsvpo7CxoDKX2Md/ajCX2zsbNLuqtqACCxNMkrDpBJY5EgRRgPMJhzXRGOPZhALxvjBuKIg==
X-Received: by 2002:a05:6512:3889:: with SMTP id n9mr17228441lft.589.1628019809522;
        Tue, 03 Aug 2021 12:43:29 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id j16sm1327632lfh.258.2021.08.03.12.43.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 12:43:28 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id m13so389097lfg.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Aug 2021 12:43:27 -0700 (PDT)
X-Received: by 2002:ac2:4885:: with SMTP id x5mr1818950lfc.487.1628019807490;
 Tue, 03 Aug 2021 12:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210803191818.993968-1-agruenba@redhat.com> <20210803191818.993968-4-agruenba@redhat.com>
In-Reply-To: <20210803191818.993968-4-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Aug 2021 12:43:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiF7jkOrpCe8=s+s=xxw8NovYWfNpe+kVHZth4m0mV5XQ@mail.gmail.com>
Message-ID: <CAHk-=wiF7jkOrpCe8=s+s=xxw8NovYWfNpe+kVHZth4m0mV5XQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/12] Turn fault_in_pages_{readable,writeable} into fault_in_{readable,writeable}
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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

On Tue, Aug 3, 2021 at 12:18 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> Turn fault_in_pages_{readable,writeable} into versions that return the number
> of bytes faulted in instead of returning a non-zero value when any of the
> requested pages couldn't be faulted in.

Ugh. This ends up making most users have horribly nasty conditionals.

I think I suggested (or maybe that was just my internal voice and I
never actually vocalized it) using the same semantics as
"copy_to/from_user()" for fault_in_pages_{readable|writable}().

Namely to return the number of bytes *not* faulted in.

That makes it trivial to test "did I get everything" - becasue zero
means "nothing failed" and remains the "complete success" marker.

And it still allows for the (much less common) case of "ok, I need to
know about partial failures".

So instead of this horror:

-               if (!fault_in_pages_writeable(buf_fx, fpu_user_xstate_size))
+               if (fault_in_writeable(buf_fx, fpu_user_xstate_size) ==
+                               fpu_user_xstate_size)

you'd just have

-               if (!fault_in_pages_writeable(buf_fx, fpu_user_xstate_size))
+               if (!fault_in_writeable(buf_fx, fpu_user_xstate_size))

because zero would continue to be a marker of success.

                 Linus

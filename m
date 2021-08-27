Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7D63FA189
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Aug 2021 00:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhH0WgR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 18:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhH0WgP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 18:36:15 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF98C0613D9
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 15:35:25 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id c8so4807461lfi.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 15:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0rGLz7zH5VYaPQJm/5R2FgZ/IY8lzcUOIJsQBb/VIWM=;
        b=JD5mh7o51KK+kOxvguNTQUf7rTVF4w9SHbDvpplojTGO4MeyrRJfBlT2B58LyfaviY
         ahMIKvD5OTZrK3VLe5bxgp+oJ1xCnF26s9jzJ+FtmfmTaj7/yI+G8RCXONqVaiSYQS1G
         DBec3lrLIt/IGBcPX8jc1EEIbl9Sy+LcB1dGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0rGLz7zH5VYaPQJm/5R2FgZ/IY8lzcUOIJsQBb/VIWM=;
        b=Q6+3milEJljVgFCASrvV03YE72W9kTZ2WoIjtHwDwGiE/+UbTBrHNnxvJyRRmNXq9d
         pn2klkdPYh3i+NmK6bC1Ar15WqYo9VNFwa+Svcbq5R8NB7BKCNTIt5sJAqvG73uVkYVE
         ncAWw5DkGSgLJOrsF94L+dnl/nlDYWmbXvMfOmNzLcEzTSbNOhGtEl3EC6Bjsnv/o1UC
         8QaiQH1V6ko0y8jqJIPPnDSbmP9SnBgMh5G60GDa+NQK3Y3u4KQWFNjAhz/pjVkzfuPX
         JdJxiAGLrmDDcAY5wL8IUy1zRyQLkjuHJtZ5gj6M2J7qt63GDC7YRZmpyLZyyXwAwNY8
         teKg==
X-Gm-Message-State: AOAM5329ucC9KuXtVHY98eee0ekDG+qz9vyMVMy8mOf7+0B5lkacCAxH
        jHtTs5ee3Zx1a/BWaJsUaP3omODQFCpFSys7
X-Google-Smtp-Source: ABdhPJxx52zvJwl02NWxWfrgL4pGePfeQ97GE83zQnPa/v66HkMkC9kKdnLp4OQW4tdN5/eZBrPVpg==
X-Received: by 2002:a19:4303:: with SMTP id q3mr8104071lfa.596.1630103723522;
        Fri, 27 Aug 2021 15:35:23 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id u12sm711823lfo.86.2021.08.27.15.35.22
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 15:35:22 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id l18so13961901lji.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 15:35:22 -0700 (PDT)
X-Received: by 2002:a05:651c:908:: with SMTP id e8mr9500825ljq.507.1630103722494;
 Fri, 27 Aug 2021 15:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210827164926.1726765-1-agruenba@redhat.com> <20210827164926.1726765-17-agruenba@redhat.com>
 <20210827183018.GJ12664@magnolia> <CAHc6FU44mGza=G4prXh08=RJZ0Wu7i6rBf53BjURj8oyX5Q8iA@mail.gmail.com>
 <20210827213239.GH12597@magnolia>
In-Reply-To: <20210827213239.GH12597@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Aug 2021 15:35:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCCyxkk+wfDZ5bQNX62MfdprBLpy_RwpSFhFziA2Oecg@mail.gmail.com>
Message-ID: <CAHk-=whCCyxkk+wfDZ5bQNX62MfdprBLpy_RwpSFhFziA2Oecg@mail.gmail.com>
Subject: Re: [PATCH v7 16/19] iomap: Add done_before argument to iomap_dio_rw
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 2:32 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> No, because you totally ignored the second question:
>
> If the directio operation succeeds even partially and the PARTIAL flag
> is set, won't that push the iov iter ahead by however many bytes
> completed?
>
> We already finished the IO for the first page, so the second attempt
> should pick up where it left off, i.e. the second page.

Darrick, I think you're missing the point.

It's the *return*value* that is the issue, not the iovec.

The iovec is updated as you say. But the return value from the async
part is - without Andreas' patch - only the async part of it.

With Andreas' patch, the async part will now return the full return
value, including the part that was done synchronously.

And the return value is returned from that async part, which somehow
thus needs to know what predated it.

Could that pre-existing part perhaps be saved somewhere else? Very
possibly. That 'struct iomap_dio' addition is kind of ugly. So maybe
what Andreas did could be done differently. But I think you guys are
arguing past each other.

           Linus

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D983212817F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 18:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfLTRfv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 12:35:51 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:39167 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfLTRfu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 12:35:50 -0500
Received: by mail-io1-f66.google.com with SMTP id c16so8749734ioh.6;
        Fri, 20 Dec 2019 09:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wLQc/GdbaTxAeCv2i12B87WYv/+yect1z7boH4l+zxc=;
        b=Snbp1guXp8WJMDJ7NEVUNEciyC9/XuhqMy9fNg3+bjS7yLK55or/hnw71baS4sJ1Mt
         gzT94sJGeHuW14jm+2j6qfFPKE4fxYOMefHHNOyWm4Vx6iUMBpQA3pOBR3Hz1jiE5bzd
         3XIYrAbuX9Rs5d01UVLArDmRdGdajXIfhotqQPWNBW8BhhRazdOCFAqEp7wb4B7WA5oi
         R8ERO6pLFKULtxTKJX1gm+JWcAa1SWcuZtqWpraDjNiZD3GNoQJbRUq0E7kt7TFN0IVN
         Yt6/DqIt5P2n1Ldst1jhjRK8ttvNUA8gjjClChFZHWY3we+2+1G+vHfDP1Mcp2Y8OjvI
         35pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wLQc/GdbaTxAeCv2i12B87WYv/+yect1z7boH4l+zxc=;
        b=Y8hJlwY0YQMgCVL5laDXvTg3hn72/mlgy3A5DBOv2RqDCWGQxEgexRsFOHXoxoqpYq
         FR8vz0/mx9ioJfdM1ZruXf4dYnxmejY/VvnFtS6M0VWzdxvIwk1pVTFzzJqtf2jcGi1l
         mv5IyA6bIMOFX/DDjFEOxS5cIpvaSI55Yq57RyQZLOlBONk8wZCvjoy48GhN7tPIZH6L
         bcaf5gKMF3rFFZ+7Fx9F9Yeuqo6bJQeZCbkGjY0nwh8D+EzE+iv3Q5DF0AM4MHJ7KvzB
         MisHNocBop/llqcsdAdUXvPKc7LUJ0etPYzyGnvzBOpu74OJ21WTZMH+Z//q3ObdW1Yd
         +qJg==
X-Gm-Message-State: APjAAAVbYZFeOZ8na8HPz7gpP5HXzX2+Sfuv2yFzGQ1TYuF6m5reGvms
        HBipZ822o8wnV5I7IcE9U06KQ/PQKZWHBKffh2Q=
X-Google-Smtp-Source: APXvYqyd6lNdaHFBiEIhRmMdonT6ZPlDDmQi7UK/M23u6kJ0+lmsitobqqCafVHaJ6YJ8DClym6dn6Yf+v+vBHKzdj8=
X-Received: by 2002:a05:6602:280b:: with SMTP id d11mr10717971ioe.250.1576863349472;
 Fri, 20 Dec 2019 09:35:49 -0800 (PST)
MIME-Version: 1.0
References: <20191220024936.GA380394@chrisdown.name> <CAOQ4uxjqSWcrA1reiyit9DRt+aq2tXBxLdPE31RrYw1yr=4hjg@mail.gmail.com>
 <20191220121615.GB388018@chrisdown.name> <CAOQ4uxgo_kAttnB4N1+om5gScYSDn3FXAr+_GUiqNy_79iiLXQ@mail.gmail.com>
 <20191220164632.GA26902@bombadil.infradead.org>
In-Reply-To: <20191220164632.GA26902@bombadil.infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 20 Dec 2019 19:35:38 +0200
Message-ID: <CAOQ4uxhYY9Ep1ncpU+E3bWg4ZpR8pjvLJMA5vj+7frEJ2KTwsg@mail.gmail.com>
Subject: Re: [PATCH] fs: inode: Reduce volatile inode wraparound risk when
 ino_t is 64 bit
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Chris Down <chris@chrisdown.name>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Hugh Dickins <hughd@google.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "zhengbin (A)" <zhengbin13@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 20, 2019 at 6:46 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Dec 20, 2019 at 03:41:11PM +0200, Amir Goldstein wrote:
> > Suggestion:
> > 1. Extend the kmem_cache API to let the ctor() know if it is
> > initializing an object
> >     for the first time (new page) or recycling an object.
>
> Uh, what?  The ctor is _only_ called when new pages are allocated.
> Part of the contract with the slab user is that objects are returned to
> the slab in an initialised state.

Right. I mixed up the ctor() with alloc_inode().
So is there anything stopping us from reusing an existing non-zero
value of  i_ino in shmem_get_inode()? for recycling shmem ino
numbers?

Thanks,
Amir.

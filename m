Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD1D1D298F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 10:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgENIC0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 04:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725935AbgENICZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 04:02:25 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD51C061A0C
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2020 01:02:25 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id s9so2032737eju.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2020 01:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OQohwe4L50M/oJP7LFqy+JHItl7Ty+QkEmlWmoe7rwE=;
        b=MLiqnTRw3pAF+JO9xJmo4W/KRXGJy7RGRXLxh/82rGI9zQZdbIbkOc1I8dJYzcPVaw
         DeKWNlNQEdHdb5e151pA0IO5UJOf5oMB3tTyxF118f81RmSp5s/MVxcFS8yK5kc2HEba
         UXRE45piJmIVrmuiHJ2lJtHvIi78htE0HeLyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OQohwe4L50M/oJP7LFqy+JHItl7Ty+QkEmlWmoe7rwE=;
        b=I1oy1LNcD8hvkxU7wG3J6I6mQZH+w8mgg1e8F5LjP335w7YdFkSFWT1sVMD1uJrh6/
         lOVfryPwEAtvBOzT+a0cq3UFmleDFTLd8Dq+AClbZlD+yGrIivW1cPYZnDLfznbbjwzI
         5wnREZbbd3azkO8I4J5Srmu55EeYe9a1ac1d8Tnm2AIZyEmeX4IltqAM6bM+EOJDOMvX
         RrU74kYQ+bn/PsdLFk79aMnHG1oSrktHESXmu8Xju2UOWZw2pH53xod3kfQdRaSZFbbE
         05QqnTfIhVqO04Fu4BexE8CkcOKAqjJUP/884kKvtHxU5SS1DyKIbghbpwcrGowKmSai
         JXtw==
X-Gm-Message-State: AOAM532K8ZLiJIJXlDhAaFuExt9h53D/khhs5oVjQH9bFXVTmpFUIT24
        FbJzz71IbCFULMetB7Tpz5y3X6nhepvtPO2GIFMB9Q==
X-Google-Smtp-Source: ABdhPJw5XNmFn1XHD6BXWQ/WtMFU9a2KVsncpWhHCuS1iWHLGucTCVnLn0zb6upOvWBn9mtpwKvexECZykZ6reVNZnE=
X-Received: by 2002:a17:906:cd08:: with SMTP id oz8mr509387ejb.90.1589443343915;
 Thu, 14 May 2020 01:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200505095915.11275-1-mszeredi@redhat.com> <20200505095915.11275-6-mszeredi@redhat.com>
 <20200513100432.GC7720@infradead.org>
In-Reply-To: <20200513100432.GC7720@infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 14 May 2020 10:02:12 +0200
Message-ID: <CAJfpeguPhJApOQgw02-yCPJZ5Tx_Zy2ZFh+De5DC560FNqdFSA@mail.gmail.com>
Subject: Re: [PATCH 05/12] f*xattr: allow O_PATH descriptors
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 13, 2020 at 12:04 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> Needs a Cc to linux-api and linux-man.
>
> On Tue, May 05, 2020 at 11:59:08AM +0200, Miklos Szeredi wrote:
> > This allows xattr ops on symlink/special files referenced by an O_PATH
> > descriptor without having to play games with /proc/self/fd/NN (which
> > doesn't work for symlinks anyway).
>
> Do we even intent to support xattrs on say links?  They never wire up
> ->listxattr and would only get them through s_xattr.  I'm defintively
> worried that this could break things without a very careful audit.

Why do you think listxattr is not wired up for symlinks?

Xfs and ext4 definitely do have it, and it seems most others too:

$ git grep -A10  "struct inode_operations.*symlink" | grep listxattr | wc -l
29

Thanks,
Miklos

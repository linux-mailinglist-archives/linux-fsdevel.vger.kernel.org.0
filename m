Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4D583C37D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 07:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391263AbfFKFo4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 01:44:56 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35427 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390492AbfFKFo4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 01:44:56 -0400
Received: by mail-yw1-f68.google.com with SMTP id k128so4781167ywf.2;
        Mon, 10 Jun 2019 22:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+w1TZXVPXsAmWyQMupPIi48Y5cj/qlmRQ3y3C88Myg4=;
        b=tqE/SaqExmYL4SMawkSvR1uHrcqw8SMH1s/cJ7q9WPOatVmT/TZY8anoN7pplN+vKM
         DC79ie7sC/M9+HEx8JXaPg9YBJNp6YY9zZm2SCuxKY4w8CTo7MUoWFtKHIy5kfqzYFXI
         qhUC1t+ShVl2ERMvbVuk5aGyysYeGRzuAGf675wNvodmAkYZ3mFtpZ9Rm/ymuQn9Yq7j
         9ZIhjzmj3PYrzpcstKORlAe9IsO9jr/Ub/zaf/4o2MdWmlbAbiB9lwYAJVldk1VtXs8R
         vlliNsbZCTTteugJKE7zhWAtaB+b6y3nrhEy+DM2Fn+QZT+L8F8G5VUGtCZZMALA7mbK
         sNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+w1TZXVPXsAmWyQMupPIi48Y5cj/qlmRQ3y3C88Myg4=;
        b=N4Q2dFQ/B20xgQT45emAhsWMIW5222tRSxIWCaUi+cE6n45OvjbP0cG5BkYLzaR61t
         9yyzH41JPrI3EZHCfF25OwctLh+7+ECkDYOUumDKiqzNiDANO9iO+AhHFq59mmKTf6vC
         SR20oLVbiycJsyvIHR0/eHfcDdrwBWYAOcYMhRiuNkTJlBWVb7ekc2j5zO9YwkijluFO
         OdQI8Xurh7p2TM2TAGSoWHU3mF+A1/Aa2NmQes1PWYnRq6LzUf0v3+zCpf/QUP4As0jT
         /UbakFRyj12WUn4oMKr6SHdhQ6f4WaQSUxoan87+NXdUOkznHk0nv9eQ0UKaH2/yK9WT
         QJVQ==
X-Gm-Message-State: APjAAAU1EAZcH3rHzqdJWPOfhbDo30zxme0JG0lHHtC3dvvPfv558NgA
        P8BbjA0dB3CJEtXYB/ktfIOAg8pySbyyStOLUHY=
X-Google-Smtp-Source: APXvYqxaOnnDdwQIbxvN92XjnTF13G1VugiR0ALHYbo83TKOwzt20Rlu0lyS+T4g9LQ5XiGl77pGfZBFYWDZJGR6Qz4=
X-Received: by 2002:a81:13d4:: with SMTP id 203mr8531169ywt.181.1560231894888;
 Mon, 10 Jun 2019 22:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190610172606.4119-1-amir73il@gmail.com> <20190611011612.GQ1871505@magnolia>
 <20190611025108.GB2774@mit.edu> <20190611032926.GA1872778@magnolia>
In-Reply-To: <20190611032926.GA1872778@magnolia>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 11 Jun 2019 08:44:43 +0300
Message-ID: <CAOQ4uxgAgKhp55VGzBZ=ODKg5ztbJCB+WiFceXZjvw9=ecPdGw@mail.gmail.com>
Subject: Re: [PATCH] vfs: allow copy_file_range from a swapfile
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        ceph-devel@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 11, 2019 at 6:29 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Mon, Jun 10, 2019 at 10:51:08PM -0400, Theodore Ts'o wrote:
> > On Mon, Jun 10, 2019 at 06:16:12PM -0700, Darrick J. Wong wrote:
> > > On Mon, Jun 10, 2019 at 08:26:06PM +0300, Amir Goldstein wrote:
> > > > read(2) is allowed from a swapfile, so copy_file_range(2) should
> > > > be allowed as well.
> > > >
> > > > Reported-by: Theodore Ts'o <tytso@mit.edu>
> > > > Fixes: 96e6e8f4a68d ("vfs: add missing checks to copy_file_range")
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >
> > > > Darrick,
> > > >
> > > > This fixes the generic/554 issue reported by Ted.
> > >
> > > Frankly I think we should go the other way -- non-root doesn't get to
> > > copy from or read from swap files.
> >
> > The issue is that without this patch, *root* doesn't get to copy from
> > swap files.  Non-root shouldn't have access via Unix permissions.  We
>
> I'm not sure even root should have that privilege - it's a swap file,
> and until you swapoff, it's owned by the kernel and we shouldn't let
> backup programs copy your swapped out credit card numbers onto tape.
>

I am not a security expert and I do not want to be, but I believe it's
better to have a complete security model before plugging random
"security holes".

That said. I don't have a strong feeling about allowing copy_file_range
from swap file. If someone complains and they have a valid use case,
we can always relax it then.

Anyway, as you saw, I removed the test case from xfstest, leaving
the behavior (as far as the testsuite cares) undefined.

Thanks,
Amir.

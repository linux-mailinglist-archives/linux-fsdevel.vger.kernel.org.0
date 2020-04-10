Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC1F1A4B6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 22:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDJUut (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Apr 2020 16:50:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgDJUut (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Apr 2020 16:50:49 -0400
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C830D2173E;
        Fri, 10 Apr 2020 20:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586551848;
        bh=E2lIjVQW6WHTE9KKwKVRpfcewIc0INyzWKKWl09INeE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0P7mev/GDX4TO25pT6YSxb6T9GzfcDy6mq1N0KvqF4XuGCHykCWzAxCncn8cD3rFl
         jrIuG0w6yMC9q0cQ70aCh6/8OUfWQ0mhGjh9Vz9AwQ/EIiKBdgi7uyxEyIUA83lCHG
         sLZsoQytB6lAag7CJTN0IUz59JackHKIWtWaL5+U=
Received: by mail-ua1-f44.google.com with SMTP id i22so1064392uak.6;
        Fri, 10 Apr 2020 13:50:48 -0700 (PDT)
X-Gm-Message-State: AGi0Pua0MSlc2ZzhgRGEtEsinn2cSDYQ/TaoKLFF7APFMf+lRs7ZZU96
        q4etpnpH7mI3Ar38ad4w/sdJLeqnTWY0GEMgEXs=
X-Google-Smtp-Source: APiQypI0tNOYGPf4/lvDfJ6zR/L+k8DJVTeWUu84CivCL0gCG2JrO97xvf/TqqE8GefE/AoaSI0o2rfUBF6Mvj8IRlE=
X-Received: by 2002:ab0:6657:: with SMTP id b23mr4604209uaq.14.1586551847706;
 Fri, 10 Apr 2020 13:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200409214530.2413-1-mcgrof@kernel.org> <20200409214530.2413-6-mcgrof@kernel.org>
 <161e938d-929b-1fdb-ba77-56b839c14b5b@acm.org> <20200410143412.GK11244@42.do-not-panic.com>
In-Reply-To: <20200410143412.GK11244@42.do-not-panic.com>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Fri, 10 Apr 2020 14:50:40 -0600
X-Gmail-Original-Message-ID: <CAB=NE6VfQH3duMGneJnzEnXzAJ1TDYn26WhQCy8X1Mb_T6esgQ@mail.gmail.com>
Message-ID: <CAB=NE6VfQH3duMGneJnzEnXzAJ1TDYn26WhQCy8X1Mb_T6esgQ@mail.gmail.com>
Subject: Re: [RFC v2 5/5] block: revert back to synchronous request_queue removal
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>,
        Ming Lei <ming.lei@redhat.com>,
        Nicolai Stange <nstange@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, yu kuai <yukuai3@huawei.com>,
        linux-block@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 10, 2020 at 8:34 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> On Thu, Apr 09, 2020 at 08:12:21PM -0700, Bart Van Assche wrote:
> > Please add a might_sleep() call in blk_put_queue() since with this patch
> > applied it is no longer allowed to call blk_put_queue() from atomic context.
>
> Sure thing.

On second though, I don't think blk_put_queue() would be the right
place for might_sleep(), given we really only care about the *last*
refcount decrement to 0. So I'll move it to blk_release_queue().
Granted, at that point we are too late, and we'd get a splat about
this issue *iff* we really sleep. So yeah, I do suppose that forcing
this check there still makes sense.

  Luis

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95AA71A4B8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 23:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgDJV1j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Apr 2020 17:27:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbgDJV1i (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Apr 2020 17:27:38 -0400
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82460215A4;
        Fri, 10 Apr 2020 21:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586554058;
        bh=V8QhhiRTymtAGzS4jMm11mYDdFfOWqwXJ0Awmxqa7oM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s/nBaA6LOPpckWlwyeu6G42+wIf81zq6VVgY/lVhpQpkRhgz03nPSamZe1NK+HPq/
         D7M7tbdynL5FR499sS8D6zY/s8Xpq3iLG7vm6xDpfqwefsnO9khABcOVrqTHv8Yf0r
         qeXKgH66aRJSC+2OLj65YDrzKFiF+ftWEMJFf8xw=
Received: by mail-ua1-f54.google.com with SMTP id x18so387044uap.8;
        Fri, 10 Apr 2020 14:27:38 -0700 (PDT)
X-Gm-Message-State: AGi0Pubjevd8pGFhQnbWWlTaFuVNvOp73AI5C4eAqlZXF/7O2Z+1oe3e
        9b+5pSOABsJGozlw7/QSbk0IXw9AraWUmN9GKUI=
X-Google-Smtp-Source: APiQypKL5aZ2RNqUUOB0SjAH5YbjeLzshTc1ta+JOreiajZrgqBymzHOh8oGSfSKa2KXtA1f94T8sQs2WZLp2sC77bg=
X-Received: by 2002:ab0:1e89:: with SMTP id o9mr4281024uak.93.1586554057531;
 Fri, 10 Apr 2020 14:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200409214530.2413-1-mcgrof@kernel.org> <20200409214530.2413-6-mcgrof@kernel.org>
 <161e938d-929b-1fdb-ba77-56b839c14b5b@acm.org> <20200410143412.GK11244@42.do-not-panic.com>
 <CAB=NE6VfQH3duMGneJnzEnXzAJ1TDYn26WhQCy8X1Mb_T6esgQ@mail.gmail.com>
In-Reply-To: <CAB=NE6VfQH3duMGneJnzEnXzAJ1TDYn26WhQCy8X1Mb_T6esgQ@mail.gmail.com>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Fri, 10 Apr 2020 15:27:30 -0600
X-Gmail-Original-Message-ID: <CAB=NE6XfdgB82ncZUkLpdYvDDdyVvVUd8nUmRCb8LbOQ213QoA@mail.gmail.com>
Message-ID: <CAB=NE6XfdgB82ncZUkLpdYvDDdyVvVUd8nUmRCb8LbOQ213QoA@mail.gmail.com>
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

On Fri, Apr 10, 2020 at 2:50 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Fri, Apr 10, 2020 at 8:34 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > On Thu, Apr 09, 2020 at 08:12:21PM -0700, Bart Van Assche wrote:
> > > Please add a might_sleep() call in blk_put_queue() since with this patch
> > > applied it is no longer allowed to call blk_put_queue() from atomic context.
> >
> > Sure thing.
>
> On second though, I don't think blk_put_queue() would be the right
> place for might_sleep(), given we really only care about the *last*
> refcount decrement to 0. So I'll move it to blk_release_queue().
> Granted, at that point we are too late, and we'd get a splat about
> this issue *iff* we really sleep. So yeah, I do suppose that forcing
> this check there still makes sense.

I'll add might_sleep() to both blk_release_queue() *and* blk_cleanup_queue().

  Luis

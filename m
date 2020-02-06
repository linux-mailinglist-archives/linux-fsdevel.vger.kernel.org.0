Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87699154822
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 16:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgBFPcO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 10:32:14 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51887 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727325AbgBFPcO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:32:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581003132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JkkJGmIOTY9azTSJOAyBmE/D2+0ai1ViZFBb2hElwXY=;
        b=AqdlXmrukIN1dSjBGLgl0WWXYapV9ibPs0KMy28+CHasnKPW+uJQj0YBECl5fnxZ/8uZVA
        5WiBYCIjpxIq04f1TF4Laa9aubDLrF0l1Ac75gCxYIo8S2L4bVQ0UD8Fz3m/qZ+8Tk0sX6
        Eo11lJ8+tzGckpkTGCGqiBk2ibbFqQw=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-KqVupLq9Oq62EhAO9UeWYg-1; Thu, 06 Feb 2020 10:32:11 -0500
X-MC-Unique: KqVupLq9Oq62EhAO9UeWYg-1
Received: by mail-oi1-f199.google.com with SMTP id 3so2981181oij.21
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2020 07:32:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JkkJGmIOTY9azTSJOAyBmE/D2+0ai1ViZFBb2hElwXY=;
        b=ARl1fAr1MDRcutbONwWbkZES5MMDNN7jn7n9U7bkQJtIxOqBA05pwvzaz3bz2CRVF0
         h+eHxDZCs0iBmpzk4ohDVBqPVwIn9ef+N2uVdhNki/1ufBpTq/yjFvnuKDLRXUi2Jc74
         NpAXgh6wHvbQVBpJu+H7wLgzMG2Nuo9xUSAicbWJ/aTk7/H1e099bH/HqLI/XEyJmoPV
         Z0srbd40IdwHjHusy5Xjlt5ElpwF1XwlwKgs39i0iXqPLLpBphJkcM5rL+MazW4Gv9OA
         IHD+VVmd8Pa3DvfzkwRKWFKBDP2eGJCuUXrM0GO1pdpVmHPFpsTzlt45pCUlmPw+08cr
         Kl0Q==
X-Gm-Message-State: APjAAAXrshQ9tXTHHBnsAdK7RSZ3WgTDbjttjBsM/e1PZHzWyf3Dzqx5
        omH4Rx7AIV/loEgbjvWxtGV7UggSn7p/0OeXrNOij5jR33N/lSp4KKYmXGqSQU7NA3vJyn4EFmN
        oM8lsFQqVM6QWMO6j67lfNGhA7ZoWTSymMm38jG0Xgw==
X-Received: by 2002:aca:48d0:: with SMTP id v199mr7121513oia.10.1581003130604;
        Thu, 06 Feb 2020 07:32:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqz63b3BCvjFz9bZiKofXwlA69pEYM2GvuAIssv4co0has6j21zg9p8DSROFpl+t1g3/AiFAiFF1ObcmOqpV8Jw=
X-Received: by 2002:aca:48d0:: with SMTP id v199mr7121485oia.10.1581003130363;
 Thu, 06 Feb 2020 07:32:10 -0800 (PST)
MIME-Version: 1.0
References: <20200114161225.309792-1-hch@lst.de> <20200114161225.309792-6-hch@lst.de>
In-Reply-To: <20200114161225.309792-6-hch@lst.de>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 6 Feb 2020 16:31:58 +0100
Message-ID: <CAHc6FU45m59PjBWWO=F740_jyOtKSwc__XfYhP84WkpK0uqcWQ@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH 05/12] gfs2: fix O_SYNC write handling
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

thanks for this patch, and sorry for taking so long to react.

On Tue, Jan 14, 2020 at 5:54 PM Christoph Hellwig <hch@lst.de> wrote:
> Don't ignore the return value from generic_write_sync for the direct to
> buffered I/O callback case when written is non-zero.  Also don't bother
> to call generic_write_sync for the pure direct I/O case, as iomap_dio_rw
> already takes care of that.

I like the idea, but the patch as is doesn't quite work: iomap_dio_rw
already bumps iocb->ki_pos, so we end up with the wrong value by
adding the (direct + buffered) write size again.
We'd probably also be better served by replacing
filemap_write_and_wait_range with generic_write_sync + IOCB_DSYNC in
the buffered fallback case. I'll send an update that you'll hopefully
like.

Andreas


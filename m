Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530DA4A4C0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 17:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380410AbiAaQ2t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 11:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380408AbiAaQ2q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:28:46 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9B5C061401;
        Mon, 31 Jan 2022 08:28:45 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id n17so17608380iod.4;
        Mon, 31 Jan 2022 08:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FWHxzL6ukBtNWpYV3M+KSic9V4wnJNgq8ieHpEwO93o=;
        b=Lk+4Y6ArOruh/mtEpbDlxFPKiic/iuo2T1ElyMnsPHR2Aq4mmWKdHn3i7VmFhOBdDX
         yclLdYUYhqUNRsYItcH0egqJbTLqNoMARlqasFZ3ozi2KKQPwrDmYtgfHd8oE9XTTCtF
         bddjOHG2rMcWhhjebNImzOPpT2lJhk4MPK5UzOwbeixeUKwNnhQbMwziXWOHUifBf1JJ
         IViFuD7zxa3n5mQZPDwEjt5C1QNRRNUWWvPqreIJQiRbhYIGUGCE3/BrCMdNZdbR/R5/
         llk87U+ofsR+KKeSr4XRvHV+1+oedIONg1cbu0GV9C2CF+F1rdIsyTbBBeh1fatMynWU
         lm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FWHxzL6ukBtNWpYV3M+KSic9V4wnJNgq8ieHpEwO93o=;
        b=hUgdLpW34tazH0HTtxvKVCRtH+dt6/Xp+mHge3/emkWzIqDftDSof91uJpSJOd+zGv
         vJV7huncLsg4/5W3nrTEeEj9IVKEdvq8QUwd6PROP8wkD1nyQdiu8bjpdpG7G3LJAm7w
         +/3h4JCo6EyImdfCQmDb7pgbzn4vwPfMNfWGICoM6Xf9tQcjkBIc3YumqCzRobuLcBfN
         tIUKUR6rYb4I5nwdsDYrhpydCxXI/LDAA9NOL498YtWoiILco/1kb/EGlh7LROs9Oo4c
         JMbl1++hz4csZm2vaCoBE3ZfXl5S66rYcezVgebydxI9J+xXnCICtejCw2tmVcsHXuIQ
         H91A==
X-Gm-Message-State: AOAM5329aFL7v7RE/L6BfvMdBrIat31kq0caFS2sNu8XljaJ5h7yE4YO
        LdHwP9CRDuT/xYNaHnfcU+sQGllIfY8Dnu+MWK4=
X-Google-Smtp-Source: ABdhPJxNb3/z0NjiVlXTcilGZskFbZSPKskFhMTsV47EDfmw8oXlq6P8d86Mev/eeZ6FGVTUKhcSVzplXAu06yRfSts=
X-Received: by 2002:a02:b0c3:: with SMTP id w3mr11342820jah.1.1643646525134;
 Mon, 31 Jan 2022 08:28:45 -0800 (PST)
MIME-Version: 1.0
References: <164364196407.1476539.8450117784231043601.stgit@warthog.procyon.org.uk>
In-Reply-To: <164364196407.1476539.8450117784231043601.stgit@warthog.procyon.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 31 Jan 2022 18:28:34 +0200
Message-ID: <CAOQ4uxgyfQULxH_ot5eAH1V7uAi4FVn5V4aKEHyJtWvnw0SODQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/5] vfs, overlayfs, cachefiles: Combine I_OVL_INUSE
 and S_KERNEL_FILE and split out no-remove
To:     David Howells <dhowells@redhat.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        linux-cachefs@redhat.com, Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 31, 2022 at 5:12 PM David Howells <dhowells@redhat.com> wrote:
>
>
> Hi Amir,
>
> How about this as a set of patches to do what you suggest[1] and hoist the
> handler functions for I_OVL_INUSE into common code and rename the flag to
> I_EXCL_INUSE.  This can then be shared with cachefiles - allowing me to get
> rid of S_KERNEL_FILE.
>

They look like what I had in mind.
Unfortunately, I had forgotten about another use that ovl makes of the flag
(see comment on patch 1/5). I'd made a suggestion on how to get rid of that use
case, but I hope this won't complicate things too much for you.

> I did split out the functionality for preventing file/dir removal to a
> separate flag, I_NO_REMOVE, so that it's not tied to I_EXCL_INUSE in case
> overlayfs doesn't want to use it.  The downside to that, though is that it
> requires a separate locking of i_lock to set/clear it.
>
> I also added four general tracepoints to log successful lock/unlock,
> failure to lock and a bad unlock.  The lock tracepoints log which driver
> asked for the lock and all tracepoints allow the driver to log an arbitrary
> reference number (in cachefiles's case this is the object debug ID).
>
> Questions:
>
>  (1) Should it be using a flag in i_state or a flag in i_flags?  I'm not
>      sure what the difference is really.

Me neither.

>
>  (2) Do we really need to take i_lock when testing I_EXCL_INUSE?  Would
>      READ_ONCE() suffice?
>

For ovl_is_inuse() I think READ_ONCE() should suffice.

Thanks,
Amir.

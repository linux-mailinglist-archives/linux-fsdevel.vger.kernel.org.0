Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1B54625B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 23:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhK2Wm5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 17:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbhK2Wlx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:41:53 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02762C03AD6B
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 10:13:15 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bu18so47065319lfb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 10:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A1KpMLhPpZ3DtBAJ2H7WA1+eK6RBPvYL8JCpapFonpw=;
        b=hYrTDwhmtIHMqqbXGO1Kse+Z0mztn57tvq1yPxTQ6q8If5SiUN3r2mIlQQuhqQ5Ciu
         K5ZjiwPNhDNHwoG8b/skXzWnqGGnw5Xo6Kz7rDlvP/WRSBwiwJnbIMXZ+5EJLE2YnPsh
         8oCcdh7mNJuIoeX8m73ktIFQqXot2Q8wW5BQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A1KpMLhPpZ3DtBAJ2H7WA1+eK6RBPvYL8JCpapFonpw=;
        b=jRO8B/bxlpjy1cTEcVnz2g0nPkIj/FH1oXj++vU56bdeOSQPkaAqSVnXyGnf8Vjug7
         xpZcMytmsvt6BYNtkdhbevY1yLRhr54u00tkMkJ/u/2wZSDRVIiTSKWgpda+Ob1rk2hc
         Ado18AlA66aJSXpq1/GYWiWSspsf8aRztLz8jW/bPtDTrG4osbaR+wsADeG2/jklAk2x
         gDIMaNDyicqtOylluXjgAhdKn2MP341SE7L8mjCyNJTCUvkGA0WdB/C/4aYyphI4J+1t
         zcs2d9M4HwRIPuq7X9aFe1tLNttpablMVMLHd8hYZljUwzCHNQFfTJ8KpeJIqS2I0+7r
         pE+w==
X-Gm-Message-State: AOAM531xBpmcGB/5mdiSb28Tor0i8fS8+8p/O67WjppdqiKpnVQyvp+u
        9ac+Hyx9oqohjFeNkG+QAMEKAdVq89kInIUc
X-Google-Smtp-Source: ABdhPJykzPnFctVhBKo9kyrn97FzD0FfzUwkDwDRRUjufOrZhf7Viokxydan+BCEG71kDPtg/hK27w==
X-Received: by 2002:a05:6512:c2a:: with SMTP id z42mr34161776lfu.6.1638209591979;
        Mon, 29 Nov 2021 10:13:11 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id v7sm1529104ljj.45.2021.11.29.10.13.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 10:13:11 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id k2so36184851lji.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 10:13:11 -0800 (PST)
X-Received: by 2002:adf:9d88:: with SMTP id p8mr36748101wre.140.1638209581186;
 Mon, 29 Nov 2021 10:13:01 -0800 (PST)
MIME-Version: 1.0
References: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
In-Reply-To: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Nov 2021 10:12:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=whGOEEb4n2_y3mnrmeNx4HYjRA-m=xMPDQD=bHWfB5chw@mail.gmail.com>
Message-ID: <CAHk-=whGOEEb4n2_y3mnrmeNx4HYjRA-m=xMPDQD=bHWfB5chw@mail.gmail.com>
Subject: Re: [PATCH 00/64] fscache, cachefiles: Rewrite
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, Jeff Layton <jlayton@kernel.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-afs@lists.infradead.org, Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trondmy@hammerspace.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        ceph-devel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 29, 2021 at 6:22 AM David Howells <dhowells@redhat.com> wrote:
>
> The patchset is structured such that the first few patches disable fscache
> use by the network filesystems using it, remove the cachefiles driver
> entirely and as much of the fscache driver as can be got away with without
> causing build failures in the network filesystems.  The patches after that
> recreate fscache and then cachefiles, attempting to add the pieces in a
> logical order.  Finally, the filesystems are reenabled and then the very
> last patch changes the documentation.

Thanks, this all looks conceptually sane to me.

But I only really scanned the commit messages, not the actual new
code. That obviously needs all the usual testing and feedback from the
users of this all..

                    Linus

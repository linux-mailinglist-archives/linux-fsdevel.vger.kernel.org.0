Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA46776FD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 07:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbjHJFux (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 01:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjHJFuw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:50:52 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA119F3
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Aug 2023 22:50:51 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5844bb9923eso7405067b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Aug 2023 22:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691646651; x=1692251451;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x7yqFcfihO6UZ4Ofnmt86oPYT4hQDfDAsWIzATt1sTc=;
        b=NAi9DyAm+4viuBaK+2te/vEYT+Qzw6FmpDOVGbbjLStMiQomr4Av2iBnJIL6Uw4DBs
         pycOXzFZlP3T8OK1any+yj5dBc2FMkEEiNo30B+BKPwyfOs5+/L9b1fS2scHlVuFJypc
         yyO1X1LKQXDjxCQGYwSBAwJleAyDIevE3FpVAlXDZrKJXDwAWnEFZgfMSsBQVg8gBD08
         YmNl+Si6DBE/oWAB0TFEay9z5QHBBPacQBGnidZZUFPoI5MUmOIXxsawP8l5ESkXe+L6
         Oun/VSu/O91/o34Q99uYMUqp1tkHQJorTfYZmpWROFuHdkRgV4zPzgPskCBPjV0rYP1Y
         wglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691646651; x=1692251451;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7yqFcfihO6UZ4Ofnmt86oPYT4hQDfDAsWIzATt1sTc=;
        b=I3YeVV12UjiL/vIYq0AtQIo++cqNoOsgkxMx02YQqBKcZXPKAvqrdLeQfCZIWB6fdL
         oDdJsvQ0xHizbrM1rNbV0SV9Z5XIFLo22D8OUMOsqE0un3wOIhWVviCTT4v4Cr3oyrzd
         rqeTbJubvDZ/HNA3jgZm91WRmpWy4z6b4LjW0W9sPG4mQHkkqRz3c/HnBU0BE+u7rjZP
         Lj4Cb/iLPnk45HL/ukYrmlaB+W99D9SWgAk3eLzNTqh7sZMbsfaspEdJtbR7FMEA1nbv
         0E1ANZw6AF9xajjzl439cb7pxk6fJBvegyY8gd0iSmtHTJD5FE+T94F2q3hoo94yXZKH
         ovjA==
X-Gm-Message-State: AOJu0YxasD48eKLI9evAf/CT4OGKkzZxMIOFCx5BkhkmC9AzkCxsB+dE
        i1qHPX1l1rBdP57HxDr6h0r7LA==
X-Google-Smtp-Source: AGHT+IHL9XQObwck1BTnXd+TUHEB5iSg6FPFgszodJQAfdmJqAorzD2QzqndyFri9FLAViEk8CrsfA==
X-Received: by 2002:a81:d54d:0:b0:577:189b:ad4 with SMTP id l13-20020a81d54d000000b00577189b0ad4mr1713495ywj.48.1691646651068;
        Wed, 09 Aug 2023 22:50:51 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e187-20020a8169c4000000b00559fb950d9fsm174825ywc.45.2023.08.09.22.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 22:50:50 -0700 (PDT)
Date:   Wed, 9 Aug 2023 22:50:39 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Christian Brauner <brauner@kernel.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleksandr Tymoshenko <ovt@google.com>,
        Carlos Maiolino <cem@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>, Daniel Xu <dxu@dxuuu.xyz>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        Yu Kuai <yukuai3@huawei.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH vfs.tmpfs 0/5] tmpfs: user xattrs and direct IO
In-Reply-To: <20230809-leitgedanke-weltumsegelung-55042d9f7177@brauner>
Message-ID: <cdedadf2-d199-1133-762f-a8fe166fb968@google.com>
References: <e92a4d33-f97-7c84-95ad-4fed8e84608c@google.com> <20230809-postkarten-zugute-3cde38456390@brauner> <20230809-leitgedanke-weltumsegelung-55042d9f7177@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 9 Aug 2023, Christian Brauner wrote:
> On Wed, Aug 09, 2023 at 08:45:57AM +0200, Christian Brauner wrote:
> > On Tue, Aug 08, 2023 at 09:28:08PM -0700, Hugh Dickins wrote:
> > > This series enables and limits user extended attributes on tmpfs,
> > > and independently provides a trivial direct IO stub for tmpfs.
> > > 
> > > It is here based on the vfs.tmpfs branch in vfs.git in next-20230808
> > > but with a cherry-pick of v6.5-rc4's commit
> > > 253e5df8b8f0 ("tmpfs: fix Documentation of noswap and huge mount options")
> > > first: since the vfs.tmpfs branch is based on v6.5-rc1, but 3/5 in this
> > > series updates tmpfs.rst in a way which depends on that commit.
> > > 
> > > IIUC the right thing to do would be to cherry-pick 253e5df8b8f0 into
> > > vfs.tmpfs before applying this series.  I'm sorry that the series as
> > > posted does not apply cleanly to any known tree! but I think posting
> > > it against v6.5-rc5 or next-20230808 would be even less helpful.
> > 
> > No worries, I'll sort that out.
> 
> So, I hemmed and hawed but decided to rebase vfs.tmpfs onto v6.5-rc4
> which includes that fix as cherry picking is odd.

Even better, thanks.

And big thank you to you and Jan and Carlos for the very quick and
welcoming reviews.  If only Hugh were able to respond like that...

Needing "freed = 0" in shmem_evict_inode(), as reported by robot:
that was stupid of me (though it happens not to matter what the value
is in the uninitialized case): I'll send you the fixup to 3/5 tomorrow
(unless it turns out that you've typed in the " = 0" yourself already).

And I'll send a replacement for 4/5, the direct IO one, following
Christoph's guidance: but I'm wilting, and just didn't get to it today.

Hugh

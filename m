Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0D457E429
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 18:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbiGVQIp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 12:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbiGVQIm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:08:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6024852442;
        Fri, 22 Jul 2022 09:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V2UoXTUSj0dESjqSV1KCC5OtChDJT+2FH7hAqN0NUfY=; b=X9H3p2X2OxIbk8g/M87b2fgAu/
        05fxzWTKDKTqDSqe4u2sca5fPq6Wbn3bPn4TR3rG4tAHu5lXRBhnwCwvLSkn9a/TRw5nEsf6kVZbI
        BA5lY9VhNNICsPSsOaGZDfRfP8aYoOfEi4h26SGWiE3jc/qjUFk40QtT/3h3+jebBjqvy66sYPyCJ
        Bmyr32Dl7PcHkfzsLH58JteZ1/QmS3mHFulve24d0dpYcR4d9SzNiDXxXIMVsfcUbvCJqK2oIofUy
        29lPcJ+Q87JzC8ht4Xxq/AeoKQg82mNbTDIeSfDUif5QlgOVYMCNZFvUZwLjf3l0eW3G5PaJG39p2
        NmldI7pg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEvCa-007lqa-Pu; Fri, 22 Jul 2022 16:08:32 +0000
Date:   Fri, 22 Jul 2022 09:08:32 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Zhang Yuchen <zhangyuchen.lcr@bytedance.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-api@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] proc: fix create timestamp of files in proc
Message-ID: <YtrLgCttVa7IP7B6@bombadil.infradead.org>
References: <20220721081617.36103-1-zhangyuchen.lcr@bytedance.com>
 <Ytl772fRS74eIneC@bombadil.infradead.org>
 <CAMZfGtXjK2BgpwTOGsWdKs9-3i0X9ohdbXJk=0DAmpEKUymS5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtXjK2BgpwTOGsWdKs9-3i0X9ohdbXJk=0DAmpEKUymS5w@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 22, 2022 at 11:43:49AM +0800, Muchun Song wrote:
> On Fri, Jul 22, 2022 at 12:16 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > On Thu, Jul 21, 2022 at 04:16:17PM +0800, Zhang Yuchen wrote:
> > > The file timestamp in procfs is the timestamp when the inode was
> > > created. If the inode of a file in procfs is reclaimed, the inode
> > > will be recreated when it is opened again, and the timestamp will
> > > be changed to the time when it was recreated.
> >
> > The commit log above starts off with a report of the directory
> > of a PID. When does the directory of a PID change dates when its
> > respective start_time does not? When does this reclaim happen exactly?
> > Under what situation?
> 
> IMHO, when the system is under memory pressure, then the proc
> inode can be reclaimed, it is also true when we `echo 3 >
> /proc/sys/vm/drop_caches`. After this operation, the proc inode's
> timestamp is changed.

Good point.

> Maybe the users think the timestamp of /proc/$pid directory is equal to
> the start_time of a process, I think it is because of a comment of
> shortage about the meaning of the timestamp of /proc files.

I'll send a documentation enhancement for this. Thanks for helping with
improving the quality of your peer's patches / feedback in the future!

  Luis

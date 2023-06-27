Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5AD740250
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 19:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjF0RhK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 13:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjF0RhG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:37:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA362272D;
        Tue, 27 Jun 2023 10:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=ilydTjdTS9jPS3Q531k5dt3/10xWOBh9LY6FBdmbcHw=; b=cXWltV79wDZw6RHYQjchi8TzHq
        6Kc6/NEUYJlQkKY8P9EiMBEP6KFDPdWnHxsHtPaeeFbNx0FS8iShKjqtxHxqTelUktI5TnHr5pepl
        iv/zfF5pzzgoIuN46eiRmCbgTu23x9Lal5BK/nU0AcHQ5m09H94J22R6OC1DvHGDn0f+whuK1lgqJ
        zMHN+oSdlUqf6qpoCwIT5xbTr78wbd4LR6kIBHy5d+JjeTVLKNwDyVh1NUB8tHdY/K6FJurYL1aY2
        yjEivrmcWKqF3kueW64pt3BfKVrr7aaE5iqahwMe8J72Ng/sqpqzlgXPw2elPZdJkcV8oKB8fs1Pq
        8tJg3p8Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qECc2-002wDj-7M; Tue, 27 Jun 2023 17:36:22 +0000
Date:   Tue, 27 Jun 2023 18:36:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, tj@kernel.org,
        peterz@infradead.org, lujialin4@huawei.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@redhat.com,
        ebiggers@kernel.org, oleg@redhat.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/2] kernfs: add kernfs_ops.free operation to free
 resources tied to the file
Message-ID: <ZJseFr/BHh+bZ7NM@casper.infradead.org>
References: <20230626201713.1204982-1-surenb@google.com>
 <2023062757-hardening-confusion-6f4e@gregkh>
 <CAJuCfpGUTMP2FTzzx+bq9_5KZjo1r_qspHYZXK2Ors-yU3XhqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGUTMP2FTzzx+bq9_5KZjo1r_qspHYZXK2Ors-yU3XhqQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 10:03:15AM -0700, Suren Baghdasaryan wrote:
> On Mon, Jun 26, 2023 at 11:25 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jun 26, 2023 at 01:17:12PM -0700, Suren Baghdasaryan wrote:
> > > kernfs_ops.release operation can be called from kernfs_drain_open_files
> > > which is not tied to the file's real lifecycle. Introduce a new kernfs_ops
> > > free operation which is called only when the last fput() of the file is
> > > performed and therefore is strictly tied to the file's lifecycle. This
> > > operation will be used for freeing resources tied to the file, like
> > > waitqueues used for polling the file.
> >
> > This is confusing, shouldn't release be the "last" time the file is
> > handled and then all resources attached to it freed?  Why do we need
> > another callback, shouldn't release handle this?
> 
> That is what I thought too but apparently kernfs_drain_open_files()
> can also cause ops->release to be called while the file keeps on
> living (see details here:
> https://lore.kernel.org/all/CAJuCfpFZ3B4530TgsSHqp5F_gwfrDujwRYewKReJru==MdEHQg@mail.gmail.com/#t).

If we're splitting these two functions apart, can we use the same naming
as the VFS please?

``flush``
        called by the close(2) system call to flush a file

``release``
        called when the last reference to an open file is closed


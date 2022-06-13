Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7838054A244
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 00:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbiFMWtL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 18:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiFMWtK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 18:49:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8823121B;
        Mon, 13 Jun 2022 15:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vivHcuWEO7dFMdfWmFo2zz7FZRzU0nU+SpS3rXiOnKw=; b=iW5b1d09EFoLvsVlISsRSBUFm+
        i0yU6R1qoudm0DVptYWGiDb4K1rbX9NCW4n7gRx/qPIs+Qx7llAtxEorPQO0y20O7/Me9iOqwEepZ
        rIR06xpcRk8Ci66ZeGy0dEfELDTD7bZBT9hR52YNbNZWtqVHPqvHQrNxyxS4b1813A3n/IPHqJvZz
        yaLZyzSJNnrTSlqHEDf2NgHEuFoJutfmcNCQlttqe34fVD+PQkKsZZDtpuWl9Lrj6LeI+2wexcy6x
        sjVOGsUf9kmyLA3RlmwcEJVDoyoIyefkiGVbQRB6J7rhnWifAKdnLYlQsp3lS6Xc3w6RJ1gyrMUQ2
        JlDWpDDQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o0srU-00HF9w-Vs; Mon, 13 Jun 2022 22:48:45 +0000
Date:   Mon, 13 Jun 2022 23:48:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        gwml@vger.gnuweeb.org
Subject: Re: Linux 5.18-rc4
Message-ID: <Yqe+zE4f7uo8YdBE@casper.infradead.org>
References: <CAHk-=whmtHMzjaVUF9bS+7vE_rrRctcCTvsAeB8fuLYcyYLN-g@mail.gmail.com>
 <226cee6a-6ca1-b603-db08-8500cd8f77b7@gnuweeb.org>
 <CAHk-=whayT+o58FrPCXVVJ3Bn-3SeoDkMA77TOd9jg4yMGNExw@mail.gmail.com>
 <87r1414y5v.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wijAnOcC2qQEAvFtRD_xpPbG+aSUXkfM-nFTHuMmPbZGA@mail.gmail.com>
 <266e648a-c537-66bc-455b-37105567c942@canonical.com>
 <Yp5iOlrgELc9SkSI@casper.infradead.org>
 <dd654ee2-ae10-e247-f98b-f5057dbb380b@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd654ee2-ae10-e247-f98b-f5057dbb380b@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 06, 2022 at 02:00:33PM -0700, John Johansen wrote:
> On 6/6/22 13:23, Matthew Wilcox wrote:
> > On Mon, Jun 06, 2022 at 12:19:36PM -0700, John Johansen wrote:
> >>> I suspect that part is that both Apparmor and IPC use the idr local lock.
> >>>
> >> bingo,
> >>
> >> apparmor moved its secids allocation from a custom radix tree to idr in
> >>
> >>   99cc45e48678 apparmor: Use an IDR to allocate apparmor secids
> >>
> >> and ipc is using the idr for its id allocation as well
> >>
> >> I can easily lift the secid() allocation out of the ctx->lock but that
> >> would still leave it happening under the file_lock and not fix the problem.
> >> I think the quick solution would be for apparmor to stop using idr, reverting
> >> back at least temporarily to the custom radix tree.
> > 
> > How about moving forward to the XArray that doesn't use that horrid
> > prealloc gunk?  Compile tested only.
> > 
> 
> I'm not very familiar with XArray but it does seem like a good fit. We do try
> to keep the secid allocation dense, ideally no holes. Wrt the current locking
> issue I want to hear what Thomas has to say. Regardless I am looking into
> whether we should just switch to XArrays going forward.

Nothing from Thomas ... shall we just go with this?  Do you want a
commit message, etc for the patch?

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DD760D496
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 21:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbiJYTT4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 15:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiJYTTy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:19:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B6425E8C;
        Tue, 25 Oct 2022 12:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n09+bMZNLfgYM0EqQ82ZGI+GYi1rd+xN3Y3MHKhcBWg=; b=CP6yoRqXwLlL65ib2h5kbr48BI
        8OnBVUhz3p1Vo36458CKULWEjbB0MwXMT1VEInqNiwhPuPfE7sXaRFhtjl82aJrchUhVYEdMcxjCq
        9SbkuQwR/A8NQ83doZ4y2MxPoatpEajlH+3gkgPExCidirm5PFmy/OeuwFKmOM1X17oYEsSMWanIu
        MBON3DyX/VSZW4zhgJ54sI5IXWbR7VXI8FGrWlRLsCxdaQX00j5wJL9p2JNXPxEga4xtJiYahtIVp
        3R6VerrsjmFBh8zsg1/45fjX9guGzZzFWEJbjpi6G8zIIiHRhy6H2nHFhp66te9vdmiGgihA+JJNz
        Mh/+wJAw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onPSi-00GUEW-JD; Tue, 25 Oct 2022 19:19:44 +0000
Date:   Tue, 25 Oct 2022 20:19:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Brian Foster <bfoster@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        jesus.a.arechiga.lopez@intel.com, tim.c.chen@linux.intel.com
Subject: Re: writeback completion soft lockup BUG in folio_wake_bit()
Message-ID: <Y1g20GUTu6mOq+CJ@casper.infradead.org>
References: <YjDj3lvlNJK/IPiU@bfoster>
 <YjJPu/3tYnuKK888@casper.infradead.org>
 <YjM88OwoccZOKp86@bfoster>
 <YjSTq4roN/LJ7Xsy@bfoster>
 <YjSbHp6B9a1G3tuQ@casper.infradead.org>
 <CAHk-=wh6V6TZjjnqBvktbaho_wqfjZYQ9zcKJTV8EP2Kygn0uQ@mail.gmail.com>
 <6350a5f07bae2_6be12944c@dwillia2-xfh.jf.intel.com.notmuch>
 <CAHk-=wizsHtGa=7dESxXd6VNU2mdHqhvCv88FB3xcWb3o3iJMw@mail.gmail.com>
 <6356f1f74678c_141929415@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <CAHk-=wj7mRYuictrQjT+sacgj9_GrmRetE1KLTiz-nOk-H4DPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj7mRYuictrQjT+sacgj9_GrmRetE1KLTiz-nOk-H4DPQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 24, 2022 at 01:28:31PM -0700, Linus Torvalds wrote:
> It does sound like we now very much have hard data for "the page
> waitlist complexity is now a bigger problem than the historical
> problem it tried to solve".
> 
> So I'll happily apply it. The only question is whether it's a "let's
> do this for 6.2", or if it's something that we'd want to back-port
> anyway, and might as well apply sooner rather than later as a fix.
> 
> I think that in turn then depends on just how artificial the test case
> was. If the test case was triggered by somebody seeing problems in
> real life loads, that would make the urgency a lot higher. But if it
> was purely a synthetic test case with no accompanying "this is what
> made us look at this" problem, it might be a 6.2 thing.
> 
> Arechiga?
> 
> Also, considering that Willy authored the patch (even if it's really
> just a "remove this whole code logic"), maybe he has opinions? Willy?

I've been carrying a pair of patches in my tree to rip out the wait
bookmarks since March, waiting for me to write a userspace testcase to
reproduce the problem against v4.13 and then check it no longer does so
against v5.0.  Unfortunately, that hasn't happened.  I'm happy to add
Arechiga's Tested-by, and submit them to Andrew and have him bring them
into v6.2, since this doesn't seem urgent?

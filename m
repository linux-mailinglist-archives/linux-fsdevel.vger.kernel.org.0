Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3F66A39CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 04:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjB0Dwa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 22:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjB0Dw3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 22:52:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A15E15CAB;
        Sun, 26 Feb 2023 19:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s2XLuqNakI5IK2tvRkLaHZ+X/T6hCi2Wf4OYq0JTOvk=; b=plS+tCwgrPsAMTki1+3xA161E7
        7XOBwVx1HrSYkbwCPg1ckJ3dy8eSc2K5SrCVtrkZqZvWws2K98C+SRsQcL1ngKu4R9FgPI/ad+QoF
        eQWsGMqCL0HQqkjsUpEF53l7ILC8sBZCDdlilmnd2lmX4uh9je5lNebBZULgqOoG0dxhymEJ8VEOC
        lFntLGJmZvvspQY6pJzGuI/PgObe9+qlNsJ+EXkAFC7o+QuIWDlGN6iwZ6onE0oAI9MF3mQ+uMJW2
        jAMv1eGOSuD1HrDb3399L6OF/eBt7IsIcNtbpRdU6fSEgqeaM6d2Kh84QeV+S7AaKlBm4vifIYOar
        cw2PlqfA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWUYe-00HP8F-Q7; Mon, 27 Feb 2023 03:52:12 +0000
Date:   Mon, 27 Feb 2023 03:52:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        kernel test robot <oliver.sang@intel.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [linus:master] [mm/mmap]  0503ea8f5b: kernel_BUG_at_mm/filemap.c
Message-ID: <Y/wo7H+ZZzFoEqvk@casper.infradead.org>
References: <202302252122.38b2139-oliver.sang@intel.com>
 <20230227031756.v57rhicna3tjbavw@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227031756.v57rhicna3tjbavw@revolver>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 26, 2023 at 10:17:56PM -0500, Liam R. Howlett wrote:
> Are you sure about this bisection?  I'm not saying it isn't my fault or
> looking to blame others, but I suspect we are indeed looking at the
> wrong commit here.

I concur.  Looking at the backtrace, I think it's more likely to be
a pagecache, swapcache or shmfs issue.  I'll look more in the morning.

> >         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
> > 
> >         # if come across any failure that blocks the test,
> >         # please remove ~/.lkp and /lkp dir to run from a clean state.
> > 
> 
> This does not work for me.  Since my last use of lkp it seems something
> was changed and now -watchdog is not recognized by my qemu and so my
> attempts to reproduce this are failing.  Is there a way to avoid using
> the -watchdog flag?  Running the command by hand fails as it seems some
> files are removed on exit?

https://www.qemu.org/docs/master/about/removed-features.html

-watchdog (since 7.2)

Use -device instead.

(I have no idea what this means, but maybe it's a clue?)

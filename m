Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7615D52D694
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 16:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240102AbiESO6u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 10:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240059AbiESO6m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 10:58:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23E9A5A89;
        Thu, 19 May 2022 07:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bOAgmeR6UE8Jq8eTwtkBILkXF6ykn4b5YwRwZCX7b7E=; b=qEDHH7DSiP/DGEjXLjijAwKUfs
        ymY04FdevHDrpotuF87hsVzBvNWWYvNH5zQhntY0z8c7nSKJIfMAdBXaymRN048YEk4ndlrZoQD15
        NANKGMUYqo0oGmL0hRZTeYr1ikIEIqYufdgH/Wjmb1HDJe04rDmC7aUODLhN7/6tL1XlIcZvB++v3
        Hl/FBOF926zEo8TRYzn/bh0dk53P0Sdf1P+GULrCZa4uFykTTfJi2E8QxnXDQE6XC37QdYeMcDyu5
        tMNcqhHGGHdChjWN5LkgL9kgSJyvavUF4uxYX5d1l93jC0JBM8P4vnDqS5HARbf6yK0jSYky7xUnn
        1QKLksqA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrhbj-00CoKR-FB; Thu, 19 May 2022 14:58:31 +0000
Date:   Thu, 19 May 2022 15:58:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, pankydev8@gmail.com,
        Theodore Tso <tytso@mit.edu>,
        Josef Bacik <josef@toxicpanda.com>, jmeneghi@redhat.com,
        Jan Kara <jack@suse.cz>, Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jake Edge <jake@lwn.net>, Klaus Jensen <its@irrelevant.dk>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [RFC: kdevops] Standardizing on failure rate nomenclature for
 expunges
Message-ID: <YoZbF90qS+LlSDfS@casper.infradead.org>
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org>
 <CAOQ4uxhKHMjGq0QKKMPFAV6iJFwe1H5hBomCVVeT1EWJzo0eXg@mail.gmail.com>
 <20220519112450.zbje64mrh65pifnz@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519112450.zbje64mrh65pifnz@zlang-mailbox>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 07:24:50PM +0800, Zorro Lang wrote:
> Yes, we talked about this, but if I don't rememeber wrong, I recommended each
> downstream testers maintain their own "testing data/config", likes exclude
> list, failed ratio, known failures etc. I think they're not suitable to be
> fixed in the mainline fstests.

This assumes a certain level of expertise, which is a barrier to entry.

For someone who wants to check "Did my patch to filesystem Y that I have
never touched before break anything?", having non-deterministic tests
run by default is bad.

As an example, run xfstests against jfs.  Hundreds of failures, including
some very scary-looking assertion failures from the page allocator.
They're (mostly) harmless in fact, just being a memory leak, but it
makes xfstests useless for this scenario.

Even for well-maintained filesystems like xfs which is regularly tested,
I expect generic/270 and a few others to fail.  They just do, and they're
not an indication that *I* broke anything.

By all means, we want to keep tests around which have failures, but
they need to be restricted to people who have a level of expertise and
interest in fixing long-standing problems, not people who are looking
for regressions.

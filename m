Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799D32354ED
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Aug 2020 05:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgHBDFw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Aug 2020 23:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHBDFw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Aug 2020 23:05:52 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DCFC06174A;
        Sat,  1 Aug 2020 20:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=C4AUGMo+yuGybGuPXaC+2uX4qyRucKB6ZNOOmOkSD7E=; b=VRMDBAM8eiF63PV0r/ghc0PsFd
        kToIrHCsMaLbDIek4RS2VMdEYR9s9dJKNi4IiVZDdFY9BUZswQg8Kh9fD77vIOOOgSP75CJZR6tEb
        ddfSSx1e8+ja8zK406tiGQem3almmIQSkZ5PR+HQEgq+9JikToOeYf8YhcwhQfg3PKzS9vLLIljiM
        jYCRmU6prmsOaOWUKBQCdWCc4qN4yWyi2IPLj2+oMdV6B0uR7WJNusigjkCGMUn5QMr9hH9n8zog4
        xS/twN4+ewlnCdh06/WFQ6PNz6KyTvFhV/hy1TjBTuVjYWTVA6Dm7gDmoe8JeipieZT4zkxg+jZ5P
        dr4+XU+Q==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k24Jm-0004Sk-6Q; Sun, 02 Aug 2020 03:05:46 +0000
Subject: Re: [PATCH mmotm] tmpfs: support 64-bit inums per-sb fix
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Down <chris@chrisdown.name>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1594661218.git.chris@chrisdown.name>
 <8b23758d0c66b5e2263e08baf9c4b6a7565cbd8f.1594661218.git.chris@chrisdown.name>
 <alpine.LSU.2.11.2008011223120.10700@eggly.anvils>
 <alpine.LSU.2.11.2008011928010.13320@eggly.anvils>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4d2af3f7-eb4f-6313-1719-b1c532c9a96d@infradead.org>
Date:   Sat, 1 Aug 2020 20:05:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2008011928010.13320@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/1/20 7:37 PM, Hugh Dickins wrote:
> Expanded Chris's Documentation and Kconfig help on tmpfs inode64.
> TMPFS_INODE64 still there, still default N, but writing down its very
> limited limitation does make me wonder again if we want the option.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
> Andrew, please fold into tmpfs-support-64-bit-inums-per-sb.patch later.
> 
> Randy, you're very active on Documentation and linux-next: may I ask you
> please to try applying this patch to latest, and see if tmpfs.rst comes
> out looking right to you?  I'm an old dog still stuck in the days of

Hi Hugh,
It looks fine.

> tmpfs.txt, hoping to avoid new tricks for a while.  Thanks!  (Bonus
> points if you can explain what the "::" on line 122 is about. I started
> out reading Documentation/doc-guide/sphinx.rst, but... got diverted.
> Perhaps I should ask Mauro or Jon, but turning for help first to you.)

That's the correct file. Around line 216, it says:

* For inserting fixed width text blocks (for code examples, use case
  examples, etc.), use ``::`` for anything that doesn't really benefit
  from syntax highlighting, especially short snippets. Use
  ``.. code-block:: <language>`` for longer code blocks that benefit
  from highlighting. For a short snippet of code embedded in the text, use \`\`.


so it's just for a (short) code example block, fixed font...


> 
>  Documentation/filesystems/tmpfs.rst |   13 ++++++++++---
>  fs/Kconfig                          |   16 +++++++++++-----
>  2 files changed, 21 insertions(+), 8 deletions(-)
> 
> --- mmotm/Documentation/filesystems/tmpfs.rst	2020-07-27 18:54:51.116524795 -0700
> +++ linux/Documentation/filesystems/tmpfs.rst	2020-08-01 18:37:07.719713987 -0700



cheers.
-- 
~Randy


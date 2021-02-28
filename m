Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25356327037
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Feb 2021 05:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhB1EEh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Feb 2021 23:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhB1EEg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Feb 2021 23:04:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E2FC06174A;
        Sat, 27 Feb 2021 20:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xLsb6hdOgPTvXqan9PgPfwKwlmUcrC3pL+IiN4sGEIM=; b=JHjHdp9O+7+SeQD9p/qzxmpQWI
        VwzjAoKHPshNtpXfhFosvLUlUxQ4W8t9ahcXcRAfRud0vZVByY6f50VvRcKp2h8BX+sJCXCWrEVxH
        bV7ojnRS22hUpIq/sw86JUfstaoppRBZG19RSIgDANbIAPqIahbO/BA11EmB5t3Dbp/GsE6HuKUNq
        tLxO6culfJ1B/LbAp7U/xkjOKhdlysey6eCYatBCGCVSw/atjkL1MxPTTkZnCNYM25Rgk6Y4SdKV4
        1gkII5t653TX+sc93wpHtl+9nGGo0B/3P11k9wR/yVuF0Nyuq8nDD3hr2OM7eY8/2u76v+bmc8DgB
        B2+hxI0A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lGDJ3-00E6Mv-Bb; Sun, 28 Feb 2021 04:03:49 +0000
Date:   Sun, 28 Feb 2021 04:03:45 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [RFC PATCH] fs: introduce mkdirat2 syscall for atomic mkdir
Message-ID: <20210228040345.GO2723601@casper.infradead.org>
References: <20210228002500.11483-1-sir@cmpwn.com>
 <20210228022440.GN2723601@casper.infradead.org>
 <C9KT3SWXRPPA.257SY2N4MVBZD@taiga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C9KT3SWXRPPA.257SY2N4MVBZD@taiga>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 27, 2021 at 09:26:21PM -0500, Drew DeVault wrote:
> On Sat Feb 27, 2021 at 9:24 PM EST, Matthew Wilcox wrote:
> > Where's the problem? If mkdir succeeds in a sticky directory, others
> > can't remove or rename it. So how can an app be tricked into doing
> > something wrong?
> 
> It's not a security concern, it's just about about making the software
> more robust.
> 
> 1. Program A creates a directory
> 2. Program A is pre-empted
> 3. Program B deletes the directory
> 4. Program A creates a file in that directory
> 5. RIP

umm ... program B deletes the directory.  program A opens it in order to
use openat().  program A gets ENOENT and exits, confused.  that's the
race you're removing here -- and it seems fairly insignificant to me.

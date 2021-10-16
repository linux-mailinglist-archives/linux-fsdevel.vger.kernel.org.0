Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D3143039F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Oct 2021 18:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhJPQVQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Oct 2021 12:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhJPQVN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Oct 2021 12:21:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D01CC061570;
        Sat, 16 Oct 2021 09:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IjZSx47/pT12yjNBS4Xi8fL7I8DemHVk6Qp+V3LbhPo=; b=LeyOSoVJ6A8yfeXchlIsBqJX9o
        pyOgmz8mJzQ8FyXMeEoLRpwIUXfu0ChcbwOjtHVVsBSYdvaWWNROkOG2ylYDhrGYVEx6q1n50c5V1
        fVeFLNCmH7LxhiNK1nXMqQk000S8RWQcc43M4prvELqkufklSpTWEbtqJcjsS2t0sme+CHzHX0a78
        r64hgAlHpXB1C3h3KrdKgyv7YOT0mF9ZLgpQzN4TwOzTT/yLF7Q5vlo5D52ibInPuZEgN5Trp87KP
        s6nu2Vm2H7ZbFr9nK0oXA9vmrS8r9KZkOzvMxBmHRlQFRg4vLFBoXWKmAkZwYTuah5iymJM1QO0t/
        8Not1XKw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbmO8-009lbl-S7; Sat, 16 Oct 2021 16:18:29 +0000
Date:   Sat, 16 Oct 2021 17:18:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Len Baker <len.baker@gmx.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Avoid open coded arithmetic in memory allocator
 functions
Message-ID: <YWr7UN1+RkayVWy2@casper.infradead.org>
References: <20211016152829.9836-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211016152829.9836-1-len.baker@gmx.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 16, 2021 at 05:28:28PM +0200, Len Baker wrote:
> +static size_t new_dir_size(size_t namelen)
> +{
> +	size_t bytes;
> +
> +	if (check_add_overflow(sizeof(struct ctl_dir), sizeof(struct ctl_node),
> +			       &bytes))
> +		return SIZE_MAX;
> +	if (check_add_overflow(bytes, array_size(sizeof(struct ctl_table), 2),
> +			       &bytes))
> +		return SIZE_MAX;
> +	if (check_add_overflow(bytes, namelen, &bytes))
> +		return SIZE_MAX;
> +	if (check_add_overflow(bytes, (size_t)1, &bytes))
> +		return SIZE_MAX;
> +
> +	return bytes;
> +}

I think this is overkill.  All these structs are small and namelen is
supplied by the kernel, not specified by userspace.  It really complicates
the code, and I don't see the advantage.


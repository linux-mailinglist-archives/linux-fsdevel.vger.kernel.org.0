Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687C9327EA6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 13:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbhCAMxp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 07:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbhCAMxl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 07:53:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8D1C061788;
        Mon,  1 Mar 2021 04:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WHvAFmzATjJkj3eS14Y2bRQ/0MK15ayQjxuRPOoXwkY=; b=Wf9g5fLQ/GJNx0hUGWiUcR688m
        SFottxWwv97wHRMcSWiZYT2E+sxl0o7LEq0E6RXd7FEuOPhQLfcASAJJ9LOurSnogDOi6PXOMY/J9
        6GRlzO+MVjNi3kD8VIvE9bJQ9KZCHhZhEsM7NbBu3xnmPbyjT4wxZc6BD3GP4KLHB1kG58wf8V3z+
        sFKLW2Ah/tdGwCaIYWTA1OO5gUNtnViM8vZHoTgdySFMKvBr8B4RZSZ00Skfe8qUbor6TpUQe7+tW
        b9OQ6zcvUGHYDX7AWw+lpPcAwhemkr/wF2oCE7T/Ot5jO0ktilYag94DmVM+raOCLVllIw+32HZi+
        VtQJEceg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lGi2P-00FiwK-BV; Mon, 01 Mar 2021 12:52:41 +0000
Date:   Mon, 1 Mar 2021 12:52:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Return -EFAULT if copy_to_user() fails
Message-ID: <20210301125237.GQ2723601@casper.infradead.org>
References: <1614597960-32681-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614597960-32681-1-git-send-email-wangqing@vivo.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 01, 2021 at 07:26:00PM +0800, Wang Qing wrote:
> The copy_to_user() function returns the number of bytes remaining to be
> copied, but we want to return -EFAULT if the copy doesn't complete.

... which is done by the only caller.

        if (set_fd_set(n, inp, fds.res_in) ||
            set_fd_set(n, outp, fds.res_out) ||
            set_fd_set(n, exp, fds.res_ex))
                ret = -EFAULT;


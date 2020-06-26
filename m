Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056CE20B33E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 16:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgFZOIo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 10:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbgFZOIo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:08:44 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F62C03E979;
        Fri, 26 Jun 2020 07:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1qE/CSYkKSIWa0HVHRGcdwYVNEuJa/ioLXid/J3lIeA=; b=WeijIFhX9wsKr5Z62w5VWa8dgx
        T5wYl8+U2un526zVn0flr6qRFw1v4aaXnSiq8IsEa6DaqjdAbcc3tHIWYGkkjxq/UbwkqxqW5XDuh
        /lt9srZLTtrq8WPPxtrizNlcXYRACYSZx/fqlrEBnHqhlhS6PWzXZXzeIiiB8ueBl02tSRXARJWhd
        6gpt+Oyx/u4ZIB/m8B2Zvy82PsGJfFMdiR9YP2zqF6xvgxtRCSDcRhxaTOYL8gcyQnQKGxihCgNcv
        j1oESnGKpy0GaXpi4phx0/3SqhNZyRYZ3CtqjzdGkNH6V+ZHozT5gIvA/8PpvVqd0Wr0J/883vpNh
        LnbJYWkg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1joolf-0007WT-GY; Fri, 26 Jun 2020 13:51:47 +0000
Date:   Fri, 26 Jun 2020 14:51:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 8/9] fs: don't allow kernel reads and writes without iter
 ops
Message-ID: <20200626135147.GB25039@casper.infradead.org>
References: <20200626075836.1998185-1-hch@lst.de>
 <20200626075836.1998185-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626075836.1998185-9-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 26, 2020 at 09:58:35AM +0200, Christoph Hellwig wrote:
> +static void warn_unsupported(struct file *file, const char *op)
> +{
> +	char pathname[128], *path;
> +
> +	path = file_path(file, pathname, sizeof(pathname));
> +	if (IS_ERR(path))
> +		path = "(unknown)";
> +	pr_warn_ratelimited(
> +		"kernel %s not supported for file %s (pid: %d comm: %.20s)\n",
> +		op, path, current->pid, current->comm);
> +}
> +

how about just:

	pr_warn_ratelimited(
		"kernel %s not supported for file %pD4 (pid: %d comm: %.20s)\n",
			op, file, current->pid, current->comm);

also, is the pid really that interesting?

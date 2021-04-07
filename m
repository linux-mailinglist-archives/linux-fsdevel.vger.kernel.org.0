Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675A035754F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 21:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349078AbhDGT64 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 15:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhDGT64 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 15:58:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E156C06175F;
        Wed,  7 Apr 2021 12:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JjXV4iIMrHWU9i+xZKHGpsUVd6AqcmhooDRZ//lUvEg=; b=XeAVDBiyS7Tj0prG+DOS4Zb3Jy
        sq87OZpN37+BzWHpapHrEajb5sSM4kcRn8q91boCj6INEfRKlCfjDhYe4ulmdWCmyorAXu+/c6iOF
        rShOkIbOeB2zkY+mdgU7VbKrHFdjcobj0wfMDD1MGhMQ/mvioh5ah0XjFvDKoMGicpZkbqyCKO5og
        3OtXef4gzxTEA+TsjLd3qtbMQcfAEON/u32ykfF3d71/v4CxHpUD8VF62UoZ/7xj8+LSQzPsVi+No
        qoQsqSE8ANU1tW4RSqzO/9nW0OpXtfOCS4mF5GrZFjzutBEupjyA0SlRpXV/Npeb55RAS3DqwZ1V9
        s5OLKejQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUEJV-00F0ZE-Jp; Wed, 07 Apr 2021 19:58:17 +0000
Date:   Wed, 7 Apr 2021 20:58:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: smoke test lseek()
Message-ID: <20210407195809.GG2531743@casper.infradead.org>
References: <20210328221524.ukfuztGsl%akpm@linux-foundation.org>
 <YG4OIhChOrVTPgdN@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG4OIhChOrVTPgdN@localhost.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 07, 2021 at 10:55:14PM +0300, Alexey Dobriyan wrote:
> Now that ->proc_lseek has been made mandatory it would be nice to test
> that nothing has been forgotten.

> @@ -45,6 +45,8 @@ static void f_reg(DIR *d, const char *filename)
>  	fd = openat(dirfd(d), filename, O_RDONLY|O_NONBLOCK);
>  	if (fd == -1)
>  		return;
> +	/* struct proc_ops::proc_lseek is mandatory if file is seekable. */
> +	(void)lseek(fd, 0, SEEK_SET);
>  	rv = read(fd, buf, sizeof(buf));
>  	assert((0 <= rv && rv <= sizeof(buf)) || rv == -1);
>  	close(fd);

why throw away the return value?  if it returns an error seeking to
offset 0, something is terribly wrong.

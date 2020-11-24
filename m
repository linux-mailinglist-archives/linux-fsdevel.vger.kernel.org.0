Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80102C1C7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 05:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgKXEGj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 23:06:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:46408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728320AbgKXEGi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 23:06:38 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25C5C2072C;
        Tue, 24 Nov 2020 04:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1606190798;
        bh=G+iM+NPKoFbWqudOP+1lcPXuXrmLt7zAynbD/g8Fg8Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZW4oqPlGi21BSyTBhYgtD/mED1mVQ/V69fathFcbWkpXmb01YQjTPgMQ8KqCUt6Fo
         nQO63WEcJT4ZeJ2E2RqzsX2GIuLmiSsaA8ud5y+R3fxtqwM4NiYI8miTFcU9ry7RhB
         WGI/Ep//SxDp8hMLrFJ3fd8rxyapRdy7jko846Uk=
Date:   Mon, 23 Nov 2020 20:06:36 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     menglong8.dong@gmail.com
Cc:     pabs3@bonedaddy.net, viro@zeniv.linux.org.uk,
        nhorman@tuxdriver.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Menglong Dong <dong.menglong@zte.com.cn>
Subject: Re: [PATCH] coredump: fix core_pattern parse error
Message-Id: <20201123200636.2dbbf127e7cd75b4022bd75f@linux-foundation.org>
In-Reply-To: <5fb62870.1c69fb81.8ef5d.af76@mx.google.com>
References: <5fb62870.1c69fb81.8ef5d.af76@mx.google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 19 Nov 2020 03:08:43 -0500 menglong8.dong@gmail.com wrote:

> From: Menglong Dong <dong.menglong@zte.com.cn>
> 
> 'format_corename()' will splite 'core_pattern' on spaces when it
> is in pipe mode, and take helper_argv[0] as the path to usermode
> executable.
> 
> It works fine in most cases. However, if there is a space between
> '|' and '/file/path', such as
> '| /usr/lib/systemd/systemd-coredump %P %u %g',
> helper_argv[0] will be parsed as '', and users will get a
> 'Core dump to | disabled'.
> 
> It is not friendly to users, as the pattern above was valid previously.
> Fix this by ignoring the spaces between '|' and '/file/path'.
> 
> ...
>
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -229,7 +229,8 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
>  		 */
>  		if (ispipe) {
>  			if (isspace(*pat_ptr)) {
> -				was_space = true;
> +				if (cn->used != 0)
> +					was_space = true;
>  				pat_ptr++;
>  				continue;
>  			} else if (was_space) {

Looks good to me.  It's been a bit more than a year, but I'll add a
cc:stable to this so that the earlier kernels get the fix.


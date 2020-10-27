Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C342829A6F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 09:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894786AbgJ0IwA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 04:52:00 -0400
Received: from casper.infradead.org ([90.155.50.34]:34938 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894680AbgJ0IwA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fSWpZLWK6a50bQhHF7Ngx8fWlq2jDUcqwsZZ4Vyxv7g=; b=vGHUAbwtRoi7FpOwEWJanX7hdN
        xQK/hI9J8zJv23Nahp1/fB+NmsiJU8yXJfFgzIhV+dWKbcu7pJYtjkH54YhBs/zBxaxqx5tnup1gE
        sSf3bEU1hm/OWwBDTLdnrHXZ5wvGukI3WU6/3TrKKIgsm6H3HBirQPXx3zexASq+A89+3oidV0gFb
        YsR6swbQlscxykecfRepR+BdcKEhR2Zmd67TC4vrh8hf3tfGqG/nG2UdIkplGN91/7uq8Huq0/qDB
        vfuwiD/cyT1dF1XnjjYhufu6uLeR7f8cGVLWwaRIAzagBh5QTT1VPoYij7dZnYDx0VTqnc4kfgHo1
        yD+lkSOQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXKhs-0003YB-AW; Tue, 27 Oct 2020 08:51:52 +0000
Date:   Tue, 27 Oct 2020 08:51:52 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        anmar.oueja@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] dcookies: Make dcookies depend on CONFIG_OPROFILE
Message-ID: <20201027085152.GB10053@infradead.org>
References: <51a9a594a38ae6e0982e78976cf046fb55b63a8e.1603191669.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51a9a594a38ae6e0982e78976cf046fb55b63a8e.1603191669.git.viresh.kumar@linaro.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Is it time to deprecate and eventually remove oprofile while we're at
it?

On Tue, Oct 20, 2020 at 04:31:27PM +0530, Viresh Kumar wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The dcookies stuff is used only with OPROFILE and there is no need to
> build it if CONFIG_OPROFILE isn't enabled. Build it depending on
> CONFIG_OPROFILE instead of CONFIG_PROFILING.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> [ Viresh: Update the name in #endif part ]
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  fs/Makefile              | 2 +-
>  include/linux/dcookies.h | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/Makefile b/fs/Makefile
> index 7bb2a05fda1f..a7b3d9ff8db5 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -64,7 +64,7 @@ obj-$(CONFIG_SYSFS)		+= sysfs/
>  obj-$(CONFIG_CONFIGFS_FS)	+= configfs/
>  obj-y				+= devpts/
>  
> -obj-$(CONFIG_PROFILING)		+= dcookies.o
> +obj-$(CONFIG_OPROFILE)		+= dcookies.o
>  obj-$(CONFIG_DLM)		+= dlm/
>   
>  # Do not add any filesystems before this line
> diff --git a/include/linux/dcookies.h b/include/linux/dcookies.h
> index ddfdac20cad0..8617c1871398 100644
> --- a/include/linux/dcookies.h
> +++ b/include/linux/dcookies.h
> @@ -11,7 +11,7 @@
>  #define DCOOKIES_H
>   
>  
> -#ifdef CONFIG_PROFILING
> +#ifdef CONFIG_OPROFILE
>   
>  #include <linux/dcache.h>
>  #include <linux/types.h>
> @@ -64,6 +64,6 @@ static inline int get_dcookie(const struct path *path, unsigned long *cookie)
>  	return -ENOSYS;
>  }
>  
> -#endif /* CONFIG_PROFILING */
> +#endif /* CONFIG_OPROFILE */
>  
>  #endif /* DCOOKIES_H */
> -- 
> 2.25.0.rc1.19.g042ed3e048af
> 
---end quoted text---

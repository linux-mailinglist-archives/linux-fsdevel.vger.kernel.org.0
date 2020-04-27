Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1281B1BAFBD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 22:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgD0UuR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 16:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbgD0UuQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:50:16 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E09C0610D5;
        Mon, 27 Apr 2020 13:50:16 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTAhN-00D2oe-Sy; Mon, 27 Apr 2020 20:49:54 +0000
Date:   Mon, 27 Apr 2020 21:49:53 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] powerpc/spufs: simplify spufs core dumping
Message-ID: <20200427204953.GY23230@ZenIV.linux.org.uk>
References: <20200427200626.1622060-1-hch@lst.de>
 <20200427200626.1622060-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427200626.1622060-2-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 27, 2020 at 10:06:21PM +0200, Christoph Hellwig wrote:

> @@ -1988,7 +1984,12 @@ static ssize_t spufs_mbox_info_read(struct file *file, char __user *buf,
>  	if (ret)
>  		return ret;
>  	spin_lock(&ctx->csa.register_lock);
> -	ret = __spufs_mbox_info_read(ctx, buf, len, pos);
> +	/* EOF if there's no entry in the mbox */
> +	if (ctx->csa.prob.mb_stat_R & 0x0000ff) {
> +		ret = simple_read_from_buffer(buf, len, pos,
> +				&ctx->csa.prob.pu_mb_R,
> +				sizeof(ctx->csa.prob.pu_mb_R));
> +	}
>  	spin_unlock(&ctx->csa.register_lock);
>  	spu_release_saved(ctx);

Again, this really needs fixing.  Preferably - as a separate commit preceding
this series, so that it could be backported.  simple_read_from_buffer() is
a blocking operation.  Yes, I understand that mainline has the same bug;
it really does need to be fixed and having to backport this series is not
a good idea, for obvious reasons.

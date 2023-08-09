Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9087D7756B7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 11:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjHIJyv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 05:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHIJyu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:54:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E2C1FCA
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Aug 2023 02:54:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1EC6121862;
        Wed,  9 Aug 2023 09:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691574888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dyhy9ry952tksH6A814qNxG1hC4mb7gokwKEbZjKvSA=;
        b=yGUxVjnbpk73WwmI2R78FfU2llw+nXvBBmYxzBt48F7HA2NctrtcySode/APmgGmAt9T8L
        5fy9wh4ugak1gjXz07xA75GJfuTArxQUVM6WCqMdd4MxVq+ayCHC3TNMzjrfScEOJmcOO3
        0ocyI15+IZNVJMAm2O3+reeOjJXO2Dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691574888;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dyhy9ry952tksH6A814qNxG1hC4mb7gokwKEbZjKvSA=;
        b=lEJSvxxH8ZwOgRrwSyllOoreeiKMv/DZbR0rz3QyhoWrfPelkDDu+X6DEH0rONAD/1cisn
        Oamd3YO5Sb+iYeDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0DC36133B5;
        Wed,  9 Aug 2023 09:54:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QGthA2hi02RGHwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 09 Aug 2023 09:54:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8A435A0769; Wed,  9 Aug 2023 11:54:47 +0200 (CEST)
Date:   Wed, 9 Aug 2023 11:54:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hugh Dickins <hughd@google.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleksandr Tymoshenko <ovt@google.com>,
        Carlos Maiolino <cem@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>, Daniel Xu <dxu@dxuuu.xyz>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        Yu Kuai <yukuai3@huawei.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH vfs.tmpfs 4/5] tmpfs: trivial support for direct IO
Message-ID: <20230809095447.7iturpglkvbzyvmg@quack3>
References: <e92a4d33-f97-7c84-95ad-4fed8e84608c@google.com>
 <7c12819-9b94-d56-ff88-35623aa34180@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c12819-9b94-d56-ff88-35623aa34180@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 08-08-23 21:34:54, Hugh Dickins wrote:
> Depending upon your philosophical viewpoint, either tmpfs always does
> direct IO, or it cannot ever do direct IO; but whichever, if tmpfs is to
> stand in for a more sophisticated filesystem, it can be helpful for tmpfs
> to support O_DIRECT.  So, give tmpfs a shmem_direct_IO() method, of the
> simplest kind: by just returning 0 done, it leaves all the work to the
> buffered fallback (and everything else just happens to work out okay -
> in particular, its dirty pages don't get lost to invalidation).
> 
> xfstests auto generic which were not run on tmpfs before but now pass:
> 036 091 113 125 130 133 135 198 207 208 209 210 211 212 214 226 239 263
> 323 355 391 406 412 422 427 446 451 465 551 586 591 609 615 647 708 729
> with no new failures.
> 
> LTP dio tests which were not run on tmpfs before but now pass:
> dio01 through dio30, except for dio04 and dio10, which fail because
> tmpfs dio read and write allow odd count: tmpfs could be made stricter,
> but would that be an improvement?
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Yeah, we are not quite consistent about whether it is better to silently
fallback to buffered IO or return error among filesystems. So I guess
whatever you like. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/shmem.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 7420b510a9f3..4d5599e566df 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2720,6 +2720,16 @@ shmem_write_end(struct file *file, struct address_space *mapping,
>  	return copied;
>  }
>  
> +static ssize_t shmem_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
> +{
> +	/*
> +	 * Just leave all the work to the buffered fallback.
> +	 * Some LTP tests may expect us to enforce alignment restrictions,
> +	 * but the fallback works just fine with any alignment, so allow it.
> +	 */
> +	return 0;
> +}
> +
>  static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  {
>  	struct file *file = iocb->ki_filp;
> @@ -4421,6 +4431,7 @@ const struct address_space_operations shmem_aops = {
>  #ifdef CONFIG_TMPFS
>  	.write_begin	= shmem_write_begin,
>  	.write_end	= shmem_write_end,
> +	.direct_IO	= shmem_direct_IO,
>  #endif
>  #ifdef CONFIG_MIGRATION
>  	.migrate_folio	= migrate_folio,
> -- 
> 2.35.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

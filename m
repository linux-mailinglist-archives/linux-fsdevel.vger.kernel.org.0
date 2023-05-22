Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2741670B264
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 02:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjEVARB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 20:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEVARA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 20:17:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8EDCE;
        Sun, 21 May 2023 17:16:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A2E761880;
        Mon, 22 May 2023 00:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4DBC433D2;
        Mon, 22 May 2023 00:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684714618;
        bh=pynMqTKclwPIt+cST9RZwiWCLVo4HSNzTZHy4TzJIsc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BXAriNGxpa+JuaO2vxwOc9RNJOKNUssZmct2fcZwWAWp3X0h0H6VbL8sSHwWS4Nlz
         4FFrrfLZBOK1xbCl0c1T84fG3aCpvtIPLwDvQzrlNxDwJfLv9BoGEpX1hZmWMVH90/
         dCZXRY3nh+vkQyvlEnLs3BwteEN+wNZb3bwJHXJ1Wh6zmCmoh60OUOzjMfheU+87DF
         MtWTLuia8tNf1tD4dLRjHDec5dxMHfNkmfksktoiwmUe4k2hWaELWrz+GqPuNs9Zw5
         8kiY+kVYzuuVS7cmiIzONousu4OZfEQyxVy6h9qY1nQPLDSUdpM78qRyPx4NabhlFy
         D6sDWIqYSxOIw==
Message-ID: <c989fa29-3e5e-e367-8d79-2bf10758dff3@kernel.org>
Date:   Mon, 22 May 2023 09:16:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 10/13] fs: factor out a direct_write_fallback helper
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
        cluster-devel@redhat.com, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org
References: <20230519093521.133226-1-hch@lst.de>
 <20230519093521.133226-11-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230519093521.133226-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/19/23 18:35, Christoph Hellwig wrote:
> Add a helper dealing with handling the syncing of a buffered write fallback
> for direct I/O.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK. One comment below.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> +	/*
> +	 * We need to ensure that the page cache pages are written to disk and
> +	 * invalidated to preserve the expected O_DIRECT semantics.
> +	 */
> +	end = pos + buffered_written - 1;
> +	err = filemap_write_and_wait_range(mapping, pos, end);
> +	if (err < 0) {
> +		/*
> +		 * We don't know how much we wrote, so just return the number of
> +		 * bytes which were direct-written
> +		 */
> +		return err;
> +	}
> +	invalidate_mapping_pages(mapping, pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
> +	return direct_written + buffered_written;

Why not adding here something like:

	if (buffered_written != iov_iter_count(from))
		return -EIO;

	return direct_written + buffered_written;

to have the same semantic as plain DIO ?

-- 
Damien Le Moal
Western Digital Research


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32415B47E8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Sep 2022 20:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiIJS1B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Sep 2022 14:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiIJS1A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Sep 2022 14:27:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7108C41D27;
        Sat, 10 Sep 2022 11:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HzbaF/w2gu/Kp3W2KzeU3D5B1emioVuvk2oKXIlN0co=; b=hm0jlUjj5UPTktuEEfUHRHbtOL
        h5E5opUGiLigsiUuo00mrPc/A4xSEK8VCx+Yx+3vbGl8ODfANdUXogLnu7f5zh29M33K+0qsQ/es7
        0xTIeKa1vqEKoFetp/WoYtCPF63JIlhvk76Rm/3uAW6SG6gLhu1HtMF1559ykvfauNUIOqkPbJCfj
        SIoFYzlt82k3xuVcsZtHS43gi4yUwtW69NwP0xZHAbA5vyoTXRt5vhNkTe5yeDQjOohy7QJmhScaI
        aDGg00fQdrkBdudzVC5CiEHwVo3HXgsI09f4qFaQknUW4ND6l2DYCkrfLZYuIEhUDs75cOwkuqbmG
        2b9Uyy1w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oX5Bb-00EFd2-Lx; Sat, 10 Sep 2022 18:26:35 +0000
Date:   Sat, 10 Sep 2022 19:26:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/5] mm: add PSI accounting around ->read_folio and
 ->readahead calls
Message-ID: <YxzW2wZzhaDvjS1c@casper.infradead.org>
References: <20220910065058.3303831-1-hch@lst.de>
 <20220910065058.3303831-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910065058.3303831-2-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 10, 2022 at 08:50:54AM +0200, Christoph Hellwig wrote:
> @@ -480,11 +487,14 @@ static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
>  	if (index == mark)
>  		folio_set_readahead(folio);
>  	err = filemap_add_folio(ractl->mapping, folio, index, gfp);
> -	if (err)
> +	if (err) {
>  		folio_put(folio);
> -	else
> -		ractl->_nr_pages += 1UL << order;
> -	return err;
> +		return err;
> +	}
> +
> +	ractl->_nr_pages += 1UL << order;
> +	ractl->_workingset = folio_test_workingset(folio);

I don't have time to look at this properly right now (about to catch a
bus to the plane), but I think this should be |=, not =?


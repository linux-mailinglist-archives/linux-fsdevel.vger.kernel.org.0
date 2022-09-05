Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2208A5ACDBE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 10:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237615AbiIEIYv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 04:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237550AbiIEIYp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:24:45 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A8CD7;
        Mon,  5 Sep 2022 01:24:20 -0700 (PDT)
Received: from letrec.thunk.org (guestnat-104-133-160-99.corp.google.com [104.133.160.99] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2858NOnQ025716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Sep 2022 04:23:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1662366211; bh=Opykd4NroLOvUVAS6DC0mH5AVipCgMT0W9fOrq2cA5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=kQY2cNMKCxqeSaFySEG9If6ZtQ8BhheeiKQJIw2xRYU0mwh5KEc4n5fb1xfvPk4CZ
         mBNdt31pMRPo3WHANZ5/Ldd6KIRnX21xck+7Bwn1Fcrsc5FcAOy78knWuHYTLXAl4g
         DxocwCUAw/g0qM3+vyInmt7rzH9XEt3Rw96cWfFdL1E5K22280Elx75++itsnVc6Gr
         BQtWa317FaLTf8L+CdQ4p6Ae6qIlTOrneZoG/Z4wofU62NxWKd3WMtYF7anpMD6LxL
         vXTuclZkTdheNbZQoIMugvCv3ZQ/q2LRDpdTb2u/xsaul3tZnLnf3enunBF8CgAtMV
         Liep1iIsFATVw==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 344298C2B5D; Mon,  5 Sep 2022 04:23:24 -0400 (EDT)
Date:   Mon, 5 Sep 2022 04:23:24 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, cluster-devel@redhat.com,
        ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com,
        reiserfs-devel@vger.kernel.org, jack@suse.cz,
        akpm@linux-foundation.org, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, rpeterso@redhat.com, agruenba@redhat.com,
        almaz.alexandrovich@paragon-software.com, mark@fasheh.com,
        dushistov@mail.ru, hch@infradead.org, chengzhihao1@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH v2 06/14] jbd2: replace ll_rw_block()
Message-ID: <YxWx/E0TIhBMhaq6@mit.edu>
References: <20220901133505.2510834-1-yi.zhang@huawei.com>
 <20220901133505.2510834-7-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901133505.2510834-7-yi.zhang@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 01, 2022 at 09:34:57PM +0800, Zhang Yi wrote:
> ll_rw_block() is not safe for the sync read path because it cannot
> guarantee that submitting read IO if the buffer has been locked. We
> could get false positive EIO after wait_on_buffer() if the buffer has
> been locked by others. So stop using ll_rw_block() in
> journal_get_superblock(). We also switch to new bh_readahead_batch()
> for the buffer array readahead path.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Thanks, looks good.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>


					- Ted

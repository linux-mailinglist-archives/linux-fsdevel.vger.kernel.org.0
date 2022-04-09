Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEC64FA4D8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Apr 2022 07:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbiDIFJa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Apr 2022 01:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241916AbiDIFIt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Apr 2022 01:08:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2FB1D9146;
        Fri,  8 Apr 2022 22:06:42 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AB9CC68AFE; Sat,  9 Apr 2022 07:06:38 +0200 (CEST)
Date:   Sat, 9 Apr 2022 07:06:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Mark Hemment <markhemm@googlemail.com>,
        Patrice CHOTARD <patrice.chotard@foss.st.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] tmpfs: fix regressions from wider use of ZERO_PAGE
Message-ID: <20220409050638.GB17755@lst.de>
References: <9a978571-8648-e830-5735-1f4748ce2e30@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a978571-8648-e830-5735-1f4748ce2e30@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 08, 2022 at 01:38:41PM -0700, Hugh Dickins wrote:
> +		} else if (iter_is_iovec(to)) {
> +			/*
> +			 * Copy to user tends to be so well optimized, but
> +			 * clear_user() not so much, that it is noticeably
> +			 * faster to copy the zero page instead of clearing.
> +			 */
> +			ret = copy_page_to_iter(ZERO_PAGE(0), offset, nr, to);

Is the offset and length guaranteed to be less than PAGE_SIZE here?

Either way I'd rather do this optimization in iov_iter_zero rather
than hiding it in tmpfs.

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708AA5A30F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 23:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344578AbiHZVVn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 17:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239997AbiHZVVm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 17:21:42 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CF51403E;
        Fri, 26 Aug 2022 14:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jA15Q1AsL1CdeNBKwMd0iWzOfyNlFoAbN16yRdeZrpU=; b=LHSaq3B7n9zwAdH9ODgDMjlqwn
        pjU/9JXzHBahjJC0FYcCwoRYqTxYpCn/xNGWrJC4SLynDeTpnGzeoS/Nck/2rj6607nBucn8yacCu
        yQo21WQcSJhTEXZKxQX6Z+Xl8g5/cKhU85KHPkdi0i1+R/LmpfIgSd8rlI0adT68dA02HWEM0orva
        bkPH5ONKMT8KRMZicpgd6wzOOpDg8W9MWF30oRIAsYBPbQB29699Ekvz3j5BdHU40hcelBIGKrxum
        SOBYPUtgJkjQgIfMN8Nrz4Qsd/Ca/ouvP7NVByTqVp8qH6YE/xsAR5cmQyfVOKvpW5evjpaVjt0i2
        ZwKUJdDg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oRglg-008f84-Nw;
        Fri, 26 Aug 2022 21:21:32 +0000
Date:   Fri, 26 Aug 2022 22:21:32 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] iov_iter: Add a function to extract an iter's
 buffers to a bvec iter
Message-ID: <Ywk5XE6FvP5pI5d4@ZenIV>
References: <166126392703.708021.14465850073772688008.stgit@warthog.procyon.org.uk>
 <166126393409.708021.16165278011941496946.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166126393409.708021.16165278011941496946.stgit@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 23, 2022 at 03:12:14PM +0100, David Howells wrote:
> +		ret = iov_iter_get_pages2(orig, pages, count, max_pages - npages,
> +					  &start);
> +		if (ret < 0) {
> +			pr_err("Couldn't get user pages (rc=%zd)\n", ret);
> +			break;
> +		}
> +
> +		if (ret > count) {
> +			pr_err("get_pages rc=%zd more than %zu\n", ret, count);
> +			break;
> +		}
> +
> +		iov_iter_advance(orig, ret);

Have you even tested that?  iov_iter_get_pages2() advances the iterator it had been
given.  And no, it does *not* return more than it had been asked to, so the second
check is complete BS.

That's aside of the usefulness of the primitive in question...

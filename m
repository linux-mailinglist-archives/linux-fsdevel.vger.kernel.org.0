Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBE1543940
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 18:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245521AbiFHQkE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 12:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243943AbiFHQkD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:40:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27FB3F8B6;
        Wed,  8 Jun 2022 09:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MwcirbnUcJouW4gUH1K/TOmiRgSxjZwJ44e3qbasRjw=; b=KPU2tAnm20YupttNFKZCw4vsSw
        V34mWrQxMg05ebxlTlDF4a1rF1kSHDi+R/CanAeYjGeVD8EChUu7lULjOOShfWpIc/MwxLAQEDGBy
        B1HphdqDXHqh62RGXSSXAOTwWKlxwsNz89CA93mjrsonFTyExUtjHOkLM8uEkNFJYG69BtJAAE0b2
        kx0X/oggN+HDbEsXpU/XHY55Afc0DwIClrq9L0cApg7pKy7biH3JlvK0wFXta4HsEqGT3bCVubNlF
        d4I9TzXlgF7OwY71sXLdyaOBoi2R7ZGYgXzIHIQyGT4lj5W/5goPXH0VnYZlb9h/0St4zkQTb0Rv8
        zFWEfJyA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyyit-00Cnqs-NR; Wed, 08 Jun 2022 16:39:59 +0000
Date:   Wed, 8 Jun 2022 17:39:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.com>, Dave Kleikamp <shaggy@kernel.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, jfs-discussion@lists.sourceforge.net
Subject: Re: [PATCH 1/5] ext2: remove nobh support
Message-ID: <YqDQ31eEWR4fRopC@casper.infradead.org>
References: <20220608150451.1432388-1-hch@lst.de>
 <20220608150451.1432388-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608150451.1432388-2-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 08, 2022 at 05:04:47PM +0200, Christoph Hellwig wrote:
> @@ -551,7 +548,8 @@ static int parse_options(char *options, struct super_block *sb,
>  			clear_opt (opts->s_mount_opt, OLDALLOC);
>  			break;
>  		case Opt_nobh:
> -			set_opt (opts->s_mount_opt, NOBH);
> +			ext2_msg(sb, KERN_INFO,
> +				"nobh option not supported");
>  			break;

This is the only part I wonder about.  Should we just silently accept
the nobh option instead of emitting a message?

Also, is it time to start emitting a message for nfs' intr option?  ;-)

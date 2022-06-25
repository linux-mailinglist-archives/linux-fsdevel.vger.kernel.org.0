Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2874255AA54
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jun 2022 15:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbiFYNKE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jun 2022 09:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiFYNKE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jun 2022 09:10:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF18A5F55;
        Sat, 25 Jun 2022 06:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nw24XXZnXVM2CczTxTtCDu7i5NW03WPL24qA7zFmQOU=; b=pxoYScQgHTX20njZz8ukZ/3Ddk
        GQeWwV4erOpLikcwHRhbrIUeCBoSxNdLconnWiktYP8EMVPEt9s3j43yyv/9mqNhcGq/sdaAKwAgx
        XT+croLLlujfhIGBQdlZV0TKDnpiLbqVtmWVHwmfRFlwnc8/NDKXfGJrvdJukmrjvPEST0LrSRGG8
        U7wrhj3+B+KHEQM/p2a9xLa4OI6zQkLd1fbhXo7TNigKBwP6x1klZmexGbm1rL2T6w8+Oqso3TBjl
        +m7bu0bo9CNUsrXl6z76d8j3pg7XTRHsCeUM5dgdkB46HOszbKRF1RfKFkunly/bV1lfIkuL7eWOx
        XFTHDn4A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o55Y2-0067pL-9w; Sat, 25 Jun 2022 13:10:02 +0000
Date:   Sat, 25 Jun 2022 06:10:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] fs: remove no_llseek
Message-ID: <YrcJKtZQLDvRgX7P@infradead.org>
References: <20220625110115.39956-1-Jason@zx2c4.com>
 <20220625110115.39956-7-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625110115.39956-7-Jason@zx2c4.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 25, 2022 at 01:01:13PM +0200, Jason A. Donenfeld wrote:
> Now that all callers of ->llseek are going through vfs_llseek(), we
> don't gain anything by keeping no_llseek around. Nothing compares it or
> calls it.

Shouldn't this and the checks for no_llseek simply be merged into patch
2?

> +	if ((file->f_mode & FMODE_LSEEK) && file->f_op->llseek)
> +		return file->f_op->llseek(file, offset, whence);
> +	return -ESPIPE;

No function change, but in general checking for the error condition
in the branch tends to be more readable.  i.e.:

	if (!(file->f_mode & FMODE_LSEEK) || !file->f_op->llseek)
		return -ESPIPE;
	return file->f_op->llseek(file, offset, whence);


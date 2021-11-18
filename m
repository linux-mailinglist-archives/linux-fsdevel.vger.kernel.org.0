Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB0845652E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 22:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhKRVxf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 16:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhKRVxf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 16:53:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853C1C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Nov 2021 13:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5E6VrBAOxY8ibGmRjyazDEOuapJg56uN8Ce+mRDgxcU=; b=gnnW0nlscnOf0fyYPWjN2OCyul
        CGxiqRQNBmXFdjkv0Rj3ulzOeV/4+GTgA6Zr7xhe8H1VBJmDCcoduxXIXHG4x5DS95cTk2reAKRNN
        ILpjkFpwcqIHR2HL7WN3EK0jurO6weYSJSaX4mce9joy1eq7lMMoI+zA+jlxkoeuHzkNwD/1nAHp6
        UYrrqoRjPu06tUtrb8UGbh5QY5fBPrDVW0iXuPXjmVZEExcXb3P5/Kh92JriusyXtymwgB4351VR4
        1P3ZoDUbh1JAhuR73g+s8dVv5TKYTxis4uMlL6DFavTI9HvvTabG6FdoAssDnjsM+rZU254a4kMuW
        AcxrnN2A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnpIX-008qCV-QN; Thu, 18 Nov 2021 21:50:25 +0000
Date:   Thu, 18 Nov 2021 21:50:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christophe Vu-Brugier <cvubrugier@fastmail.fm>
Cc:     linux-fsdevel@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Christophe Vu-Brugier <christophe.vu-brugier@seagate.com>
Subject: Re: [PATCH 1/1] exfat: fix i_blocks for files truncated over 4 GiB
Message-ID: <YZbKobiUUt6eG6zQ@casper.infradead.org>
References: <20211118212828.4360-1-cvubrugier@fastmail.fm>
 <20211118212828.4360-2-cvubrugier@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118212828.4360-2-cvubrugier@fastmail.fm>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 18, 2021 at 10:28:28PM +0100, Christophe Vu-Brugier wrote:
>  	inode->i_blocks = ((i_size_read(inode) + (sbi->cluster_size - 1)) &
> -			~(sbi->cluster_size - 1)) >> inode->i_blkbits;
> +		~((loff_t)sbi->cluster_size - 1)) >> inode->i_blkbits;

Isn't this a convoluted way to write:

	inode->i_blocks = round_up(i_size_read(inode), sbi->cluster_size) >>
				inode->i_blkbits;
?


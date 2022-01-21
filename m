Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A8E495A57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 08:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378850AbiAUHKB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 02:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348858AbiAUHKB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:10:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529BDC061574;
        Thu, 20 Jan 2022 23:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/iWwKF5zBo+/YqnIlxI/fBLzy6wUHNMRmfKOAf2uK/0=; b=euNtdBdzwfCYHwQlnISZwlowHv
        Ghmi9l9Zl16SCmCwWK7jluHzRlhl52g/7nnfe1ORbcbWz9eDsTLODftQAP0tQHhTQXNKExIDhJWQR
        4fKqsCljldRSV8PZQHlegwZhFHZ9EtUloBylY5RK3eI/qjkyxiZFaZj6fQ4MiR0+zNZXQsGMAycnU
        2oWxcxPC/e7RJEfKpGZ3J1zNhH/rSYHEEISC9QO9qMPLt3qitFPkckTdxf3yffrudX0s+EP6cLkkY
        1UsupL+zm3akz9Ziutyd2iS7/vdibOYkDaUDgTd30H6/mok/dXO+eYc+FQsShPk5ewqwwszZTJ470
        kA5hUg5w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAo3c-00E1cx-0w; Fri, 21 Jan 2022 07:10:00 +0000
Date:   Thu, 20 Jan 2022 23:10:00 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v10 1/5] fscrypt: add functions for direct I/O support
Message-ID: <YepcSJGy2IbBrMZB@infradead.org>
References: <20220120071215.123274-1-ebiggers@kernel.org>
 <20220120071215.123274-2-ebiggers@kernel.org>
 <YekdAa4fCKw7VY3J@infradead.org>
 <Yeklkcc7NXKYDHUL@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yeklkcc7NXKYDHUL@sol.localdomain>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 20, 2022 at 01:04:17AM -0800, Eric Biggers wrote:
> I actually had changed this from v9 because fscrypt_dio_supported() seemed
> backwards, given that its purpose is to check whether DIO is unsupported, not
> whether it's supported per se (and the function's comment reflected this).  What
> ext4 and f2fs do is check a list of reasons why DIO would *not* be supported,
> and if none apply, then it is supported.  This is just one of those reasons.
> 
> This is subjective though, so if people prefer the old way, I'll change it back.

I find non-negated API much better and would also help with undinwinding
the ext4/f2fs mess.  But I'm not going to block the series on such a
minor detail, of course.

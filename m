Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE146494967
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 09:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359193AbiATI1r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 03:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbiATI1r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:27:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECC0C061574;
        Thu, 20 Jan 2022 00:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NvoGguWE8KfBM4538M3l0btmQ9N+hOwabmMgVLC+gno=; b=vdL9/LCIsKA/ZuPkjYTLiufeyy
        zkM0HgffALaitBeO6Q7A1SRP9lTgJJSzQBGPKnRo+MyDuoRqf6BUmaesQaGvMMJ0cUvp8sbX1yXKf
        DXl+8z3bRs/4eZIyI2/XlUmYAYH/0l31eTNUlpxoUrYc1QFdwUNDchBSQ39rBGb3TRQUJudHq/t1d
        Afz8DHBzwEVQh/0HzT+NB9VpbRvVc0S6nnnwnAv+IKuCoH6AVRWNIRJNZJ8X8wBP9BDjqCOiggDGM
        UcRgAyrvA7i2VrJ/6zOPchbVoi22WiVX+zueyPxLhPr3qOeEtqo7o/tFztKAAeqcRprYEPSppKH55
        S7BOaMww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nASnJ-009kk9-OV; Thu, 20 Jan 2022 08:27:45 +0000
Date:   Thu, 20 Jan 2022 00:27:45 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v10 1/5] fscrypt: add functions for direct I/O support
Message-ID: <YekdAa4fCKw7VY3J@infradead.org>
References: <20220120071215.123274-1-ebiggers@kernel.org>
 <20220120071215.123274-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120071215.123274-2-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +/**
> + * fscrypt_dio_unsupported() - check whether a DIO (direct I/O) request is
> + *			       unsupported due to encryption constraints
> + * @iocb: the file and position the I/O is targeting
> + * @iter: the I/O data segment(s)
> + *
> + * Return: true if DIO is unsupported
> + */
> +bool fscrypt_dio_unsupported(struct kiocb *iocb, struct iov_iter *iter)

I always find non-negated functions easier to follow, i.e. turn this
into fscrypt_dio_supported().

> +	/*
> +	 * Since the granularity of encryption is filesystem blocks, the file
> +	 * position and total I/O length must be aligned to the filesystem block
> +	 * size -- not just to the block device's logical block size as is
> +	 * traditionally the case for DIO on many filesystems (not including
> +	 * f2fs, which only allows filesystem block aligned DIO anyway).

I would not really mention a specific file system here.

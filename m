Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12797494A4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 10:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358549AbiATJEX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 04:04:23 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39968 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbiATJEW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:04:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07CAEB81D09;
        Thu, 20 Jan 2022 09:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740ACC340E0;
        Thu, 20 Jan 2022 09:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642669459;
        bh=pfcthZCzooY2kl7Qa+cy/1Et4X5WXDRQLsSpT+07JNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C4VrIZYfGPgn0lzFMGsDmv/5TJ65MtkSeLkZ/xugErRO7yEmM4T4FUpDKKp9LkDZy
         m8nHN+Zv9vYV74Fn9nFjB+k1iKKVZrT8SYKWQ9NloeIENKz9SjLn9ekr6svNGmlu9X
         9E/T5KZS/LphCPHQp879QSPVdpzM0XMkIV6e4DlDR+4VH2Q7Ri1v5lOHFotzeQeQEE
         nkI8FaSX9rs8WMHkIUd28GD0IzwAkP1FX+iX0Ha+d2y0f0pdnoTGc7N0JTJzMEBqcJ
         5y5fmKtLWxbDHNdHEGMtZRGwwHCJQOIca4mT4LQ3CanX8yoM1G7an7HiaMPVVWYm9E
         BXhiBw6TTdh+A==
Date:   Thu, 20 Jan 2022 01:04:17 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v10 1/5] fscrypt: add functions for direct I/O support
Message-ID: <Yeklkcc7NXKYDHUL@sol.localdomain>
References: <20220120071215.123274-1-ebiggers@kernel.org>
 <20220120071215.123274-2-ebiggers@kernel.org>
 <YekdAa4fCKw7VY3J@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YekdAa4fCKw7VY3J@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 20, 2022 at 12:27:45AM -0800, Christoph Hellwig wrote:
> > +/**
> > + * fscrypt_dio_unsupported() - check whether a DIO (direct I/O) request is
> > + *			       unsupported due to encryption constraints
> > + * @iocb: the file and position the I/O is targeting
> > + * @iter: the I/O data segment(s)
> > + *
> > + * Return: true if DIO is unsupported
> > + */
> > +bool fscrypt_dio_unsupported(struct kiocb *iocb, struct iov_iter *iter)
> 
> I always find non-negated functions easier to follow, i.e. turn this
> into fscrypt_dio_supported().
> 

I actually had changed this from v9 because fscrypt_dio_supported() seemed
backwards, given that its purpose is to check whether DIO is unsupported, not
whether it's supported per se (and the function's comment reflected this).  What
ext4 and f2fs do is check a list of reasons why DIO would *not* be supported,
and if none apply, then it is supported.  This is just one of those reasons.

This is subjective though, so if people prefer the old way, I'll change it back.

- Eric

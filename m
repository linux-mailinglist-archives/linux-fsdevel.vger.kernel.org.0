Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710962C8E4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 20:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbgK3TnL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 14:43:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:50332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727942AbgK3TnL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 14:43:11 -0500
Received: from gmail.com (unknown [104.132.1.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83C7820709;
        Mon, 30 Nov 2020 19:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606765350;
        bh=0NMZI3KwqVrJhjvhdKXBVCYUQQFFXi3QbS59sB9SJz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JOzo5GT8CfJGGdJ9E94TIKlDdqVO0mqkysWP9am6QBz3tLla3cKlSUCOyZ44yEonf
         xNjNX8jyj5Her2thZe8lARYwbex8IW+dPe6nd5wU65l2OAj2NP8KGb97XNG2OA9KwK
         5cB9H/imoEEn5Z7Rx91da40EON5gzH4ub9Jjl+fs=
Date:   Mon, 30 Nov 2020 11:42:28 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-fscrypt@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Sebastien Buisson <sbuisson@ddn.com>
Subject: Re: backup/restore of fscrypt files
Message-ID: <20201130194228.GA1248532@gmail.com>
References: <D1AD7D55-94D6-4C19-96B4-BAD0FD33CF49@dilger.ca>
 <X8U8TG2ie77YiCF5@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8U8TG2ie77YiCF5@sol.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 30, 2020 at 10:39:10AM -0800, Eric Biggers wrote:
> (Allowing only direct I/O on files that don't have encryption key unavailable
> may help...)

It may sense to only provide the ciphertext when reads are done using
RWF_ENCODED
(https://lkml.kernel.org/linux-fsdevel/cover.1605723568.git.osandov@fb.com),
rather than making normal reads return ciphertext when the key is unavailable.

Ciphertext reads would always be uncached, which would avoid two conflicting
uses of the same address_space.

- Eric

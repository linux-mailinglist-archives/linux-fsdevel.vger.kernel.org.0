Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38C721AA14
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 23:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgGIV70 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 17:59:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgGIV7Z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 17:59:25 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1C8120672;
        Thu,  9 Jul 2020 21:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594331965;
        bh=PcF5ZLXsR+T1pZugOPirxGijT4fToIElCeEXDGjGu5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oby6MxtV20D13kOVSTaJgUYG5nAAo8sH23d7/SoK4aWHc7Ptd5247NMgYqJyG6nrH
         XhStnvd4gWMxCHoszwNn+BzsvvVto+8XUWVlYPw9Oku9bfgcfXmdp9HnZIWwWHGC96
         +u803Hssn6Q/Pn1ZsRhLkOHPWPzbQiigBf37ZXFg=
Date:   Thu, 9 Jul 2020 14:59:23 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/5] iomap: support direct I/O with fscrypt using
 blk-crypto
Message-ID: <20200709215923.GD3855682@gmail.com>
References: <20200709194751.2579207-1-satyat@google.com>
 <20200709194751.2579207-4-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709194751.2579207-4-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 09, 2020 at 07:47:49PM +0000, Satya Tangirala wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Wire up iomap direct I/O with the fscrypt additions for direct I/O,
> and set bio crypt contexts on bios when appropriate.

It might be useful to mention why the calls to fscrypt_limit_dio_pages() are
needed.  (It's because the iomap code works directly with logical ranges, so it
doesn't have a chance to do fscrypt_mergeable_bio() on every page.)

> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  fs/iomap/direct-io.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

You probably should add linux-xfs@vger.kernel.org to Cc, as per
'./scripts/get_maintainer.pl fs/iomap/'.

- Eric

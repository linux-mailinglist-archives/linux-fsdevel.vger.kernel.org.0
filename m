Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BADA9306AF6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 03:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhA1CRs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 21:17:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:43492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229528AbhA1CRr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 21:17:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 286BC64D9F;
        Thu, 28 Jan 2021 02:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611800226;
        bh=kkx2gxqL3eTEODYMMPfss/+rMKGv9VbYrVIUTu2Ff4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cssw+EuDfiMMpcWBMW8S00pxx9lnqxS1W91b97rL7PG0rmKgJPZ5xqF6wb/gtp2yZ
         GopReLJwPmf4Gnw6cSI59/I4BiHzQzOtVuXYJW2jboMdRI1BcosIqfsopkBhi9bKL2
         Kp5zj2rgof2d620b1orH0QxaQ6iJO91DSkqZDfrc/AX68wLvUyw7HWTU9wD2W4evcT
         hmxedXHJF7yQ1O8g0ngBrivco2m6rGJhN9FY8RIgb1HApK5YmtXYmN/LYxH/9nXek5
         hl2Z5vb+kxKcIdlaG9skNoOL7ACiBqHgK73pw7VZdlMxaaEz0dPjAz04TY5gHE88+v
         7Gm4drqXaqNyA==
Date:   Wed, 27 Jan 2021 18:17:04 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-api@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Victor Hsieh <victorhsieh@google.com>
Subject: Re: [PATCH 4/6] fs-verity: support reading Merkle tree with ioctl
Message-ID: <YBIeoGowXVrG3QfU@sol.localdomain>
References: <20210115181819.34732-1-ebiggers@kernel.org>
 <20210115181819.34732-5-ebiggers@kernel.org>
 <YBIPD53iVg1US++r@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBIPD53iVg1US++r@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 27, 2021 at 05:10:39PM -0800, Jaegeuk Kim wrote:
> 
> Minor thought:
> How about invalidating or truncating merkel tree pages?
> 
> Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 

Removing them from the page cache after the read, you mean?  I'm not sure we can
assume that users of this ioctl would want the pages to *not* be cached, any
more than we could assume that for any regular read().  I think we should just
leave the pages cached (like a regular read) and not do anything special.  Like
other pagecache pages, the kernel will evict the Merkle tree pages eventually if
they aren't being accessed anymore and memory needs to be reclaimed.

- Eric

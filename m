Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD94214783C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 06:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbgAXFm7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 00:42:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:45980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730222AbgAXFm7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 00:42:59 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CEDE2070A;
        Fri, 24 Jan 2020 05:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579844578;
        bh=UtXlQmAwVpIV4UVkULwSxcBxj3f1rwjkrvqd+IMtrm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gHZoFfUfHkbxCFtJeTBNinZ/zDprtq6eg9/MVNYgeL82NiDWUtWTiqMDe4DOtiM70
         xdTFSRWqRr9C87t/SulBsXb/TeI1wl6PGQYgFnLLS8shbSH78TyKf1/Z5uZqqWjwVT
         uWVf1KoxKRFRDgOcVd4Yu4ZLUxDsSDoMNw9deF+8=
Date:   Thu, 23 Jan 2020 21:42:56 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Daniel Rosenberg <drosen@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH] ext4: fix race conditions in ->d_compare() and ->d_hash()
Message-ID: <20200124054256.GC832@sol.localdomain>
References: <20200124041234.159740-1-ebiggers@kernel.org>
 <20200124050423.GA31271@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20200124051601.GB832@sol.localdomain>
 <20200124053415.GC31271@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124053415.GC31271@hsiangkao-HP-ZHAN-66-Pro-G1>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 24, 2020 at 01:34:23PM +0800, Gao Xiang wrote:
> On Thu, Jan 23, 2020 at 09:16:01PM -0800, Eric Biggers wrote:
> 
> []
> 
> > So we need READ_ONCE() to ensure that a consistent value is used.
> 
> By the way, my understanding is all pointer could be accessed
> atomicly guaranteed by compiler. In my opinion, we generally
> use READ_ONCE() on pointers for other uses (such as, avoid
> accessing a variable twice due to compiler optimization and
> it will break some logic potentially or need some data
> dependency barrier...)
> 
> Thanks,
> Gao Xiang

But that *is* why we need READ_ONCE() here.  Without it, there's no guarantee
that the compiler doesn't load the variable twice.  Please read:
https://github.com/google/ktsan/wiki/READ_ONCE-and-WRITE_ONCE

- Eric

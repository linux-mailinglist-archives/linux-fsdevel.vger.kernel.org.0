Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E9B26BB30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 05:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgIPD7Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 23:59:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgIPD7X (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 23:59:23 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C30C21582;
        Wed, 16 Sep 2020 03:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600228762;
        bh=i2+Evef8SvghzHDY7MEFH48JypIz3p7ieh+i/8dH9/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1o8yUPaQHrhrGkEmXFhjbtCQjFWa+0UQvzX7d3jyXJgYQhwsgDB3WXt1LWc6+XTep
         r2AY2txSkL8VlObyY1qlg0iNmVm1DBPCsn4YBh8BHx3iHpbXJsBuzNxWOZ7qLCCH7T
         fjn7QRQ5ZdzwojHVNPuPcl4NLGCiZZcneeEh5H4U=
Date:   Tue, 15 Sep 2020 20:59:14 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: don't unnecessarily clone write access for
 writable fds
Message-ID: <20200916035914.GA825@sol.localdomain>
References: <20200611160534.55042-1-ebiggers@kernel.org>
 <20200629165014.GA20492@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629165014.GA20492@sol.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 29, 2020 at 09:50:14AM -0700, Eric Biggers wrote:
> On Thu, Jun 11, 2020 at 09:05:34AM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > There's no need for mnt_want_write_file() to increment mnt_writers when
> > the file is already open for writing, provided that
> > mnt_drop_write_file() is changed to conditionally decrement it.
> > 
> > We seem to have ended up in the current situation because
> > mnt_want_write_file() used to be paired with mnt_drop_write(), due to
> > mnt_drop_write_file() not having been added yet.  So originally
> > mnt_want_write_file() had to always increment mnt_writers.
> > 
> > But later mnt_drop_write_file() was added, and all callers of
> > mnt_want_write_file() were paired with it.  This makes the compatibility
> > between mnt_want_write_file() and mnt_drop_write() no longer necessary.
> > 
> > Therefore, make __mnt_want_write_file() and __mnt_drop_write_file() skip
> > incrementing mnt_writers on files already open for writing.  This
> > removes the only caller of mnt_clone_write(), so remove that too.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Al, any thoughts on this patch?
> 

Ping?

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F9020DF86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 23:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389508AbgF2Uhb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 16:37:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732095AbgF2TUP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:20:15 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6738C25511;
        Mon, 29 Jun 2020 16:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593449416;
        bh=fixPM011IXmV72KayBjsTcKueDK/xQBWs4YyvLISZOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VS/WIVM4nxT0BS2eahmSB3tmX3H1+D4UhP993lN9x/5qDz6hB/TqPP6O4zB2S0Vvy
         tIpwpM5pdGqgybGvXIqCjExLWwzzKA5FAzAZQlt0Q0TOq4uUB+q7kSkfwPPbmnJVAZ
         NIW29k8ysfe/gv8mW85SS2idLgTXLzNN8+r1Bzxg=
Date:   Mon, 29 Jun 2020 09:50:14 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: don't unnecessarily clone write access for
 writable fds
Message-ID: <20200629165014.GA20492@sol.localdomain>
References: <20200611160534.55042-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611160534.55042-1-ebiggers@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 11, 2020 at 09:05:34AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> There's no need for mnt_want_write_file() to increment mnt_writers when
> the file is already open for writing, provided that
> mnt_drop_write_file() is changed to conditionally decrement it.
> 
> We seem to have ended up in the current situation because
> mnt_want_write_file() used to be paired with mnt_drop_write(), due to
> mnt_drop_write_file() not having been added yet.  So originally
> mnt_want_write_file() had to always increment mnt_writers.
> 
> But later mnt_drop_write_file() was added, and all callers of
> mnt_want_write_file() were paired with it.  This makes the compatibility
> between mnt_want_write_file() and mnt_drop_write() no longer necessary.
> 
> Therefore, make __mnt_want_write_file() and __mnt_drop_write_file() skip
> incrementing mnt_writers on files already open for writing.  This
> removes the only caller of mnt_clone_write(), so remove that too.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Al, any thoughts on this patch?

- Eric

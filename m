Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C542CB09B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 00:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgLAXAt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 18:00:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:45700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgLAXAs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 18:00:48 -0500
Date:   Tue, 1 Dec 2020 15:00:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606863608;
        bh=UfPQWdK3xBzO1ApIT0Gn7pd2KneFS4j8rVtIyl7vrbg=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=MfiWeMWuaKPYMaaNv9SarNLRpZv08vfHzR572Es3sRYwsmPjO71SF5djmfQppon1c
         D6snuuoylEaT+4eMUrBNlzy1IIRX679LmvlxeGbnhmZknXKzg8u4+teHK7CsizAs+6
         ge14TfRlVCJUZjbOHdANYPfd3CGZTIgupPhJoVtU=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] f2fs: remove f2fs_dir_open()
Message-ID: <X8bK9l/9N03++CYM@sol.localdomain>
References: <20201125002336.274045-1-ebiggers@kernel.org>
 <20201125002336.274045-3-ebiggers@kernel.org>
 <9522461b-b854-76ac-29c7-160f0f078823@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9522461b-b854-76ac-29c7-160f0f078823@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 26, 2020 at 03:04:55PM +0800, Chao Yu wrote:
> On 2020/11/25 8:23, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Since encrypted directories can be opened without their encryption key
> > being available, and each readdir tries to set up the key, trying to set
> 
> readdir -> readdir/lookup?

Yes, ->lookup() tries to set up the key too.  It's different because ->lookup()
doesn't require that the directory be open.  But I suppose that's another reason
why setting up the directory's key in ->open() isn't useful.

I'll add something about that.

- Eric

> 
> > up the key in ->open() too isn't really useful.
> > 
> > Just remove it so that directories don't need an ->open() method
> > anymore, and so that we eliminate a use of fscrypt_get_encryption_info()
> > (which I'd like to stop exporting to filesystems).
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,

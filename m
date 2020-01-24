Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4976414779D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 05:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbgAXE34 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 23:29:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:50666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729316AbgAXE3z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 23:29:55 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC6392072C;
        Fri, 24 Jan 2020 04:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579840195;
        bh=w7bUGOmBcf8WYfmLHNz1iZda5pKwrIDULz8xqJEmZmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RJRx1UroRpNjDxxEZ8+qL1gktnq773hIx31h2M0OdBjHhtDUVdOlVsijub/9qOrJC
         l16OFpelVLUsiwddVu0rQyNDShAvyriuZEyJnfg6kkHmDYhN8CJDcx/BAP2oLrP6OW
         tgAwolhEK7ImbCOQj5cJpnHZjDPPM3BpUgQxIjes=
Date:   Thu, 23 Jan 2020 20:29:53 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: oopsably broken case-insensitive support in ext4 and f2fs (Re:
 vfat: Broken case-insensitive support for UTF-8)
Message-ID: <20200124042953.GA832@sol.localdomain>
References: <20200119221455.bac7dc55g56q2l4r@pali>
 <87sgkan57p.fsf@mail.parknet.co.jp>
 <20200120073040.GZ8904@ZenIV.linux.org.uk>
 <20200120074558.GA8904@ZenIV.linux.org.uk>
 <20200120080721.GB8904@ZenIV.linux.org.uk>
 <20200120193558.GD8904@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120193558.GD8904@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 20, 2020 at 07:35:58PM +0000, Al Viro wrote:
> On Mon, Jan 20, 2020 at 08:07:21AM +0000, Al Viro wrote:
> 
> > > > I hadn't checked ->d_compare() instances for a while; somebody needs to
> > > > do that again, by the look of it.  The above definitely is broken;
> > > > no idea how many other instaces had grown such bugs...
> > > 
> > > f2fs one also has the same bug.  Anyway, I'm going down right now, will
> > > check the rest tomorrow morning...
> > 
> > We _probably_ can get away with just checking that inode for NULL and
> > buggering off if it is (->d_seq mismatch is guaranteed in that case),
> > but I suspect that we might need READ_ONCE() on both dereferences.
> > I hate memory barriers...
> 
> FWIW, other instances seem to be OK; HFS+ one might or might not be
> OK in the face of concurrent rename (wrong result in that case is
> no problem; oops would be), but it doesn't play silly buggers with
> pointer-chasing.
> 
> ext4 and f2fs do, and ->d_compare() is broken in both of them.

Thanks Al.  I sent out fixes for this:

ext4: https://lore.kernel.org/r/20200124041234.159740-1-ebiggers@kernel.org
f2fs: https://lore.kernel.org/r/20200124041549.159983-1-ebiggers@kernel.org

Note that ->d_hash() was broken too.  In fact, that was much easier to
reproduce.

- Eric

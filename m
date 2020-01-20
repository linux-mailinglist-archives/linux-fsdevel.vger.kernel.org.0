Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4541143277
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 20:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgATTgD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 14:36:03 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:54342 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgATTgD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 14:36:03 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itcq6-00CD2L-9O; Mon, 20 Jan 2020 19:35:58 +0000
Date:   Mon, 20 Jan 2020 19:35:58 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: oopsably broken case-insensitive support in ext4 and f2fs (Re:
 vfat: Broken case-insensitive support for UTF-8)
Message-ID: <20200120193558.GD8904@ZenIV.linux.org.uk>
References: <20200119221455.bac7dc55g56q2l4r@pali>
 <87sgkan57p.fsf@mail.parknet.co.jp>
 <20200120073040.GZ8904@ZenIV.linux.org.uk>
 <20200120074558.GA8904@ZenIV.linux.org.uk>
 <20200120080721.GB8904@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120080721.GB8904@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 20, 2020 at 08:07:21AM +0000, Al Viro wrote:

> > > I hadn't checked ->d_compare() instances for a while; somebody needs to
> > > do that again, by the look of it.  The above definitely is broken;
> > > no idea how many other instaces had grown such bugs...
> > 
> > f2fs one also has the same bug.  Anyway, I'm going down right now, will
> > check the rest tomorrow morning...
> 
> We _probably_ can get away with just checking that inode for NULL and
> buggering off if it is (->d_seq mismatch is guaranteed in that case),
> but I suspect that we might need READ_ONCE() on both dereferences.
> I hate memory barriers...

FWIW, other instances seem to be OK; HFS+ one might or might not be
OK in the face of concurrent rename (wrong result in that case is
no problem; oops would be), but it doesn't play silly buggers with
pointer-chasing.

ext4 and f2fs do, and ->d_compare() is broken in both of them.

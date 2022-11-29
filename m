Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA86E63C0D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 14:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiK2NRi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 08:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiK2NRN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 08:17:13 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA6D61740;
        Tue, 29 Nov 2022 05:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ovEN2R1RcoyCmUvaJNV3bgGf54R1/0A9UQvs6JwGjy0=; b=VCDjRvvIL7hZ+3BDLMLNcVcDOc
        Q/TG09qk+hX2Yc7iYpjtjKWpMAg6QuT66/lUBVoOgG1SJddV/G3hF7s1W3QcWtNWasGbt2RHhhpoB
        2dyBRVPwMKFCZomSisy7eREG1MqGSg9E5wAaNvorozi/v7wJuurqY5oAp+kcCiZvLzKgXyODWVMOE
        Paf9Dp++B5UFZoPw2Lj5us3iPTL7KTVYS6Nf1ORGgDX2ZHkGnIehszlSxGGBNSGJ7DcrEBcC+K3IO
        DnL/vPlipbptC4Ti4ZCqKulpGHMOshczri78Z0Ozt/hpiLeITr8taocWAF8cNJDgO6DmR45cLA1LJ
        0LJ14MBg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1p00TM-007fjC-25;
        Tue, 29 Nov 2022 13:16:28 +0000
Date:   Tue, 29 Nov 2022 13:16:28 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+8c7a4ca1cc31b7ce7070@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, dan.j.williams@intel.com, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Subject: Re: [syzbot] WARNING in iov_iter_revert (3)
Message-ID: <Y4YGLBZoXKj6broy@ZenIV>
References: <000000000000519d0205ee4ba094@google.com>
 <000000000000f5ecad05ee8fccf0@google.com>
 <20221129090831.6281-1-hdanton@sina.com>
 <Y4X5F43D+As21b6M@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4X5F43D+As21b6M@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 29, 2022 at 12:20:39PM +0000, Al Viro wrote:
> ->direct_IO() should return the amount of data actually copied to userland;
> if that's how much it has consumed from iterator - great, iov_iter_revert(i, 0)
> is a no-op.  If it has consumed more, the caller will take care of that.
> If it has consumed say 4Kb of data from iterator, but claims that it has
> managed to store 12Kb into that, it's broken and should be fixed.
> 
> If it wants to do revert on its own, for whatever reason, it is welcome - nothing
> will break, as long as you do *not* return the value greater than the amount you
> ended up taking from iterator.  However, I don't understand the reason why ntfs3
> wants to bother (and appears to get it wrong, at that); the current rules are
> such that caller will take care of revert.

Looking at ntfs3, WTF does it bother with zeroing on short reads (?) in the
first place?  Anyway, immediate bug there is the assumption that
blockdev_direct_IO() won't consume more than its return value; it bloody
well might.

*IF* you want that logics on reads (again, I'm not at all sure what is it
doing there), you want this:

        } else if (vbo < valid && valid < end) {
		size_t consumed = iter_count - iov_iter_count(iter);
		size_t valid_bytes = valid - vbo;
		iov_iter_revert(iter, consumed - valid_bytes);
		iov_iter_zero(ret - valid_bytes, iter);
	}

This iov_iter_zero() would better not be an attempt to overwrite some
data that shouldn't have been copied to userland; if that's what it
is, it's an infoleak - another thread might have observed the data
copied there before that zeroing.

Oh, and
                if (end > valid && !S_ISBLK(inode->i_mode)) {

several lines above is obvious bollocks - if inode is a block device,
we won't be going anywhere near any NTFS address_space_operations or
ntfs_direct_IO().

Seriously, what's going on with zeroing there?

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F4F2042B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 23:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbgFVVbV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 17:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgFVVbU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 17:31:20 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD7FC061573;
        Mon, 22 Jun 2020 14:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0St7asvNPVxLaBHB1RK9zv6Jvm/lZadMYRZUBSljz24=; b=oj4Bk9vTZeNSRyVdFKG3t5CXZP
        V4bs3uTSLWMlz5u7j2QApDQpjPAuUr3i1no67+CVMyRIKgQdrPPiTgIhzZsNZbCEBI5NrTeH8mdZ3
        YfEyve8Kelj2u3mzgq3ooUpu8vRgrIVq3BICF8LldaSbRrg3jRXZdpHNH/pkGE4HnjxGm2fJKcbcB
        WhfYdb3BHqPC0wuFFdOFL9KdA/8E1fhW3LlWVPoy1z4FZDIXUa5RxDJm6uBzmB3zDR0KF8MJC6mDE
        /FuIGRRtf2xu3sCm4AmtXYgYEMh9xZFpcfBryWxWcGTj5DuwuMY8r8jP3kPAZlK6TySBQzTOnfk50
        feIoI8Og==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jnU1u-0000ld-Im; Mon, 22 Jun 2020 21:31:02 +0000
Date:   Mon, 22 Jun 2020 22:31:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Egor Chelak <egor.chelak@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs: fix High Sierra dirent flag accesses
Message-ID: <20200622213102.GD21350@casper.infradead.org>
References: <20200621040817.3388-1-egor.chelak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200621040817.3388-1-egor.chelak@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 21, 2020 at 07:08:17AM +0300, Egor Chelak wrote:
> The flags byte of the dirent was accessed as de->flags[0] in a couple of
> places, and not as de->flags[-sbi->s_high_sierra], which is how it's
> accessed elsewhere. This caused a bug, where some files on an HSF disc
> could be inaccessible.
> 
> For context, here is the difference between HSF dirents and ISO dirents:
> Offset  | High Sierra | ISO-9660       | struct iso_directory_record
> Byte 24 | Flags       | mtime timezone | de->date[6] (de->flags[-1])
> Byte 25 | Reserved    | Flags          | de->flags[0]

Also, ew.  Why on earth do we do 'de->flags[-sbi->s_high_sierra]'?
I'm surprised we don't have any tools that warn about references outside
an array.  I would do this as ...

static inline u8 de_flags(struct isofs_sb_info *sbi,
		struct iso_directory_record *de)
{
	if (sbi->s_high_sierra)
		return de->date[6];
	return de->flags;
}

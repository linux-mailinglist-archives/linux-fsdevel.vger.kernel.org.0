Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED923EB63E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 15:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240433AbhHMNsw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 09:48:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44396 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239392AbhHMNsu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 09:48:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D61AE1FFC4;
        Fri, 13 Aug 2021 13:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628862502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iKfxhwub3oLTOa/l2On4u32rCTa2b379k/9DNB6qAU0=;
        b=Z8uS515S7zGDIuGZKjdGQnOGi1B1NMkvn5EMA+l5RfMfD16SG+wM9Mm19p+1gipU7UNAHX
        0E1CJ40H6H/zsQSY2HDwFUHjF2rqaZ5HB9V3rjis6qJb/e0Pz6SehsbBqLGTKBNap1mO4r
        qDyFX3gpOxFN0s2mLPgjWuzgZ7EINj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628862502;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iKfxhwub3oLTOa/l2On4u32rCTa2b379k/9DNB6qAU0=;
        b=zyI2xYTl44lkAN35E0504dtH/sg3z277p6lXJScR58eQIKfhnvpgRsIr1Y6nFxZ5yCYNkB
        DAkXUUrU1WgUfMAg==
Received: from quack2.suse.cz (jack.udp.ovpn1.prg.suse.de [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 6A489A3B87;
        Fri, 13 Aug 2021 13:48:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4587E1E423D; Fri, 13 Aug 2021 15:48:22 +0200 (CEST)
Date:   Fri, 13 Aug 2021 15:48:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Pavel Machek <pavel@ucw.cz>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 03/20] udf: Fix iocharset=utf8 mount option
Message-ID: <20210813134822.GF11955@quack2.suse.cz>
References: <20210808162453.1653-1-pali@kernel.org>
 <20210808162453.1653-4-pali@kernel.org>
 <20210812141736.GE14675@quack2.suse.cz>
 <20210812155134.g67ncugjvruos3cy@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210812155134.g67ncugjvruos3cy@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 12-08-21 17:51:34, Pali Rohár wrote:
> On Thursday 12 August 2021 16:17:36 Jan Kara wrote:
> > On Sun 08-08-21 18:24:36, Pali Rohár wrote:
> > > Currently iocharset=utf8 mount option is broken. To use UTF-8 as iocharset,
> > > it is required to use utf8 mount option.
> > > 
> > > Fix iocharset=utf8 mount option to use be equivalent to the utf8 mount
> > > option.
> > > 
> > > If UTF-8 as iocharset is used then s_nls_map is set to NULL. So simplify
> > > code around, remove UDF_FLAG_NLS_MAP and UDF_FLAG_UTF8 flags as to
> > > distinguish between UTF-8 and non-UTF-8 it is needed just to check if
> > > s_nls_map set to NULL or not.
> > > 
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > 
> > Thanks for the cleanup. It looks good. Feel free to add:
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > 
> > Or should I take this patch through my tree?
> 
> Hello! Patches are just RFC, mostly untested and not ready for merging.
> I will wait for feedback and then I do more testing nad prepare new
> patch series.

OK, FWIW I've also tested the UDF and isofs patches.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

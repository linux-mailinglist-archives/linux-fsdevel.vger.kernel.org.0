Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CABD3F1540
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 10:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbhHSIfL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 04:35:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231494AbhHSIfK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:35:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 896D1610FA;
        Thu, 19 Aug 2021 08:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629362074;
        bh=Bd2L1bF1i5ySeLJ979rjOA+eVsO+A3AVVXhjsHT7yGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XbZFir7iCQmB49KMFmSrAaS5/1hj+ReN+h9w4sj8ze/4hYuraavS71ss+lp4A80iU
         At1TEW+wYevB3cmLh/neU1KFlyLVpt2aS8RHAUOVbgb1BUCE3ua2zhTB2eT7KrRyNf
         AoA8gCV8ywtLsOyJE/dXp+8CoMIjcLplvazqy72vzKjA1GJKv+51E/KoN40z14uy7f
         +oO0DKJCIrDRyn5hnYfqfj/K70DJQd/jwnkek1INKgV/aA8t4Af92aNMu7iEfhNoPv
         wc/FOH7kxBCTpa1TlmYwD7fz6aN04hx33KGrs+N8D6eKftBVNafYBb7SQ/C5H6EcvN
         o240Z2pI38mww==
Received: by pali.im (Postfix)
        id 365367EA; Thu, 19 Aug 2021 10:34:32 +0200 (CEST)
Date:   Thu, 19 Aug 2021 10:34:32 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
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
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 03/20] udf: Fix iocharset=utf8 mount option
Message-ID: <20210819083432.yy36hrbxzmbasvwd@pali>
References: <20210808162453.1653-1-pali@kernel.org>
 <20210808162453.1653-4-pali@kernel.org>
 <20210812141736.GE14675@quack2.suse.cz>
 <20210812155134.g67ncugjvruos3cy@pali>
 <20210813134822.GF11955@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210813134822.GF11955@quack2.suse.cz>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Friday 13 August 2021 15:48:22 Jan Kara wrote:
> On Thu 12-08-21 17:51:34, Pali Rohár wrote:
> > On Thursday 12 August 2021 16:17:36 Jan Kara wrote:
> > > On Sun 08-08-21 18:24:36, Pali Rohár wrote:
> > > > Currently iocharset=utf8 mount option is broken. To use UTF-8 as iocharset,
> > > > it is required to use utf8 mount option.
> > > > 
> > > > Fix iocharset=utf8 mount option to use be equivalent to the utf8 mount
> > > > option.
> > > > 
> > > > If UTF-8 as iocharset is used then s_nls_map is set to NULL. So simplify
> > > > code around, remove UDF_FLAG_NLS_MAP and UDF_FLAG_UTF8 flags as to
> > > > distinguish between UTF-8 and non-UTF-8 it is needed just to check if
> > > > s_nls_map set to NULL or not.
> > > > 
> > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > 
> > > Thanks for the cleanup. It looks good. Feel free to add:
> > > 
> > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > 
> > > Or should I take this patch through my tree?
> > 
> > Hello! Patches are just RFC, mostly untested and not ready for merging.
> > I will wait for feedback and then I do more testing nad prepare new
> > patch series.
> 
> OK, FWIW I've also tested the UDF and isofs patches.

Well, if you have already done tests, patches are correct and these fs
driver are working fine then fell free to take it through your tree.

I just wanted to warn people that patches in this RFC are mostly
untested to prevent some issues. But if somebody else was faster than
me, did testing + reviewing and there was no issue, I do not see any
problem with including them. Just I cannot put my own Tested-by (yet) :-)

> 								Honza
> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

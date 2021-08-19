Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88933F1768
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 12:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238161AbhHSKlu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 06:41:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41020 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237730AbhHSKlt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 06:41:49 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 614ED220A2;
        Thu, 19 Aug 2021 10:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629369672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rYCiuaaVE837hJmVPqNGfQdo0C78s0ZEZthPtB8IJws=;
        b=QHaOmtrPYFKY/ECa0Oh3D3wOcmiAL2JIpqDvMQlYI8BpjqLWJt/mUSCQ2vcjBliEoI4vxA
        SYRH4Cp+inhlt3V0CmPecdnxJE3Epw2H+midOIK0+xTMDInKdu3RequJsEUPyMp2pqyIQw
        CijlpHlUEd3Hub7F+wyUGJuZ/cSF75w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629369672;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rYCiuaaVE837hJmVPqNGfQdo0C78s0ZEZthPtB8IJws=;
        b=Gru6Sh+lMbjFw9se8RNLXjS6xr6bYz+hcdqsCoSCBrJKyJSzbka4LCg8dAxA8ab7QDTvHb
        tSzoTxy76e1B4yCA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 66AC1A3B9A;
        Thu, 19 Aug 2021 10:40:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B8FF31E0679; Thu, 19 Aug 2021 12:41:11 +0200 (CEST)
Date:   Thu, 19 Aug 2021 12:41:11 +0200
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
Message-ID: <20210819104111.GC32435@quack2.suse.cz>
References: <20210808162453.1653-1-pali@kernel.org>
 <20210808162453.1653-4-pali@kernel.org>
 <20210812141736.GE14675@quack2.suse.cz>
 <20210812155134.g67ncugjvruos3cy@pali>
 <20210813134822.GF11955@quack2.suse.cz>
 <20210819083432.yy36hrbxzmbasvwd@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210819083432.yy36hrbxzmbasvwd@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 19-08-21 10:34:32, Pali Rohár wrote:
> On Friday 13 August 2021 15:48:22 Jan Kara wrote:
> > On Thu 12-08-21 17:51:34, Pali Rohár wrote:
> > > On Thursday 12 August 2021 16:17:36 Jan Kara wrote:
> > > > On Sun 08-08-21 18:24:36, Pali Rohár wrote:
> > > > > Currently iocharset=utf8 mount option is broken. To use UTF-8 as iocharset,
> > > > > it is required to use utf8 mount option.
> > > > > 
> > > > > Fix iocharset=utf8 mount option to use be equivalent to the utf8 mount
> > > > > option.
> > > > > 
> > > > > If UTF-8 as iocharset is used then s_nls_map is set to NULL. So simplify
> > > > > code around, remove UDF_FLAG_NLS_MAP and UDF_FLAG_UTF8 flags as to
> > > > > distinguish between UTF-8 and non-UTF-8 it is needed just to check if
> > > > > s_nls_map set to NULL or not.
> > > > > 
> > > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > 
> > > > Thanks for the cleanup. It looks good. Feel free to add:
> > > > 
> > > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > > 
> > > > Or should I take this patch through my tree?
> > > 
> > > Hello! Patches are just RFC, mostly untested and not ready for merging.
> > > I will wait for feedback and then I do more testing nad prepare new
> > > patch series.
> > 
> > OK, FWIW I've also tested the UDF and isofs patches.
> 
> Well, if you have already done tests, patches are correct and these fs
> driver are working fine then fell free to take it through your tree.
> 
> I just wanted to warn people that patches in this RFC are mostly
> untested to prevent some issues. But if somebody else was faster than
> me, did testing + reviewing and there was no issue, I do not see any
> problem with including them. Just I cannot put my own Tested-by (yet) :-)

OK, I've pulled the udf and isofs fixes to my tree.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

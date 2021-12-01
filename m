Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C045464EFB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 14:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349610AbhLANtv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 08:49:51 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55264 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243984AbhLANtg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:49:36 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D8F38212BD;
        Wed,  1 Dec 2021 13:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638366373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kFdpGV0gChShndpvLmabsn1WZ0PgMpD+dQP2h4bmzQg=;
        b=D+wgzn1i2O2ygMx8PX3YQ4ENgHlnwAmE6gPLr7PIGmC7hglivSU4A6haiXXMSN16leBHkb
        JsAE0M9vzUAgthx1ClHbU72OpeTj7xYnJzeYFPA0edXj2/v38eswnIXCzqzh/PzRQsB3Yu
        b23+O5tXvkOtViUEdojI3FiLF7sEqCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638366373;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kFdpGV0gChShndpvLmabsn1WZ0PgMpD+dQP2h4bmzQg=;
        b=xuOautOusXhgrOYVbpH5MFMSpa9fYifjJ9oLVUoVx8BUZ0YnFoFag7yiwCGP7zHs129n1l
        xqdXrI4WSYAqYQBQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 672EFA3B83;
        Wed,  1 Dec 2021 13:46:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 357021E1494; Wed,  1 Dec 2021 14:46:10 +0100 (CET)
Date:   Wed, 1 Dec 2021 14:46:10 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Chengguang Xu <cgxu519@mykernel.net>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ronyjin <ronyjin@tencent.com>,
        charliecgxu <charliecgxu@tencent.com>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC PATCH v5 06/10] ovl: implement overlayfs' ->write_inode
 operation
Message-ID: <20211201134610.GA1815@quack2.suse.cz>
References: <20211118112315.GD13047@quack2.suse.cz>
 <17d32ecf46e.124314f8f672.8832559275193368959@mykernel.net>
 <20211118164349.GB8267@quack2.suse.cz>
 <17d36d37022.1227b6f102736.1047689367927335302@mykernel.net>
 <20211130112206.GE7174@quack2.suse.cz>
 <17d719b79f9.d89bf95117881.5882353172682156775@mykernel.net>
 <CAOQ4uxidK-yDMZoZtoRwTZLgSTr1o2Mu2L55vJRNJDLV0-Sb1w@mail.gmail.com>
 <17d73da701b.e571c37220081.6904057835107693340@mykernel.net>
 <17d74b08dcd.c0e94e6320632.9167792887632811518@mykernel.net>
 <CAOQ4uxiCYFeeH8oUUNG+rDCru_1XcwB6fR2keS1C6=d_yD9XzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiCYFeeH8oUUNG+rDCru_1XcwB6fR2keS1C6=d_yD9XzA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 01-12-21 09:19:17, Amir Goldstein wrote:
> On Wed, Dec 1, 2021 at 8:31 AM Chengguang Xu <cgxu519@mykernel.net> wrote:
> > So the final solution to handle all the concerns looks like accurately
> > mark overlay inode diry on modification and re-mark dirty only for
> > mmaped file in ->write_inode().
> >
> > Hi Miklos, Jan
> >
> > Will you agree with new proposal above?
> >
> 
> Maybe you can still pull off a simpler version by remarking dirty only
> writably mmapped upper AND inode_is_open_for_write(upper)?

Well, if inode is writeably mapped, it must be also open for write, doesn't
it? The VMA of the mapping will hold file open. So remarking overlay inode
dirty during writeback while inode_is_open_for_write(upper) looks like
reasonably easy and presumably there won't be that many inodes open for
writing for this to become big overhead?

> If I am not mistaken, if you always mark overlay inode dirty on ovl_flush()
> of FMODE_WRITE file, there is nothing that can make upper inode dirty
> after last close (if upper is not mmaped), so one more inode sync should
> be enough. No?

But we still need to catch other dirtying events like timestamp updates,
truncate(2) etc. to mark overlay inode dirty. Not sure how reliably that
can be done...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

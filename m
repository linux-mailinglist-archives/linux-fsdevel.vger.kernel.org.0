Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866D04255BC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 16:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242135AbhJGOsm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 10:48:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57798 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbhJGOsl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 10:48:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1A13D200CA;
        Thu,  7 Oct 2021 14:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633618007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bn9jHUhGBy/09SeVT+oXfiBXLQm4zhIk/PLnuS4BfXI=;
        b=B/xXd3mEz5i39N+aRPpqCSx8dpZC3l3YxzQvpAAzQJ/JuNzH97nq4rXaBGubVqGO/CtkTQ
        SWV6nwz9TF+X3duxO6WwEvyVVlSmWhwaqBZJEw+u5HY2Eafvwri5A9ZfgfbSp8wxB22C3g
        vqmjgMO1TUZ/xSV2WFX2aF1Sb5xFhn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633618007;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bn9jHUhGBy/09SeVT+oXfiBXLQm4zhIk/PLnuS4BfXI=;
        b=ML+pYq8+P53uEk51AL6tU6Xo3jdPHvJ1X3hWA591UWgFCiZ54EKDX0ClBt/zTX0f6p4DHE
        2ivBMw5ulqfDO0Bg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 026BAA3B83;
        Thu,  7 Oct 2021 14:46:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D43BF1F2C96; Thu,  7 Oct 2021 16:46:46 +0200 (CEST)
Date:   Thu, 7 Oct 2021 16:46:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Chengguang Xu <cgxu519@mykernel.net>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v5 06/10] ovl: implement overlayfs' ->write_inode
 operation
Message-ID: <20211007144646.GL12712@quack2.suse.cz>
References: <20210923130814.140814-1-cgxu519@mykernel.net>
 <20210923130814.140814-7-cgxu519@mykernel.net>
 <CAJfpeguqj2vst4Zj5EovSktJkXiDSCSWY=X12X0Yrz4M8gPRmQ@mail.gmail.com>
 <17c5aba1fef.c5c03d5825886.6577730832510234905@mykernel.net>
 <CAJfpegtr1NkOiY9YWd1meU1yiD-LFX-aB55UVJs94FrX0VNEJQ@mail.gmail.com>
 <17c5adfe5ea.12f1be94625921.4478415437452327206@mykernel.net>
 <CAJfpegt4jZpSCXGFk2ieqUXVm3m=ng7QtSzZp2bXVs07bfrbXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegt4jZpSCXGFk2ieqUXVm3m=ng7QtSzZp2bXVs07bfrbXg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 07-10-21 15:34:19, Miklos Szeredi wrote:
> On Thu, 7 Oct 2021 at 15:10, Chengguang Xu <cgxu519@mykernel.net> wrote:
> >  > However that wasn't what I was asking about.  AFAICS ->write_inode()
> >  > won't start write back for dirty pages.   Maybe I'm missing something,
> >  > but there it looks as if nothing will actually trigger writeback for
> >  > dirty pages in upper inode.
> >  >
> >
> > Actually, page writeback on upper inode will be triggered by overlayfs ->writepages and
> > overlayfs' ->writepages will be called by vfs writeback function (i.e writeback_sb_inodes).
> 
> Right.
> 
> But wouldn't it be simpler to do this from ->write_inode()?

You could but then you'd have to make sure you have I_DIRTY_SYNC always set
when I_DIRTY_PAGES is set on the upper inode so that your ->write_inode()
callback gets called. Overall I agree the logic would be probably simpler.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703DF46949E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 12:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242061AbhLFLDb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 06:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242037AbhLFLDa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:03:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2D8C061746;
        Mon,  6 Dec 2021 03:00:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59D41B8104F;
        Mon,  6 Dec 2021 11:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F48BC341C1;
        Mon,  6 Dec 2021 10:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638788399;
        bh=7WT84C+j1gBM6+y9UakjmiSGzVufWXb4tuAOex1ntIw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sje3SygmpqOjYMA+yuSBTywrAUOgYAPjyEaVw3iGNLujt2sEfXw1XFDWRiV4cvY0b
         YPpPTk5Ste5kKO9AnkuNgvf4cbOhr+kCo4+YYQuKB89nLQ82YgdaKkChpRBNMCLimI
         H+giKC/KxSI/rhqCyfpgneKaGz5FouPv3PGOvqNOqtZL3XgpSOO9pY17R4Mk243gN5
         AVHuZkfSAoQ1SpV1Kb/tKNOXsbezafRtWOWxD4tmICS14oVknNxT7pjFzESqMjzqw5
         yy7HA36wU+dHToa6j2a3sYSTLiJyicPwpKBjnHtpIxtBWFvoink8o0lT8o080bxNGD
         KJU40SDXhkegA==
Message-ID: <dfd01818f8de7e47b3f8bc56550f6db0e977be76.camel@kernel.org>
Subject: Re: [PATCH 1/2] ceph: conversion to new fscache API
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     ceph-devel@vger.kernel.org, idryomov@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Mon, 06 Dec 2021 05:59:57 -0500
In-Reply-To: <1219681.1638784646@warthog.procyon.org.uk>
References: <20211129162907.149445-2-jlayton@kernel.org>
         <20211129162907.149445-1-jlayton@kernel.org>
         <1219681.1638784646@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-12-06 at 09:57 +0000, David Howells wrote:
> Jeff Layton <jlayton@kernel.org> wrote:
> 
> >  		if (!(gfp & __GFP_DIRECT_RECLAIM) || !(gfp & __GFP_FS))
> 
> There's a function for the first part of this:
> 
> 		if (!gfpflags_allow_blocking(gfp) || !(gfp & __GFP_FS))
> 
> > +	fsc->fscache = fscache_acquire_volume(name, NULL, 0);
> >  
> >  	if (fsc->fscache) {
> >  		ent->fscache = fsc->fscache;
> >  		list_add_tail(&ent->list, &ceph_fscache_list);
> 
> It shouldn't really be necessary to have ceph_fscache_list since
> fscache_acquire_volume() will do it's own duplicate check.  I wonder if I
> should make fscache_acquire_volume() return -EEXIST or -EBUSY rather than NULL
> in such a case and not print an error, but rather leave that to the filesystem
> to display.
> 
> That would allow you to get rid of the ceph_fscache_entry struct also, I
> think.
> 

Returning an error there sounds like a better thing to do.

I'll make the other changes you suggested now. Let me know if you change
the fscache_acquire_volume return.

> > +#define FSCACHE_USE_NEW_IO_API
> 
> That doesn't exist anymore.
> 
> > +		/*
> > +		 * If we're truncating up, then we should be able to just update
> > +		 * the existing cookie.
> > +		 */
> > +		if (size > isize)
> > +			ceph_fscache_update(inode);
> 
> Might look better to say "expanding" rather than "truncating up".
> 
> David
> 

-- 
Jeff Layton <jlayton@kernel.org>

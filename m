Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41EB527B825
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Sep 2020 01:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbgI1Xai (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Sep 2020 19:30:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727125AbgI1Xac (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:30:32 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49BCC22262;
        Mon, 28 Sep 2020 22:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601331283;
        bh=USpniiZPSjX9PvCc27mG/IIV3bgaeRYXivPfC1sKaCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1JPJAa2M8r1+Kmgu2TUoUpoIUzu0X8/iCW/FXrJ+a3Jd9Id4x5d0wHUS5KczOFfSG
         QGLKMegDqCV2jarOmBu7voR1a+2TJpmbBMMDVHhg1BiqwC5DXIDA8GEGrd08lKzHli
         Ydn4a/Qdlc/puyb39pAQ58QzsjRekS18hTo6EzSA=
Date:   Mon, 28 Sep 2020 15:14:41 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Laight <David.Laight@aculab.com>,
        syzbot+51177e4144d764827c45@syzkaller.appspotmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: WARNING in __kernel_read (2)
Message-ID: <20200928221441.GF1340@sol.localdomain>
References: <000000000000da992305b02e9a51@google.com>
 <3b3de066852d4e30bd9d85bd28023100@AcuMS.aculab.com>
 <642ed0b4810d44ab97a7832ccb8b3e44@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <642ed0b4810d44ab97a7832ccb8b3e44@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 26, 2020 at 01:17:04PM +0000, David Laight wrote:
> From: David Laight
> > Sent: 26 September 2020 12:16
> > To: 'syzbot' <syzbot+51177e4144d764827c45@syzkaller.appspotmail.com>; linux-fsdevel@vger.kernel.org;
> > linux-kernel@vger.kernel.org; syzkaller-bugs@googlegroups.com; viro@zeniv.linux.org.uk
> > Subject: RE: WARNING in __kernel_read (2)
> > 
> > > From: syzbot <syzbot+51177e4144d764827c45@syzkaller.appspotmail.com>
> > > Sent: 26 September 2020 03:58
> > > To: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; syzkaller-bugs@googlegroups.com;
> > > viro@zeniv.linux.org.uk
> > > Subject: WARNING in __kernel_read (2)
> > 
> > I suspect this is calling finit_module() on an fd
> > that doesn't have read permissions.
> 
> Code inspection also seems to imply that the check means
> the exec() also requires read permissions on the file.
> 
> This isn't traditionally true.
> suid #! scripts are particularly odd without 'owner read'
> (everyone except the owner can run them!).

Christoph, any thoughts here?  You added this WARN_ON_ONCE in:

	commit 61a707c543e2afe3aa7e88f87267c5dafa4b5afa
	Author: Christoph Hellwig <hch@lst.de>
	Date:   Fri May 8 08:54:16 2020 +0200

	    fs: add a __kernel_read helper

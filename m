Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8B0A15B081
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 20:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgBLTLs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 14:11:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42032 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBLTLq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 14:11:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PBqLp03iLEuifCxoohjgIL+G7nTfwMmO8s7fwfJBCos=; b=kb42Zo7MqnHboTKJHH8/xP6vNt
        iF3IhtcZpD5Nt8JolYP81/846ukrortbm+fRSpT66GWuJPejtQCPvWRpr6kxDIEWu9A42Hz1MP3Is
        /C8faLkggVBpiES0w7SI0IfgBON7QpEBAskFVmMCGH9irwpKzaPzDyHn7Kw83jEdX62humt6imp9e
        CjhcvFFEo76dZnf4wwDAGZHqpy2aq7TIl7/idNM9fVrtEJhdx1RkrmSykpmorhMTMyRKFSsk7vZXx
        uCKqGzxbpFyhVFT/OklAjoHFlxuSYDvQHkFdZJMvCnE5D4xpi0uQeMOe07TPqFzShEEAqvD1LqPER
        FIQQ4Trw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1xAl-0004Ln-HU; Wed, 12 Feb 2020 18:55:43 +0000
Date:   Wed, 12 Feb 2020 10:55:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, libc-alpha@sourceware.org,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: XFS reports lchmod failure, but changes file system contents
Message-ID: <20200212185543.GA12993@infradead.org>
References: <874kvwowke.fsf@mid.deneb.enyo.de>
 <20200212161604.GP6870@magnolia>
 <20200212181128.GA31394@infradead.org>
 <87pnejmyhy.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnejmyhy.fsf@mid.deneb.enyo.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 07:50:01PM +0100, Florian Weimer wrote:
> * Christoph Hellwig:
> 
> > xfs doesn't seem all that different from the other file systems,
> > so I suspect you'll also see it with other on-disk file systems.
> > We probably need a check high up in the chmod and co code to reject
> > the operation early for O_PATH file descriptors pointing to symlinks.
> 
> We will change the glibc emulation to avoid trying to lchmod symbolic
> links in this way.  This will avoid triggering the kernel bug.

We'll still need to fix it.

> (We'd really like to get a proper fchmodat system call with a flags
> argument, though, for AT_EMPTY_PATH and AT_SYMLINK_NOFOLLOW.)

Send a patch (o find a minion to do so).

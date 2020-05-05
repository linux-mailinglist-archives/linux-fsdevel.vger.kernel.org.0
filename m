Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4791C54F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 14:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgEEL76 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 07:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727090AbgEEL76 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 07:59:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC6AC061A0F;
        Tue,  5 May 2020 04:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=REPCft4TfvdeWRVXri2o1wuqZJcFojbavxrdrjtttCI=; b=NWIHP2gLwMqhCrrP0wSUBPv/7z
        G7dxQhOCiYv0w/rVrLpvagaryypM4WVVrVT3d96a0dX4gHH3uH/bISMCDo7chbiqvapAgCfGxdYWB
        5OWaNHLX4wYaHdJN6OvdzMnl2MxU+AceWTvhlzlHxfc+9+bmYyZ7Bfu37w0Iy9zZhNpucB4vmTHaJ
        z563vHi53bukqAgYai33YDQikFMZsdCs1yPrbEso6bhPlyXfHA7ebfkSIz74UByYomhc8DfMmIcqj
        30SF4G+p9UdMv/jzsXFgM5E0I3y4YLfe2uwd5KP1StlJI+y9n0aOA0bYljdtXbftau0rzofUJZwno
        XQhNFf8A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVwEk-0004lb-81; Tue, 05 May 2020 11:59:46 +0000
Date:   Tue, 5 May 2020 04:59:46 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Jeff Layton <jlayton@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 54/61] afs: Wait on PG_fscache before
 modifying/releasing a page
Message-ID: <20200505115946.GF16070@bombadil.infradead.org>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
 <158861253957.340223.7465334678444521655.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158861253957.340223.7465334678444521655.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 04, 2020 at 06:15:39PM +0100, David Howells wrote:
> PG_fscache is going to be used to indicate that a page is being written to
> the cache, and that the page should not be modified or released until it's
> finished.
> 
> Make afs_invalidatepage() and afs_releasepage() wait for it.

Well, why?  Keeping a refcount on the page will prevent it from going
away while it's being written to storage.  And the fact that it's
being written to this cache is no reason to delay the truncate of a file
(is it?)  Similarly, I don't see why we need to wait for the page to make
it to the cache before we start to modify it.  Certainly we'll need to
re-write it to the cache since the cache is now stale, but why should
we wait for the now-stale write to complete?


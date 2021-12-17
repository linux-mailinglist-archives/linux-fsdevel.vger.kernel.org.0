Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E224792A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Dec 2021 18:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239776AbhLQRSJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Dec 2021 12:18:09 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50672 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236241AbhLQRSI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:18:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABADBB829B2;
        Fri, 17 Dec 2021 17:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00632C36AE1;
        Fri, 17 Dec 2021 17:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639761486;
        bh=gvUpKwlu6PEF7ySh0jU8vlsHpMimt4HRUxuFGsDwOJg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hKqB8qmKXvqFruzb0x1f2NkRdQrH+46NvzRkFUxeNma2eh00vG5EM9XBnQr+iMZNG
         ZTT3K3ARanOu/AIItiaTKaugZ9Ttg7vsxbtCdOsLOxo4GzVtj4bKeOX+X52tCXVQwD
         xKVlB4pH95vAnPN/V30IEb6VidiyMoBEyxOB+hOcfbmzOaCs4xjPq/pNOsQQF93dqS
         aldECva+pHD1l2lyMEYZFmMadT0tGYWson542ped+Uuu1kfis0UVoscLG6tgLxPSeU
         bmp911cgQrJ3iCnxRXwtxhMQQLUltHkN+J0w7HAP5nmhxbCF6hkGr/sQ1FrDhskVvE
         asxWfOpJKEIKg==
Message-ID: <e2fcdecb9288dc112d0051e917da5bb48bf72388.camel@kernel.org>
Subject: Re: [PATCH v2 1/2] ceph: Uninline the data on a file opened for
 writing
From:   Jeff Layton <jlayton@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     ceph-devel@vger.kernel.org, idryomov@gmail.com,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 17 Dec 2021 12:18:04 -0500
In-Reply-To: <Yby4sKDALDXHAbdT@casper.infradead.org>
References: <163975498535.2021751.13839139728966985077.stgit@warthog.procyon.org.uk>
         <Yby4sKDALDXHAbdT@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-12-17 at 16:20 +0000, Matthew Wilcox wrote:
> On Fri, Dec 17, 2021 at 03:29:45PM +0000, David Howells wrote:
> > If a ceph file is made up of inline data, uninline that in the ceph_open()
> > rather than in ceph_page_mkwrite(), ceph_write_iter(), ceph_fallocate() or
> > ceph_write_begin().
> 
> I don't think this is the right approach.  Just opening a file with
> O_RDWR shouldn't take it out of inline mode; an actual write (or fault)
> should be required to uninline it.
> 

This feature is being deprecated in ceph altogether, so more
aggressively uninlining of files is fine. The kernel cephfs client never
supported writes to it anyway so this feature was really only used by a
few brave souls.

We're hoping to have it formally removed by the time the Ceph Quincy
release ships (~April-May timeframe). Unfortunately, we need to keep
support for it around for a bit longer since some still-supported ceph
releases don't have this deprecated.

> > This makes it easier to convert to using the netfs library for VM write
> > hooks.
> 
> I don't understand.  You're talking about the fault path?  Surely
> the filesystem gets called with the vm_fault parameter only, then
> calls into the netfs code, passing vmf and the operations struct?
> And ceph could uninline there.
> 

Taking the uninlining out of the write codepaths is a _good_ thing, IMO.
If we were planning to keep this feature around, then I might disagree
with doing this, but it fits with the current plans for inline data just
fine for now.

-- 
Jeff Layton <jlayton@kernel.org>

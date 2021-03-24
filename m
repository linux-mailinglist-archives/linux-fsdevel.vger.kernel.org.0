Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19363472EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 08:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhCXHoc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 03:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbhCXHo3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:44:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A03C061763;
        Wed, 24 Mar 2021 00:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AjhZ2CVIIKjR5isQC6sJ/24i99ctPOUtMKvV5qXF0xo=; b=IOmFqAHA8XBS4+6O0mpzjzYRae
        B1ys2xUT6rxBMk4sgdkyX6jTWMKUBaHQNKaPBp70tGMXQYhMaJQOj9TWfo2ONlGlm+wzTGpMakf6f
        N7kwFlK3Vl5z23eVQ/ZAAwvf0wDFYLgqhTAdhABjiYp+BeVk1af3i6nZdPfU/9ttFO4aABwJ72JAg
        fubbFCncJww+o/hOD7Fy5FEGotQpnB16aHDV7wwVy4/pGkyi4tV9yEk0T++f0KLug4oee9IaTZ5eH
        XNSq0kMXV/XypVwmGWQn6JdDaqWkQ7YUZievOvUZF2/NtQbOD1C7E8kPVQ5ItimWZtpkSbfdJeGR/
        J07I9N0w==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOyAg-00B6jN-AB; Wed, 24 Mar 2021 07:43:35 +0000
Date:   Wed, 24 Mar 2021 07:43:18 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] xfs: use a unique and persistent value for f_fsid
Message-ID: <20210324074318.GA2646094@infradead.org>
References: <20210322171118.446536-1-amir73il@gmail.com>
 <20210322230352.GW63242@dread.disaster.area>
 <CAOQ4uxjFMPNgR-aCqZt3FD90XtBVFZncdgNc4RdOCbsxukkyYQ@mail.gmail.com>
 <20210323072607.GF63242@dread.disaster.area>
 <CAOQ4uxgAddAfGkA7LMTPoBmrwVXbvHfnN8SWsW_WXm=LPVmc7Q@mail.gmail.com>
 <20210324005421.GK63242@dread.disaster.area>
 <CAOQ4uxhhMVQ4XE8DMU1EjaXBo-go3_pFX3CCWn=7GuUXcMW=PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhhMVQ4XE8DMU1EjaXBo-go3_pFX3CCWn=7GuUXcMW=PA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 24, 2021 at 08:53:25AM +0200, Amir Goldstein wrote:
> > This also means that userspace can be entirely filesystem agnostic
> > and it doesn't need to rely on parsing proc files to translate
> > ephemeral mount IDs to paths, statvfs() and hoping that f_fsid is
> > stable enough that it doesn't get the destination wrong.  It also
> > means that fanotify UAPI probably no longer needs to supply a
> > f_fsid with the filehandle because it is built into the
> > filehandle....
> >
> 
> That is one option. Let's call it the "bullet proof" option.
> 
> Another option, let's call it the "pragmatic" options, is that you accept
> that my patch shouldn't break anything and agree to apply it.

Your patch may very well break something.  Most Linux file systems do
store the dev_t in the fsid and userspace may for whatever silly
reasons depend on it.

Also trying to use the fsid for anything persistent is plain stupid,
64-bits are not enough entropy for such an identifier.  You at least
need a 128-bit UUID-like identifier for that.

So I think this whole discussion is going in the wrong direction.
Is exposing a stable file system identifier useful?  Yes, for many
reasons.  Is repurposing the fsid for that a good idea?  Hell no.

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FF2463E52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 20:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239652AbhK3TEZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 14:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbhK3TEY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 14:04:24 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A95C061574;
        Tue, 30 Nov 2021 11:01:05 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 007B76EAA; Tue, 30 Nov 2021 14:01:03 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 007B76EAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1638298864;
        bh=j/egBfgeGqZVHllVq98Drwek8LDKyW56D7aV6TCUZ0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=svA1MQ2KHaHguQCV36XPy+8lteWSq0pE7riMGPM7GQr4Llvs6x7ATOl9S0QssmC1c
         flZJ6GuRPsJEsMawWLqulr9KPxiAh4L+lMNtSZc+cm+Efk3xi4NkQEJn9ghfkdA5ot
         3DTzhOatS8CDxCx1tmYwIETqmd3m2jD9roGuZvtw=
Date:   Tue, 30 Nov 2021 14:01:03 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20211130190103.GD8837@fieldses.org>
References: <C9C6AEC1-641C-4614-B149-5275EFF81C3D@oracle.com>
 <22000fe0-9b17-3d88-1730-c8704417cb92@oracle.com>
 <B42B0F9C-57E2-4F58-8DBD-277636B92607@oracle.com>
 <c8eef4ab9cb7acdf506d35b7910266daa9ded18c.camel@hammerspace.com>
 <0B58F7BC-A946-4FE6-8AC2-4C694A2120A3@oracle.com>
 <3afa1db55ccdf52eff7afb7b684eb961f878b68a.camel@hammerspace.com>
 <7548c291-cc0a-ed7a-ca37-63afe1d88c27@oracle.com>
 <FC3CB37C-8E5C-4DB0-B31F-0AA2B6D8B57F@oracle.com>
 <20211130160513.GC8837@fieldses.org>
 <978a322ad63bfdd8752b6ff9fbfce129c4c99193.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <978a322ad63bfdd8752b6ff9fbfce129c4c99193.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 30, 2021 at 04:14:10PM +0000, Trond Myklebust wrote:
> On Tue, 2021-11-30 at 11:05 -0500, Bruce Fields wrote:
> > On Tue, Nov 30, 2021 at 03:36:43PM +0000, Chuck Lever III wrote:
> > > I am a little concerned that we are trying to optimize a case
> > > that won't happen during practice. pynfs does not reflect any
> > > kind of realistic or reasonable client behavior -- it's designed
> > > to test very specific server operations.
> > 
> > I wonder how hard this problem would be to hit in normal use.  I
> > mean, a
> > few hundred or a thousand clients doesn't sound that crazy.  This
> > case
> > depends on an open deny, but you could hit the same problem with file
> > locks.  Would it be that weird to have a client trying to get a write
> > lock on a file read-locked by a bunch of other clients?
> > 
> 
> That's a scenario that is subject to starvation problems anyway.

Yes, if it's hundreds of clients continuously grabbing read locks.  But
if it's something like: send all the readers a signal, then request a
write lock as a way to wait for them to finish; then you'd normally
expect to get it soon after the last client drops its lock.

I don't know, maybe that's uncommon.

--b.

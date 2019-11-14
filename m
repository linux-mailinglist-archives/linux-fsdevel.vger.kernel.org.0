Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAEECFD1AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 00:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfKNXtK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 18:49:10 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:49010 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfKNXtK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 18:49:10 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVOrJ-0006Oi-Cr; Thu, 14 Nov 2019 23:49:05 +0000
Date:   Thu, 14 Nov 2019 23:49:05 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Subject: Re: [RFC] is ovl_fh->fid really intended to be misaligned?
Message-ID: <20191114234905.GL26530@ZenIV.linux.org.uk>
References: <20191114154723.GJ26530@ZenIV.linux.org.uk>
 <20191114195544.GB5569@miu.piliscsaba.redhat.com>
 <CAOQ4uxhjAwU_V0cUF+VkQbAwXKTJKsZuyysNXMecuM9Y1iuUsw@mail.gmail.com>
 <CAOQ4uxhaw_H0ScTvehHqZVkp5KgBtd_bgcf-0bo_GnUrT8Rwqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhaw_H0ScTvehHqZVkp5KgBtd_bgcf-0bo_GnUrT8Rwqg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 01:13:15AM +0200, Amir Goldstein wrote:

> See attached.
> IMHO it looks much easier to verify that these changes are correct
> compared to your open coded offset shifting all over the place.
> 
> It even passed the exportfs tests first try.
> Only some index tests are failing.
> 
> If you like this version, I can fix up the failures and add Al's
> suggestions to simplify code with OVL_FH_MAX_SIZE
> memory allocations.

Huh?  Correct me if I'm wrong, but doesn't that patch make it
reject all old fhandles just on the type check?  That includes
anything sent over the wire, or stored in xattrs, or represented
as names in indexdir...

_If_ we can change the fhandle layout at will, everything's
easy - you can add padding in any way you like.  But fhandles
are a lot more permanent than this approach would require -
mere rebooting the server into a new kernel must not make the
clients see -ESTALE on everything they'd imported from it!
And then there's implied "you can throw indexdir contents at
any time", which is also not a good thing to do.

Sure, introducing a variant with better layout would be nice,
and using a new type for it is pretty much required, but
you can't just discard old-layout fhandles you'd ever issued.

I'm afraid it's a lot stickier than you think; decisions on
fhandle layout are nearly as permanent as those on the
storage layouts for a filesystem.  Especially in case of
overlayfs, where they are literally a part of the storage
layout - the names in indexdir and the contents of
trusted.overlay.upper xattr on subdirectories in there...

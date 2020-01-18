Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1D8141543
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2020 01:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbgARArr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 19:47:47 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40996 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729394AbgARArr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 19:47:47 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iscH4-00AY2T-4y; Sat, 18 Jan 2020 00:47:38 +0000
Date:   Sat, 18 Jan 2020 00:47:38 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>, "hch@lst.de" <hch@lst.de>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
Message-ID: <20200118004738.GQ8904@ZenIV.linux.org.uk>
References: <364531.1579265357@warthog.procyon.org.uk>
 <d2730b78cf0eac685c3719909df34d8d1b0bc347.camel@hammerspace.com>
 <20200117154657.GK8904@ZenIV.linux.org.uk>
 <20200117163616.GA282555@vader>
 <20200117165904.GN8904@ZenIV.linux.org.uk>
 <20200117172855.GA295250@vader>
 <20200117181730.GO8904@ZenIV.linux.org.uk>
 <20200117202219.GB295250@vader>
 <20200117222212.GP8904@ZenIV.linux.org.uk>
 <20200117235444.GC295250@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117235444.GC295250@vader>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 17, 2020 at 03:54:44PM -0800, Omar Sandoval wrote:
 
> > 	3) permission checks need to be specified
> 
> I believe the only difference here vs standard linkat is that newpath
> must not be immutable or append-only?

I would bloody hope not - at the very least you want sticky bit on parent
to have effect, same as with rename()/rmdir()/unlink()...

> > references to pathconf, Cthulhu and other equally delightful entities
> > are not really welcome.
> 
> EOPNOTSUPP is probably the most helpful.

Umm...  What would you feed it, though?  You need to get past your
"links to the same file, do nothing" escape...

> Based on my previous attempt at it [1], it's not too bad.

+                       error = may_delete(dir, new_dentry, d_is_dir(old_dentry));                                       

Why bother with d_is_dir(), when you are going to reject directories
anyway?

+       if (dir->i_op->link)                                                                                             
+               error = dir->i_op->link(old_dentry, dir, new_dentry);                                                    
+       else                                                                                                             
+               error = dir->i_op->link2(old_dentry, dir, new_dentry, flags);                                            
+       if (error)                                                                                                       
+               goto out;                                                                                                
+                                                                                                                        

No.  This is completely wrong; just make it ->link_replace() and be done
with that; no extra arguments and *always* the same conditions wrt
positive/negative.  One of the reasons why ->rename() tends to be
ugly (and a source of quite a few bugs over years) are those "if
target is positive/if target is negative" scattered over the instances.

Make the choice conditional upon the positivity of target.

And you don't need to reproduce every quirk of rename() error values.
Really.  Unless you really intend to have userland do a loop of
linkat(2) attempts (a-la mkstemp(3)), followed by rename(2) for
fallback...

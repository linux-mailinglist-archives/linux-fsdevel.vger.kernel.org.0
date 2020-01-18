Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C70C141593
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2020 03:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbgARCUp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 21:20:45 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41882 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgARCUp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 21:20:45 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isdiy-00AaR6-N3; Sat, 18 Jan 2020 02:20:32 +0000
Date:   Sat, 18 Jan 2020 02:20:32 +0000
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
Message-ID: <20200118022032.GR8904@ZenIV.linux.org.uk>
References: <20200117154657.GK8904@ZenIV.linux.org.uk>
 <20200117163616.GA282555@vader>
 <20200117165904.GN8904@ZenIV.linux.org.uk>
 <20200117172855.GA295250@vader>
 <20200117181730.GO8904@ZenIV.linux.org.uk>
 <20200117202219.GB295250@vader>
 <20200117222212.GP8904@ZenIV.linux.org.uk>
 <20200117235444.GC295250@vader>
 <20200118004738.GQ8904@ZenIV.linux.org.uk>
 <20200118011734.GD295250@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118011734.GD295250@vader>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 17, 2020 at 05:17:34PM -0800, Omar Sandoval wrote:
> > No.  This is completely wrong; just make it ->link_replace() and be done
> > with that; no extra arguments and *always* the same conditions wrt
> > positive/negative.  One of the reasons why ->rename() tends to be
> > ugly (and a source of quite a few bugs over years) are those "if
> > target is positive/if target is negative" scattered over the instances.
> > 
> > Make the choice conditional upon the positivity of target.
> 
> Yup, you already convinced me that ->link_replace() is better in your
> last email.

FWIW, that might be not so simple ;-/  Reason: NFS-like stuff.  Client
sees a negative in cache; the problem is how to decide whether to
tell the server "OK, I want normal link()" vs. "if it turns out that
someone has created it by the time you see the request, give do
a replacing link".  Sure, if could treat ->link() telling you -EEXIST
as "OK, repeat it with ->link_replace(), then", but that's an extra
roundtrip...

Hell knows...  I would really like to avoid any kind of ->atomic_open()
redux ;-/

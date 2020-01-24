Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCAEE148DCC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 19:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391366AbgAXSbI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 13:31:08 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:47020 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389707AbgAXSbH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 13:31:07 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iv3jT-00237c-6W; Fri, 24 Jan 2020 18:31:03 +0000
Date:   Fri, 24 Jan 2020 18:31:03 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Gao Xiang <hsiangkao@aol.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Daniel Rosenberg <drosen@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH] ext4: fix race conditions in ->d_compare() and ->d_hash()
Message-ID: <20200124183103.GJ23230@ZenIV.linux.org.uk>
References: <20200124041234.159740-1-ebiggers@kernel.org>
 <20200124050423.GA31271@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20200124051601.GB832@sol.localdomain>
 <20200124053415.GC31271@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20200124054256.GC832@sol.localdomain>
 <20200124061525.GA2407@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20200124181253.GA41762@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124181253.GA41762@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 24, 2020 at 10:12:54AM -0800, Eric Biggers wrote:

> > Thanks for your web reference, I will look into it. I think there
> > is no worry about dentry->d_parent here because of this only one
> > dereference on dentry->d_parent.
> > 
> > You could ignore my words anyway, just my little thought though.
> > Other part of the patch is ok.
> > 
> 
> While that does make it really unlikely to cause a real-world problem, it's
> still undefined behavior to not properly annotate a data race, it would make the
> code harder to understand as there would be no indication that there's a data
> race, and it would confuse tools that try to automatically detect data races.
> So let's keep the READ_ONCE() on d_parent.

*nod*

Note that on everything except alpha it'll generate the same code, unless
the compiler screws up an generates multiple loads.  On alpha it adds
a barrier and I really don't want to sit down and check if its absense
could lead to anything unpleasant.

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6AFC25894
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 22:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfEUUAJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 May 2019 16:00:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54340 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfEUUAJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 May 2019 16:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2WyprSMw0XFiETzAPNoNDTntzyZkEUNNpfxivfnIFag=; b=QiopMVtd93jBeeZmGnTEUvoiY
        vTPJBvJYi5LOSLhmJkqq10H0GkG3Ybuyy2GgEBBiF6ACrbhxxgV/cxaVIjW/Rpjp1yKFHUZAv1Rzs
        o1M82BikP7PxF4SKNxlHxXnX3FiPFbC3GuT6o/Xx4fpryP3q4N96k+ORmXqwzQ/wBAmTBfLHHeQeL
        pscG03ZyLkH3VoNLwDaRa2+XwwmT02a/YpHBEuyfMmby5LJOqSKTeZ4/HIghH62m/WrVueaUx5gSn
        gGeLrAOgfYQfm1X7Wem5prlIJSsG2MzhdkQt9r9wKpMJDj01yDP86ICLz49twvNvu10nerPb/M0CU
        bnqNZlgRg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTAv2-0006w6-9U; Tue, 21 May 2019 19:59:28 +0000
Date:   Tue, 21 May 2019 12:59:28 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, jannh@google.com, fweimer@redhat.com,
        oleg@redhat.com, tglx@linutronix.de, torvalds@linux-foundation.org,
        arnd@arndb.de, shuah@kernel.org, tkjos@android.com,
        ldv@altlinux.org, miklos@szeredi.hu, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 1/2] open: add close_range()
Message-ID: <20190521195928.GB6738@bombadil.infradead.org>
References: <20190521150006.GJ17978@ZenIV.linux.org.uk>
 <20190521113448.20654-1-christian@brauner.io>
 <28114.1558456227@warthog.procyon.org.uk>
 <20190521192009.GK17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521192009.GK17978@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 21, 2019 at 08:20:09PM +0100, Al Viro wrote:
> On Tue, May 21, 2019 at 05:30:27PM +0100, David Howells wrote:
> 
> > If we can live with close_from(int first) rather than close_range(), then this
> > can perhaps be done a lot more efficiently by:
> > 
> > 	new = alloc_fdtable(first);
> > 	spin_lock(&files->file_lock);
> > 	old = files_fdtable(files);
> > 	copy_fds(new, old, 0, first - 1);
> > 	rcu_assign_pointer(files->fdt, new);
> > 	spin_unlock(&files->file_lock);
> > 	clear_fds(old, 0, first - 1);
> > 	close_fdt_from(old, first);
> > 	kfree_rcu(old);
> 
> I really hate to think how that would interact with POSIX locks...

POSIX locks store current->files in fl_owner; David's resizing the
underlying files->fdt, just like growing from 64 to 256 fds.

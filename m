Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028EA46B9E2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 12:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbhLGLTC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 06:19:02 -0500
Received: from verein.lst.de ([213.95.11.211]:55809 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235629AbhLGLTB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 06:19:01 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id D841E68B05; Tue,  7 Dec 2021 12:15:26 +0100 (CET)
Date:   Tue, 7 Dec 2021 12:15:26 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-kernel@vger.kernel.org,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kexec <kexec@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 01/14] fs/proc/vmcore: Update read_from_oldmem()
 for user pointer
Message-ID: <20211207111526.GA18554@lst.de>
References: <20211203104231.17597-1-amit.kachhap@arm.com> <20211203104231.17597-2-amit.kachhap@arm.com> <20211206140451.GA4936@lst.de> <Ya4bdB0UBJCZhUSo@casper.infradead.org> <20211206145422.GA8794@lst.de> <Ya4nI7ly15pJA5xp@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya4nI7ly15pJA5xp@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 06, 2021 at 03:07:15PM +0000, Matthew Wilcox wrote:
> > > What do you think to adding a generic copy_pfn_to_iter()?  Not sure
> > > which APIs to use to implement it ... some architectures have weird
> > > requirements about which APIs can be used for what kinds of PFNs.
> > 
> > Hmm.  I though kmap_local_pfn(_prot) is all we need?
> 
> In the !HIGHMEM case, that calls pfn_to_page(), and I think the
> point of this path is that we don't have a struct page for this pfn.

Indeed.  But to me this suggest that the !highmem stub is broken and
we should probably fix it rather than adding yet another interface.

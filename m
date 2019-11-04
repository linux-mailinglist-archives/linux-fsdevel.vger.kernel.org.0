Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3E62EE469
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 17:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfKDQKA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 11:10:00 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54168 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728012AbfKDQKA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 11:10:00 -0500
Received: from callcc.thunk.org (ip-12-2-52-196.nyc.us.northamericancoax.com [196.52.2.12])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xA4G8QEQ010632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Nov 2019 11:08:27 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 05B81420311; Mon,  4 Nov 2019 11:08:23 -0500 (EST)
Date:   Mon, 4 Nov 2019 11:08:23 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/5] Ext4: Add support for blocksize < pagesize for
 dioread_nolock
Message-ID: <20191104160823.GI28764@mit.edu>
References: <20191016073711.4141-1-riteshh@linux.ibm.com>
 <20191023232614.GB1124@mit.edu>
 <20191029071925.60AABA405B@b06wcsmtp001.portsmouth.uk.ibm.com>
 <20191103191606.GB8037@mit.edu>
 <20191104101623.GB27115@bobrowski>
 <20191104103759.4085C4C046@d06av22.portsmouth.uk.ibm.com>
 <20191104104913.GC27115@bobrowski>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104104913.GC27115@bobrowski>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 04, 2019 at 09:49:14PM +1100, Matthew Bobrowski wrote:
> > It sure may be giving a merge conflict (due to io_end structure).
> > But this dioread_nolock series was not dependent over iomap series.
> 
> Uh ha. Well, there's been a chunk of code injected into
> ext4_end_io_dio() here and by me removing it, I'm not entirely sure
> what the downstream effects will be for this specific change...

Yeah, that was probably my failure to do the merge correctly; I'm
hoping that Ritesh will be able to fix that up.  If not we can throw
an "experimental" config to enable dioread_nolock on subpage
blocksizes, just to warn people that under some extreme workloads,
they might end up corrupting their allocation bitmap, which then might
lead to data loss.  I suspect it would actually work fine for most
users; but out of paranoia, if we can't figure out the generic/270
failure before the merge window, we can just make dioread_nolock_1k
experimental for now.

  	      	     	       		- Ted
							      

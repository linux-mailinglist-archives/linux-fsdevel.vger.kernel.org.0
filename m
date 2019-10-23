Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F34DE1B7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 14:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390347AbfJWM5d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 08:57:33 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54963 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390108AbfJWM5d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:57:33 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9NCv1VA016128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Oct 2019 08:57:02 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3FF4B420456; Wed, 23 Oct 2019 08:57:01 -0400 (EDT)
Date:   Wed, 23 Oct 2019 08:57:01 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, linux-fscrypt@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/3] fscrypt: add support for inline-encryption-optimized
 policies
Message-ID: <20191023125701.GA2460@mit.edu>
References: <20191021230355.23136-1-ebiggers@kernel.org>
 <20191021230355.23136-2-ebiggers@kernel.org>
 <20191022052712.GA2083@dread.disaster.area>
 <20191022060004.GA333751@sol.localdomain>
 <20191022133001.GA23268@mit.edu>
 <20191023092718.GA23274@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023092718.GA23274@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 23, 2019 at 02:27:18AM -0700, Christoph Hellwig wrote:
> On Tue, Oct 22, 2019 at 09:30:01AM -0400, Theodore Y. Ts'o wrote:
> > If and when we actually get inline crypto support for server-class
> > systems, hopefully they will support 128-bit DUN's, and/or they will
> > have sufficiently fast key load times such that we can use per-file
> > keying.
> 
> NVMe is working on a key per I/O feature.  So at very least the naming
> of this option should be "crappy_underwhelming_embedded_inline_crypto"

If and when the vaporware shows up in real hardware, and assuming that
fscrypt is useful for this hardware, we can name it
"super_duper_fancy_inline_crypto".  :-)

Remember that fscrypt only encrypts the data and the file name.  It
doesn't encrypt the metadata.  It has very specific use cases for
Android and ChromeOS where you have multiple users that need to use
different keys, and in the case of ChromeOS, we want to be able to
efficiently use the space so that while user A is logged in, we can
delete files in user B's cache directory without user B's keys being
present.  (This is why we can't use fixed per-user partitions with
dm-crypt; that solution was considered and rejected before we started
work on fscrypt.)

If you aren't working under tight space and cost constraints, it's
actually better to encrypt the whole partition, so that all of the
metadata can be protected.  fscrypt is deployed in millions and
millions of devices, and is solving real world problems.  However, it
never claimed to be the only way to address encryption in the storage
stack --- and it's not at all clear fscrypt is the way that makes the
most amount of sense for NVMe devices.  So let's cross that bridge
when we get to it.

Cheers,

	       	   	      	       	      - Ted

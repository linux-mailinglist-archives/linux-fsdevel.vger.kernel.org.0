Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEC1E2866
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 04:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408294AbfJXCpC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 22:45:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406591AbfJXCpC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 22:45:02 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 450E0205ED;
        Thu, 24 Oct 2019 02:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571885101;
        bh=a2UR3JAnyAGjBvbCcFgN3hdU19LvuMRY6eXNL0aIMNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zmudk+9tdkF/VJbvVxVh1n6lA0HdvlzM3gBA3QAF1BMscyQJAyMeSZ2oTVsjvvwLT
         7zWvsbjWU2UqzIiP1iVr+lRHIhxOdYWj/Wc+SyebQphK85AotCcV+0CDrhh0+yrGnd
         B9bdgo2eMR7JqYlPmsGNBDIgqcbCsb1s4q8+D25A=
Date:   Wed, 23 Oct 2019 19:44:59 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Satya Tangirala <satyat@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>
Subject: Re: [PATCH 1/3] fscrypt: add support for inline-encryption-optimized
 policies
Message-ID: <20191024024459.GA743@sol.localdomain>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Satya Tangirala <satyat@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>
References: <20191021230355.23136-1-ebiggers@kernel.org>
 <20191021230355.23136-2-ebiggers@kernel.org>
 <20191022052712.GA2083@dread.disaster.area>
 <20191022060004.GA333751@sol.localdomain>
 <20191022133001.GA23268@mit.edu>
 <20191023092718.GA23274@infradead.org>
 <20191023125701.GA2460@mit.edu>
 <20191024012759.GA32358@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024012759.GA32358@infradead.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 23, 2019 at 06:27:59PM -0700, Christoph Hellwig wrote:
> > If and when the vaporware shows up in real hardware, and assuming that
> > fscrypt is useful for this hardware, we can name it
> > "super_duper_fancy_inline_crypto".  :-)
> 
> I think you are entirely missing the point.  The point is that naming
> the option someting related to inline encryption is fundamentally
> wrong.  It is related to a limitation of existing inline crypto
> engines, not related to the fudamental model.  And all the other
> rambling below don't matter either.
> 

Would you be happy with something that more directly describes the change the
flag makes, like FSCRYPT_POLICY_FLAG_CONTENTS_IV_INO_LBLK_64?  I.e., the IVs for
contents encryption are 64-bit and contain the inode and logical block numbers.

Actually, we could use the same key derivation and IV generation for directories
and symlinks too, which would result in just FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64.
(lblk is 0 when encrypting a filename.)

Although, in general it would be nice to name the settings in ways that are
easier for people not intimately familiar with the crypto to understand...

- Eric

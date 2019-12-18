Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD351256AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 23:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfLRW13 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 17:27:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:56350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfLRW13 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 17:27:29 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64E652082E;
        Wed, 18 Dec 2019 22:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576708048;
        bh=o7ngMB3x98VTTgkfiZtHSRbzMlQgbTWT/i52kLguSiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ejOCM73UI0+1N/sJ9nYSoNO/OfQJ03EACQbtWn4J87NE/6ll5ayLk55m3ox2OKeQC
         HgPzXi9FGNhpGKPYTE4Ui97/imrJbiNqO1xo4jwnZiZFvWSzvQk8iQwbysEQiFrczV
         X2v68LmTPcM7l+ZfsedbX9c3YpZ9ycitDC0wF0CU=
Date:   Wed, 18 Dec 2019 14:27:26 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v6 2/9] block: Add encryption context to struct bio
Message-ID: <20191218222726.GC47399@gmail.com>
References: <20191218145136.172774-1-satyat@google.com>
 <20191218145136.172774-3-satyat@google.com>
 <20191218212116.GA7476@magnolia>
 <yq1y2v9e37b.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1y2v9e37b.fsf@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 04:25:28PM -0500, Martin K. Petersen wrote:
> 
> Darrick,
> 
> >> +#ifdef CONFIG_BLK_INLINE_ENCRYPTION
> >> +	struct bio_crypt_ctx	*bi_crypt_context;
> >> +#endif
> >
> > This grows struct bio even if we aren't actively using bi_crypt_context,
> > and I thought Jens told us to stop making it bigger. :)
> 
> Yeah. Why not use the bio integrity plumbing? It was explicitly designed
> to attach things to a bio and have them consumed by the device driver.
> 

There's not really any such thing as "use the bio integrity plumbing".
blk-integrity just does blk-integrity; it's not a plumbing layer that allows
other features to be supported.  Well, in theory we could refactor and rename
all the hooks to "blk-extra" and make them delegate to either blk-integrity or
blk-crypto, but I think that would be overkill.

What we could do, though, is say that at most one of blk-crypto and
blk-integrity can be used at once on a given bio, and put the bi_integrity and
bi_crypt_context pointers in union.  (That would require allocating a
REQ_INLINECRYPT bit so that we can tell what the pointer points to.)

- Eric

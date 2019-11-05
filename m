Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60083EF268
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 02:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbfKEBDS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 20:03:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:54846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728761AbfKEBDS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 20:03:18 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C60232067D;
        Tue,  5 Nov 2019 01:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572915797;
        bh=4Jmct+axA8jAkXluFcFQI+uLkQTpqnvf/DA6hb5ReCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nnl5cMFG8BKuRG8ENOvinMxVE3HupXrzgoCoDukHlYgCMGI8K0oFkbfYfvj8iwGMZ
         BzncIGhzlSd8Tq4p78mCz6fMFe+r9sH1z08KjMRUBKDvvQhIRWVYb/8d92xKHoIJYQ
         zdX4RS+7YST5kTD4rUt+3j18FC1y0Lf5NWHcquyk=
Date:   Mon, 4 Nov 2019 17:03:15 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Satya Tangirala <satyat@google.com>, linux-scsi@vger.kernel.org,
        Kim Boojin <boojin.kim@samsung.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 7/9] fscrypt: add inline encryption support
Message-ID: <20191105010315.GA692@sol.localdomain>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
        Satya Tangirala <satyat@google.com>, linux-scsi@vger.kernel.org,
        Kim Boojin <boojin.kim@samsung.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20191028072032.6911-1-satyat@google.com>
 <20191028072032.6911-8-satyat@google.com>
 <20191031183217.GF23601@infradead.org>
 <20191031202125.GA111219@gmail.com>
 <20191031212103.GA6244@infradead.org>
 <20191031222500.GB111219@gmail.com>
 <20191105001554.GA24056@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105001554.GA24056@infradead.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 04, 2019 at 04:15:54PM -0800, Christoph Hellwig wrote:
> > I don't think combining these things is a good idea because it would restrict
> > the use of inline encryption to filesystems that allow IV_INO_LBLK_64 encryption
> > policies, i.e. filesystems that have stable inode numbers, 32-bit inodes, and
> > 32-bit file logical block numbers.
> > 
> > The on-disk format (i.e. the type of encryption policy chosen) and the
> > implementation (inline or filesystem-layer crypto) are really two separate
> > things.  This was one of the changes in v4 => v5 of this patchset; these two
> > things used to be conflated but now they are separate.  Now you can use inline
> > encryption with the existing fscrypt policies too.
> > 
> > We could use two separate SB_* flags, like SB_INLINE_CRYPT and
> > SB_IV_INO_LBLK_64_SUPPORT.
> 
> Yes, I think that is a good idea.
> 
> > However, the ->has_stable_inodes() and
> > ->get_ino_and_lblk_bits() methods are nice because they separate the filesystem
> > properties from the question of "is this encryption policy supported".
> > Declaring the filesystem properties is easier to do because it doesn't require
> > any fscrypt-specific knowledge.  Also, fs/crypto/ could use these properties in
> > different ways in the future, e.g. if another IV generation scheme is added.
> 
> I don't really like writing up method boilerplates for something that
> is a simple boolean flag.

fs/crypto/ uses ->has_stable_inodes() and ->get_ino_and_lblk_bits() to print an
appropriate error message.  If we changed it to a simple flag we'd have to print
a less useful error message.  Also, people are basically guaranteed to not
understand what "SB_IV_INO_LBLK_64_SUPPORT" means exactly, and are likely to
copy-and-paste it incorrectly when adding fscrypt support to a new filesystem.
Also it would make it more difficult to add other fscrypt IV generation schemes
in the future as we'd then need to add another sb flag (e.g. SB_IV_INO_LBLK_128)
and make filesystem-specific changes, rather than change fs/crypto/ only.

So personally I'd prefer to keep ->has_stable_inodes() and
->get_ino_and_lblk_bits() for now.

Replacing ->inline_crypt_enabled() with SB_INLINE_CRYPT makes much more sense
though.

- Eric

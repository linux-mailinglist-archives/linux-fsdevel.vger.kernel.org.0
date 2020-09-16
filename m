Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C2226CA56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 21:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgIPTyE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 15:54:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbgIPRgU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:36:20 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABEF4206A5;
        Wed, 16 Sep 2020 17:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600277764;
        bh=yfe0B96TjNHpcAsawqjrrf7+IjHmy67vaiqa85BWIAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I+hC2nQ+ZOPA571P2RhI3RjRHIeqnS8CFYsB1rjy8HQTS+a2VSX+648dcZXFLEPOB
         WDnTByDdKVTjchwSYR66xKed5nxfUPFjAZ0Qm1LU4C6e1Y7zgr/cuvQgnqM/OC4A1Y
         AtnlSxj8RyhCEw2Sq5daEBAdbWDe4O2SLXgVpGFg=
Date:   Wed, 16 Sep 2020 10:36:03 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>
Subject: Re: [RFC PATCH v3 12/16] ceph: add encrypted fname handling to
 ceph_mdsc_build_path
Message-ID: <20200916173603.GA4373@sol.localdomain>
References: <20200914191707.380444-1-jlayton@kernel.org>
 <20200914191707.380444-13-jlayton@kernel.org>
 <20200915014159.GK899@sol.localdomain>
 <bd9257732cfd98ee30ccc151125d21d6955d6f66.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd9257732cfd98ee30ccc151125d21d6955d6f66.camel@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 08:30:01AM -0400, Jeff Layton wrote:
> 
> It sounds like we'll probably need to stabilize some version of the
> nokey name so that we can allow the MDS to look them up. Would it be a
> problem for us to use the current version of the nokey name format for
> this, or would it be better to come up with some other distinct format
> for this?
> 

You could use the current version, with the dirhash field changed from u32 to
__le32 so that it doesn't depend on CPU endianness.  But you should also
consider using just base64(SHA256(filename)).  The SHA256(filename) approach
wouldn't include a dirhash, and it would handle short filenames less
efficiently.  However, it would be simpler.  Would it be any easier for you?

I'm not sure which would be better from a fs/crypto/ perspective.  For *now*, it
would be easier if you just used the current 'struct fscrypt_nokey_name'.
However, anything you use would be set in stone, whereas as-is the format can be
changed at any time.  In fact, we changed it recently; see commit edc440e3d27f.

If we happen to change the nokey name in the future for local filesystems (say,
to use BLAKE2 instead of SHA256, or to support longer dirhashes), then it would
be easier if the stable format were just SHA256(filename).

It's not a huge deal though.  So if e.g. you like that the current format avoids
the cryptographic hash for the vast majority of filenames, and if you're fine
with the slightly increased complexity, you can just use it.

- Eric

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7AF126AEC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 22:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgIOUk4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 16:40:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgIOUkU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 16:40:20 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81E9520809;
        Tue, 15 Sep 2020 20:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600202419;
        bh=d553kZG/1vudXy0iP1IIbGFXaqNIwSNExaxRlyADW6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EPBZUH/CvWumB4sfHfjZ50blj9267iBKZOa91or0upWdtbYSsAhtV8iH1VKOVMolI
         ywW4U7/bQ5Vd0ETq6EGBc/0Jfc29ov7W+LAlNMP2VZ0C6/MKTqrDDxKjejCi4ZFJKE
         T2oSOvSC5ZsbXF+MAe7lyRkHIW5mbPBZkQaP3CBY=
Date:   Tue, 15 Sep 2020 13:40:18 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v3 14/16] ceph: add support to readdir for encrypted
 filenames
Message-ID: <20200915204018.GA3999121@gmail.com>
References: <20200914191707.380444-1-jlayton@kernel.org>
 <20200914191707.380444-15-jlayton@kernel.org>
 <20200915015719.GL899@sol.localdomain>
 <bf448095f9d675bad3adb0ddc2d7652625824bc6.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf448095f9d675bad3adb0ddc2d7652625824bc6.camel@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15, 2020 at 09:27:49AM -0400, Jeff Layton wrote:
> > > +	}
> > > +
> > > +	declen = fscrypt_base64_decode(name, len, tname->name);
> > > +	if (declen < 0 || declen > NAME_MAX) {
> > > +		ret = -EIO;
> > > +		goto out;
> > > +	}
> > 
> > declen <= 0, to cover the empty name case.
> > 
> > Also, is there a point in checking for > NAME_MAX?
> > 
> 
> IDK. We're getting these strings from the MDS and they could end up
> being corrupt if there are bugs there (or if the MDS is compromised). 
> Of course, if we get a name longer than NAME_MAX then we've overrun the
> buffer.
> 
> Maybe we should add a maxlen parameter to fscrypt_base64_encode/decode ?
> Or maybe I should just have fscrypt_fname_alloc_buffer allocate a buffer
> the same size as "len"? It might be a little larger than necessary, but
> that would be safer.

How about checking that the base64-encoded filename is <= BASE64_CHARS(NAME_MAX)
in length?  Then decoding it can't give more than NAME_MAX bytes.

fscrypt_setup_filename() does a similar check when decoding a no-key name.

- Eric

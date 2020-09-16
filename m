Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB09426C931
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 21:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgIPRrw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 13:47:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbgIPRqW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:46:22 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75E2720872;
        Wed, 16 Sep 2020 12:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600258569;
        bh=YwjrKFeCizHh1E75zdoKPRol7rdCFhBLd+n6EntX4lI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FwF973/bGsjwAIRYwZ8MTf9VW4AXnViN3IzTm6htJ5hx4QQ6WGUPbInOY5+9thJ6H
         6eHZctedvKR0eMs6oQijn9pR+WUGT90ACi9iXNCvKHyNUK+4m4ZnXjsQLxX8kESQkC
         MHfYdGTqEpx82TcSavPRUzvUhvL3E67NiSsSfq8Q=
Message-ID: <39809abc369f810c9b227f50ae34a33b51a51f01.camel@kernel.org>
Subject: Re: [RFC PATCH v3 14/16] ceph: add support to readdir for encrypted
 filenames
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Wed, 16 Sep 2020 08:16:08 -0400
In-Reply-To: <20200915204018.GA3999121@gmail.com>
References: <20200914191707.380444-1-jlayton@kernel.org>
         <20200914191707.380444-15-jlayton@kernel.org>
         <20200915015719.GL899@sol.localdomain>
         <bf448095f9d675bad3adb0ddc2d7652625824bc6.camel@kernel.org>
         <20200915204018.GA3999121@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-09-15 at 13:40 -0700, Eric Biggers wrote:
> On Tue, Sep 15, 2020 at 09:27:49AM -0400, Jeff Layton wrote:
> > > > +	}
> > > > +
> > > > +	declen = fscrypt_base64_decode(name, len, tname->name);
> > > > +	if (declen < 0 || declen > NAME_MAX) {
> > > > +		ret = -EIO;
> > > > +		goto out;
> > > > +	}
> > > 
> > > declen <= 0, to cover the empty name case.
> > > 
> > > Also, is there a point in checking for > NAME_MAX?
> > > 
> > 
> > IDK. We're getting these strings from the MDS and they could end up
> > being corrupt if there are bugs there (or if the MDS is compromised). 
> > Of course, if we get a name longer than NAME_MAX then we've overrun the
> > buffer.
> > 
> > Maybe we should add a maxlen parameter to fscrypt_base64_encode/decode ?
> > Or maybe I should just have fscrypt_fname_alloc_buffer allocate a buffer
> > the same size as "len"? It might be a little larger than necessary, but
> > that would be safer.
> 
> How about checking that the base64-encoded filename is <= BASE64_CHARS(NAME_MAX)
> in length?  Then decoding it can't give more than NAME_MAX bytes.
> 
> fscrypt_setup_filename() does a similar check when decoding a no-key name.
> 

Good idea. I'll roll that in.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>


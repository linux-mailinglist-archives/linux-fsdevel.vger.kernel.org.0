Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8F026AEE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 22:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgIOUuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 16:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727974AbgIOUt4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 16:49:56 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D4B920771;
        Tue, 15 Sep 2020 20:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600202995;
        bh=iOn4nfisBiDXFMfR1MeN89veRDfMLvU7cH8cDv24Wws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w5+zX+x3R4WxcRBJWX7FalNLdylB1bF4SvsMMVd4N6j1lXt8niUAh242BdbFIcPZ4
         wPuhtDMlW0i46znG73sAVOMG6DHSNEW1/vjVQQaIjjtBob5xJK7DTS8pngisK/orWH
         QFLd4MyRPqLn8O8lkYrvktsGmfbXDSGkL9bb3QzE=
Date:   Tue, 15 Sep 2020 13:49:53 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v3 16/16] ceph: create symlinks with encrypted and
 base64-encoded targets
Message-ID: <20200915204953.GB3999121@gmail.com>
References: <20200914191707.380444-1-jlayton@kernel.org>
 <20200914191707.380444-17-jlayton@kernel.org>
 <20200915020725.GM899@sol.localdomain>
 <5bdc7608df4ff480c07eb6a0e85514ebd986e5d9.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bdc7608df4ff480c07eb6a0e85514ebd986e5d9.camel@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15, 2020 at 10:05:53AM -0400, Jeff Layton wrote:
> > > +static const char *ceph_encrypted_get_link(struct dentry *dentry, struct inode *inode,
> > > +					   struct delayed_call *done)
> > > +{
> > > +	struct ceph_inode_info *ci = ceph_inode(inode);
> > > +
> > > +	if (!dentry)
> > > +		return ERR_PTR(-ECHILD);
> > > +
> > > +	return fscrypt_get_symlink(inode, ci->i_symlink, ksize(ci->i_symlink), done);
> > 
> > Using ksize() seems wrong here, since that would allow fscrypt_get_symlink() to
> > read beyond the part of the buffer that is actually initialized.
> > 
> 
> Is that actually a problem? I did have an earlier patch that carried
> around the length, but it didn't seem to be necessary.
> 
> ISTM that that might end up decrypting more data than is actually
> needed, but eventually there will be a NULL terminator in the data and
> the rest would be ignored.
> 

Yes it's a problem.  The code that decrypts the symlink adds the null terminator
at the end.  So if the stated buffer size is wrong, then decrypted uninitialized
memory can be included into the symlink target that userspace then sees.

> If it is a problem, then we should probably change the comment header
> over fscrypt_get_symlink. It currently says:
> 
>    * @max_size: size of @caddr buffer
> 
> ...which is another reason why I figured using ksize there was OK.

ksize() is rarely used, as it should be.  (For one, it disables KASAN on the
buffer...)  I think that when people see "buffer size" they almost always think
the actual allocated size of the buffer, not ksize().  But we could change it to
say "allocated size" if that would make it clearer...

- Eric

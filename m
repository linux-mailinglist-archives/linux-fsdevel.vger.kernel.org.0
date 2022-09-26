Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8654C5E9C18
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 10:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbiIZIcr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 04:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbiIZIco (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:32:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365B03AB17
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 01:32:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BAF12B80C92
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 08:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123A0C433D6;
        Mon, 26 Sep 2022 08:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664181160;
        bh=jIb9wQoVjonBrNAO/VRrXJBHSt5Gq3YRsHXRAtqMA7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d1wBOw4jkugTY9bFITNl/wHRZ9x/oYDdVHuVlAW/XiKpEbZIxsBZYcArQ0gOLC8JI
         bVnX199eONCbbKYKf2e5tHz2xHA7VMHSB3NK0w+gj7Dcye8EbWTG8twIrWaaweLqD/
         Gci1TxvT546h1dMmn0FRh9yBtHpv0tk6u/yPXryvI4ia2c5Jx1sL8+Ax4lH0VyD0zu
         1ctVHMBfZ/G1f1QrO3X3UHg7cv6mCJIUpBMVLnob/J4PxZyYwLtHY1UTOIB5jV8JLW
         7DP7rZ2TWM0YqjLRQZjDFV7zzU3zR0EjpztIMdk3TN869/LSVYGHxdFOzhant8rEIN
         pYoGmfK2b+kmA==
Date:   Mon, 26 Sep 2022 10:32:34 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH 06/29] 9p: implement get acl method
Message-ID: <20220926083234.diqk6cicudk5snn5@wittgenstein>
References: <20220922151728.1557914-1-brauner@kernel.org>
 <20220922151728.1557914-7-brauner@kernel.org>
 <Yy9E4T0HT6hEmpoZ@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yy9E4T0HT6hEmpoZ@ZenIV>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 24, 2022 at 06:56:49PM +0100, Al Viro wrote:
> On Thu, Sep 22, 2022 at 05:17:04PM +0200, Christian Brauner wrote:
> 
> > -static struct posix_acl *__v9fs_get_acl(struct p9_fid *fid, char *name)
> > +static int v9fs_fid_get_acl(struct p9_fid *fid, const char *name,
> > +			    struct posix_acl **kacl)
> >  {
> >  	ssize_t size;
> >  	void *value = NULL;
> >  	struct posix_acl *acl = NULL;
> >  
> >  	size = v9fs_fid_xattr_get(fid, name, NULL, 0);
> > -	if (size > 0) {
> > -		value = kzalloc(size, GFP_NOFS);
> > -		if (!value)
> > -			return ERR_PTR(-ENOMEM);
> > -		size = v9fs_fid_xattr_get(fid, name, value, size);
> > -		if (size > 0) {
> > -			acl = posix_acl_from_xattr(&init_user_ns, value, size);
> > -			if (IS_ERR(acl))
> > -				goto err_out;
> > -		}
> > -	} else if (size == -ENODATA || size == 0 ||
> > -		   size == -ENOSYS || size == -EOPNOTSUPP) {
> > -		acl = NULL;
> > -	} else
> > -		acl = ERR_PTR(-EIO);
> > +	if (size <= 0)
> > +		goto out;
> >  
> > -err_out:
> > +	/* just return the size */
> > +	if (!kacl)
> > +		goto out;
> 
> How can that happen?  Both callers are passing addresses of local variables
> as the third argument.  And what's the point of that kacl thing, anyway?
> Same callers would be much happier if you returned acl or ERR_PTR()...

Yeah, my bad. I had an initial draft just to get something to test where
I returned it through an return argument instead of the function. Seems
I missed to fix that spot. Thanks, fixed and also massaged the callers a bit.

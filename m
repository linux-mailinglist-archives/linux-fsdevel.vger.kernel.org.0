Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CD55E9BCD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 10:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbiIZIRN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 04:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbiIZIQy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:16:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB5D3341E
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 01:16:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E365B618F4
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 08:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36ADEC433D7;
        Mon, 26 Sep 2022 08:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664180203;
        bh=U5p2p/d04U35saRpnmqWtX0yXHd6h87V9OhIvL+IXHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fcbcY689za0EdbcEnEbR9RXAxvNLjdnNN9quEnyCOjR3ILejT+A1CR8/Sb9aWFDBD
         U6gP1gupty3nb4mOj8BlwXmaIF2TWgn7rX4D4ztXvUzWzrZWnDglBb8nVhLsyatUD4
         iVWJKduaiU/AOFiGGBBswq3T4NYNBGGrJuvQN47JJmPdp6I636sOAw6dg5G7QyL73B
         /M9nwOptpR1+zPDYo4TD5cGwnjHFkdh6n4gOnpcPFBgZtt4f9uC2Dv5ZM3sMKHX8JQ
         l1tQQGgZycM9t81XCG6hh13KWLZ/m7lBP74gqVf2NUNHc8JMXw9DiMyApCc0tS67V8
         CPQPcQ3gXzAhg==
Date:   Mon, 26 Sep 2022 10:16:38 +0200
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
Message-ID: <20220926081638.qejv7w4udimbg32d@wittgenstein>
References: <20220922151728.1557914-1-brauner@kernel.org>
 <20220922151728.1557914-7-brauner@kernel.org>
 <Yy9I4GQEgH1cj/ke@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yy9I4GQEgH1cj/ke@ZenIV>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 24, 2022 at 07:13:52PM +0100, Al Viro wrote:
> On Thu, Sep 22, 2022 at 05:17:04PM +0200, Christian Brauner wrote:
> > +	struct v9fs_session_info *v9ses;
> > +	struct posix_acl *acl = NULL;
> > +
> > +	v9ses = v9fs_dentry2v9ses(dentry);
> > +	/* We allow set/get/list of acl when access=client is not specified. */
> > +	if ((v9ses->flags & V9FS_ACCESS_MASK) != V9FS_ACCESS_CLIENT)
> > +		acl = v9fs_acl_get(dentry, posix_acl_xattr_name(type));
> > +	else
> > +		acl = v9fs_get_cached_acl(d_inode(dentry), type);
> > +	if (IS_ERR(acl))
> > +		return acl;
> > +
> > +	return acl;
> 
> *blink*
> 	1.  Set acl to NULL, just in case.
> 	2.  Set acl to either one expression or another
> 	3.  If acl is an ERR_PTR(something), return acl
> 	4.  buggrit, return acl anyway.

A little less elegant than I would've liked it to be. Thanks, I fixed that.

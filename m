Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42805E8F2A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Sep 2022 20:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiIXSN5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Sep 2022 14:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiIXSNz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Sep 2022 14:13:55 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14DF6AE9D
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Sep 2022 11:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JCjOC+kJyI3LoFk1HZucLeLgATg1WlshxOETKBbIdAU=; b=XviR4iWx60orBCR2ELvAaXZ7AM
        XiUodkRXKNvjaZmZpU1eTPEG0673m6uUO9JXV6zivLmgPJPex1Zixn4rV/S5Qjwn/CXS/sWTItCOq
        4yS6CR/cWFM7z2/NsEnlImYbZ7ATjSWsBwAS7M9U0s+HHnoKZBn9u/ovcgpIde9i11ysFOrkwHzlB
        RuO2vlmeiuwUABNlR3hauHR5mywxSzpmkySZYoRAE/ZhnyAUjeQo+oV2AT7wtpE7hF/rjnRtRvnRV
        g1XeMGVMbxT4T4SaLoMsEjLnw9VmmYPMawGW4p5JvfNRaynFJtvR4IC72Q1usQ7k16DC8p3xSWpMu
        8CUz6ApQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oc9ey-003OpL-2Q;
        Sat, 24 Sep 2022 18:13:52 +0000
Date:   Sat, 24 Sep 2022 19:13:52 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH 06/29] 9p: implement get acl method
Message-ID: <Yy9I4GQEgH1cj/ke@ZenIV>
References: <20220922151728.1557914-1-brauner@kernel.org>
 <20220922151728.1557914-7-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922151728.1557914-7-brauner@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 22, 2022 at 05:17:04PM +0200, Christian Brauner wrote:
> +	struct v9fs_session_info *v9ses;
> +	struct posix_acl *acl = NULL;
> +
> +	v9ses = v9fs_dentry2v9ses(dentry);
> +	/* We allow set/get/list of acl when access=client is not specified. */
> +	if ((v9ses->flags & V9FS_ACCESS_MASK) != V9FS_ACCESS_CLIENT)
> +		acl = v9fs_acl_get(dentry, posix_acl_xattr_name(type));
> +	else
> +		acl = v9fs_get_cached_acl(d_inode(dentry), type);
> +	if (IS_ERR(acl))
> +		return acl;
> +
> +	return acl;

*blink*
	1.  Set acl to NULL, just in case.
	2.  Set acl to either one expression or another
	3.  If acl is an ERR_PTR(something), return acl
	4.  buggrit, return acl anyway.

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8895EF05F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 10:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbiI2I0M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 04:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbiI2I0C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:26:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAF86EF2B;
        Thu, 29 Sep 2022 01:26:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1875162077;
        Thu, 29 Sep 2022 08:26:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EC5C433D6;
        Thu, 29 Sep 2022 08:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664439959;
        bh=ZGTcZaZidzwnb+P5lXnjE44J9zl+dgJ+T6Toyp6G8z0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gL2THj/D4HENX7TDZHJ+qgxHg6/hIVyzBE2OhRzp3xQqa7aaE32AvgCsU0pgWrYCx
         7tiXDDyNtGwrdDqEWVtErsbkh7Sw7dl3Atn/W3hcnbvYOekFAgu0xvBFcGbWfr6SCI
         7COCme+wtcMuauLi37ZP+fh3usBiyNA9SE86LzOKOW3v8US+KY/17VvVMe9F4tVu0y
         s+aJglqAlNDLXXap7BeHgWkMOIHQ0cLhxmie0fapJKcd07h9Pfz+K9aarszpTDjDwU
         VVc47co0SKitcEqyD8YDLrvFU+1dbktT75HVJPacuMNSXn7F9yXZv9b7Q5R0E5cFuG
         pwjYi2OO2pdJw==
Date:   Thu, 29 Sep 2022 10:25:54 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 14/29] acl: add vfs_set_acl()
Message-ID: <20220929082554.5rclj4ioo37qg254@wittgenstein>
References: <20220928160843.382601-1-brauner@kernel.org>
 <20220928160843.382601-15-brauner@kernel.org>
 <20220929081727.GB3699@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220929081727.GB3699@lst.de>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022 at 10:17:27AM +0200, Christoph Hellwig wrote:
> > +EXPORT_SYMBOL(vfs_set_acl);
> 
> I think all this stackable file system infrastucture should be
> EXPORT_SYMBOL_GPL, like a lot of the other internal stuff.

Ok, sounds good.

> 
> > +int xattr_permission(struct user_namespace *mnt_userns, struct inode *inode,
> > +		     const char *name, int mask)
> 
> Hmm.  The only think ACLs actually need from xattr_permission are
> the immutable / append check and the HAS_UNMAPPED_ID one.  I'd rather
> open code that, or if you cane come up with a sane name do a smaller
> helper rather than doing all the strcmp on the prefixes for now
> good reason.

I'll see if a little helper makes more sense than open-coding.

> 
> > +static inline int vfs_set_acl(struct user_namespace *mnt_userns,
> > +			      struct dentry *dentry, const char *name,
> > +			      struct posix_acl *acl)
> > +{
> > +	return 0;
> 
> Should this really return 0 if ACLs are not supported?

Yeah, we should probably -EOPNOTSUPP for all of:
vfs_{get,set,remove}_acl() in this case. Good point, thanks!

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17EE5BEED3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 22:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiITU5w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 16:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiITU5v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 16:57:51 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA0E69F77
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 13:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Pf9qR9Fe1+cPN5qIheDeTvqG7MgEj2UlIczNsOrn/uY=; b=IrQIFXsiLedu67d5LIrISLKNix
        4irBDsTBIN7K/NizqRg5YFqBubPMgmGBdbDBld3FsVW4FfsZaxuy1un3hkKVWTwxxao+cPW3YNvkt
        3mpo/adJMbC/z7nXswwsE1+kTTbs0Gpn/KJuh9sqEvkqBdlppznaOYwO/PIrOk5q8cwQN65jg2g/+
        fhgyuIkn9ad65bUfNiryeE0C7vPbplUrDYmAtRSbyivwSamEWFrv2/vquETvKpFKPk6hDnttVmAKk
        1oj8O512vfzJPQmdSRFB0HqZUSNizD6kzp4q8kQP0w+vh63cNwsu62L0QYi1idanRTC/jwjc3hQo6
        DPhZ+nww==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oakJP-001tZY-1U;
        Tue, 20 Sep 2022 20:57:47 +0000
Date:   Tue, 20 Sep 2022 21:57:47 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [PATCH v3 7/9] vfs: move open right after ->tmpfile()
Message-ID: <YyopS+KNN49oz2vB@ZenIV>
References: <20220920193632.2215598-1-mszeredi@redhat.com>
 <20220920193632.2215598-8-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920193632.2215598-8-mszeredi@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 20, 2022 at 09:36:30PM +0200, Miklos Szeredi wrote:

>  	inode = child->d_inode;

Better
	inode = file_inode(file);

so that child would be completely ignored after dput().

> +	error = vfs_tmpfile(mnt_userns, &path, file, op->mode);
> +	if (error)
>  		goto out2;
> -	dput(path.dentry);
> -	path.dentry = child;
> -	audit_inode(nd->name, child, 0);
> +	audit_inode(nd->name, file->f_path.dentry, 0);
>  	/* Don't check for other permissions, the inode was just created */
> -	error = may_open(mnt_userns, &path, 0, op->open_flag);

Umm...  I'm not sure that losing it is the right thing - it might
be argued that ->permission(..., MAY_OPEN) is to be ignored for
tmpfile (and the only thing checking for MAY_OPEN is nfs, which is
*not* going to grow tmpfile any time soon - certainly not with these
calling conventions), but you are also dropping the call of
security_inode_permission(inode, MAY_OPEN) and that's a change
compared to what LSM crowd used to get...

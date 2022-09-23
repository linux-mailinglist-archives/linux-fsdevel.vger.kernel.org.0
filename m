Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF8E5E75E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 10:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiIWIiT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 04:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiIWIiS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:38:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B051166F9;
        Fri, 23 Sep 2022 01:38:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D70961760;
        Fri, 23 Sep 2022 08:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0EC4C433D6;
        Fri, 23 Sep 2022 08:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663922296;
        bh=M8Ka5P9rFWMx/O/TJxBboZRCB7Mp5Vz0LaZwdoz5uw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hMhQ37S0igkC+6D/o9a6VmWtcdzSofgz2HMTaQueuFMm8SLMjvz1h5Gzn3+5Il+im
         pjnU2f5cBbm3l8LzPgRtAJbln5/rxtBd6I0g+B6Yz0eoltehiRdbgEvyNEH6KdSNiu
         DEyppo52LeJpzZwRAJ8+YoXChuXid+6+zQvauEH465E25G/3Mw0xy4lZQx0zape9GB
         I/Od/Db2HkGAP+dF3H/grZviFbRkVIKXZUjvaZEb6r4MugJ9POSodjzWrhFdMEh0wF
         c6X2zYcecS/DaYqFq4GOdcBdjXQZnpG9sP4E4ZTAHjMuMUxqSK9davYF7enKhIX2+Y
         eqO/jO9qWMJgw==
Date:   Fri, 23 Sep 2022 10:38:10 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Steve French <smfrench@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Hyunchul Lee <hyc.lee@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-cifs@vger.kernel.org
Subject: Re: [PATCH 04/29] cifs: implement get acl method
Message-ID: <20220923083810.ff7jfaszl7qhoutd@wittgenstein>
References: <20220922151728.1557914-1-brauner@kernel.org>
 <20220922151728.1557914-5-brauner@kernel.org>
 <CAH2r5mvkSW1FY2tP87mKGrOMkoN8tbOP9r=xJ4XnVbkcrE9guA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH2r5mvkSW1FY2tP87mKGrOMkoN8tbOP9r=xJ4XnVbkcrE9guA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 22, 2022 at 10:52:43PM -0500, Steve French wrote:
> Looks like the SMB1 Protocol operations for get/set posix ACL were
> removed in the companion patch (in SMB3, POSIX ACLs have to be handled

Sorry, what companion patch? Is a patch in this series or are you
referring to something else?

> by mapping from rich acls).  Was this intentional or did I miss
> something? I didn't see the functions for sending these over the wire
> for SMB1 (which does support POSIX ACLs, not just RichACLs (SMB/NTFS
> ACLs))

I'm sorry, I don't understand. This is basically a 1:1 port of what you
currently have in cifs_xattr_set() and cifs_xattr_get() under the
XATTR_ACL_DEFAULT and XATTR_ACL_ACCESS switches. So basically, the
patches in this series just add almost 1:1 copies of
CIFSSMBSetPosixACL() and CIFSSMBGetPosixACL() just that instead of
operating on void * they operate on a proper vfs struct posix acl. So
nothing would've changed behavior wise. Ofc, there's always the chance
that I missed sm especially bc I'm not a cifs developer. :)

> 
>         pSMB->SubCommand = cpu_to_le16(TRANS2_SET_PATH_INFORMATION);
>         pSMB->InformationLevel = cpu_to_le16(SMB_SET_POSIX_ACL);

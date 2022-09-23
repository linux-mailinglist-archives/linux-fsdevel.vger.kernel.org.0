Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6285E7FA2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 18:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbiIWQX2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 12:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiIWQX1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:23:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67C7113B66;
        Fri, 23 Sep 2022 09:23:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DB48B80FEF;
        Fri, 23 Sep 2022 16:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21267C433D7;
        Fri, 23 Sep 2022 16:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663950202;
        bh=CD0rNvsWFge93dq5vbuhhjn4Di5DBI42DFl0RcYObuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kGjkhWc7qOXCRFrdfalK/b3JIObcW2PznGAgAbJPDl4not+/7HAYMOkNJ5Px95UQc
         nd9QdKKbt9C+FjC6VFgc483piWtq7smgsBb1kcoHcEPDAU88oxvuXfR7872fqpHjGT
         iPZNQf8JA9qy2BUjplgkM5K/vJOlOI6gZgRBccDKGOBCBOADg08BX+DxJXuLNZzJDn
         nFyOuVtKl6Lf8sJ38ptQ6BGna9SsrK7H1X0dSc9AGl8S2IKOmxAAKCw2z5AB8oxgQ6
         VolV25e98h4aBWvcXl0Hw7uWMFoxDKLZtvnl/WkN627q5Iz/lXLIMFPXR9ehIyihzw
         5gYBb44mnKpKw==
Date:   Fri, 23 Sep 2022 18:23:17 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 23/29] ovl: use posix acl api
Message-ID: <20220923162317.mvjlv6yzdsvjradl@wittgenstein>
References: <20220922151728.1557914-1-brauner@kernel.org>
 <20220922151728.1557914-24-brauner@kernel.org>
 <CAJfpegs092_0VkmfnyRP54_fJrssQbDxsh2Q754GLq34LZb0LQ@mail.gmail.com>
 <20220923154742.iplvc4nj5y6gaci4@wittgenstein>
 <CAJfpegt1YJzyE=UYF=DNW-qd08zLRgG7vpbm32m0rWEbWjLNOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegt1YJzyE=UYF=DNW-qd08zLRgG7vpbm32m0rWEbWjLNOw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 23, 2022 at 05:57:04PM +0200, Miklos Szeredi wrote:
> On Fri, 23 Sept 2022 at 17:47, Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Fri, Sep 23, 2022 at 05:38:34PM +0200, Miklos Szeredi wrote:
> 
> > It's basically just like when you copy a file betweed idmapped mounts:
> >
> > mount -o X-mount.idmap=<mapping1> --bind /source /source-idmapped
> > mount -o X-mount.idmap=<mapping2> --bind /target /target-idmapped
> >
> > cp /source-idmapped/file1 /target-idmapped
> >
> > where you need to take the source and target idmappings into account.
> >
> > So basically like what ovl_set_attr() is doing just for acls. But I
> 
> But then before this patch the copy-up behavior was incorrect, right?
> 
> In that case this needs to be advertised as a bug fix, rather than a cleanup.

No, it was correct. The testsuite I added would've yelled loudly if that
were buggy.

It's just that this was done in vfs_getxattr() before. But that is
rather hacky and is one of the things we're getting rid off. If
vfs_get_acl() did that it would return mount not filesystem values which
isn't correct for the general case.

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC856EF5BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Apr 2023 15:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241208AbjDZNrv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 09:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241217AbjDZNrt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:47:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CF12108;
        Wed, 26 Apr 2023 06:47:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55E7862C99;
        Wed, 26 Apr 2023 13:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EAFC433D2;
        Wed, 26 Apr 2023 13:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682516864;
        bh=BeQTHSgn73mgmnwOUhFvCFWNIQI7Fzt95A2oYI6JAVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hGIBv6jgEkOMCRHIO2QoFmdaFfllJS5HHYOEltqpcJDSiMJDYbfbdz0YoqhuieIit
         4MbhvwfQFB2AnICy+pWO4vP/JcvQRxovDM5V09Ee9HmXesFUoJ0DjwMsxyMZqPy9lZ
         3E1c/3Txqs0+trwliJIpplhKByGavEAgHpnA7iEFKPUiwfvZeNMdvjqCZdD7kUiCKZ
         L18+gOq7p+V2QmcNutl4pgiIsaIVfOks6rmgUUqqbb6f2zO15Y1cJtIEr6OQ/1CtIu
         hETi+o+0IuJKnx31EHUSeK1sQQDbsb8TGmgSnsefo247RF85bwA9Y6PFZWwZzIiNgm
         jQdMBe8wh4W1A==
Date:   Wed, 26 Apr 2023 09:47:41 -0400
From:   Chuck Lever <cel@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-nfs@vger.kernel.org,
        jlayton@kernel.org
Subject: Re: [RFC][PATCH 0/4] Prepare for supporting more filesystems with
 fanotify
Message-ID: <ZEkrfVEQ8EkmUcxK@manet.1015granger.net>
References: <20230425130105.2606684-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425130105.2606684-1-amir73il@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 25, 2023 at 04:01:01PM +0300, Amir Goldstein wrote:
> Jan,
> 
> Following up on the FAN_REPORT_ANY_FID proposal [1], here is a shot at an
> alternative proposal to seamlessly support more filesystems.
> 
> While fanotify relaxes the requirements for filesystems to support
> reporting fid to require only the ->encode_fh() operation, there are
> currently no new filesystems that meet the relaxed requirements.
> 
> I will shortly post patches that allow overlayfs to meet the new
> requirements with default overlay configurations.
> 
> The overlay and vfs/fanotify patch sets are completely independent.
> The are both available on my github branch [2] and there is a simple
> LTP test variant that tests reporting fid from overlayfs [3], which
> also demonstrates the minor UAPI change of name_to_handle_at(2) for
> requesting a non-decodeable file handle by userspace.
> 
> Thanks,
> Amir.
> 
> [1] https://lore.kernel.org/linux-fsdevel/20230417162721.ouzs33oh6mb7vtft@quack3/
> [2] https://github.com/amir73il/linux/commits/exportfs_encode_fid
> [3] https://github.com/amir73il/ltp/commits/exportfs_encode_fid
> 
> Amir Goldstein (4):
>   exportfs: change connectable argument to bit flags
>   exportfs: add explicit flag to request non-decodeable file handles
>   exportfs: allow exporting non-decodeable file handles to userspace
>   fanotify: support reporting non-decodeable file handles
> 
>  Documentation/filesystems/nfs/exporting.rst |  4 +--
>  fs/exportfs/expfs.c                         | 29 ++++++++++++++++++---
>  fs/fhandle.c                                | 20 ++++++++------
>  fs/nfsd/nfsfh.c                             |  5 ++--
>  fs/notify/fanotify/fanotify.c               |  4 +--
>  fs/notify/fanotify/fanotify_user.c          |  6 ++---
>  fs/notify/fdinfo.c                          |  2 +-
>  include/linux/exportfs.h                    | 18 ++++++++++---
>  include/uapi/linux/fcntl.h                  |  5 ++++
>  9 files changed, 67 insertions(+), 26 deletions(-)

Hello Amir-

Note that the maintainers of exportfs are Jeff and myself. Please
copy us on future versions of this patch series. Thanks!

[cel@klimt even-releases]$ scripts/get_maintainer.pl fs/exportfs/
Chuck Lever <chuck.lever@oracle.com> (supporter:KERNEL NFSD, SUNRPC, AND LOCKD SERVERS)
Jeff Layton <jlayton@kernel.org> (supporter:KERNEL NFSD, SUNRPC, AND LOCKD SERVERS)
linux-nfs@vger.kernel.org (open list:KERNEL NFSD, SUNRPC, AND LOCKD SERVERS)
linux-kernel@vger.kernel.org (open list)


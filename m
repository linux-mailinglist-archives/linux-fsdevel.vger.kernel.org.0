Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864CD6E2364
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 14:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjDNMhK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 08:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjDNMhJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:37:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F61C1;
        Fri, 14 Apr 2023 05:37:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB7A36479A;
        Fri, 14 Apr 2023 12:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E39EC433D2;
        Fri, 14 Apr 2023 12:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681475826;
        bh=Us7ISxYWs8GsQYX5eeazV9oM+moxkRyjegsjXO5avfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GSXLm5G25EGwept4abIZuTOjvtssoTBQoJWP7nHVxhG6yu2kjfVVHQueWb1oCGx9W
         Z9EMXtVTKEQA0MK/l6vjm9dMs0nsG1e50LpXoH2+LTIfMMZnagjitPOEIMfv9QJh5x
         Zbc2o/5KkTRjUP2PGetlbuWqL/aVJLsZg0K+LeVA7Ef0QU3i5p5avkFDGIm1rJ1FTu
         usjYBXA6ayJ4ED/wbTgsGoGxroSVXl+/KVmaJX65jB7CsLNaYLgifkJ90NReaxQ3i2
         QsY+Scajn4f1Z/ihtsK8F2GsfcH9m5htK2+N5TOj0Ev4poK+WsSw+9Uwq7RVyhYTRd
         3mKGi7jSVmuSg==
Date:   Fri, 14 Apr 2023 14:37:00 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Theodore Ts'o <tytso@mit.edu>,
        David Laight <David.Laight@ACULAB.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] Alter fcntl to handle int arguments correctly
Message-ID: <20230414-krumm-dekorativ-60ed7358b587@brauner>
References: <20230414100212.766118-1-Luca.Vizzarro@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230414100212.766118-1-Luca.Vizzarro@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 11:02:07AM +0100, Luca Vizzarro wrote:
> According to the documentation of fcntl, some commands take an int as
> argument. In practice not all of them enforce this behaviour, as they
> instead accept a more permissive long and in most cases not even a
> range check is performed.
> 
> An issue could possibly arise from a combination of the handling of the
> varargs in user space and the ABI rules of the target, which may result
> in the top bits of an int argument being non-zero.
> 
> This issue was originally raised and detailed in the following thread:
>   https://lore.kernel.org/linux-api/Y1%2FDS6uoWP7OSkmd@arm.com/
> 
> This series modifies the interested commands so that they explicitly
> take an int argument. It also propagates this change down to helper and
> related functions as necessary.
> 
> This series is also available on my fork at:
>   https://git.morello-project.org/Sevenarth/linux/-/commits/fcntl-int-handling
> 
> Best regards,
> Luca Vizzarro
> 
> Luca Vizzarro (5):
>   fcntl: Cast commands with int args explicitly
>   fs: Pass argument to fcntl_setlease as int
>   pipe: Pass argument of pipe_fcntl as int
>   memfd: Pass argument of memfd_fcntl as int
>   dnotify: Pass argument of fcntl_dirnotify as int
> 
>  fs/cifs/cifsfs.c            |  2 +-
>  fs/fcntl.c                  | 29 +++++++++++++++--------------
>  fs/libfs.c                  |  2 +-
>  fs/locks.c                  | 20 ++++++++++----------
>  fs/nfs/nfs4_fs.h            |  2 +-
>  fs/nfs/nfs4file.c           |  2 +-
>  fs/nfs/nfs4proc.c           |  4 ++--
>  fs/notify/dnotify/dnotify.c |  4 ++--
>  fs/pipe.c                   |  6 +++---
>  include/linux/dnotify.h     |  4 ++--
>  include/linux/filelock.h    | 12 ++++++------
>  include/linux/fs.h          |  6 +++---
>  include/linux/memfd.h       |  4 ++--
>  include/linux/pipe_fs_i.h   |  4 ++--
>  mm/memfd.c                  |  6 +-----
>  15 files changed, 52 insertions(+), 55 deletions(-)
> 
> --
> 2.34.1
> 
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

Fyi, this blurb at the end breaks applying this series.

It means when someone pulls these patches down they get corrupted git
patches. You should fix your setup to not have this nonsense in your
mails. I tried to apply this for review to v6.2 up until v6.3-mainline
until I realized that the patches are corrupted by the blurb at the
end...

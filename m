Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A7A3DEFC4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 16:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236517AbhHCOJA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 10:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236432AbhHCOJA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:09:00 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA79C061757;
        Tue,  3 Aug 2021 07:08:49 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id D03856855; Tue,  3 Aug 2021 10:08:46 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org D03856855
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1627999726;
        bh=6y1stnT7LmaJlptQnLDx23qQWH50FVnQt9YPvUgp8TU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WuhuvtS7gTovhY+upvMJtuP/kxXSDck/bfNAXucQT9EVBoU6y4KvyXnyVYeXYR2/X
         T7+vsGVEDf6ib/5eapurYxojIDJErRdDxmrAdBVtBeZhVmN7GBTe1Cejpj0jw+/MJa
         DuFSMZsktFBRSq64EXj1x6N8UvX6PnYSpVnIcToY=
Date:   Tue, 3 Aug 2021 10:08:46 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Thomas Huth <thuth@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, linux-s390@vger.kernel.org,
        Jia He <hejianet@gmail.com>,
        Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/2] Fix /proc/sys/fs/nfs/nsm_use_hostnames on big endian
 machines
Message-ID: <20210803140846.GB30327@fieldses.org>
References: <20210803105937.52052-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803105937.52052-1-thuth@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good to me.  Could Chuck take it with nfsd stuff if somebody could
ACK the sysctl part?

--b.

On Tue, Aug 03, 2021 at 12:59:35PM +0200, Thomas Huth wrote:
> There is an endianess problem with /proc/sys/fs/nfs/nsm_use_hostnames
> (which can e.g. be seen on an s390x host) :
> 
>  # modprobe lockd nsm_use_hostnames=1
>  # cat /proc/sys/fs/nfs/nsm_use_hostnames
>  16777216
> 
> The nsm_use_hostnames variable is declared as "bool" which is required
> for the correct type for the module parameter. However, this does not
> work correctly with the entry in the /proc filesystem since this
> currently requires "int".
> 
> Jia He already provided patches for this problem a couple of years ago,
> but apparently they felt through the cracks and never got merged. So
> here's a rebased version to finally fix this issue.
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1764075
> 
> Jia He (2):
>   sysctl: introduce new proc handler proc_dobool
>   lockd: change the proc_handler for nsm_use_hostnames
> 
>  fs/lockd/svc.c         |  2 +-
>  include/linux/sysctl.h |  2 ++
>  kernel/sysctl.c        | 42 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+), 1 deletion(-)
> 
> -- 
> 2.27.0

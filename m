Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9ADA36DF63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 21:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240538AbhD1TON (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 15:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbhD1TOM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 15:14:12 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEEAC061573;
        Wed, 28 Apr 2021 12:13:26 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id D98DB3723; Wed, 28 Apr 2021 15:13:25 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org D98DB3723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1619637205;
        bh=dK+/Sk39NdF6I9xPBcXsj2vaM5G7nrMH39n1B8fuYT4=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=LBqrNQ83RGiejWRj6Q7+3Ddq0L/cSPz7wTGgAoRbWiYL93w7TY0HmgResWNnyCu46
         emtghxopIrGSnrJ0BkMF/8orD8xshNW2h7lF9gq6PyIFbQqLHdqiDjNvFcT0TpDQmT
         nSCPbghhv4dXAIhwGNR3qglEpBGmRt5N35t8a2T0=
Date:   Wed, 28 Apr 2021 15:13:25 -0400
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        smfrench@gmail.com, senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        aaptel@suse.com, sandeen@sandeen.net, dan.carpenter@oracle.com,
        colin.king@canonical.com, rdunlap@infradead.org,
        willy@infradead.org
Subject: Re: [PATCH v2 00/10] cifsd: introduce new SMB3 kernel server
Message-ID: <20210428191325.GA7400@fieldses.org>
References: <CGME20210422003835epcas1p246c40c6a6bbc0e9f5d4ccf9b69bef0d7@epcas1p2.samsung.com>
 <20210422002824.12677-1-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422002824.12677-1-namjae.jeon@samsung.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 22, 2021 at 09:28:14AM +0900, Namjae Jeon wrote:
> ACLs                           Partially Supported. only DACLs available, SACLs
>                                (auditing) is planned for the future. For
>                                ownership (SIDs) ksmbd generates random subauth
>                                values(then store it to disk) and use uid/gid
>                                get from inode as RID for local domain SID.
>                                The current acl implementation is limited to
>                                standalone server, not a domain member.
>                                Integration with Samba tools is being worked on to
>                                allow future support for running as a domain member.

How exactly is this implementing ACLs?  I grepped through the code a bit
and couldn't quite figure it out--it looked like maybe it's both
converting to a POSIX ACL and storing the full SBM ACL in an xattr, is
that correct?  When you read an ACL, and both are present, which do you
use?

Also it looked like there's some code from fs/nfsd/nfs4acl.c, could we
share that somehow instead of copying?

--b.

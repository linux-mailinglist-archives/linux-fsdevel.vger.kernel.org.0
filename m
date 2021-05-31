Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F2F396751
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 May 2021 19:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbhEaRp5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 May 2021 13:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbhEaRpo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 May 2021 13:45:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4D9C06129E
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 May 2021 10:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hhjNHtVotsrkCPgVTalYOAJUNqMIrZxU+HqjLpfTXkk=; b=EaiRQfavcMyCeRQ7c+8BCxLfB5
        k32YJySHXy3bYKmuUwvh67a+j5E0j2o92UJ49QokxJ3AnKu6vXS/wmVJchTaJauKFl0autTkw4CZO
        3UXSy2wGFJ5GwBm0H2/pkBWf5E+HsKTeE3Lfh6EQcnHut6+TIR03dLRqQMB9+hGOdJjnKeqrKt8XG
        iAZpwY3wXZTk3Eo9UI1uMEwS9UFC9uhwVmPR2vuLPrwjfVssxn1Ir7MfVY5W9PmlnENGxDN+LnOSF
        xr/l2eiRshfvIv6rQKhYdgc+EePPLFOF7ftLJjIC1sdsdCv8h0rqBcpZXgzmheEc0PhOivhbuxB2w
        rHc1MLew==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lnlNc-009FBO-2M; Mon, 31 May 2021 17:07:12 +0000
Date:   Mon, 31 May 2021 18:07:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     tianyu zhou <tyjoe.linux@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Missing check for CAP_SYS_ADMIN in do_reconfigure_mnt()
Message-ID: <YLUXvOI433/W8EvD@casper.infradead.org>
References: <CAM6ytZrBUMB6xpP_srni8VParnNiuFPZZ2H-WsWUJEZH_vSk1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM6ytZrBUMB6xpP_srni8VParnNiuFPZZ2H-WsWUJEZH_vSk1w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 31, 2021 at 10:59:54PM +0800, tianyu zhou wrote:
> Hi, function do_remount() in fs/namespace.c checks the CAP_SYS_ADMIN
> before it calls set_mount_attributes().
> 
> However, in another caller of set_mount_attributes(),
> do_reconfigure_mnt(), I have not found any check for CAP_SYS_ADMIN.
> So, is there a missing check bug inside do_reconfigure_mnt() ? (which
> makes it possible for normal user to reach set_mount_attributes())

You weren't looking hard enough ...

path_mount()
        if (!may_mount())
                return -EPERM;
...
        if ((flags & (MS_REMOUNT | MS_BIND)) == (MS_REMOUNT | MS_BIND))
                return do_reconfigure_mnt(path, mnt_flags);

(this is the only call to do_reconfigure_mnt())

and:

static inline bool may_mount(void)
{
        return ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN);
}


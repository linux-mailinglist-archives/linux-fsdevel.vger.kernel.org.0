Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAA440FEA5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 19:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344100AbhIQRaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 13:30:23 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60658 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbhIQRaW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 13:30:22 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3B3501FF6E;
        Fri, 17 Sep 2021 17:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631899739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rmT5s0ZIASojQz5Dpz34eZ0EtRJc756ScfCxuvg+I9w=;
        b=nJ6FLBUA73ozuG4UevY4HKy5btbpDi/FkXCilpowyOoZrTGQqvI91XT2ZG8QtcCMLxdpFV
        Qwq1mSfE28sIDMe78Fd9K+ztznY7QlOycZMAEGI1vu/rQyYYmlo2Ej4IyvC5Z+43TMoRgV
        eXzrPKcWoHGqsxMj1f3ce+Wq3BJlcB8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F6E613C4B;
        Fri, 17 Sep 2021 17:28:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9xkwB1vQRGH8agAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 17 Sep 2021 17:28:59 +0000
Date:   Fri, 17 Sep 2021 19:28:57 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Jinmeng Zhou <jjjinmeng.zhou@gmail.com>
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        shenwenbosmile@gmail.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: A missing check bug in cgroup1_reconfigure()
Message-ID: <20210917172857.GB13346@blackbody.suse.cz>
References: <CAA-qYXjxht4+GhTjNb0xmr4dLQYDVpDbO1R_FDcWtnsrQC=VNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA-qYXjxht4+GhTjNb0xmr4dLQYDVpDbO1R_FDcWtnsrQC=VNQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 16, 2021 at 03:33:49PM +0800, Jinmeng Zhou <jjjinmeng.zhou@gmail.com> wrote:
> Dear maintainers,
> hi, our team has found a missing check bug on Linux kernel v5.10.7
> using static analysis.
> There is a checking path where cgroup1_get_tree() calls cgroup1_root_to_use()
> to mount cgroup_root after checking capability.
> However, another no-checking path exists, cgroup1_reconfigure() calls
> trace_cgroup_remount()
> to remount without checking capability.
> We think there is a missing check bug before mounting cgroup_root in
> cgroup1_reconfigure().

Thanks for the report.
AFAICS, the callers of the fs_context_operations callbacks do the checks
themselves, therefore I _think_ even the check in cgroup1_get_tree() is
superfluous (see also commit 23bf1b6be9c2 ("kernfs, sysfs, cgroup,
intel_rdt: Support fs_context")).

But let me CC also VFS folks for confirmation (rest of the message
below).

> Specifically, cgroup1_get_tree() uses ns_capable(ctx->ns->user_ns,
> CAP_SYS_ADMIN) to check
> the permission before calling the critical function
> cgroup1_root_to_use() to mount.
> 
> 1. // check ns_capable() ////////////////////////////
> 2. int cgroup1_get_tree(struct fs_context *fc)
> 3. {
> 4.  struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
> 5.  int ret;
> 6.  /* Check if the caller has permission to mount. */
> 7.  if (!ns_capable(ctx->ns->user_ns, CAP_SYS_ADMIN))
> 8.    return -EPERM;
> 9.  cgroup_lock_and_drain_offline(&cgrp_dfl_root.cgrp);
> 10. ret = cgroup1_root_to_use(fc);
> 11. ...
> 12. }
> 
> trace_cgroup_remount() is called to remount cgroup_root in
> cgroup1_reconfigure().
> However, it lacks the check.
> 1. int cgroup1_reconfigure(struct fs_context *fc)
> 2. {
> 3.  struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
> 4.  struct kernfs_root *kf_root = kernfs_root_from_sb(fc->root->d_sb);
> 5.  struct cgroup_root *root = cgroup_root_from_kf(kf_root);
> 6.  int ret = 0;
> 7.  u16 added_mask, removed_mask;
> 8.  ...
> 9.  trace_cgroup_remount(root);
> 10. ...
> 11. }
> 
> We find cgroup1_reconfigure() is only used in a variable initialization.
> Function cgroup1_get_tree() is also used in this initialization.
> Both functions are indirectly called which is hard to trace.
> We reasonably consider that the two functions can be equally reached
> by the user,
> therefore, there is a missing check bug.
> 1. static const struct fs_context_operations cgroup1_fs_context_ops = {
> 2. …
> 3.  .get_tree = cgroup1_get_tree,
> 4.  .reconfigure = cgroup1_reconfigure,
> 5. };
> 
> 
> Thanks!
> 
> 
> Best regards,
> Jinmeng Zhou
> 

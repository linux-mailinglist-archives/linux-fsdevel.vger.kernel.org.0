Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF52D2EA51D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 07:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbhAEGAn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 01:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbhAEGAn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 01:00:43 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17B0C061793;
        Mon,  4 Jan 2021 22:00:02 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kwfNY-006yqt-0a; Tue, 05 Jan 2021 05:59:36 +0000
Date:   Tue, 5 Jan 2021 05:59:35 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4] proc: Allow pid_revalidate() during LOOKUP_RCU
Message-ID: <20210105055935.GT3579531@ZenIV.linux.org.uk>
References: <20210104232123.31378-1-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104232123.31378-1-stephen.s.brennan@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 04, 2021 at 03:21:22PM -0800, Stephen Brennan wrote:
> The pid_revalidate() function drops from RCU into REF lookup mode. When
> many threads are resolving paths within /proc in parallel, this can
> result in heavy spinlock contention on d_lockref as each thread tries to
> grab a reference to the /proc dentry (and drop it shortly thereafter).
> 
> Investigation indicates that it is not necessary to drop RCU in
> pid_revalidate(), as no RCU data is modified and the function never
> sleeps. So, remove the LOOKUP_RCU check.

Umm...  I'm rather worried about the side effect you are removing here -
you are suddenly exposing a bunch of methods in there to RCU mode.
E.g. is proc_pid_permission() safe with MAY_NOT_BLOCK in the mask?
generic_permission() call in there is fine, but has_pid_permission()
doesn't even see the mask.  Is that thing safe in RCU mode?  AFAICS,
this
static int selinux_ptrace_access_check(struct task_struct *child,
                                     unsigned int mode)
{
        u32 sid = current_sid();
        u32 csid = task_sid(child);

        if (mode & PTRACE_MODE_READ)
                return avc_has_perm(&selinux_state,
                                    sid, csid, SECCLASS_FILE, FILE__READ, NULL);

        return avc_has_perm(&selinux_state,
                            sid, csid, SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
}
is reachable and IIRC avc_has_perm() should *NOT* be called in RCU mode.
If nothing else, audit handling needs care...

And LSM-related stuff is only a part of possible issues here.  It does need
a careful code audit - you are taking a bunch of methods into the conditions
they'd never been tested in.  ->permission(), ->get_link(), ->d_revalidate(),
->d_hash() and ->d_compare() instances for objects that subtree.  The last
two are not there in case of anything in /proc/<pid>, but the first 3 very
much are.

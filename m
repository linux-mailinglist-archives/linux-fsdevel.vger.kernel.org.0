Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADB52D6B30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 00:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393761AbgLJWzu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 17:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392746AbgLJWzV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 17:55:21 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D26AC0619DC;
        Thu, 10 Dec 2020 14:54:17 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knUp3-000QLY-DS; Thu, 10 Dec 2020 22:54:05 +0000
Date:   Thu, 10 Dec 2020 22:54:05 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jann@thejh.net>
Subject: Re: [PATCH] files: rcu free files_struct
Message-ID: <20201210225405.GU3579531@ZenIV.linux.org.uk>
References: <877dprtxly.fsf@x220.int.ebiederm.org>
 <20201209142359.GN3579531@ZenIV.linux.org.uk>
 <87o8j2svnt.fsf_-_@x220.int.ebiederm.org>
 <CAHk-=wiUMHBHmmDS3_Xqh1wfGFyd_rdDmpZzk0cODoj1i7_VOA@mail.gmail.com>
 <20201209195033.GP3579531@ZenIV.linux.org.uk>
 <87sg8er7gp.fsf@x220.int.ebiederm.org>
 <20201210061304.GS3579531@ZenIV.linux.org.uk>
 <87h7oto3ya.fsf@x220.int.ebiederm.org>
 <20201210213624.GT3579531@ZenIV.linux.org.uk>
 <20201210223024.hi2zlluqqxcdaod4@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210223024.hi2zlluqqxcdaod4@wittgenstein>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 11:30:24PM +0100, Christian Brauner wrote:
> (requiring btf), i.e. security_file_open, then follow
> file->f_inode->i_sb->s_type->s_magic. If we change the say struct
> super_block I'd expect these bpf programs to break.

To break they would need to have compiled in the first place;
->s_type is struct file_system_type and it contains no ->s_magic
(nor would it be possible, really - ->s_magic can vary between
filesystems that *do* share ->s_type).

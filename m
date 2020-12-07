Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F042D1DBB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 23:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgLGWts (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 17:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgLGWts (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:49:48 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20F1C061749;
        Mon,  7 Dec 2020 14:49:07 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmPJX-00HHD1-Rb; Mon, 07 Dec 2020 22:49:03 +0000
Date:   Mon, 7 Dec 2020 22:49:03 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        criu@openvz.org, bpf@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH v2 09/24] file: Replace fcheck_files with
 files_lookup_fd_rcu
Message-ID: <20201207224903.GA4117703@ZenIV.linux.org.uk>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
 <20201120231441.29911-9-ebiederm@xmission.com>
 <20201207224656.GC4115853@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207224656.GC4115853@ZenIV.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 07, 2020 at 10:46:57PM +0000, Al Viro wrote:
> On Fri, Nov 20, 2020 at 05:14:26PM -0600, Eric W. Biederman wrote:
> 
> >  /*
> >   * Check whether the specified fd has an open file.
> >   */
> > -#define fcheck(fd)	fcheck_files(current->files, fd)
> > +#define fcheck(fd)	files_lookup_fd_rcu(current->files, fd)
> 
> Huh?
> fs/file.c:1113: file = fcheck(oldfd);
> 	dup3(), under ->file_lock, no rcu_read_lock() in sight
> 
> fs/locks.c:2548:                f = fcheck(fd);
> 	fcntl_setlk(), ditto
> 
> fs/locks.c:2679:                f = fcheck(fd);
> 	fcntl_setlk64(), ditto
> 
> fs/notify/dnotify/dnotify.c:330:        f = fcheck(fd);
> 	fcntl_dirnotify(); this one _is_ under rcu_read_lock().
> 
> 
> IOW, unless I've missed something earlier in the series, this is wrong.

I have missed something, all right.  Ignore that comment...

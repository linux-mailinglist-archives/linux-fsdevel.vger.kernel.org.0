Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E652D1D5F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 23:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgLGWdQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 17:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgLGWdQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:33:16 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0E4C061793;
        Mon,  7 Dec 2020 14:32:36 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmP3P-00HGyz-WE; Mon, 07 Dec 2020 22:32:24 +0000
Date:   Mon, 7 Dec 2020 22:32:23 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, criu@openvz.org,
        bpf <bpf@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
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
Subject: Re: [PATCH v2 02/24] exec: Simplify unshare_files
Message-ID: <20201207223223.GB4115853@ZenIV.linux.org.uk>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
 <20201120231441.29911-2-ebiederm@xmission.com>
 <20201123175052.GA20279@redhat.com>
 <CAHk-=wj2OnjWr696z4yzDO9_mF44ND60qBHPvi1i9DBrjdLvUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj2OnjWr696z4yzDO9_mF44ND60qBHPvi1i9DBrjdLvUw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 23, 2020 at 10:25:13AM -0800, Linus Torvalds wrote:
> On Mon, Nov 23, 2020 at 9:52 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Can anyone explain why does do_coredump() need unshare_files() at all?
> 
> Hmm. It goes back to 2012, and it's placed just before calling
> "->core_dump()", so I assume some core dumping function messed with
> the file table back when..
> 
> I can't see anything like that currently.
> 
> The alternative is that core-dumping just keeps the file table around
> for a long while, and thus files don't actually close in a timely
> manner. So it might not be a "correctness" issue as much as a latency
> issue.

IIRC, it was "weird architecture hooks might be playing silly buggers
with some per-descriptor information they want in coredumps, better
make sure it can't change under them"; it doesn't cost much and
it reduced the analysis surface nicely.

Had been a while ago, so the memories might be faulty...  Anyway, that
reasoning seems to be applicable right now - rather than keeping an
eye on coredump logics on random architectures that might be looking
at descriptor table in unsafe way, just make sure they have a stable
private table and be done with that.

How much is simplified by not doing it there, anyway?

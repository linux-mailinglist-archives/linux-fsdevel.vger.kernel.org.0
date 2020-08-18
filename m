Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B20A248345
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 12:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgHRKnt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 06:43:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39312 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgHRKns (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 06:43:48 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k7z5m-0003jk-JH; Tue, 18 Aug 2020 10:43:46 +0000
Date:   Tue, 18 Aug 2020 12:43:45 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        criu@openvz.org, bpf@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@debian.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH 12/17] proc/fd: In fdinfo seq_show don't use
 get_files_struct
Message-ID: <20200818104345.n5ugxlzuv5iuggqs@wittgenstein>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
 <20200817220425.9389-12-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200817220425.9389-12-ebiederm@xmission.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 17, 2020 at 05:04:20PM -0500, Eric W. Biederman wrote:
> When discussing[1] exec and posix file locks it was realized that none
> of the callers of get_files_struct fundamentally needed to call
> get_files_struct, and that by switching them to helper functions
> instead it will both simplify their code and remove unnecessary
> increments of files_struct.count.  Those unnecessary increments can
> result in exec unnecessarily unsharing files_struct which breaking
> posix locks, and it can result in fget_light having to fallback to
> fget reducing system performance.
> 
> Instead hold task_lock for the duration that task->files needs to be
> stable in seq_show.  The task_lock was already taken in
> get_files_struct, and so skipping get_files_struct performs less work
> overall, and avoids the problems with the files_struct reference
> count.
> 
> [1] https://lkml.kernel.org/r/20180915160423.GA31461@redhat.com
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

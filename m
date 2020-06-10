Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE2C1F4BAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 05:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgFJDJO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 23:09:14 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57485 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgFJDJO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 23:09:14 -0400
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 05A38P2B029472;
        Wed, 10 Jun 2020 12:08:25 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp);
 Wed, 10 Jun 2020 12:08:25 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 05A38Kkn029445
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 10 Jun 2020 12:08:25 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>
References: <20200606201956.rvfanoqkevjcptfl@ast-mbp>
 <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
 <20200607014935.vhd3scr4qmawq7no@ast-mbp>
 <33cf7a57-0afa-9bb9-f831-61cca6c19eba@i-love.sakura.ne.jp>
 <20200608162306.iu35p4xoa2kcp3bu@ast-mbp.dhcp.thefacebook.com>
 <af00d341-6046-e187-f5c8-5f57b40f017c@i-love.sakura.ne.jp>
 <20200609012826.dssh2lbfr6tlhwwa@ast-mbp.dhcp.thefacebook.com>
 <ddabab93-4660-3a46-8b05-89385e292b75@i-love.sakura.ne.jp>
 <20200609223214.43db3orsyjczb2dd@ast-mbp.dhcp.thefacebook.com>
 <6a8b284f-461e-11b5-9985-6dc70012f774@i-love.sakura.ne.jp>
 <20200610000546.4hh4n53vaxc4hypi@ast-mbp.dhcp.thefacebook.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <1be571d2-c517-d7a7-788e-3bcc07afa858@i-love.sakura.ne.jp>
Date:   Wed, 10 Jun 2020 12:08:20 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200610000546.4hh4n53vaxc4hypi@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/06/10 9:05, Alexei Starovoitov wrote:
> I think you're still missing that usermode_blob is completely fs-less.
> It doesn't need any fs to work.

fork_usermode_blob() allows usage like fork_usermode_blob("#!/bin/sh").
A problem for LSMs is not "It doesn't need any fs to work." but "It can access any fs and
it can issue arbitrary syscalls.".

LSM modules switch their security context upon execve(), based on available information like
"What is the !AT_SYMLINK_NOFOLLOW pathname for the requested program passed to execve()?",
"What is the AT_SYMLINK_NOFOLLOW pathname for the requested program passed to execve()?",
"What are argv[]/envp[] for the requested program passed to execve()?", "What is the inode's
security context passed to execve()?" etc. And file-less execve() request (a.k.a.
fork_usermode_blob()) makes pathname information (which pathname-based LSMs depend on)
unavailable.

Since fork_usermode_blob() can execute arbitrary code in userspace, fork_usermode_blob() can
allow execution of e.g. statically linked HTTP server and statically linked DBMS server, without
giving LSM modules a chance to understand the intent of individual file-less execve() request.
If many different statically linked programs were executed via fork_usermode_blob(), how LSM
modules can determine whether a syscall from a file-less process should be permitted/denied?

By the way, TOMOYO LSM wants to know meaningful AT_SYMLINK_NOFOLLOW pathname and !AT_SYMLINK_NOFOLLOW
pathname, and currently there is no API for allow obtaining both pathnames atomically. But that is a
different problem, for what this mail thread is discussing would be whether we can avoid file-less
execve() request (i.e. get rid of fork_usermode_blob()).


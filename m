Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12081F4EEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 09:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgFJHbS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 03:31:18 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53947 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgFJHbS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 03:31:18 -0400
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 05A7URas010288;
        Wed, 10 Jun 2020 16:30:28 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav303.sakura.ne.jp);
 Wed, 10 Jun 2020 16:30:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav303.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 05A7URpx010284
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 10 Jun 2020 16:30:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
To:     linux-security-module <linux-security-module@vger.kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
References: <20200607014935.vhd3scr4qmawq7no@ast-mbp>
 <33cf7a57-0afa-9bb9-f831-61cca6c19eba@i-love.sakura.ne.jp>
 <20200608162306.iu35p4xoa2kcp3bu@ast-mbp.dhcp.thefacebook.com>
 <af00d341-6046-e187-f5c8-5f57b40f017c@i-love.sakura.ne.jp>
 <20200609012826.dssh2lbfr6tlhwwa@ast-mbp.dhcp.thefacebook.com>
 <ddabab93-4660-3a46-8b05-89385e292b75@i-love.sakura.ne.jp>
 <20200609223214.43db3orsyjczb2dd@ast-mbp.dhcp.thefacebook.com>
 <6a8b284f-461e-11b5-9985-6dc70012f774@i-love.sakura.ne.jp>
 <20200610000546.4hh4n53vaxc4hypi@ast-mbp.dhcp.thefacebook.com>
 <1be571d2-c517-d7a7-788e-3bcc07afa858@i-love.sakura.ne.jp>
 <20200610033256.xkv5a7l6vtb2jiox@ast-mbp.dhcp.thefacebook.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <c9828709-c8e1-06a2-8643-e09e2e555b81@i-love.sakura.ne.jp>
Date:   Wed, 10 Jun 2020 16:30:28 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200610033256.xkv5a7l6vtb2jiox@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Forwarding to LSM-ML. Security people, any comments?

On 2020/06/10 12:32, Alexei Starovoitov wrote:
> On Wed, Jun 10, 2020 at 12:08:20PM +0900, Tetsuo Handa wrote:
>> On 2020/06/10 9:05, Alexei Starovoitov wrote:
>>> I think you're still missing that usermode_blob is completely fs-less.
>>> It doesn't need any fs to work.
>>
>> fork_usermode_blob() allows usage like fork_usermode_blob("#!/bin/sh").
>> A problem for LSMs is not "It doesn't need any fs to work." but "It can access any fs and
>> it can issue arbitrary syscalls.".
>>
>> LSM modules switch their security context upon execve(), based on available information like
>> "What is the !AT_SYMLINK_NOFOLLOW pathname for the requested program passed to execve()?",
>> "What is the AT_SYMLINK_NOFOLLOW pathname for the requested program passed to execve()?",
>> "What are argv[]/envp[] for the requested program passed to execve()?", "What is the inode's
>> security context passed to execve()?" etc. And file-less execve() request (a.k.a.
>> fork_usermode_blob()) makes pathname information (which pathname-based LSMs depend on)
>> unavailable.
>>
>> Since fork_usermode_blob() can execute arbitrary code in userspace, fork_usermode_blob() can
>> allow execution of e.g. statically linked HTTP server and statically linked DBMS server, without
>> giving LSM modules a chance to understand the intent of individual file-less execve() request.
>> If many different statically linked programs were executed via fork_usermode_blob(), how LSM
>> modules can determine whether a syscall from a file-less process should be permitted/denied?
> 
> What you're saying is tomoyo doesn't trust kernel modules that are built-in
> as part of vmlinux and doesn't trust vmlinux build.
> I cannot really comprehend that since it means that tomoyo doesn't trust itself.
> 
>> By the way, TOMOYO LSM wants to know meaningful AT_SYMLINK_NOFOLLOW pathname and !AT_SYMLINK_NOFOLLOW
>> pathname, and currently there is no API for allow obtaining both pathnames atomically. But that is a
>> different problem, for what this mail thread is discussing would be whether we can avoid file-less
>> execve() request (i.e. get rid of fork_usermode_blob()).
> 
> tomoyo does path name resolution as a string and using that for security?
> I'm looking at tomoyo_realpath*() and tomoyo_pathcmp(). Ouch.
> Path based security is anti pattern of security.
> I didn't realize tomoyo so broken.
> 

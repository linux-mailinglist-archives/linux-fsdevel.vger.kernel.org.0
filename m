Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2124C2069DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 03:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388351AbgFXBwK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 21:52:10 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:49258 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388035AbgFXBwK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 21:52:10 -0400
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 05O1pHbH083981;
        Wed, 24 Jun 2020 10:51:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp);
 Wed, 24 Jun 2020 10:51:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 05O1pGv7083968
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 24 Jun 2020 10:51:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
References: <87d066vd4y.fsf@x220.int.ebiederm.org>
 <20200611233134.5vofl53dj5wpwp5j@ast-mbp.dhcp.thefacebook.com>
 <87bllngirv.fsf@x220.int.ebiederm.org>
 <CAADnVQ+qNxFjTYBpYW9ZhStMh_oJBS5C_FsxSS=0Mzy=u54MSg@mail.gmail.com>
 <CAADnVQLuGYX=LamARhrZcze1ej4ELj-y99fLzOCgz60XLPw_cQ@mail.gmail.com>
 <87ftaxd7ky.fsf@x220.int.ebiederm.org>
 <20200616015552.isi6j5x732okiky4@ast-mbp.dhcp.thefacebook.com>
 <87h7v1pskt.fsf@x220.int.ebiederm.org>
 <20200623183520.5e7fmlt3omwa2lof@ast-mbp.dhcp.thefacebook.com>
 <87h7v1mx4z.fsf@x220.int.ebiederm.org>
 <20200623194023.lzl34qt2wndhcehk@ast-mbp.dhcp.thefacebook.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <b4a805e7-e009-dfdf-d011-be636ce5c4f5@i-love.sakura.ne.jp>
Date:   Wed, 24 Jun 2020 10:51:15 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623194023.lzl34qt2wndhcehk@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/06/24 4:40, Alexei Starovoitov wrote:
> There is no refcnt bug. It was a user error on tomoyo side.
> fork_blob() works as expected.

Absolutely wrong! Any check which returns an error during current->in_execve == 1
will cause this refcnt bug. You are simply ignoring that there is possibility
that execve() fails.

> Not true again.
> usermode_blob is part of the kernel module.

Disagree.

> Kernel module when loaded doesn't have path.

Disagree.

Kernel modules can be trusted via module signature mechanism, and the byte array
(which contains code / data) is protected by keeping that byte array within the
kernel address space. Therefore, pathname based security does not need to complain
that there is no pathname when kernel module is loaded.

However, regarding usermode_blob, although the byte array (which contains code / data)
might be initially loaded from the kernel space (which is protected), that byte array
is no longer protected (e.g. SIGKILL, strace()) when executed because they are placed
in the user address space. Thus, LSM modules (including pathname based security) want
to control how that byte array can behave.

> tomoyo has to fix itself.

TOMOYO needs to somehow handle /dev/fd/ case from execveat(), but fork_blob() is a
different story.

On 2020/06/24 3:53, Eric W. Biederman wrote:
> This isn't work anyone else can do because there are not yet any real in
> tree users of fork_blob.  The fact that no one else can make
> substantials changes to the code because it has no users is what gets in
> the way of maintenance.

It sounds to me that fork_blob() is a dangerous interface which anonymously
allows arbitrary behavior in an unprotected environment. Therefore,

> Either a path needs to be provided or the LSMs that work in terms
> of paths need to be fixed.

LSM modules want to control how that byte array can behave. But Alexei
still does not explain how information for LSM modules can be provided.

> My recomendation for long term maintenance is to split fork_blob into 2
> functions: fs_from_blob, and the ordinary call_usermodehelper_exec.
> That removes the need for any special support for anything in the exec
> path because your blob will also have a path for your file, and the
> file in the filesystem can be reused for restart.

Yes, that would be an approach for providing information for LSM modules.

> But with no in-tree users none of us can do anything bug guess what
> the actual requirements of fork_usermode_blob are.

Exactly. Since it is not explained why the usermode process started by
fork_usermode_blob() cannot interfere (or be interfered by) the rest of
the system (including normal usermode processes), the byte array comes from
the kernel address space is insufficient for convincing LSM modules to
ignore what that byte array can do.


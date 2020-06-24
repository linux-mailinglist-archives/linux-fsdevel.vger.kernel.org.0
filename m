Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA9C206B77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 06:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388036AbgFXE7V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 00:59:21 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58415 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgFXE7V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 00:59:21 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 05O4wXwK066260;
        Wed, 24 Jun 2020 13:58:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp);
 Wed, 24 Jun 2020 13:58:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 05O4wXR6066257
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 24 Jun 2020 13:58:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
References: <87bllngirv.fsf@x220.int.ebiederm.org>
 <CAADnVQ+qNxFjTYBpYW9ZhStMh_oJBS5C_FsxSS=0Mzy=u54MSg@mail.gmail.com>
 <CAADnVQLuGYX=LamARhrZcze1ej4ELj-y99fLzOCgz60XLPw_cQ@mail.gmail.com>
 <87ftaxd7ky.fsf@x220.int.ebiederm.org>
 <20200616015552.isi6j5x732okiky4@ast-mbp.dhcp.thefacebook.com>
 <87h7v1pskt.fsf@x220.int.ebiederm.org>
 <20200623183520.5e7fmlt3omwa2lof@ast-mbp.dhcp.thefacebook.com>
 <87h7v1mx4z.fsf@x220.int.ebiederm.org>
 <20200623194023.lzl34qt2wndhcehk@ast-mbp.dhcp.thefacebook.com>
 <b4a805e7-e009-dfdf-d011-be636ce5c4f5@i-love.sakura.ne.jp>
 <20200624040054.x5xzkuhiw67cywzl@ast-mbp.dhcp.thefacebook.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <5254444e-465e-6dee-287b-bef58526b724@i-love.sakura.ne.jp>
Date:   Wed, 24 Jun 2020 13:58:33 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624040054.x5xzkuhiw67cywzl@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/06/24 13:00, Alexei Starovoitov wrote:
>> However, regarding usermode_blob, although the byte array (which contains code / data)
>> might be initially loaded from the kernel space (which is protected), that byte array
>> is no longer protected (e.g. SIGKILL, strace()) when executed because they are placed
>> in the user address space. Thus, LSM modules (including pathname based security) want
>> to control how that byte array can behave.
> 
> It's privileged memory regardless. root can poke into kernel or any process memory.

LSM is there to restrict processes running as "root".
Your "root can poke into kernel or any process memory." response is out of step with the times.

Initial byte array used for usermode blob might be protected because of "part of .rodata or
.init.rodata of kernel module", but that byte array after started in userspace is no longer
protected. I don't trust such byte array as "part of kernel module", and I'm asking you how
such byte array does not interfere (or be interfered by) the rest of the system.

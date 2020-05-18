Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E1A1D7D05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 17:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgERPhe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 11:37:34 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57636 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERPhe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 11:37:34 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04IFaqlj007747;
        Tue, 19 May 2020 00:36:52 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp);
 Tue, 19 May 2020 00:36:52 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04IFacsP007670
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 19 May 2020 00:36:51 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v3] proc: proc_pid_ns takes super_block as an argument
To:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+c1af344512918c61362c@syzkaller.appspotmail.com>,
        jmorris@namei.org, linux-next@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <87lfltcbc4.fsf@x220.int.ebiederm.org>
 <20200518150818.2929164-1-gladkov.alexey@gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <ffcf787e-8380-96e8-0432-54742140f490@i-love.sakura.ne.jp>
Date:   Tue, 19 May 2020 00:36:34 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200518150818.2929164-1-gladkov.alexey@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I would shorten like below:

syzbot found that

  touch /proc/testfile

causes NULL pointer dereference at tomoyo_get_local_path()
because inode of the dentry is NULL.

Before c59f415a7cb6, Tomoyo received pid_ns from proc's s_fs_info
directly. Since proc_pid_ns() can only work with inode, using it in
the tomoyo_get_local_path() was wrong.

To avoid creating more functions for getting proc_ns, change the
argument type of the proc_pid_ns() function. Then, Tomoyo can use
the existing super_block to get pid_ns.


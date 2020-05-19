Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D561D8EE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 06:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgESEqA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 00:46:00 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55482 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgESEqA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 00:46:00 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04J4iXXc050017;
        Tue, 19 May 2020 13:44:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp);
 Tue, 19 May 2020 13:44:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04J4iXTE050013
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 19 May 2020 13:44:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v4 2/4] sysctl: Move some boundary constants form sysctl.c
 to sysctl_vals
To:     Xiaoming Ni <nixiaoming@huawei.com>, keescook@chromium.org
Cc:     mcgrof@kernel.org, yzaikin@google.com, adobriyan@gmail.com,
        mingo@kernel.org, gpiccoli@canonical.com, rdna@fb.com,
        patrick.bellasi@arm.com, sfr@canb.auug.org.au,
        akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        tglx@linutronix.de, peterz@infradead.org,
        Jisheng.Zhang@synaptics.com, khlebnikov@yandex-team.ru,
        bigeasy@linutronix.de, pmladek@suse.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        wangle6@huawei.com, alex.huangjianhui@huawei.com
References: <1589859071-25898-1-git-send-email-nixiaoming@huawei.com>
 <1589859071-25898-3-git-send-email-nixiaoming@huawei.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <1bf1aefb-adfd-4f43-35c7-5b320d43faf8@i-love.sakura.ne.jp>
Date:   Tue, 19 May 2020 13:44:30 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1589859071-25898-3-git-send-email-nixiaoming@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/05/19 12:31, Xiaoming Ni wrote:
> Some boundary (.extra1 .extra2) constants (E.g: neg_one two) in
> sysctl.c are used in multiple features. Move these variables to
> sysctl_vals to avoid adding duplicate variables when cleaning up
> sysctls table.
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

I feel that it is use of

	void *extra1;
	void *extra2;

in "struct ctl_table" that requires constant values indirection.
Can't we get rid of sysctl_vals using some "union" like below?

struct ctl_table {
	const char *procname;           /* Text ID for /proc/sys, or zero */
	void *data;
	int maxlen;
	umode_t mode;
	struct ctl_table *child;        /* Deprecated */
	proc_handler *proc_handler;     /* Callback for text formatting */
	struct ctl_table_poll *poll;
	union {
		void *min_max_ptr[2];
		int min_max_int[2];
		long min_max_long[2];
	};
} __randomize_layout;

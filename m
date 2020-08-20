Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1028F24C095
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 16:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgHTO1p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 10:27:45 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55593 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgHTO1o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:27:44 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 07KEQXrD085945;
        Thu, 20 Aug 2020 23:26:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp);
 Thu, 20 Aug 2020 23:26:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 07KEQXg6085942
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 20 Aug 2020 23:26:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 1/1] mm, oom_adj: don't loop through tasks in
 __set_oom_adj when not necessary
To:     Michal Hocko <mhocko@suse.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Suren Baghdasaryan <surenb@google.com>, timmurray@google.com,
        mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        esyr@redhat.com, christian@kellner.me, areber@redhat.com,
        shakeelb@google.com, cyphar@cyphar.com, oleg@redhat.com,
        adobriyan@gmail.com, akpm@linux-foundation.org,
        gladkov.alexey@gmail.com, walken@google.com,
        daniel.m.jordan@oracle.com, avagin@gmail.com,
        bernd.edlinger@hotmail.de, john.johansen@canonical.com,
        laoar.shao@gmail.com, minchan@kernel.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20200820002053.1424000-1-surenb@google.com>
 <87zh6pxzq6.fsf@x220.int.ebiederm.org> <20200820124241.GJ5033@dhcp22.suse.cz>
 <87lfi9xz7y.fsf@x220.int.ebiederm.org> <87d03lxysr.fsf@x220.int.ebiederm.org>
 <20200820132631.GK5033@dhcp22.suse.cz>
 <20200820133454.ch24kewh42ax4ebl@wittgenstein>
 <dcb62b67-5ad6-f63a-a909-e2fa70b240fc@i-love.sakura.ne.jp>
 <20200820140054.fdkbotd4tgfrqpe6@wittgenstein>
 <20200820141538.GM5033@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <42d5645e-0364-c8cd-01dc-93a9aaff5b09@i-love.sakura.ne.jp>
Date:   Thu, 20 Aug 2020 23:26:29 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820141538.GM5033@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/08/20 23:15, Michal Hocko wrote:
> I would tend to agree that from the userspace POV it is nice to look at
> oom tuning per process but fundamentaly the oom killer operates on the
> address space much more than other resources bound to a process because
> it is usually the address space hogging the largest portion of the
> memory footprint. This is the reason why the oom killer has been
> evaluating tasks based on that aspect rather than other potential memory
> consumers bound to a task. Mostly due to lack of means to evaluate
> those.

We already allow specifying potential memory consumers via oom_task_origin().

If we change from a property of the task/thread-group to a property of mm,
we won't be able to add means to adjust oom score based on other potential
memory consumers bound to a task (e.g. pipes) in the future.

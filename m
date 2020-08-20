Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDA624BFB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 15:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgHTNxO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 09:53:14 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59341 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbgHTNuh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 09:50:37 -0400
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 07KDml2B045145;
        Thu, 20 Aug 2020 22:48:47 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp);
 Thu, 20 Aug 2020 22:48:47 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 07KDml2i045137
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 20 Aug 2020 22:48:47 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 1/1] mm, oom_adj: don't loop through tasks in
 __set_oom_adj when not necessary
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Suren Baghdasaryan <surenb@google.com>, timmurray@google.com
Cc:     Michal Hocko <mhocko@suse.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, esyr@redhat.com,
        christian@kellner.me, areber@redhat.com, shakeelb@google.com,
        cyphar@cyphar.com, oleg@redhat.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, gladkov.alexey@gmail.com,
        walken@google.com, daniel.m.jordan@oracle.com, avagin@gmail.com,
        bernd.edlinger@hotmail.de, john.johansen@canonical.com,
        laoar.shao@gmail.com, minchan@kernel.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20200820002053.1424000-1-surenb@google.com>
 <87zh6pxzq6.fsf@x220.int.ebiederm.org> <20200820124241.GJ5033@dhcp22.suse.cz>
 <87lfi9xz7y.fsf@x220.int.ebiederm.org> <87d03lxysr.fsf@x220.int.ebiederm.org>
 <20200820132631.GK5033@dhcp22.suse.cz>
 <20200820133454.ch24kewh42ax4ebl@wittgenstein>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <dcb62b67-5ad6-f63a-a909-e2fa70b240fc@i-love.sakura.ne.jp>
Date:   Thu, 20 Aug 2020 22:48:43 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820133454.ch24kewh42ax4ebl@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/08/20 22:34, Christian Brauner wrote:
> On Thu, Aug 20, 2020 at 03:26:31PM +0200, Michal Hocko wrote:
>> If you can handle vfork by other means then I am all for it. There were
>> no patches in that regard proposed yet. Maybe it will turn out simpler
>> then the heavy lifting we have to do in the oom specific code.
> 
> Eric's not wrong. I fiddled with this too this morning but since
> oom_score_adj is fiddled with in a bunch of places this seemed way more
> code churn then what's proposed here.

I prefer simply reverting commit 44a70adec910d692 ("mm, oom_adj: make sure
processes sharing mm have same view of oom_score_adj").

  https://lore.kernel.org/patchwork/patch/1037208/

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5BF1F6BDB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 18:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgFKQKR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 12:10:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59596 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726095AbgFKQKR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 12:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591891814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sAc8K5GdtWCdfeiweUngiX2JdslVVBJ6iUtA5e6N5iA=;
        b=ZXgasndI73gWrU13Xf6clABdubG50rKZM06OPGjZIJQ+1bOkyICN2xrvOI4SpwZ36qB3s7
        rSDDErflvAsTTfT+vxB+Uf0O7L9Bhbv9wJ9+t8LtZtOESrMNFnH/491JbmjV2x4iw1bTD/
        rrLCT2OqDaavXRmjb0CbZdyAxwdwtJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-HVzvVuaIPNaCw67pkCMHGA-1; Thu, 11 Jun 2020 12:10:12 -0400
X-MC-Unique: HVzvVuaIPNaCw67pkCMHGA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6776107ACCA;
        Thu, 11 Jun 2020 16:10:08 +0000 (UTC)
Received: from llong.remote.csb (ovpn-115-149.rdu2.redhat.com [10.10.115.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C2655C1B0;
        Thu, 11 Jun 2020 16:10:00 +0000 (UTC)
Subject: Re: possible deadlock in send_sigio
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+a9fb1457d720a55d6dc5@syzkaller.appspotmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, allison@lohutok.net,
        areber@redhat.com, aubrey.li@linux.intel.com,
        Andrei Vagin <avagin@gmail.com>,
        Bruce Fields <bfields@fieldses.org>,
        Christian Brauner <christian@brauner.io>, cyphar@cyphar.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, guro@fb.com,
        Jeff Layton <jlayton@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>, linmiaohe@huawei.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, sargun@sargun.me,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Boqun Feng <boqun.feng@gmail.com>
References: <000000000000760d0705a270ad0c@google.com>
 <69818a6c-7025-8950-da4b-7fdc065d90d6@redhat.com>
 <CACT4Y+brpePBoR7EUwPiSvGAgo6bhvpKvLTiCaCfRSadzn6yRw@mail.gmail.com>
 <88c172af-46df-116e-6f22-b77f98803dcb@redhat.com>
 <20200611142214.GI2531@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <b405aca6-a3b2-cf11-a482-2b4af1e548bd@redhat.com>
Date:   Thu, 11 Jun 2020 12:09:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200611142214.GI2531@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/11/20 10:22 AM, Peter Zijlstra wrote:
> On Thu, Jun 11, 2020 at 09:51:29AM -0400, Waiman Long wrote:
>
>> There was an old lockdep patch that I think may address the issue, but was
>> not merged at the time. I will need to dig it out and see if it can be
>> adapted to work in the current kernel. It may take some time.
> Boqun was working on that; I can't remember what happened, but ISTR it
> was shaping up nice.
>
Yes, I am talking about Boqun's patch. However, I think he had moved to 
another company and so may not be able to actively work on that again.

Cheers,
Longman


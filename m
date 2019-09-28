Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F10BC11F2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2019 21:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfI1TH3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Sep 2019 15:07:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:49886 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726026AbfI1TH3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Sep 2019 15:07:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 678EEB18B;
        Sat, 28 Sep 2019 19:07:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 28 Sep 2019 21:07:26 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     hev <r@hev.cc>, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Davide Libenzi <davidel@xmailserver.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Wong <e@80x24.org>, Jason Baron <jbaron@akamai.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4] fs/epoll: Remove unnecessary wakeups of nested
 epoll that in ET mode
In-Reply-To: <20190927192915.6ec24ad706258de99470a96e@linux-foundation.org>
References: <20190925015603.10939-1-r@hev.cc>
 <20190927192915.6ec24ad706258de99470a96e@linux-foundation.org>
Message-ID: <ddd241902bef0062ed648f4eb2e5ec0e@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-09-28 04:29, Andrew Morton wrote:
> On Wed, 25 Sep 2019 09:56:03 +0800 hev <r@hev.cc> wrote:
> 
>> From: Heiher <r@hev.cc>
>> 
>> Take the case where we have:
>> 
>>         t0
>>          | (ew)
>>         e0
>>          | (et)
>>         e1
>>          | (lt)
>>         s0
>> 
>> t0: thread 0
>> e0: epoll fd 0
>> e1: epoll fd 1
>> s0: socket fd 0
>> ew: epoll_wait
>> et: edge-trigger
>> lt: level-trigger
>> 
>> We only need to wakeup nested epoll fds if something has been queued 
>> to the
>> overflow list, since the ep_poll() traverses the rdllist during 
>> recursive poll
>> and thus events on the overflow list may not be visible yet.
>> 
>> Test code:
> 
> Look sane to me.  Do you have any performance testing results which
> show a benefit?
> 
> epoll maintainership isn't exactly a hive of activity nowadays :(
> Roman, would you please have time to review this?

Yes, I can revisit this once more next week.

Heiher, mind to prepare a patchset with your test suit and make it a 
part
of kselftest?  I hope nobody has any objections.

--
Roman


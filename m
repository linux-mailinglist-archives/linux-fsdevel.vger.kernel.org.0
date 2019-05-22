Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC2926413
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 14:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbfEVMyM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 08:54:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:56812 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728794AbfEVMyL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 08:54:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5D8F0ACAC;
        Wed, 22 May 2019 12:54:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 22 May 2019 14:54:09 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Eric Wong <e@80x24.org>
Cc:     Azat Khuzhin <azat@libevent.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/13] epoll: offload polling to a work in case of epfd
 polled from userspace
In-Reply-To: <20190521075114.if4urjezominbojj@dcvr>
References: <20190516085810.31077-1-rpenyaev@suse.de>
 <20190516085810.31077-6-rpenyaev@suse.de>
 <20190521075114.if4urjezominbojj@dcvr>
Message-ID: <7fced5a4f9468a273b6acb0ca0fdcfb1@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-05-21 09:51, Eric Wong wrote:
> Roman Penyaev <rpenyaev@suse.de> wrote:
>> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
>> index 81da4571f1e0..9d3905c0afbf 100644
>> --- a/fs/eventpoll.c
>> +++ b/fs/eventpoll.c
>> @@ -44,6 +44,7 @@
>>  #include <linux/seq_file.h>
>>  #include <linux/compat.h>
>>  #include <linux/rculist.h>
>> +#include <linux/workqueue.h>
>>  #include <net/busy_poll.h>
>> 
>>  /*
>> @@ -185,6 +186,9 @@ struct epitem {
>> 
>>  	/* The structure that describe the interested events and the source 
>> fd */
>>  	struct epoll_event event;
>> +
>> +	/* Work for offloading event callback */
>> +	struct work_struct work;
>>  };
>> 
>>  /*
> 
> Can we avoid the size regression for existing epoll users?

Yeah, ->next, ->rdllink, ->ws are not used for user polling, so can hold 
work
struct and co (or pointer on container which holds work struct, if work 
struct
is huge).

--
Roman


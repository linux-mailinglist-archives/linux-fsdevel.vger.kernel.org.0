Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5595DD46AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 19:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfJKReq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 13:34:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728400AbfJKReq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 13:34:46 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2487718CB90E;
        Fri, 11 Oct 2019 17:34:46 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B75D9600C4;
        Fri, 11 Oct 2019 17:34:45 +0000 (UTC)
Subject: Re: [PATCH] fs: avoid softlockups in s_inodes iterators
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <jbacik@fb.com>
References: <841d0e0f-f04c-9611-2eea-0bcc40e5b084@redhat.com>
 <20191011172927.4d4wnvgd7rfwwr7o@macbook-pro-91.dhcp.thefacebook.com>
From:   Eric Sandeen <sandeen@redhat.com>
Message-ID: <bed67fc8-641a-18c1-0547-369c75c51508@redhat.com>
Date:   Fri, 11 Oct 2019 12:34:45 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191011172927.4d4wnvgd7rfwwr7o@macbook-pro-91.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Fri, 11 Oct 2019 17:34:46 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/11/19 12:29 PM, Josef Bacik wrote:
> On Fri, Oct 11, 2019 at 11:49:38AM -0500, Eric Sandeen wrote:
>> Anything that walks all inodes on sb->s_inodes list without rescheduling
>> risks softlockups.
>>
>> Previous efforts were made in 2 functions, see:
>>
>> c27d82f fs/drop_caches.c: avoid softlockups in drop_pagecache_sb()
>> ac05fbb inode: don't softlockup when evicting inodes
>>
>> but there hasn't been an audit of all walkers, so do that now.  This
>> also consistently moves the cond_resched() calls to the bottom of each
>> loop.
>>
>> One remains: remove_dquot_ref(), because I'm not quite sure how to deal
>> with that one w/o taking the i_lock.
>>
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> 
> You've got iput cleanups in here and cond_resched()'s.  I feel like this is a
> missed opportunity to pad your patch count.  Thanks,

yeah, I was going to suggest that I could split it out into 3
(move cond_rescheds, clean up iputs, add new rescheds) if there was a
request.  But it seemed a bit ridiculously granular.  Find by me
if desired, tho.

So, was that a request?

-Eric

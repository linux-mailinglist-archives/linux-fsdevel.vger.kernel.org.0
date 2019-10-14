Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A81F6D6B4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2019 23:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731978AbfJNVg7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Oct 2019 17:36:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48704 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731408AbfJNVg7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Oct 2019 17:36:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 58CAA796FF;
        Mon, 14 Oct 2019 21:36:59 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1051B5D9C9;
        Mon, 14 Oct 2019 21:36:58 +0000 (UTC)
Subject: Re: [PATCH V2] fs: avoid softlockups in s_inodes iterators
From:   Eric Sandeen <sandeen@redhat.com>
To:     fsdevel <linux-fsdevel@vger.kernel.org>
References: <a26fae1d-a741-6eb1-b460-968a3b97e238@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Josef Bacik <jbacik@fb.com>
Message-ID: <8af0e23f-b7a4-d046-3ebd-fb30c3f18700@redhat.com>
Date:   Mon, 14 Oct 2019 16:36:58 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <a26fae1d-a741-6eb1-b460-968a3b97e238@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 14 Oct 2019 21:36:59 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/14/19 4:30 PM, Eric Sandeen wrote:
> Anything that walks all inodes on sb->s_inodes list without rescheduling
> risks softlockups.
> 
> Previous efforts were made in 2 functions, see:
> 
> c27d82f fs/drop_caches.c: avoid softlockups in drop_pagecache_sb()
> ac05fbb inode: don't softlockup when evicting inodes
> 
> but there hasn't been an audit of all walkers, so do that now.  This
> also consistently moves the cond_resched() calls to the bottom of each
> loop in cases where it already exists.
> 
> One loop remains: remove_dquot_ref(), because I'm not quite sure how
> to deal with that one w/o taking the i_lock.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Whoops, cc: Jan & Josef as on original, sorry.

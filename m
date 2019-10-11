Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF33AD47D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 20:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfJKSpy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 14:45:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728374AbfJKSpy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 14:45:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A2F0C8AC6FD;
        Fri, 11 Oct 2019 18:45:54 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4067560600;
        Fri, 11 Oct 2019 18:45:54 +0000 (UTC)
Subject: Re: [PATCH] fs: avoid softlockups in s_inodes iterators
To:     Matthew Wilcox <willy@infradead.org>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <jbacik@fb.com>
References: <841d0e0f-f04c-9611-2eea-0bcc40e5b084@redhat.com>
 <20191011183253.GV32665@bombadil.infradead.org>
From:   Eric Sandeen <sandeen@redhat.com>
Message-ID: <6e67a39c-88ed-f6a9-16a7-6ae9560a1112@redhat.com>
Date:   Fri, 11 Oct 2019 13:45:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191011183253.GV32665@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Fri, 11 Oct 2019 18:45:54 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/11/19 1:32 PM, Matthew Wilcox wrote:
> On Fri, Oct 11, 2019 at 11:49:38AM -0500, Eric Sandeen wrote:
>> @@ -698,6 +699,13 @@ int invalidate_inodes(struct super_block *sb, bool kill_dirty)
>>  		inode_lru_list_del(inode);
>>  		spin_unlock(&inode->i_lock);
>>  		list_add(&inode->i_lru, &dispose);
>> +
>> +		if (need_resched()) {
>> +			spin_unlock(&sb->s_inode_list_lock);
>> +			cond_resched();
>> +			dispose_list(&dispose);
>> +			goto again;
>> +		}
>>  	}
>>  	spin_unlock(&sb->s_inode_list_lock);
>>  
> 
> Is this equivalent to:
> 
> +		cond_resched_lock(&sb->s_inode_list_lock));
> 
> or is disposing of the list a crucial part here?

I think we need to dispose, or we'll start with the entire ~unmodified list again after the goto:

-Eric


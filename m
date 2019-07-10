Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C503B64BB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 19:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfGJRxN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 13:53:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33926 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbfGJRxM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 13:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8fcd7IbnIeaKZRDWGNY647WsqvJ1v4ulGC4wdseyzjU=; b=tWJ+nMiWEt+cTSzgkEfK4ty17
        p285HhZgqGVQOTNP8uv+ahVLDfACpGUHQpS+e2XwQQIF1SlEdaDwCLqCEg58g0GsCKAurrVl/mlQt
        4aetyL5Lq1it5JU1B2tfyCgS3WFLlG01Y1lHnfunj9DizxuS90uq/WMRvxyqfgj4hxd1CbDulER0U
        pNW8i1l3DgieGo+dXDOLd1SdeJKcnwuQdN1qWuw9ZhKZiIU/OpSRCR3Xy++YvGDlC2sQiZwwPa6qu
        mG1thk1E8xOlMGjXeX0xOJ4X0Jv71AE71WiP2Dw7aZcvS+UWB3ygJqx+CnGcC3kLTVi92Fk52bpYH
        s8lSmyJuA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlGmD-0006lK-Hh; Wed, 10 Jul 2019 17:53:09 +0000
Subject: Re: [RFC PATCH] fanotify, inotify, dnotify, security: add security
 hook for fs notifications
To:     Joe Perches <joe@perches.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>, paul@paul-moore.com
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com, jack@suse.cz,
        amir73il@gmail.com, jmorris@namei.org, sds@tycho.nsa.gov,
        linux-kernel@vger.kernel.org
References: <20190710133403.855-1-acgoide@tycho.nsa.gov>
 <4fd98c88-61a6-a155-5028-db22a778d3c1@schaufler-ca.com>
 <cb754dda-fbce-8169-4cd7-eef66e8d809e@infradead.org>
 <6ce2ce60b2435940bc8dfa07fa2553c4524d2db5.camel@perches.com>
 <079745c94c232591453dcb01c9d9406b721bb6bf.camel@perches.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <60654c12-0742-8653-231b-312f48e0149b@infradead.org>
Date:   Wed, 10 Jul 2019 10:53:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <079745c94c232591453dcb01c9d9406b721bb6bf.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/10/19 10:22 AM, Joe Perches wrote:
> On Wed, 2019-07-10 at 10:18 -0700, Joe Perches wrote:
>> On Wed, 2019-07-10 at 09:49 -0700, Randy Dunlap wrote:
>>> On 7/10/19 9:38 AM, Casey Schaufler wrote:
>>>> On 7/10/2019 6:34 AM, Aaron Goidel wrote:
>>>>> @@ -3261,6 +3262,26 @@ static int selinux_inode_removexattr(struct dentry *dentry, const char *name)
>>>>>  	return -EACCES;
>>>>>  }
>>>>>  
>>>>> +static int selinux_inode_notify(struct inode *inode, u64 mask)
>>>>> +{
>>>>> +	u32 perm = FILE__WATCH; // basic permission, can a watch be set?
>>>>
>>>> We don't use // comments in the Linux kernel.
>>>>
>>>
>>> I thought that we had recently moved into the 21st century on that issue,
>>> but I don't see it mentioned in coding-style.rst.  Maybe we need a Doc update.
>>>
>>> checkpatch allows C99 comments by default.
>>> Joe, do you recall about this?
>>
>> My recollection is it was something I thought was
>> just simple and useful so I added it to checkpatch
>> without going through the negative of the nominal
>> approvals required by modifying CodingStyle.
> 
> https://lkml.org/lkml/2016/7/8/625
> 

Aha, thanks, I don't recall seeing that one.

-- 
~Randy

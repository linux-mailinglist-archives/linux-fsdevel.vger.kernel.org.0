Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96512E187C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 13:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404630AbfJWLGB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 07:06:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17770 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390566AbfJWLGB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:06:01 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9NB4hQu130863
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 07:06:00 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vtnnyr1pa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 07:06:00 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 23 Oct 2019 12:05:57 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 23 Oct 2019 12:05:55 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9NB5sex54263842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 11:05:54 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51DB24C052;
        Wed, 23 Oct 2019 11:05:54 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D04AE4C044;
        Wed, 23 Oct 2019 11:05:51 +0000 (GMT)
Received: from [9.199.158.207] (unknown [9.199.158.207])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Oct 2019 11:05:51 +0000 (GMT)
Subject: Re: [PATCH RESEND 1/1] vfs: Really check for inode ptr in lookup_fast
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        wugyuan@cn.ibm.com, jlayton@kernel.org, hsiangkao@aol.com,
        Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20190927044243.18856-1-riteshh@linux.ibm.com>
 <20191015040730.6A84742047@d06av24.portsmouth.uk.ibm.com>
 <20191022133855.B1B4752050@d06av21.portsmouth.uk.ibm.com>
 <20191022143736.GX26530@ZenIV.linux.org.uk>
 <20191022201131.GZ26530@ZenIV.linux.org.uk>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 23 Oct 2019 16:35:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191022201131.GZ26530@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19102311-4275-0000-0000-00000376149D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102311-4276-0000-0000-000038893B65
Message-Id: <20191023110551.D04AE4C044@d06av22.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-23_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=771 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910230112
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/23/19 1:41 AM, Al Viro wrote:
> On Tue, Oct 22, 2019 at 03:37:36PM +0100, Al Viro wrote:
>> On Tue, Oct 22, 2019 at 07:08:54PM +0530, Ritesh Harjani wrote:
>>> I think we have still not taken this patch. Al?

>> or, for that matter, any callers of filename_lookup() assuming that the
>> lack of ENOENT means that the last call of walk_component() (from lookup_last())
>> has not failed with the same ENOENT and thus the result has been observed
>> positive.
>> You've picked the easiest one to hit, but on e.g. KVM setups you can have the
>> host thread representing the CPU where __d_set_inode_and_type() runs get
>> preempted (by the host kernel), leaving others with much wider window.

I had thought so about the other call sites, but as you said
maybe this was the easiest one to hit.
Then, I kind of followed your suggested fix in below link to fix at 
least this current crash.
https://patchwork.kernel.org/patch/10909881/

>>
>> Sure, we can do that to all callers of d_is_negative/d_is_positive, but...
>> the same goes for any places that assumes that d_is_dir() implies that
>> the sucker is positive, etc.
>>
>> What we have guaranteed is
>> 	* ->d_lock serializes ->d_flags/->d_inode changes
>> 	* ->d_seq is bumped before/after such changes
>> 	* positive dentry never changes ->d_inode as long as you hold
>> a reference (negative dentry *can* become positive right under you)
>>
>> So there are 3 classes of valid users: those holding ->d_lock, those
>> sampling and rechecking ->d_seq and those relying upon having observed
>> the sucker they've pinned to be positive.

:) Thanks for simplifying like this. Agreed.



>>
>> What you've been hitting is "we have it pinned, ->d_flags says it's
>> positive but we still observe the value of ->d_inode from before the
>> store to ->d_flags that has made it look positive".
> 
> Actually, your patch opens another problem there.  Suppose you make
> it d_really_is_positive() and hit the same race sans reordering.
> Dentry is found by __d_lookup() and is negative.  Right after we
> return from __d_lookup() another thread makes it positive (a symlink)
> - ->d_inode is set, d_really_is_positive() becomes true.  OK, on we
> go, pick the inode and move on.  Right?  ->d_flags is still not set
> by the thread that made it positive.  We return from lookup_fast()
> and call step_into().  And get to
>          if (likely(!d_is_symlink(path->dentry)) ||
> Which checks ->d_flags and sees the value from before the sucker
> became positive.  IOW, d_is_symlink() is false here.  If that
> was the last path component and we'd been told to follow links,
> we will end up with positive dentry of a symlink coming out of
> pathname resolution.
> 

hmm. yes, looks like it, based on your above explanation.
So even though this could avoid crash, but still we may end up with
a bogus entry with current patch.



> Similar fun happens if you have mkdir racing with lookup - ENOENT
> is what should've happened if lookup comes first, success - if
> mkdir does.  This way we can hit ENOTDIR, due to false negative
> from d_can_lookup().
> 
> IOW, d_really_is_negative() in lookup_fast() will paper over
> one of oopsen, but it
> 	* won't cover similar oopsen on other codepaths and
> 	* will lead to bogus behaviour.
> 
> I'm not sure that blanket conversion of d_is_... to smp_load_acquire()
> is the right solution; it might very well be that we need to do that
> only on a small subset of call sites, lookup_fast() being one of
> those.  But we do want at least to be certain that something we'd
> got from lookup_fast() in non-RCU mode already has ->d_flags visible.

We may also need similar guarantees with __d_clear_type_and_inode().

So do you think we should make use of ->d_seq for verifying this?
I see both __d_set_inode_and_type & __d_clear_type_and_inode() called
under ->d_seq_begin/->d_seq_end.

Then maybe we should use ->d_seq checking at those call sites.
We cannot unconditionally use ->d_seq checking in __d_entry_type(),
since we sometimes call this function inside ->d_seq_begin
(like in lookup_fast).


> 
> I'm going through the callers right now, will post a followup once
> the things get cleaner...
> 
Thanks for looking into this.


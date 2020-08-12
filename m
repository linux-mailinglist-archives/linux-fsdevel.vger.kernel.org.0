Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E6F242DD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 19:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgHLRHO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 13:07:14 -0400
Received: from linux.microsoft.com ([13.77.154.182]:33702 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbgHLRHN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 13:07:13 -0400
Received: from [10.137.106.139] (unknown [131.107.174.11])
        by linux.microsoft.com (Postfix) with ESMTPSA id E097C20B4908;
        Wed, 12 Aug 2020 10:07:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E097C20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597252032;
        bh=SIe2k0peitBjW17yZJXqD0TtHRPmDC1R6Lbe35xyn4c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PLIfautqDTtZvkV5njfOIjkAj6r6JznMM7OdDU7PlLhgZqfL4Pe2paFWOZNHYGde0
         y2m6/Jc5+vr2IziCujXNmDEaBARiGhY57RfU99LHHeOdaXuDYd4ISc2lqnTHN222lU
         zRHuYBYjX8OqIJoFSc8A8rzTUreTmp+o7KtpdsMg=
Subject: Re: [dm-devel] [RFC PATCH v5 00/11] Integrity Policy Enforcement LSM
 (IPE)
To:     Chuck Lever <chucklever@gmail.com>,
        James Morris <jmorris@namei.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Pavel Machek <pavel@ucw.cz>, Sasha Levin <sashal@kernel.org>,
        snitzer@redhat.com, dm-devel@redhat.com,
        tyhicks@linux.microsoft.com, agk@redhat.com,
        Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>, nramas@linux.microsoft.com,
        serge@hallyn.com, pasha.tatashin@soleen.com,
        Jann Horn <jannh@google.com>, linux-block@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, mdsakib@microsoft.com,
        open list <linux-kernel@vger.kernel.org>, eparis@redhat.com,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        jaskarankhurana@linux.microsoft.com
References: <20200728213614.586312-1-deven.desai@linux.microsoft.com>
 <20200802115545.GA1162@bug> <20200802140300.GA2975990@sasha-vm>
 <20200802143143.GB20261@amd> <1596386606.4087.20.camel@HansenPartnership.com>
 <fb35a1f7-7633-a678-3f0f-17cf83032d2b@linux.microsoft.com>
 <1596639689.3457.17.camel@HansenPartnership.com>
 <alpine.LRH.2.21.2008050934060.28225@namei.org>
 <b08ae82102f35936427bf138085484f75532cff1.camel@linux.ibm.com>
 <329E8DBA-049E-4959-AFD4-9D118DEB176E@gmail.com>
 <alpine.LRH.2.21.2008120643370.10591@namei.org>
 <70603A4E-A548-4ECB-97D4-D3102CE77701@gmail.com>
From:   Deven Bowers <deven.desai@linux.microsoft.com>
Message-ID: <5edd58e3-7f12-10af-ef1c-4c1b32cf99e4@linux.microsoft.com>
Date:   Wed, 12 Aug 2020 10:07:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <70603A4E-A548-4ECB-97D4-D3102CE77701@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/12/2020 7:18 AM, Chuck Lever wrote:
> 
> 
>> On Aug 11, 2020, at 5:03 PM, James Morris <jmorris@namei.org> wrote:
>>
>> On Sat, 8 Aug 2020, Chuck Lever wrote:
>>
>>> My interest is in code integrity enforcement for executables stored
>>> in NFS files.
>>>
>>> My struggle with IPE is that due to its dependence on dm-verity, it
>>> does not seem to able to protect content that is stored separately
>>> from its execution environment and accessed via a file access
>>> protocol (FUSE, SMB, NFS, etc).
>>
>> It's not dependent on DM-Verity, that's just one possible integrity
>> verification mechanism, and one of two supported in this initial
>> version. The other is 'boot_verified' for a verified or otherwise trusted
>> rootfs. Future versions will support FS-Verity, at least.
>>
>> IPE was designed to be extensible in this way, with a strong separation of
>> mechanism and policy.
> 
> I got that, but it looked to me like the whole system relied on having
> access to the block device under the filesystem. That's not possible
> for a remote filesystem like Ceph or NFS.

Block device structure no, (though that's what the currently used, to be
fair). It really has a hard dependency on the file structure,
specifically the ability to determine whether that file structure can be 
used to navigate back to the integrity claim provided by the mechanism.

In the current world of IPE, the integrity claim is the root-hash or 
root-hash-signature on the block device, provided by dm-verity's 
setsecurity hooks (also introduced in this series).

> 
> I'm happy to take a closer look if someone can point me the right way.
> 

Sure, if you look at the 2nd patch, you want to look at the file 
"security/ipe/ipe-property.h", it defines what methods are required to
be implemented by a mechanism to work with IPE. It passes the engine
context which is defined as:

  struct ipe_engine_ctx {
  	enum ipe_op op;
  	enum ipe_hook hook;
  	const struct file *file;
  	const char *audit_pathname;
	const struct ipe_bdev_blob *sec_bdev;
  };

Now, if the security blob existed for the block_device, it would be
in sec_bdev, but that may be NULL, as well to be fair.

If you want a more worked example of how integration works, patches 8
and 10 introduce the dm-verity properties mentioned in this patch.

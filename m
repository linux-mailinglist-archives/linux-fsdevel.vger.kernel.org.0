Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E861D3953
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 20:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgENSqp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 14:46:45 -0400
Received: from smtp-42ac.mail.infomaniak.ch ([84.16.66.172]:46207 "EHLO
        smtp-42ac.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726778AbgENSqp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 14:46:45 -0400
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 49NL912MZTzlhTr0;
        Thu, 14 May 2020 20:46:13 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 49NL8x2tM0zljT02;
        Thu, 14 May 2020 20:46:09 +0200 (CEST)
Subject: Re: [PATCH v17 05/10] fs,landlock: Support filesystem access-control
To:     Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
References: <20200511192156.1618284-1-mic@digikod.net>
 <20200511192156.1618284-6-mic@digikod.net>
 <alpine.LRH.2.21.2005141335280.30052@namei.org>
 <c159d845-6108-4b67-6527-405589fa5382@digikod.net>
 <bcfa8f74-5bc9-b363-5372-b254ba2e88a7@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <2d781760-341e-2f7a-9586-558fcf41a097@digikod.net>
Date:   Thu, 14 May 2020 20:46:08 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <bcfa8f74-5bc9-b363-5372-b254ba2e88a7@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 14/05/2020 17:58, Casey Schaufler wrote:
> On 5/14/2020 3:39 AM, Mickaël Salaün wrote:
>> On 14/05/2020 05:37, James Morris wrote:
>>> On Mon, 11 May 2020, Mickaël Salaün wrote:
>>>
>>>
>>>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>>>> index 45cc10cdf6dd..2276642f8e05 100644
>>>> --- a/include/linux/fs.h
>>>> +++ b/include/linux/fs.h
>>>> @@ -1517,6 +1517,11 @@ struct super_block {
>>>>  	/* Pending fsnotify inode refs */
>>>>  	atomic_long_t s_fsnotify_inode_refs;
>>>>  
>>>> +#ifdef CONFIG_SECURITY_LANDLOCK
>>>> +	/* References to Landlock underlying objects */
>>>> +	atomic_long_t s_landlock_inode_refs;
>>>> +#endif
>>>> +
>>> This needs to be converted to the LSM API via superblock blob stacking.
>>>
>>> See Casey's old patch: 
>>> https://lore.kernel.org/linux-security-module/20190829232935.7099-2-casey@schaufler-ca.com/
>> s_landlock_inode_refs is quite similar to s_fsnotify_inode_refs, but I
>> can do it once the superblock security blob patch is upstream. Is it a
>> blocker for now? What is the current status of lbs_superblock?
> 
> As no currently stackable modules conflict over the superblock
> (SELinux and Smack are the existing users) there has been no need
> to move its management into the infrastructure. The active push for
> stacking does not (yet) include everything needed for SELinux+Smack.
> It includes what is needed for SELinux+AppArmor and Smack+AppArmor.
> That does not include the superblock blob.
> 
> You can include a patch in the landlock set that provides infrastructure
> management of the superblock blob. Feel free to glean it from my proposal.

OK, I'll add it to the next series.

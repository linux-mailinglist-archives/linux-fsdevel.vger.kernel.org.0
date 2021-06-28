Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93CD3B68BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 20:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbhF1S6R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 14:58:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29910 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235540AbhF1S6Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 14:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624906549;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8HinIvCMtHYb1qVrOJ0tRZVpQdvLsbcc131aWbfWsnw=;
        b=SbUGlsIVl78h0uiaemPWM9cGzfxZKn3Rt6n7IizhzS0V1sNU8zsSocDshgkybG0mgfwgK9
        rTSMZO4DbfQOULSxs8ZT5SE30obdTmrqXNcr+eVk5AuNr0fcS/7XBG+rRwa5d5cKt9hM4k
        DNRznjKrR0iCeylsVPvunnuRxnsNHGA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-jatOE6HYOFCMJRYZh3jPbA-1; Mon, 28 Jun 2021 14:55:48 -0400
X-MC-Unique: jatOE6HYOFCMJRYZh3jPbA-1
Received: by mail-qv1-f72.google.com with SMTP id u6-20020a0cdd060000b029028eafc445e1so2077246qvk.22
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 11:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=8HinIvCMtHYb1qVrOJ0tRZVpQdvLsbcc131aWbfWsnw=;
        b=ZBj3XyuU+JRxeaKrNK5doIfeKC1unJFM8bHLeLlns/lQB1niaWtODDbIlRkeRXCCXc
         HKVHDLlhMGI/PBaikuoMlSG5i/o1mIJ8cBth//sZEaMnC8ncC9AdCvMnHgPoa09qPSKg
         b3t6R0glCADvY5gA176VhjZCkqoLljx4upee1UyGpPhkRS0XtPhDexpCuYxq9iRS5ckt
         8kjuNNNqXuXRHwhXwiER7qOzl2GlRIQ1cfr4PmCrtXBdLakxyT2nQO2K+5nz6QVPxLP5
         3hqIdDvStAnFYxpW1CLXoAq3sLmCGcs0gt9rqKMN/cykG766vBCONTd+HPB6/2lxhOtC
         BnPA==
X-Gm-Message-State: AOAM533ypB0gtFX+MnzxstRhe2OkvbdkdguMEDJWQ1NUCJXgDzovBQ6r
        10BbaVWyGnEi+UHZZ/1qiWibK/tfNu1IVM+L9b/lM8i5ISlQK4IeAs/GfKzjzgefN23ojJMJsbx
        4vVwogKqH1xC7adi/AlbqA+rCJw==
X-Received: by 2002:a05:622a:1103:: with SMTP id e3mr19263972qty.390.1624906547849;
        Mon, 28 Jun 2021 11:55:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqEW/3cBf2LZoNrjSfaumssIJCB2Hs91eIgGjWvxLJcGsx/bwi1i70Q1f4gaNmEkrdoTFZCQ==
X-Received: by 2002:a05:622a:1103:: with SMTP id e3mr19263956qty.390.1624906547630;
        Mon, 28 Jun 2021 11:55:47 -0700 (PDT)
Received: from localhost.localdomain (cpe-74-65-150-180.maine.res.rr.com. [74.65.150.180])
        by smtp.gmail.com with ESMTPSA id e12sm6878175qtj.3.2021.06.28.11.55.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 11:55:46 -0700 (PDT)
Reply-To: dwalsh@redhat.com
Subject: Re: [RFC PATCH 0/1] xattr: Allow user.* xattr on symlink/special
 files if caller has CAP_SYS_RESOURCE
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        "berrange@redhat.com" <berrange@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
References: <20210625191229.1752531-1-vgoyal@redhat.com>
 <BN0PR11MB57275823CE05DED7BC755460FD069@BN0PR11MB5727.namprd11.prod.outlook.com>
 <20210628131708.GA1803896@redhat.com>
 <1b446468-dcf8-9e21-58d3-c032686eeee5@redhat.com>
 <5d8f033c-eba2-7a8b-f19a-1005bbb615ea@schaufler-ca.com>
From:   Daniel Walsh <dwalsh@redhat.com>
Organization: Red Hat
Message-ID: <69016bdc-fcf1-34df-1663-42d8f57c927c@redhat.com>
Date:   Mon, 28 Jun 2021 14:55:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5d8f033c-eba2-7a8b-f19a-1005bbb615ea@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/28/21 12:04, Casey Schaufler wrote:
> On 6/28/2021 6:36 AM, Daniel Walsh wrote:
>> On 6/28/21 09:17, Vivek Goyal wrote:
>>> On Fri, Jun 25, 2021 at 09:49:51PM +0000, Schaufler, Casey wrote:
>>>>> -----Original Message-----
>>>>> From: Vivek Goyal <vgoyal@redhat.com>
>>>>> Sent: Friday, June 25, 2021 12:12 PM
>>>>> To: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>>> viro@zeniv.linux.org.uk
>>>>> Cc: virtio-fs@redhat.com; dwalsh@redhat.com; dgilbert@redhat.com;
>>>>> berrange@redhat.com; vgoyal@redhat.com
>>>> Please include Linux Security Module list <linux-security-module@vger.kernel.org>
>>>> and selinux@vger.kernel.org on this topic.
>>>>
>>>>> Subject: [RFC PATCH 0/1] xattr: Allow user.* xattr on symlink/special files if
>>>>> caller has CAP_SYS_RESOURCE
>>>>>
>>>>> Hi,
>>>>>
>>>>> In virtiofs, actual file server is virtiosd daemon running on host.
>>>>> There we have a mode where xattrs can be remapped to something else.
>>>>> For example security.selinux can be remapped to
>>>>> user.virtiofsd.securit.selinux on the host.
>>>> This would seem to provide mechanism whereby a user can violate
>>>> SELinux policy quite easily.
>>> Hi Casey,
>>>
>>> As david already replied, we are not bypassing host's SELinux policy (if
>>> there is one). We are just trying to provide a mode where host and
>>> guest's SELinux policies could co-exist without interefering
>>> with each other.
>>>
>>> By remappming guests SELinux xattrs (and not host's SELinux xattrs),
>>> a file probably will have two xattrs
>>>
>>> "security.selinux" and "user.virtiofsd.security.selinux". Host will
>>> enforce SELinux policy based on security.selinux xattr and guest
>>> will see the SELinux info stored in "user.virtiofsd.security.selinux"
>>> and guest SELinux policy will enforce rules based on that.
>>> (user.virtiofsd.security.selinux will be remapped to "security.selinux"
>>> when guest does getxattr()).
>>>
>>> IOW, this mode is allowing both host and guest SELinux policies to
>>> co-exist and not interefere with each other. (Remapping guests's
>>> SELinux xattr is not changing hosts's SELinux label and is not
>>> bypassing host's SELinux policy).
>>>
>>> virtiofsd also provides for the mode where if guest process sets
>>> SELinux xattr it shows up as security.selinux on host. But now we
>>> have multiple issues. There are two SELinux policies (host and guest)
>>> which are operating on same lable. And there is a very good chance
>>> that two have not been written in such a way that they work with
>>> each other. In fact there does not seem to exist a notion where
>>> two different SELinux policies are operating on same label.
>>>
>>> At high level, this is in a way similar to files created on
>>> virtio-blk devices. Say this device is backed by a foo.img file
>>> on host. Now host selinux policy will set its own label on
>>> foo.img and provide access control while labels created by guest
>>> are not seen or controlled by host's SELinux policy. Only guest
>>> SELinux policy works with those labels.
>>>
>>> So this is similar kind of attempt. Provide isolation between
>>> host and guests's SELinux labels so that two policies can
>>> co-exist and not interfere with each other.
>>>
>>>>> This remapping is useful when SELinux is enabled in guest and virtiofs
>>>>> as being used as rootfs. Guest and host SELinux policy might not match
>>>>> and host policy might deny security.selinux xattr setting by guest
>>>>> onto host. Or host might have SELinux disabled and in that case to
>>>>> be able to set security.selinux xattr, virtiofsd will need to have
>>>>> CAP_SYS_ADMIN (which we are trying to avoid). Being able to remap
>>>>> guest security.selinux (or other xattrs) on host to something else
>>>>> is also better from security point of view.
>>>> Can you please provide some rationale for this assertion?
>>>> I have been working with security xattrs longer than anyone
>>>> and have trouble accepting the statement.
>>> If guest is not able to interfere or change host's SELinux labels
>>> directly, it sounded better.
>>>
>>> Irrespective of this, my primary concern is that to allow guest
>>> VM to be able to use SELinux seamlessly in diverse host OS
>>> environments (typical of cloud deployments). And being able to
>>> provide a mode where host and guest's security labels can
>>> co-exist and policies can work independently, should be able
>>> to achieve that goal.
>>>
>>>>> But when we try this, we noticed that SELinux relabeling in guest
>>>>> is failing on some symlinks. When I debugged a little more, I
>>>>> came to know that "user.*" xattrs are not allowed on symlinks
>>>>> or special files.
>>>>>
>>>>> "man xattr" seems to suggest that primary reason to disallow is
>>>>> that arbitrary users can set unlimited amount of "user.*" xattrs
>>>>> on these files and bypass quota check.
>>>>>
>>>>> If that's the primary reason, I am wondering is it possible to relax
>>>>> the restrictions if caller has CAP_SYS_RESOURCE. This capability
>>>>> allows caller to bypass quota checks. So it should not be
>>>>> a problem atleast from quota perpective.
>>>>>
>>>>> That will allow me to give CAP_SYS_RESOURCE to virtiofs deamon
>>>>> and remap xattrs arbitrarily.
>>>> On a Smack system you should require CAP_MAC_ADMIN to remap
>>>> security. xattrs. I sounds like you're in serious danger of running afoul
>>>> of LSM attribute policy on a reasonable general level.
>>> I think I did not explain xattr remapping properly and that's why this
>>> confusion is there. Only guests's xattrs will be remapped and not
>>> hosts's xattr. So one can not bypass any access control implemented
>>> by any of the LSM on host.
>>>
>>> Thanks
>>> Vivek
>>>
>> I want to point out that this solves a  couple of other problems also.
> I am not (usually) adverse to solving problems. My concern is with
> regard to creating new ones.
>
>> Currently virtiofsd attempts to write security attributes on the host, which is denied by default on systems without SELinux and no CAP_SYS_ADMIN.
> Right. Which is as it should be.
> Also, s/SELinux/a LSM that uses security xattrs/
>
>>    This means if you want to run a container or VM
> A container uses the kernel from the host. A VM uses the kernel
> from the guest. Unless you're calling a VM a container for
> marketing purposes. If this scheme works for non-VM based containers
> there's a problem.
That is your definition of a container.  Our definition includes 
container workloads within kvm separation along with their own kernels. 
(Kata and libkrun).  As opposed to VM workloads which run full operating 
system workloads including systemd, logging, cron, sshd ...
>> on a host without SELinux support but the VM has SELinux enabled, then virtiofsd needs CAP_SYS_ADMIN.  It would be much more secure if it only needed CAP_SYS_RESOURCE.
> I don't know, so I'm asking. Does virtiofsd really get run with limited capabilities,
> or does it get run as root like most system daemons? If it runs as root the argument
> has no legs.
I believe it should almost always get run with limited privileges, we 
are opening a whole from the kvm separated workload into the host.  If 
there is a bug in virtiofsd, it can attack the host.
>>    If the host has SELinux enabled then it can run without CAP_SYS_ADMIN or CAP_SYS_RESOURCE, but it will only be allowed to write labels that the host system understands, any label not understood will be blocked. Not only this, but the label that is running virtiofsd pretty much has to run as unconfined, since it could be writing any SELinux label.
> You could fix that easily enough by teaching SELinux about the proper
> use of CAP_MAC_ADMIN. Alas, I understand that there's no way that's
> going to happen, and why it would be considered philosophically repugnant
> in the SELinux community.
Sure, but this ignores the more important next comment.
>> If virtiofsd is writing Userxattrs with CAP_SYS_RESOURCE, then we can run with a confined SELinux label only allowing it to sexattr on the content in the designated directory, make the container/vm much more secure.
>>
> User xattrs are less protected than security xattrs. You are exposing the
> security xattrs on the guest to the possible whims of a malicious, unprivileged
> actor on the host. All it needs is the right UID.
>
> We have unused xattr namespaces. Would using the "trusted" namespace
> work for your purposes?
>
No because they bring their own issues, and can not be used without 
CAP_SYS_ADMIN.

My number one concern is attacks from the kvm separated work space 
against the host, since virtiofsd is opening up the attack vector.  
Running it with the least privs possible from the MAC and DAC point of 
view is the goal.



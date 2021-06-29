Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9DF3B7960
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 22:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbhF2UbD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 16:31:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48913 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235506AbhF2Ua6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 16:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624998509;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qe7cO7mpeKYSPAW3JclQzTAT82wV6nS1Y2KDeR28ebA=;
        b=Qwkj2ZCOJ9C3FlX17w6FQxH4NS6a9XZaXzmCMg8HMEjdANYUPIMPsTWuPuU4dOB5MVY1qc
        xQqSHfZg628qBS7mQEIx93kF2XwmpyCq4SfQIqz5I9I16G6ARIxBaoLMjK1j3smCQq1c/K
        nJkuHODB0I/sWK1g3NONzfjvJ4G7Paw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-EFGuxjzKPO25E85mvTyClw-1; Tue, 29 Jun 2021 16:28:27 -0400
X-MC-Unique: EFGuxjzKPO25E85mvTyClw-1
Received: by mail-qt1-f200.google.com with SMTP id d26-20020ac847da0000b0290250c4d73502so4586164qtr.20
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jun 2021 13:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=Qe7cO7mpeKYSPAW3JclQzTAT82wV6nS1Y2KDeR28ebA=;
        b=S22UNbyaOBTjoPuLCtGVp6DjWwchvgskuojUivxf+elKMb+xVQjOKL2qqfVN1ce1qW
         ey4lriIE+6v6stenVNCXOTHhIxQ8QOV+PiEgCvuXbJfAkyH9qNcaHxIDNJzR0bJg3n1R
         ydwMCAFjUPT3eYzSfUfXmgeXHGkiVIKpd2saVjQcK3Ro4E/kbuvAvYkGDfAmrc06ozR/
         UIINb5gpzLmVmZpxukPSXBKSBSE3xIoOhFFEByRDXsG8WUbitsOmgeJuTMDBz4GCW/F/
         1OOwuGxfHH8u5JfahAkVoD1b3gqlyIvCQ4J9geys8gv1MmrJRFaqu2ooCR+2xLOAkLeo
         AQSA==
X-Gm-Message-State: AOAM531QkzdYb1BAGz7uqTyA0tLCqFgnkF5/CQBzQ/b+u6lGa1hqhOf2
        AgPA4OP1wxq+9oNler2PAIKZoqIVDDhyz0XPrTZp7LW4VZwI2z3cKTAHr1zy2L5u2f/QDKVg0OM
        mUDI8gskXdLvSlVR9N8wdZ+Zsrw==
X-Received: by 2002:a37:5646:: with SMTP id k67mr32407692qkb.333.1624998507523;
        Tue, 29 Jun 2021 13:28:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+y8RUwhLqAwixJVYSR0nEBkuaoQfKDwogR7bN19ijIyOgKyo2J6TkvVQredHzeCKP9yFU8A==
X-Received: by 2002:a37:5646:: with SMTP id k67mr32407667qkb.333.1624998507292;
        Tue, 29 Jun 2021 13:28:27 -0700 (PDT)
Received: from localhost.localdomain (cpe-74-65-150-180.maine.res.rr.com. [74.65.150.180])
        by smtp.gmail.com with ESMTPSA id k19sm8094710qta.90.2021.06.29.13.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 13:28:26 -0700 (PDT)
Reply-To: dwalsh@redhat.com
Subject: Re: [RFC PATCH 0/1] xattr: Allow user.* xattr on symlink/special
 files if caller has CAP_SYS_RESOURCE
To:     Vivek Goyal <vgoyal@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
        "berrange@redhat.com" <berrange@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
References: <BN0PR11MB57275823CE05DED7BC755460FD069@BN0PR11MB5727.namprd11.prod.outlook.com>
 <20210628131708.GA1803896@redhat.com>
 <1b446468-dcf8-9e21-58d3-c032686eeee5@redhat.com>
 <5d8f033c-eba2-7a8b-f19a-1005bbb615ea@schaufler-ca.com>
 <YNn4p+Zn444Sc4V+@work-vm>
 <a13f2861-7786-09f4-99a8-f0a5216d0fb1@schaufler-ca.com>
 <YNrhQ9XfcHTtM6QA@work-vm>
 <e6f9ed0d-c101-01df-3dff-85c1b38f9714@schaufler-ca.com>
 <20210629152007.GC5231@redhat.com>
 <78663f5c-d2fd-747a-48e3-0c5fd8b40332@schaufler-ca.com>
 <20210629173530.GD5231@redhat.com>
From:   Daniel Walsh <dwalsh@redhat.com>
Organization: Red Hat
Message-ID: <f4992b3a-a939-5bc4-a5da-0ce8913bd569@redhat.com>
Date:   Tue, 29 Jun 2021 16:28:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629173530.GD5231@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/29/21 13:35, Vivek Goyal wrote:
> On Tue, Jun 29, 2021 at 09:13:48AM -0700, Casey Schaufler wrote:
>> On 6/29/2021 8:20 AM, Vivek Goyal wrote:
>>> On Tue, Jun 29, 2021 at 07:38:15AM -0700, Casey Schaufler wrote:
>>>
>>> [..]
>>>>>>>> User xattrs are less protected than security xattrs. You are exposing the
>>>>>>>> security xattrs on the guest to the possible whims of a malicious, unprivileged
>>>>>>>> actor on the host. All it needs is the right UID.
>>>>>>> Yep, we realise that; but when you're mainly interested in making sure
>>>>>>> the guest can't attack the host, that's less worrying.
>>>>>> That's uncomfortable.
>>>>> Why exactly?
>>>> If a mechanism is designed with a known vulnerability you
>>>> fail your validation/evaluation efforts.
>>> We are working with the constraint that shared directory should not be
>>> accessible to unpriviliged users on host. And with that constraint, what
>>> you are referring to is not a vulnerability.
>> Sure, that's quite reasonable for your use case. It doesn't mean
>> that the vulnerability doesn't exist, it means you've mitigated it.
>>
>>
>>>> Your mechanism is
>>>> less general because other potential use cases may not be
>>>> as cavalier about the vulnerability.
>>> Prefixing xattrs with "user.virtiofsd" is just one of the options.
>>> virtiofsd has the capability to prefix "trusted.virtiofsd" as well.
>>> We have not chosen that because we don't want to give it CAP_SYS_ADMIN.
>>>
>>> So other use cases which don't like prefixing "user.virtiofsd", can
>>> give CAP_SYS_ADMIN and work with it.
>>>
>>>> I think that you can
>>>> approach this differently, get a solution that does everything
>>>> you want, and avoid the known problem.
>>> What's the solution? Are you referring to using "trusted.*" instead? But
>>> that has its own problem of giving CAP_SYS_ADMIN to virtiofsd.
>> I'm coming to the conclusion that xattr namespaces, analogous
>> to user namespaces, are the correct solution. They generalize
>> for multiple filesystem and LSM use cases. The use of namespaces
>> is well understood, especially in the container community. It
>> looks to me as if it would address your use case swimmingly.
> Even if xattrs were namespaced, I am not sure it solves the issue
> of unpriviliged UID being able to modify security xattrs of file.
> If it happens to be correct UID, it should be able to spin up a
> user namespace and modify namespaced xattrs?
>
> Anyway, once namespaced xattrs are available, I will gladly make use
> of it. But that probably should not be a blocker for this patch.
>
> Vivek
>
All this conversation is great, and I look forward to a better solution, 
but if we go back to the patch, it was to fix an issue where the kernel 
is requiring CAP_SYS_ADMIN for writing user Xattrs on link files and 
other special files.

The documented reason for this is to prevent the users from using XATTRS 
to avoid quota.

The CAP_SYS_RESOURCE capability is denfined to allow processes with this 
capability to ignore quota.

This PR allows processes with CAP_SYS_RESOURCE to create user Xattrs.

To me this makes sense.

Is there any argument against this?


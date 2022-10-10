Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB155F96B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 04:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiJJCDF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Oct 2022 22:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiJJCDE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Oct 2022 22:03:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDB753D17
        for <linux-fsdevel@vger.kernel.org>; Sun,  9 Oct 2022 19:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665367381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A9D5wip/7UzsP48lsG4dlIjjptcfG4NcBff3j6uyHfY=;
        b=OgXZ6ZsbOmTfhUlvIkOn3sCcpocKmTQ8FpQwoaRMJLmEnQGVjN4v4yD5GrTRnkzgGoYGiW
        oWhbpqRheO6+50xSbB64IsdOnbuctEzGVd1DQS3CRT19ZD90b644IBfILzmy/KNUWGj3U1
        BQWxEgerEmOBTrAI+LXfeZ+PuBJ0fM0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-440-Veo5EjDkMfSiL3mplcCsug-1; Sun, 09 Oct 2022 22:03:00 -0400
X-MC-Unique: Veo5EjDkMfSiL3mplcCsug-1
Received: by mail-pl1-f197.google.com with SMTP id q3-20020a17090311c300b0017898180dddso7167650plh.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Oct 2022 19:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A9D5wip/7UzsP48lsG4dlIjjptcfG4NcBff3j6uyHfY=;
        b=whTPJSCd2BnBcXYWaRie9wPtM7wEUiMRt00U0Wq3QoO0BgHdB8QSrboxRkGok7FyI0
         l6cNYBeFpfzNxO6HLD0a8A0+2fRcu+CV251X2DKexCyf8++Yu009XK/5130aFI9P9/YS
         RA/PgrEGLt2Sj5y8c/fy9AHQLDDQ+hLqLVr3pny3A34wnZIePUmWlKBKBzFULXWWgI8R
         agY1gq3yRi+/Srd1teHha7U3MYHcius7GcWN9b0MCa542gXeHLgXHmGinRP6xRttippp
         dHZxZN/61ITenJF4sdtT9sPM2Exvx/9+y63Q7mQv07mh34s21dEL4oUtywPi4bcuPv4x
         1SQg==
X-Gm-Message-State: ACrzQf1gBekunpQILfX0BhgcIMQ68F0N1v3ZGnzFDNFyyyIlYbQ6KwHw
        8ERPTssRNWb3tNgV76UYfCLPASCnQwWQZxQVpEctXr7LxnH3W8Khwma3IAStHVeIWkrES4YA8iD
        oshupedgu7kCG/Uzcymm9OyB1Zw==
X-Received: by 2002:a17:903:11cc:b0:178:aec1:18c3 with SMTP id q12-20020a17090311cc00b00178aec118c3mr17054746plh.91.1665367379152;
        Sun, 09 Oct 2022 19:02:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM52Q497ExWyGQB53YxhyR85Pul+6YxQWQ9Mz57/zd++9ekxn6RSUEmUXpw/wZAKRHHG71trjQ==
X-Received: by 2002:a17:903:11cc:b0:178:aec1:18c3 with SMTP id q12-20020a17090311cc00b00178aec118c3mr17054717plh.91.1665367378848;
        Sun, 09 Oct 2022 19:02:58 -0700 (PDT)
Received: from [10.72.12.247] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n9-20020a170903110900b00176cdd80148sm5291984plh.305.2022.10.09.19.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 19:02:58 -0700 (PDT)
Subject: Re: [PATCH] fs/ceph/super: add mount options "snapdir{mode,uid,gid}"
To:     Max Kellermann <max.kellermann@ionos.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     idryomov@gmail.com, jlayton@kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220927120857.639461-1-max.kellermann@ionos.com>
 <88f8941f-82bf-5152-b49a-56cb2e465abb@redhat.com>
 <CAKPOu+88FT1SeFDhvnD_NC7aEJBxd=-T99w67mA-s4SXQXjQNw@mail.gmail.com>
 <75e7f676-8c85-af0a-97b2-43664f60c811@redhat.com>
 <CAKPOu+-rKOVsZ1T=1X-T-Y5Fe1MW2Fs9ixQh8rgq3S9shi8Thw@mail.gmail.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <baf42d14-9bc8-93e1-3d75-7248f93afbd2@redhat.com>
Date:   Mon, 10 Oct 2022 10:02:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAKPOu+-rKOVsZ1T=1X-T-Y5Fe1MW2Fs9ixQh8rgq3S9shi8Thw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 09/10/2022 18:27, Max Kellermann wrote:
> On Sun, Oct 9, 2022 at 10:43 AM Xiubo Li <xiubli@redhat.com> wrote:
>> I mean CEPHFS CLIENT CAPABILITIES [1].
> I know that, but that's suitable for me. This is client-specific, not
> user (uid/gid) specific.
>
> In my use case, a server can run unprivileged user processes which
> should not be able create snapshots for their own home directory, and
> ideally they should not even be able to traverse into the ".snap"
> directory and access the snapshots created of their home directory.
> Other (non-superuser) system processes however should be able to
> manage snapshots. It should be possible to bind-mount snapshots into
> the user's mount namespace.
>
> All of that is possible with my patch, but impossible with your
> suggestion. The client-specific approach is all-or-nothing (unless I
> miss something vital).
>
>> The snapdir name is a different case.
> But this is only about the snapdir. The snapdir does not exist on the
> server, it is synthesized on the client (in the Linux kernel cephfs
> code).

This could be applied to it's parent dir instead as one metadata in mds 
side and in client side it will be transfer to snapdir's metadata, just 
like what the snapshots.

But just ignore this approach.

>> But your current approach will introduce issues when an UID/GID is reused after an user/groud is deleted ?
> The UID I would specify is one which exists on the client, for a
> dedicated system user whose purpose is to manage cephfs snapshots of
> all users. The UID is created when the machine is installed, and is
> never deleted.

This is an ideal use case IMO.

I googled about reusing the UID/GID issues and found someone has hit a 
similar issue in their use case.

>> Maybe the proper approach is the posix acl. Then by default the .snap dir will inherit the permission from its parent and you can change it as you wish. This permission could be spread to all the other clients too ?
> No, that would be impractical and unreliable.
> Impractical because it would require me to walk the whole filesystem
> tree and let the kernel synthesize the snapdir inode for all
> directories and change its ACL;

No, it don't have to. This could work simply as the snaprealm hierarchy 
thing in kceph.

Only the up top directory need to record the ACL and all the descendants 
will point and use it if they don't have their own ACLs.

>   impractical because walking millions
> of directories takes longer than I am willing to wait.
> Unreliable because there would be race problems when another client
> (or even the local client) creates a new directory. Until my local
> "snapdir ACL daemon" learns about the existence of the new directory
> and is able to update its ACL, the user can already have messed with
> it.

For multiple clients case I think the cephfs capabilities [3] could 
guarantee the consistency of this. While for the single client case if 
before the user could update its ACL just after creating it someone else 
has changed it or messed it up, then won't the existing ACLs have the 
same issue ?

[3] https://docs.ceph.com/en/quincy/cephfs/capabilities/


> Both of that is not a problem with my patch.
>
Jeff,

Any idea ?

Thanks!

- Xiubo



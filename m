Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A9B57214F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 18:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbiGLQrO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 12:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiGLQrN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79C4426550
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 09:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657644431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G3Svshh0CSIKBecEYyWOPWehxtR8pBn+wN2kw/qyhZM=;
        b=PlaQXlLZ+5tVZOf6logywhOEMlg7pK+S+MXygk67cvguXwmuWEMK3UArtx+mqiGsZoSXn/
        BhKfVC0G8CAGp+fKCz9b9Grj8dGuS4tUwLpYwQoNg/F64eqP2r69z3d5UYwiyoxGD98hwm
        4uP6BF/mS5FhdAwBctUKAeYbZoYo3i8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-6coTC7AOMUyVvxJ9Rq57pA-1; Tue, 12 Jul 2022 12:47:08 -0400
X-MC-Unique: 6coTC7AOMUyVvxJ9Rq57pA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC23C1C04B4C;
        Tue, 12 Jul 2022 16:47:07 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.48.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 99E0E40CF8E4;
        Tue, 12 Jul 2022 16:47:06 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     "David Howells" <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, "Ian Kent" <raven@themaw.net>,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Linux Containers" <containers@lists.linux.dev>
Subject: Re: [RFC PATCH 0/2] Keyagents: another call_usermodehelper approach
 for namespaces
Date:   Tue, 12 Jul 2022 12:47:05 -0400
Message-ID: <148B818D-0F61-42F6-A0EA-20D060E42560@redhat.com>
In-Reply-To: <875yk25scg.fsf@email.froward.int.ebiederm.org>
References: <cover.1657624639.git.bcodding@redhat.com>
 <875yk25scg.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12 Jul 2022, at 10:16, Eric W. Biederman wrote:

> Adding the containers list to the discussion so more interested people
> have a chance of seeing this.
>
> Benjamin Coddington <bcodding@redhat.com> writes:
>
>> A persistent unsolved problem exists: how can the kernel find and/or =

>> create
>> the appropriate "container" within which to execute a userspace =

>> program to
>> construct keys or satisfy users of call_usermodehelper()?
>>
>> I believe the latest serious attempt to solve this problem was =

>> David's "Make
>> containers kernel objects":
>> https://lore.kernel.org/lkml/149547014649.10599.12025037906646164347.s=
tgit@warthog.procyon.org.uk/
>>
>> Over in NFS' space, we've most recently pondered this issue while =

>> looking at
>> ways to pass a kernel socket to userspace in order to handle TLS =

>> events:
>> https://lore.kernel.org/linux-nfs/E2BF9CFF-9361-400B-BDEE-CF5E0AFDCA63=
@redhat.com/
>>
>> The problem is that containers are not kernel objects, rather a =

>> collection
>> of namespaces, cgroups, etc.  Attempts at making the kernel aware of
>> containers have been mired in discussion and problems.  It has been
>> suggested that the best representation of a "container" from the =

>> kernel's
>> perspective is a process.
>>
>> Keyagents are processes represented by a key.  If a keyagent's key is =

>> linked
>> to a session_keyring, it can be sent a realtime signal when a calling
>> process requests a matching key_type.  That signal will dispatch the =

>> process
>> to construct the desired key within the keyagent process context.  =

>> Keyagents
>> are similar to ssh-agents.  To use a keyagent, one must execute a =

>> keyagent
>> process in the desired context, and then link the keyagent's key onto =

>> other
>> process' session_keyrings.
>>
>> This method of linking keyagent keys to session_keyrings can be used =

>> to
>> construct the various mappings of callers to keyagents that =

>> containers may
>> need.  A single keyagent process can answer request-key upcalls =

>> across
>> container boundaries, or upcalls can be restricted to specific =

>> containers.
>>
>> I'm aware that building on realtime signals may not be a popular =

>> choice, but
>> using realtime signals makes this work simple and ensures delivery.  =

>> Realtime
>> signals are able to convey everything needed to construct keys in =

>> userspace:
>> the under-construction key's serial number.
>>
>> This work is not complete; it has security implications, it needs
>> documentation, it has not been reviewed by anyone.  Thanks for =

>> reading this
>> RFC.  I wish to collect criticism and validate this approach.
>
> At a high level I do agree that we need to send a message to a =

> userspace
> process and that message should contain enough information to start =

> the
> user mode helper.
>
> Then a daemon or possibly the container init can receive the message
> and dispatch the user mode helper.
>
> Fundamentally that design solves all of the container issues, and I
> think solves a few of the user mode helper issues as well.
>
> The challenge with this design is that it requires someone standing up =

> a
> daemon to receive the messages and call a user mode helper to retain
> compatibility with current systems.

Yes..

> I would prefer to see a file descriptor rather than a signal used to
> deliver the message.  Signals suck for many many reasons and a file
> descriptor based notification potentially can be much simpler.

In the example keyagent on userspace side, signal handling is done with
signalfd(2), which greatly simplifies things.

> One of those many reasons is that by not following the common pattern
> for filling in kernel_siginfo you have left uninitialized padding in
> your structure that will be copied to userspace thus creating a kernel
> information leak.  Similarly your code doesn't fill in about half the
> fields that are present in the siginfo union for the _rt case.

Yes, I just used the stack and only filled in the bare minimum.

> I think a file descriptor based design could additionally address the
> back and forth your design needs with keys to figure out what event =

> has
> happened and what user mode helper to invoke.

The keys have already built out a fairly rich interface for accepting
authorization keys, and instantiating partially-constructed keys.  I =

think
the only communication needed (currently) is to dispatch and pass the =

key
serial value.

If we used file descriptors instead of rt signals, there'd be some =

protocol
engineering to do.

> Ideally I would also like to see a design less tied to keys.  So that =

> we
> could use this for the other user mode helper cases as well.   That =

> said
> solving request_key appears to be the truly important part, there =

> aren't
> many other user mode helpers.  Still it would be nice if in theory the
> design could be used to dispatch the coredump helper as well.

What if there was a key_type "usermode_helper"?  Requesting a key of =

that
type executes the binary specified in the callout info.  A keyagent =

could
satisfy the creation of this key, which would allow the usermode_helper
process to execute in the context of a container.  If no keyagent, fall =

back
to the legacy call_usermode_helper.

Thanks for the look,
Ben


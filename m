Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50079638486
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 08:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiKYHin (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 02:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKYHil (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 02:38:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C93A1C13A
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Nov 2022 23:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669361869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BK1d2Dl2urZZ8skwDMJPJaZui4B2C1Jgbod8qqP283s=;
        b=BMDG7qjm1Ek77IRiyq50h1XKlO8OSTY1wphFuoaZIBQXmUAUHwn7+vUwqrVWi8u//lbTCP
        FE3GTR9PayP4Hcsus5bcVB+Rod+2WCLkbByie3XUZ00Q2ysQVgJZNQwb/c4CslDY2Fey3l
        q95bX8O/aSkuRfDI7UGXGoX6sZq8SwQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-648-G49SNh7jPbufrDaGShNuRw-1; Fri, 25 Nov 2022 02:37:48 -0500
X-MC-Unique: G49SNh7jPbufrDaGShNuRw-1
Received: by mail-qt1-f198.google.com with SMTP id y19-20020a05622a121300b003a526e0ff9bso3515795qtx.15
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Nov 2022 23:37:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BK1d2Dl2urZZ8skwDMJPJaZui4B2C1Jgbod8qqP283s=;
        b=VMprMjCh1Z8HgLpAVKwpOjnKthEFsKoZdpMeV9rp/LTx+8nTOJsMw8QrZIQ+ucUsWh
         SGZomCx72X9S2kCCtS4Zst7+UjRyrTa0V/9fCkui7S8XoV3Yd6joGqEmRjwtQEYICTZE
         jn1kp43OXPBggGw0MOtHpO82KONWDZr9ilOPWUrcmFH3yHh79FZpYMfcTvKOArGbvBUg
         X4mOY1nMigALEBF1dZYrREtYziKv+VFCRc2MKnjib1Zf8fv5rN6nHTHE2UaHnw1Ff1QB
         nl/VzLgZiNSep3+6sf4Kw06mf6+JH05tiRptsSaiJlS814FSHhA7Akwp8ki2CS2kPubL
         rOTg==
X-Gm-Message-State: ANoB5plBcQ1W103R329/k9TrO+idRZJwrPYPO9jnfz284hRWyjCXMJj5
        /luDgO+JkOBtqmU+AbeYGhjrbvWFV7CYWZqVZHQggOdwY43kkPEd+LkpklefM2BXt7lGyTKJbiH
        Kjy5cWe4+GOtXVWvapAV68N7aig==
X-Received: by 2002:a0c:ec4a:0:b0:4bb:c9fc:cae5 with SMTP id n10-20020a0cec4a000000b004bbc9fccae5mr16972914qvq.1.1669361867555;
        Thu, 24 Nov 2022 23:37:47 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5787UYM9UBlkRy9aePQckj7hw4zIY1MXgp4O2i10CZdW+hyPxmFbOia9KT1gU4r19n7SJvHw==
X-Received: by 2002:a0c:ec4a:0:b0:4bb:c9fc:cae5 with SMTP id n10-20020a0cec4a000000b004bbc9fccae5mr16972901qvq.1.1669361867297;
        Thu, 24 Nov 2022 23:37:47 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id bj15-20020a05620a190f00b006cbe3be300esm2322198qkb.12.2022.11.24.23.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 23:37:46 -0800 (PST)
Message-ID: <3aa42e668930900cf49283e0c8c8a13d754c5204.camel@redhat.com>
Subject: Re: [PATCH v2] epoll: use refcount to reduce ep_mutex contention
From:   Paolo Abeni <pabeni@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jason Baron <jbaron@akamai.com>,
        Roman Penyaev <rpenyaev@suse.de>, netdev@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>
Date:   Fri, 25 Nov 2022 08:37:43 +0100
In-Reply-To: <Y3/4FW4mqY3fWRfU@sol.localdomain>
References: <f35e58ed5af8131f0f402c3dc6c3033fa96d1843.1669312208.git.pabeni@redhat.com>
         <Y3/4FW4mqY3fWRfU@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Thu, 2022-11-24 at 15:02 -0800, Eric Biggers wrote:
> On Thu, Nov 24, 2022 at 06:57:41PM +0100, Paolo Abeni wrote:
> > To reduce the contention this patch introduces explicit reference counting
> > for the eventpoll struct. Each registered event acquires a reference,
> > and references are released at ep_remove() time. ep_free() doesn't touch
> > anymore the event RB tree, it just unregisters the existing callbacks
> > and drops a reference to the ep struct. The struct itself is freed when
> > the reference count reaches 0. The reference count updates are protected
> > by the mtx mutex so no additional atomic operations are needed.
> 
> So, the behavior before this patch is that closing an epoll file frees all
> resources associated with it.  This behavior is documented in the man page
> epoll_create(2): "When all file descriptors referring to an epoll instance have
> been closed, the kernel destroys the instance and releases the associated
> resources for reuse."
> 
> The behavior after this patch is that the resources aren't freed until the epoll
> file *and* all files that were added to it have been closed.
> 
> Is that okay? 

This is actually the question that I intended to raise here. I should
have probably make it explicit. 

Also thank you for pointing out the man page info, at very least this
patch would require updating it - or possibly that is a reason to shot
this patch completelly. I would love to ear more opinions ;)

>  I suppose in most cases it is, since the usual use case for epoll
> is to have a long-lived epoll instance and shorter lived file descriptors that
> are polled using that long-lived epoll instance.
> 
> But probably some users do things the other way around.  I.e., they have a
> long-lived file descriptor that is repeatedly polled using different epoll
> instances that have a shorter lifetime.
> 
> In that case, the number of 'struct eventpoll' and 'struct epitem' in kernel
> memory will keep growing until 'max_user_watches' is hit, at which point
> EPOLL_CTL_ADD will start failing with ENOSPC.
> 
> Are you sure that is fine?

I did not think about such use-case, thank you for pointing that out!
Even if it looks like quite a corner-case, it also looks like quite a
deal breaker to me. Again other opinions more then welcome! ;)

Please allow me a question: do you think that solving the contention
problem reported here inside the kernel is worthy? Or should we
encourage (or enforce) the user-space to always do EPOLL_CTL_DEL for
better scalability?

Thanks,

Paolo


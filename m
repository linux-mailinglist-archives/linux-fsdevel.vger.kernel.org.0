Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709504CA8EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 16:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243426AbiCBPUZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 10:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbiCBPUY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:20:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B40E0C6258
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Mar 2022 07:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646234380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ss+f+RADfTVm1TaAGMxnunJihZ0Q5aGV0Ws8tGhjrZI=;
        b=KB3F8j9p64yW2wXc/Y+Y7mHP2b3Mse0Yn+Sur6eIVtUNvdeqVmZP0QIDVLYdyLlBFmX7zU
        Kato0asBGuydphIia1GsZ+8czdUda5dmBCLc4XxdKi3mOJ/cBLEr+F30t8QUl5vDzlkCW8
        VN1UBqjNBvNYPf0ICEUgcp2ajFgJsMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-320-AbUz4eUSNw6ECWZ2gnLwqg-1; Wed, 02 Mar 2022 10:19:35 -0500
X-MC-Unique: AbUz4eUSNw6ECWZ2gnLwqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59AC8100B3AC;
        Wed,  2 Mar 2022 15:19:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F319583BFA;
        Wed,  2 Mar 2022 15:19:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Yh1swsJLXvLLIQ0e@bombadil.infradead.org>
References: <Yh1swsJLXvLLIQ0e@bombadil.infradead.org> <2ee1eb2b46a3bbdbde4244634586655247f5c676.camel@HansenPartnership.com> <1476917.1643724793@warthog.procyon.org.uk>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     dhowells@redhat.com,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] configfd as a replacement for both ioctls and fsconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3570400.1646234372.1@warthog.procyon.org.uk>
Date:   Wed, 02 Mar 2022 15:19:32 +0000
Message-ID: <3570401.1646234372@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Luis Chamberlain <mcgrof@kernel.org> wrote:

> > It'd be nice to be able to set up a 'configuration transaction' and then
> > do a commit to apply it all in one go.
> 
> Can't io-uring cmd effort help here?

I don't know.  Wouldn't that want to apply each element as a separate thing?

But you might want to do something more akin to a db transaction, where you
start a transaction, read stuff, consider your changes, propose your changes
and then commit - which would mean io_uring wouldn't help.

David


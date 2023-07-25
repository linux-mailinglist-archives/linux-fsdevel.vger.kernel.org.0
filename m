Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B677621A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 20:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjGYSk5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 14:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjGYSk4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:40:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55663213F
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 11:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690310407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7ss2tzNf07FPnrLqdDtf+Er94L4qFrw/j0drlGJAUJI=;
        b=NIOG19pVtJ3Tjy18s1TICgIHAKlLW0QpU5VfArgORCwhmMfDnvufV7U8PSncFCNUEeVMyP
        4UHsAjD4kEIOvAvZ777XTfLQBvFgVDyxyoGBtYMgxQnzRRSdMcr/Uf7p3lLUCAVOPW/t9A
        DCReWIFKAgCZa0aVsd8XErxy1GM+Z3s=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194-8oo2ft68MBSY5EtXE1nj0w-1; Tue, 25 Jul 2023 14:40:05 -0400
X-MC-Unique: 8oo2ft68MBSY5EtXE1nj0w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 844A21C3408F;
        Tue, 25 Jul 2023 18:40:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5BBCD4094DC1;
        Tue, 25 Jul 2023 18:39:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <87fs5c3rbl.fsf@oldenburg3.str.redhat.com>
References: <87fs5c3rbl.fsf@oldenburg3.str.redhat.com> <cover.1689092120.git.legion@kernel.org> <cover.1689074739.git.legion@kernel.org> <104971.1690300714@warthog.procyon.org.uk>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     dhowells@redhat.com, Alexey Gladkov <legion@kernel.org>,
        James.Bottomley@HansenPartnership.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, axboe@kernel.dk,
        benh@kernel.crashing.org, borntraeger@de.ibm.com, bp@alien8.de,
        catalin.marinas@arm.com, christian@brauner.io, dalias@libc.org,
        davem@davemloft.net, deepa.kernel@gmail.com, deller@gmx.de,
        fenghua.yu@intel.com, geert@linux-m68k.org, glebfm@altlinux.org,
        gor@linux.ibm.com, hare@suse.com, hpa@zytor.com,
        ink@jurassic.park.msu.ru, jhogan@kernel.org, kim.phillips@arm.com,
        ldv@altlinux.org, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux@armlinux.org.uk,
        linuxppc-dev@lists.ozlabs.org, luto@kernel.org, mattst88@gmail.com,
        mingo@redhat.com, monstr@monstr.eu, mpe@ellerman.id.au,
        namhyung@kernel.org, paulus@samba.org, peterz@infradead.org,
        ralf@linux-mips.org, sparclinux@vger.kernel.org, stefan@agner.ch,
        tglx@linutronix.de, tony.luck@intel.com, tycho@tycho.ws,
        will@kernel.org, x86@kernel.org, ysato@users.sourceforge.jp,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: Add fchmodat2() - or add a more general syscall?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <107289.1690310391.1@warthog.procyon.org.uk>
Date:   Tue, 25 Jul 2023 19:39:51 +0100
Message-ID: <107290.1690310391@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Florian Weimer <fweimer@redhat.com> wrote:

> > Rather than adding a fchmodat2() syscall, should we add a
> > "set_file_attrs()" syscall that takes a mask and allows you to set a bunch
> > of stuff all in one go?  Basically, an interface to notify_change() in the
> > kernel that would allow several stats to be set atomically.  This might be
> > of particular interest to network filesystems.
> 
> Do you mean atomically as in compare-and-swap (update only if old values
> match), or just a way to update multiple file attributes with a single
> system call?

I was thinking more in terms of the latter.  AFAIK, there aren't any network
filesystems support a CAS interface on file attributes like that.  To be able
to do a CAS operation, we'd need to pass in the old values as well as the new.

Another thing we could look at is doing "create_and_set_attrs()", possibly
allowing it to take a list of xattrs also.

David


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A506D679F15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 17:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbjAXQpK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 11:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbjAXQov (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:44:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450E440F6
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 08:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674578640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yqNvEPpBKbnUx2JvfnaECTfxYQrTr8AaIzrVdEili4Q=;
        b=egEeCCyAMJnk/8OgZTjupQhYGtwIDl7Vc0sfFHD1TTBO85u1uD2FQA49Km9a+wsLj/epNm
        xhqMLdBdkovEF1mwEsmdsANkkOOFlhrWxaNZkxCMQsv1THNuP+AYNKLuYBT4fvewjMjkOA
        vio1SXHj8K+7wD9rApnadIa3pAa9Asw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-2bNzs6r4MC6QoOhW9syN_A-1; Tue, 24 Jan 2023 11:43:54 -0500
X-MC-Unique: 2bNzs6r4MC6QoOhW9syN_A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4029118E0921;
        Tue, 24 Jan 2023 16:43:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-192-111.brq.redhat.com [10.40.192.111])
        by smtp.corp.redhat.com (Postfix) with SMTP id 37BF0492B00;
        Tue, 24 Jan 2023 16:43:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 24 Jan 2023 17:43:51 +0100 (CET)
Date:   Tue, 24 Jan 2023 17:43:47 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
        peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org, avagin@gmail.com
Subject: Re: [PATCH 3/3] ptrace,syscall_user_dispatch: add a getter/setter
 for sud configuration
Message-ID: <20230124164347.GA28280@redhat.com>
References: <20230123032942.18263-1-gregory.price@memverge.com>
 <20230123032942.18263-4-gregory.price@memverge.com>
 <20230123154101.GA6268@redhat.com>
 <Y87OEdDXwZG8pmmE@memverge.com>
 <20230123195228.GD6268@redhat.com>
 <Y9AAcuomaVM2JRCA@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9AAcuomaVM2JRCA@memverge.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I won't really argue, but...

On 01/24, Gregory Price wrote:
>
> On Mon, Jan 23, 2023 at 08:52:29PM +0100, Oleg Nesterov wrote:
> > On 01/23, Gregory Price wrote:
> > >
> > > So i think dropping 2/3 in the list is good.  If you concur i'll do
> > > that.
> >
> > Well I obviously think that 2/3 should be dropped ;)
> >
> > As for 1/3 and 3/3, feel free to add my reviewed-by.
> >
> > Oleg.
> >
>
> I'm actually going to walk my agreement back.
>
> After one more review, the need for the proc/status entry is not to
> decide whether to dump SUD settings, but for use in deciding whether to
> set the SUSPEND_SYSCALL_DISPATCH option from patch 1/3.

Rather than read /proc/pid/status, CRIU can just do
PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG unconditionally
and check syscall_user_dispatch_config.mode ?

Why do want to expose SYSCALL_USER_DISPATCH in /proc/status? If this task
is not stopped you can't trust this value anyway. If it is stopped, I don't
think ptrace(PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG) is slower than reading
/proc.

but perhaps I missed something?

Oleg.


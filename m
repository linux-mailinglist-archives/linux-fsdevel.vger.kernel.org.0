Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CE967811F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 17:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbjAWQOt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 11:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjAWQOs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:14:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B809512844
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 08:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674490441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LDRokBji3H//aUw+TxNZ5cyuNmI344JxNA+bsayunTs=;
        b=EFZwm5qQVE/EztUWy65bVeLcEBs79r8FII99iWt/8yZVX1tqo24szHCgJPhm3KH+A1838d
        qanDVscw/hCZzXVvMkt5z5EIUsnAG4IFmPcD/nipNuRseLckQnWI4VJHlGxm4KBJaNUH5o
        VL0gcalU1xgOi05bwK6NB09wkU7TjCw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-39-yO-SeMwmOfG2zLIJUksghg-1; Mon, 23 Jan 2023 11:13:56 -0500
X-MC-Unique: yO-SeMwmOfG2zLIJUksghg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D8E76281DE60;
        Mon, 23 Jan 2023 16:13:55 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B662240C2004;
        Mon, 23 Jan 2023 16:13:55 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs/aio: obey min_nr when doing wakeups
References: <20230118152603.28301-1-kent.overstreet@linux.dev>
        <20230120140347.2133611-1-kent.overstreet@linux.dev>
        <x49cz7956ox.fsf@segfault.boston.devel.redhat.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Mon, 23 Jan 2023 11:17:53 -0500
In-Reply-To: <x49cz7956ox.fsf@segfault.boston.devel.redhat.com> (Jeff Moyer's
        message of "Fri, 20 Jan 2023 14:47:42 -0500")
Message-ID: <x491qnl5ioe.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Moyer <jmoyer@redhat.com> writes:

> Hi, Kent,
>
> Kent Overstreet <kent.overstreet@linux.dev> writes:
>
>> I've been observing workloads where IPIs due to wakeups in
>> aio_complete() are ~15% of total CPU time in the profile. Most of those
>> wakeups are unnecessary when completion batching is in use in
>> io_getevents().
>>
>> This plumbs min_nr through via the wait eventry, so that aio_complete()
>> can avoid doing unnecessary wakeups.
>>
>> v2: This fixes a race in the first version of the patch. If we read some
>> events out after adding to the waitlist, we need to update wait.min_nr
>> call prepare_to_wait_event() again before scheduling.
>
> I like the idea of the patch, and I'll get some real world performance
> numbers soon.  But first, this version (and the previous version as
> well) fails test case 23 in the libaio regression test suite:
>
> Starting cases/23.p
> FAIL: poll missed an event!
> FAIL: poll missed an event!
> test cases/23.t completed FAILED.

It turns out that this only fails on the (relatively) old kernel against
which I applied the patches.  When I apply both patches to the latest
tree, there is no test failure.

Sorry for the noise, I'll be sure to test on the latest going forward.
Now to figure out what changed elsewhere to fix this....

Cheers,
Jeff


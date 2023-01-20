Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25DB675870
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 16:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjATPXq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 10:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjATPXo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:23:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC501677B6
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 07:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674228183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xsYESgVCcA1MZ2umV5mhLIskMRGsLrEQukfEQC626BQ=;
        b=NWrSzpk0Ng6Ra2itDvrOUEAOeXiHqvaQuDEDHfDjMaLKFfuNvQ7cCS8LhsOeHdAj7yBGiO
        n9Mus/NyeYoXhbjovFYIC3zmDwTMJ/HV1tX5iQPPcguIfBalpW4BIQuMTK5tW5NGL9WPP9
        K7yqFtyZxu5VN93eYXYCOOHojhv0hz4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-493-Y2hQe0jBN5yvTpDT1QYZ8g-1; Fri, 20 Jan 2023 10:22:58 -0500
X-MC-Unique: Y2hQe0jBN5yvTpDT1QYZ8g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A02E985CCE0;
        Fri, 20 Jan 2023 15:22:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-193-66.brq.redhat.com [10.40.193.66])
        by smtp.corp.redhat.com (Postfix) with SMTP id 26A9340C6EC4;
        Fri, 20 Jan 2023 15:22:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 20 Jan 2023 16:22:55 +0100 (CET)
Date:   Fri, 20 Jan 2023 16:22:51 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
        peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v3 1/3] ptrace,syscall_user_dispatch: Implement Syscall
 User Dispatch Suspension
Message-ID: <20230120152250.GA9801@redhat.com>
References: <20230120144356.40717-1-gregory.price@memverge.com>
 <20230120144356.40717-2-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120144356.40717-2-gregory.price@memverge.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Gregory,

I'll try to read this series next Monday, I need to recall what does
syscall-user-dispatch actually do ;)

just one question for now,

On 01/20, Gregory Price wrote:
>
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -370,6 +370,10 @@ static int check_ptrace_options(unsigned long data)
>  	if (data & ~(unsigned long)PTRACE_O_MASK)
>  		return -EINVAL;
>  
> +	if (unlikely(data & PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH) &&
> +	    (!IS_ENABLED(CONFIG_CHECKPOINT_RESTART)))
> +			return -EINVAL;

Hmm? git grep CHECKPOINT_RESTART shows nothing.

Oleg.


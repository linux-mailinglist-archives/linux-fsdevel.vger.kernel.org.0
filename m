Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44FE678028
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 16:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjAWPmA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 10:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjAWPmA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:42:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6751233C4
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 07:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674488475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uaUUtgXgmy7k2/WeJoiebCH4/uPcZhQeGH1gQkn9fM0=;
        b=VKA5K69MsXtFr8tl2YbixBUfn3075BTjpkR6PUZyi8217/jSVeFtPwB3j59JJWR5CsLS6a
        EhOW9WD9zEnDofKdu25q5eBKrREVAhluqk/im2ZxsmrZq34jB4yzKe52JVtGVRuEzMS42e
        BUDRVqMswk6Kcs8AeGMhxm3p9ww+I3A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-Z0Cfls3eNN2w8rOGGhhRWw-1; Mon, 23 Jan 2023 10:41:09 -0500
X-MC-Unique: Z0Cfls3eNN2w8rOGGhhRWw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABECD3C0F66A;
        Mon, 23 Jan 2023 15:41:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-192-224.brq.redhat.com [10.40.192.224])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4B1EE140EBF4;
        Mon, 23 Jan 2023 15:41:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 23 Jan 2023 16:41:06 +0100 (CET)
Date:   Mon, 23 Jan 2023 16:41:02 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
        peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH 3/3] ptrace,syscall_user_dispatch: add a getter/setter
 for sud configuration
Message-ID: <20230123154101.GA6268@redhat.com>
References: <20230123032942.18263-1-gregory.price@memverge.com>
 <20230123032942.18263-4-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123032942.18263-4-gregory.price@memverge.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/22, Gregory Price wrote:
>
> +int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
> +		void __user *data)
> +{
> +	struct syscall_user_dispatch *sd = &task->syscall_dispatch;
> +	struct syscall_user_dispatch_config config;
> +
> +	if (size != sizeof(struct syscall_user_dispatch_config))
> +		return -EINVAL;
> +
> +	if (test_syscall_work(SYSCALL_USER_DISPATCH))
> +		config.mode = PR_SYS_DISPATCH_ON;
> +	else
> +		config.mode = PR_SYS_DISPATCH_OFF;

Stupid question...

Why do we need 2/3 (which reports SYSCALL_USER_DISPATCH in proc/pid/status) then?

Oleg.


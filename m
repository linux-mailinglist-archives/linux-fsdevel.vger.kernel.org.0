Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3281F585644
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jul 2022 22:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237466AbiG2Urp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jul 2022 16:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiG2Uro (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jul 2022 16:47:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88E956A9E4
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Jul 2022 13:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659127662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bD2SiMlD4xD+BqEtfLLnVfvqTe1uoHgWXGwb6/5GECc=;
        b=QGnWyPiuVbzugGmvr6QnBg+b7dg/iU6fTwq710Mi+UNVPiUjKReIc5GusLUWWz7IA4D6Ly
        iyssrVsAB8Re7DFYMpJCH/EdsXXhOVHJBwjImtij5sAVO1jbt2u2+49VowCWuPokZHUsaq
        lMJFhE5HU9eXcMG7wN0at6L0BZqxR1s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-W4q5IP3nPqu8r8KnJDNhcA-1; Fri, 29 Jul 2022 16:47:38 -0400
X-MC-Unique: W4q5IP3nPqu8r8KnJDNhcA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41591380451F;
        Fri, 29 Jul 2022 20:47:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.26])
        by smtp.corp.redhat.com (Postfix) with SMTP id E89E51121314;
        Fri, 29 Jul 2022 20:47:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 29 Jul 2022 22:47:35 +0200 (CEST)
Date:   Fri, 29 Jul 2022 22:47:32 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Tycho Andersen <tycho@tycho.pizza>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC][PATCH] fuse: In fuse_flush only wait if someone wants the
 return code
Message-ID: <20220729204730.GA3625@redhat.com>
References: <YuGBXnqb5rPwAlYk@tycho.pizza>
 <20220727191949.GD18822@redhat.com>
 <YuGUyayVWDB7R89i@tycho.pizza>
 <20220728091220.GA11207@redhat.com>
 <YuL9uc8WfiYlb2Hw@tycho.pizza>
 <87pmhofr1q.fsf@email.froward.int.ebiederm.org>
 <YuPlqp0jSvVu4WBK@tycho.pizza>
 <87v8rfevz3.fsf@email.froward.int.ebiederm.org>
 <YuQPc51yXhnBHjIx@tycho.pizza>
 <87h72zes14.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h72zes14.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/29, Eric W. Biederman wrote:
>
> +static int fuse_flush_async(struct file *file, fl_owner_t id)
> +{
> +	struct inode *inode = file_inode(file);
> +	struct fuse_mount *fm = get_fuse_mount(inode);
> +	struct fuse_file *ff = file->private_data;
> +	struct fuse_flush_args *fa;
> +	int err;
> +
> +	fa = kzalloc(sizeof(*fa), GFP_KERNEL);
> +	if (!fa)
> +		return -ENOMEM;
> +
> +	fa->inarg.fh = ff->fh;
> +	fa->inarg.lock_owner = fuse_lock_owner_id(fm->fc, id);
> +	fa->args.opcode = FUSE_FLUSH;
> +	fa->args.nodeid = get_node_id(inode);
> +	fa->args.in_numargs = 1;
> +	fa->args.in_args[0].size = sizeof(fa->inarg);
> +	fa->args.in_args[0].value = &fa->inarg;
> +	fa->args.force = true;
> +	fa->args.end = fuse_flush_end;
> +	fa->inode = inode;
> +	__iget(inode);

Hmm... who does iput() ?

Oleg.


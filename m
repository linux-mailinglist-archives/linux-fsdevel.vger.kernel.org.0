Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D9B4E247E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 11:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346414AbiCUKlm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 06:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244734AbiCUKll (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 06:41:41 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCC655230;
        Mon, 21 Mar 2022 03:40:15 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u16so19042921wru.4;
        Mon, 21 Mar 2022 03:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sQF2fC9oVBJtKCte5qIRv47iQ3cY8MbUU/gOUyu8y0A=;
        b=kcLRthEhCtAevhm9pjsceZfa/8uLBuEDIpkZsHEwV1D6+Ot1+0g3YRXqjPOZ2RaOMa
         FAPai3KhKLpiDwaUGl5ezGQD7O8IYdJQuP5bHmH5BXseY5tzHVMq59GiGhRcMUEFIkjF
         lrf/xEIdHbhmgKAeSNQfvShE0kvjNMARyW6+zSgl3JOhfItFi9k8Zy0UJrX0QLbY5kpm
         JzLdy7WY4dKUCRPzQLT/lZTKf6+FOJ+DvRBWAmHl9LtvfPVBZ4sM3Vd2jPgEXOZI0Xqe
         sOclm0u37CBz3tRh01ox7bSMrQpabcNyJGYUb/UPE3K8G8lp5Srx9W/sDnD6LB9QkUCb
         5pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sQF2fC9oVBJtKCte5qIRv47iQ3cY8MbUU/gOUyu8y0A=;
        b=KQ+DWVSoPFWAWyRQbyGofFHc9thEPjtnk3kuTpufcrCxmkrYVZpAhlXa/ozF+rz3/s
         8FAIkB4Jan1Pv+94QsKq4SeA3xpCUNf3r98fUpobrcTjf+pvX3/8Nmh8Rt+3//tw8TjQ
         r/G8KOAdAz0yjH6PC5wq9K9zLoCJjshlc/a4+6gpAwxUjz5vGOqsTBVyUnNUkNJN2IhA
         LbwdHu0se9rlt5cEnMeW+HH8P9o/JXIOdfz1mm5kYmuzaQRlrPYpaOtYRXDngYeN1uZm
         ggk7Vqxt1nqx7mzQqpwpxX4GubilDfkTtUeuV7/ZtdOKXGvDL1A1Njqn5EH3D2UPiKAL
         C/2g==
X-Gm-Message-State: AOAM5329K0JAHc903AAAFxLcsVMiGQ/S+TrAbJJ3LAjrWzyu6s3/6fk5
        7JK8t4KoUQ0NY+uoUAmuwQ==
X-Google-Smtp-Source: ABdhPJz7yuSExi8tERMJBvllNiVhA2bP7vAWj6HQqxj1JFU0I/9oVxkxsklDHownd8mPqIM8meKHYg==
X-Received: by 2002:adf:f28d:0:b0:203:f161:55ac with SMTP id k13-20020adff28d000000b00203f16155acmr14573782wro.209.1647859213392;
        Mon, 21 Mar 2022 03:40:13 -0700 (PDT)
Received: from localhost.localdomain ([46.53.252.158])
        by smtp.gmail.com with ESMTPSA id bg18-20020a05600c3c9200b0037c2ef07493sm15712568wmb.3.2022.03.21.03.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 03:40:12 -0700 (PDT)
Date:   Mon, 21 Mar 2022 13:40:10 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     hui li <juanfengpy@gmail.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: fix dentry/inode overinstantiating under
 /proc/${pid}/net
Message-ID: <YjhWCuybOW9RT47L@localhost.localdomain>
References: <CAPmgiUJVaACDyWkEhpC5Tfk233t-Tw6_f-Y99KLUDqv6dEq0tw@mail.gmail.com>
 <YjMFTSKZp9eX/c4k@localhost.localdomain>
 <CAPmgiUJsd-gdq=JG1rF8BHfpADeS45rcVWwnC2qKE=7W1EryiQ@mail.gmail.com>
 <YjdVHgildbWO7diJ@localhost.localdomain>
 <CAPmgiUK90T212icXkSJ2vSiCjXbUqO-fptNLL7NF6SMDAyTtRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPmgiUK90T212icXkSJ2vSiCjXbUqO-fptNLL7NF6SMDAyTtRg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 21, 2022 at 05:15:02PM +0800, hui li wrote:
> Alexey Dobriyan <adobriyan@gmail.com> 于2022年3月21日周一 00:24写道：
> >
> > When a process exits, /proc/${pid}, and /proc/${pid}/net dentries are flushed.
> > However some leaf dentries like /proc/${pid}/net/arp_cache aren't.
> > That's because respective PDEs have proc_misc_d_revalidate() hook which
> > returns 1 and leaves dentries/inodes in the LRU.
> >
> > Force revalidation/lookup on everything under /proc/${pid}/net by inheriting
> > proc_net_dentry_ops.
> >
> > Fixes: c6c75deda813 ("proc: fix lookup in /proc/net subdirectories after setns(2)")
> > Reported-by: hui li <juanfengpy@gmail.com>
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > ---
> >
> >  fs/proc/generic.c  |    4 ++++
> >  fs/proc/proc_net.c |    3 +++
> >  2 files changed, 7 insertions(+)
> >
> > --- a/fs/proc/generic.c
> > +++ b/fs/proc/generic.c
> > @@ -448,6 +448,10 @@ static struct proc_dir_entry *__proc_create(struct proc_dir_entry **parent,
> >         proc_set_user(ent, (*parent)->uid, (*parent)->gid);
> >
> >         ent->proc_dops = &proc_misc_dentry_ops;
> > +       /* Revalidate everything under /proc/${pid}/net */
> > +       if ((*parent)->proc_dops == &proc_net_dentry_ops) {
> > +               pde_force_lookup(ent);
> > +       }
> >
> >  out:
> >         return ent;
> > --- a/fs/proc/proc_net.c
> > +++ b/fs/proc/proc_net.c
> > @@ -376,6 +376,9 @@ static __net_init int proc_net_ns_init(struct net *net)
> >
> >         proc_set_user(netd, uid, gid);
> >
> > +       /* Seed dentry revalidation for /proc/${pid}/net */
> > +       pde_force_lookup(netd);
> > +
> >         err = -EEXIST;
> >         net_statd = proc_net_mkdir(net, "stat", netd);
> >         if (!net_statd)

> proc_misc_dentry_ops is a general ops for dentry under /proc, except
> for "/proc/${pid}/net"，other dentries may also use there own ops too,
> so I think change proc_misc_d_delete may be better?
> see patch under: https://lkml.org/lkml/2022/3/17/319

I don't think so.

proc_misc_d_delete covers "everything else" part under /proc/ and
/proc/net which are 2 separate trees. Now /proc/net/ requires
revalidation because of

	commit c6c75deda81344c3a95d1d1f606d5cee109e5d54
	proc: fix lookup in /proc/net subdirectories after setns(2)

so the bug is that the above commit was applied only partially.
In particular, /proc/*/net/stat/arp_cache was created with
proc_create_seq_data(), avoiding proc_net_* APIs.

And there is probably the same "lookup after setns find wrong file"
if you search hard enough in /proc/*/net/

This is the logic. Please test on your systems.

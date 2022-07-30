Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98A0585785
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Jul 2022 02:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238817AbiG3AQH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jul 2022 20:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiG3AQG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jul 2022 20:16:06 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1525175A8;
        Fri, 29 Jul 2022 17:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s3aSkqR/dYUoO2LIxitiibTrasBdwNm6x5YaSCe1T4c=; b=WeIft9Zo2zESXHly8mhIsLVSGb
        dbJQYDIHLnES8L5DoSiypKxWusG/dtS3icrixuN9xhE/A2NwJid2XZ8KZ1V9uhv8FI5UCrURGSDZ4
        gily7+r3epBqZ+DUUpUivY/663gz7QJ2CgOJh6Pjl8c1kV1JquPn9T9ZB/HLwzKbQ5DRSVL+FxETG
        KCINowQ73vq+HG5ma71zfHBS6dSbLYM3R8P4Pr8dEioZuV5xk5zA+VA/KqqeHWnXB7dPfmaWJqHDM
        ZfwYkqjwvl16A7k9vKJNbZrncYMNdv/CKocEuuP7eIUq0MfIzd32sVTQV7tNkQnXYU1iOBPHxhEer
        6qCOLrEQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oHa8v-00HD4Q-PH;
        Sat, 30 Jul 2022 00:15:45 +0000
Date:   Sat, 30 Jul 2022 01:15:45 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] fuse: In fuse_flush only wait if someone wants the
 return code
Message-ID: <YuR4MRL8WxA88il+@ZenIV>
References: <20220727191949.GD18822@redhat.com>
 <YuGUyayVWDB7R89i@tycho.pizza>
 <20220728091220.GA11207@redhat.com>
 <YuL9uc8WfiYlb2Hw@tycho.pizza>
 <87pmhofr1q.fsf@email.froward.int.ebiederm.org>
 <YuPlqp0jSvVu4WBK@tycho.pizza>
 <87v8rfevz3.fsf@email.froward.int.ebiederm.org>
 <YuQPc51yXhnBHjIx@tycho.pizza>
 <87h72zes14.fsf_-_@email.froward.int.ebiederm.org>
 <20220729204730.GA3625@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729204730.GA3625@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 29, 2022 at 10:47:32PM +0200, Oleg Nesterov wrote:
> On 07/29, Eric W. Biederman wrote:
> >
> > +static int fuse_flush_async(struct file *file, fl_owner_t id)
> > +{
> > +	struct inode *inode = file_inode(file);
> > +	struct fuse_mount *fm = get_fuse_mount(inode);
> > +	struct fuse_file *ff = file->private_data;
> > +	struct fuse_flush_args *fa;
> > +	int err;
> > +
> > +	fa = kzalloc(sizeof(*fa), GFP_KERNEL);
> > +	if (!fa)
> > +		return -ENOMEM;
> > +
> > +	fa->inarg.fh = ff->fh;
> > +	fa->inarg.lock_owner = fuse_lock_owner_id(fm->fc, id);
> > +	fa->args.opcode = FUSE_FLUSH;
> > +	fa->args.nodeid = get_node_id(inode);
> > +	fa->args.in_numargs = 1;
> > +	fa->args.in_args[0].size = sizeof(fa->inarg);
> > +	fa->args.in_args[0].value = &fa->inarg;
> > +	fa->args.force = true;
> > +	fa->args.end = fuse_flush_end;
> > +	fa->inode = inode;
> > +	__iget(inode);
> 
> Hmm... who does iput() ?

... or holds ->i_lock as expected by __iget()...

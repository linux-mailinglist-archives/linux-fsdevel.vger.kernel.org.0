Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B48D4F6B17
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 22:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiDFUSK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 16:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbiDFURA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:17:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DD0EF7BB
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Apr 2022 10:47:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 65ECA1F857;
        Wed,  6 Apr 2022 17:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649267268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Pxlla3FuR4WXfcVIBQR9lhE0iYiPJXKI84lo4RYzgk=;
        b=IOt/XDBCB9Z05sR4bpEj+n6+Mte+G29GTNhQGCQT4avdg2sNK8AWR7scdVDnXa6gJ+zcxN
        PggS8uLaCWUsjj48bNYGx6hkRU8lUewV8utOE0FnRex5sZ7cmz494SwqfYBW1kQQn36Dvb
        MoFhW+PnxAdaLX7XAw/KMrEQBDTuWmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649267268;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Pxlla3FuR4WXfcVIBQR9lhE0iYiPJXKI84lo4RYzgk=;
        b=ylfhGl/V/9ZkM5WBL+DlzxGCOp3C6juMz4SOoRXUB4aJ95RdHsS6xDKk3GwoVN87Px/QQi
        iCv2WrOiXDnLH+BQ==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4C67AA3B89;
        Wed,  6 Apr 2022 17:47:48 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E8804A061D; Wed,  6 Apr 2022 19:47:47 +0200 (CEST)
Date:   Wed, 6 Apr 2022 19:47:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 04/16] fsnotify: remove unneeded refcounts of
 s_fsnotify_connectors
Message-ID: <20220406174747.da3qwn7sicplcem4@quack3.lan>
References: <20220329074904.2980320-1-amir73il@gmail.com>
 <20220329074904.2980320-5-amir73il@gmail.com>
 <20220405125407.qn6ac5e3bpr5is6h@quack3.lan>
 <CAOQ4uxh3XvBnXs0d71Uk_6Df3_d4kP97sdLqpkHUu2AP32of2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh3XvBnXs0d71Uk_6Df3_d4kP97sdLqpkHUu2AP32of2A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 05-04-22 16:09:00, Amir Goldstein wrote:
> On Tue, Apr 5, 2022 at 3:54 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 29-03-22 10:48:52, Amir Goldstein wrote:
> > > s_fsnotify_connectors is elevated for every inode mark in addition to
> > > the refcount already taken by the inode connector.
> > >
> > > This is a relic from s_fsnotify_inode_refs pre connector era.
> > > Remove those unneeded recounts.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > I disagree it is a relict. fsnotify_sb_delete() relies on
> > s_fsnotify_connectors to wait for all connectors to be properly torn down
> > on unmount so that we don't get "Busy inodes after unmount" error messages
> > (and use-after-free issues). Am I missing something?
> >
> 
> I meant it is a relic from the time before s_fsnotify_inode_refs became
> s_fsnotify_connectors.
> 
> Nowadays, one s_fsnotify_connectors refcount per connector is enough.
> No need for one refcount per inode.
> 
> Open code the the sequence:
>     if (inode)
>         fsnotify_put_inode_ref(inode);
>     fsnotify_put_sb_connectors(conn);
> 
> To see how silly it is.

I see your point and I agree the general direction makes sense but
technically I think your patch is buggy. Because notice that we do
fsnotify_put_sb_connectors() in fsnotify_detach_connector_from_object() so
after this call there's nothing blocking umount while we can be still
holding inode references from some marks attached to this connector. So
racing inode mark destruction & umount can lead to "Busy inodes after
umount" messages.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

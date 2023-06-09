Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4377172A2AE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 20:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjFIS50 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 14:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjFIS5Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:57:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF69A3592
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 11:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686337001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dgvP+3cfn/JdGFtz/3/sc6XWKCWQswTzTsmhHZdWj30=;
        b=Vs/VoRj/gR4A8hVo1dGgYJ65SwSEGWKrpyqlPkjXwiBZpz7RF2ri3hRbgfahxLUa32YDAB
        2/m+x5X4TVCbeuAQ/FTCYlNq2eGepkI/lvfJK/HX7GVOHN7N02tW9hZ84BWw3YSOKHyJ8k
        YY/w1b/+cqChYhhKVU/r9H1lGMICAsE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-349-SKIIw_DfPvGS0vW0tUyxKg-1; Fri, 09 Jun 2023 14:56:38 -0400
X-MC-Unique: SKIIw_DfPvGS0vW0tUyxKg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0CCB8007D9;
        Fri,  9 Jun 2023 18:56:37 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D18E810ED7;
        Fri,  9 Jun 2023 18:56:37 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id C04E930C0502; Fri,  9 Jun 2023 18:56:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id BE97D3F7CF;
        Fri,  9 Jun 2023 20:56:37 +0200 (CEST)
Date:   Fri, 9 Jun 2023 20:56:37 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-bcachefs@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: fuzzing bcachefs with dm-flakey
In-Reply-To: <20230602011355.GA16848@frogsfrogsfrogs>
Message-ID: <7bf96e58-7151-a63d-317f-1ddedd4927ad@redhat.com>
References: <alpine.LRH.2.21.2305260915400.12513@file01.intranet.prod.int.rdu2.redhat.com> <20230602011355.GA16848@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Thu, 1 Jun 2023, Darrick J. Wong wrote:

> On Mon, May 29, 2023 at 04:59:40PM -0400, Mikulas Patocka wrote:
>
> > #!/bin/sh -ex
> > umount /mnt/test || true
> > dmsetup remove_all || true
> > rmmod brd || true
> > SRC=/usr/src/git/bcachefs-tools
> > while true; do
> >         modprobe brd rd_size=1048576
> >         bcachefs format --replicas=2 /dev/ram0 /dev/ram1
> >         dmsetup create flakey --table "0 `blockdev --getsize /dev/ram0` linear /dev/ram0 0"
> >         mount -t bcachefs /dev/mapper/flakey:/dev/ram1 /mnt/test
> >         dmsetup load flakey --table "0 `blockdev --getsize /dev/ram0` flakey /dev/ram0 0 0 1 4 random_write_corrupt 100000000 random_read_corrupt 100000000"
> 
> Hey, that's really neat!
> 
> Any chance you'd be willing to get the dm-flakey changes merged into
> upstream so that someone can write a recoveryloop fstest to test all the
> filesystems systematically?
> 
> :D
> 
> --D

Yes, we will merge improved dm-flakey in the next merge window.

Mikulas


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94BA597F4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 09:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243658AbiHRHgt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 03:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241561AbiHRHgr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 03:36:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52350A3472;
        Thu, 18 Aug 2022 00:36:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2D73616F1;
        Thu, 18 Aug 2022 07:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A222C433B5;
        Thu, 18 Aug 2022 07:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660808206;
        bh=fcBplLQ58WkiFcB/VqRifFZDN/mfAskxWz0KH4Er7Og=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GGwPPdWTkqUUYyHfV4EklmY7LVLgLUplMyWnLTdIb+jiH9mg9y1r34kGr6mpD55PL
         GN6JVVfvw91kMXSvVvZ/nQo2s2vYDuxSqWCvJfcST3G7hapS3Zkhayc/F0L2Tyvn1F
         +T1gnLSR+ySh2+xDhFci0CwICkUcig2geC2bdM/fuYEQ7AzV+NOQtNLI31UAESSN9R
         RQZCjYyZKUAoAywIBxpzuviDHCptlrGQFugqAd2ikubLBWLUOfZUTK2zj6dDP+0yqC
         Z0/uidMLBNePmOt2MOq7tyn0i52ETd3FtIG2V35FQYEC3UOglR051qiziR7GzsYoFK
         adTy0iJzkO50g==
Date:   Thu, 18 Aug 2022 09:36:40 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jeff Layton <jlayton@kernel.org>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>
Subject: Re: [PATCH v2] ext4: fix i_version handling in ext4
Message-ID: <20220818073640.nxisir45whbcamtx@wittgenstein>
References: <20220817162638.133341-1-jlayton@kernel.org>
 <20220817181903.3qqqzqvgghr2lqgm@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220817181903.3qqqzqvgghr2lqgm@quack3>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 08:19:03PM +0200, Jan Kara wrote:
> On Wed 17-08-22 12:26:38, Jeff Layton wrote:
> > ext4 currently updates the i_version counter when the atime is updated
> > during a read. This is less than ideal as it can cause unnecessary cache
> > invalidations with NFSv4 and unnecessary remeasurements for IMA. The
> > increment in ext4_mark_iloc_dirty is also problematic since it can also
> > corrupt the i_version counter for ea_inodes. We aren't bumping the file
> > times in ext4_mark_iloc_dirty, so changing the i_version there seems
> > wrong, and is the cause of both problems.
> > 
> > Remove that callsite and add increments to the setattr, setxattr and
> > ioctl codepaths (at the same time that we update the ctime). The
> > i_version bump that already happens during timestamp updates should take
> > care of the rest.
> > 
> > In ext4_move_extents, increment the i_version on both inodes, and also
> > add in missing ctime updates.
> > 
> > Cc: Lukas Czerner <lczerner@redhat.com>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> 
> Hopefully all cases covered ;) Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks for making sure all cases are covered. :)
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>

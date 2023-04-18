Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464616E6624
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 15:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjDRNnS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 09:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjDRNnQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:43:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA26B464;
        Tue, 18 Apr 2023 06:43:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 295A9628B0;
        Tue, 18 Apr 2023 13:43:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B536C433D2;
        Tue, 18 Apr 2023 13:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681825394;
        bh=8CeMtAHvPr/DVv1Uah6ugiLcifRrCRLVHfjWo9vaRmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j2NrDv2KOl5CKpwFaABnTrRd+Z50vAnBSnVNiDyaJtYmlLpRunousgsb3IhOMRA1L
         /ImdUiy4XIjCDMojYV0PnvwgOgQKX+8dyFT/+eB+bmbkck8UWJEaImvsgfp2jjCgB7
         MimVn9/3e9Q8wTqaHtsStmyUpYSJepF8lB3eqoQrS/mLUlObm8kBdkkrXx0Orcl0qN
         4/W501ecA6KH9af/axf6BlXvI+upIYtAwlAKsAq4tH1N0wU1Zas5fF6nTJJ1uALU1k
         DMfJljHte1nkS90CWOIlYm0y0mskd9Jwq21D1AfqSGVgmV7mdYykFOG7a5JhMMQHcY
         dfztlbPplkqCA==
Date:   Tue, 18 Apr 2023 15:43:10 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [RFC][PATCH 1/2] fanotify: add support for FAN_UNMOUNT event
Message-ID: <20230418-gebacken-roben-610d78ee4e66@brauner>
References: <20230414182903.1852019-1-amir73il@gmail.com>
 <20230414182903.1852019-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230414182903.1852019-2-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 09:29:02PM +0300, Amir Goldstein wrote:
> inotify generates unsolicited IN_UNMOUNT events for every inode
> mark before the filesystem containing the inode is shutdown.
> 
> Unlike IN_UNMOUNT, FAN_UNMOUNT is an opt-in event that can only be
> set on a mount mark and is generated when the mount is unmounted.
> 
> FAN_UNMOUNT requires FAN_REPORT_FID and reports an fid info record
> with fsid of the filesystem and an empty file handle.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

I think this is a useful addition to the fanotify api and more useful
than IN_UMOUNT.

Going back to your cover letter. Afaiu, IN_UMOUNT is generated when the
superblock in which a watched object resides goes away. That's roughly
what I had in mind with FAN_SB_SHUTDOWN (ignoring naming discusions for
now).

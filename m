Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD634BBA0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 14:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235756AbiBRNXR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 08:23:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiBRNXP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 08:23:15 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE4325B2E9;
        Fri, 18 Feb 2022 05:22:57 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8F694219A7;
        Fri, 18 Feb 2022 13:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645190576;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RgkZJ7ZhSERSWBQqI33cC4w2rylgQi9fENbXBv/d1xM=;
        b=lmt1xfm27odWD5fnWFGSKNegSnlKJKxHbTbPYa1lsEyeZELtbVLmB/v80BkgAHJdF9EjbS
        IR8GEvOdwwwSYySEyBcS0k8qtQrYDjvEoDczHJcstikrU/Qbphq69vhZy4s8a4EAzfwIgy
        kBCovEOwp/A0SIRLKsLMqrHLjfsU4G0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645190576;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RgkZJ7ZhSERSWBQqI33cC4w2rylgQi9fENbXBv/d1xM=;
        b=cakBRZ92N4MYl546FxHVDIwO4uapqv57wa1Xh5jygvRCxm34OeqVjAn/WZHL9vzLe5yVz/
        6oImeYSscOlBn1CQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 820E1A3B93;
        Fri, 18 Feb 2022 13:22:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E0E37DA829; Fri, 18 Feb 2022 14:19:10 +0100 (CET)
Date:   Fri, 18 Feb 2022 14:19:10 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] fs: allow cross-vfsmount reflink/dedupe
Message-ID: <20220218131910.GT12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <67ae4c62a4749ae6870c452d1b458cc5f48b8263.1645042835.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67ae4c62a4749ae6870c452d1b458cc5f48b8263.1645042835.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 16, 2022 at 03:21:23PM -0500, Josef Bacik wrote:
> Currently we disallow reflink and dedupe if the two files aren't on the
> same vfsmount.  However we really only need to disallow it if they're
> not on the same super block.  It is very common for btrfs to have a main
> subvolume that is mounted and then different subvolumes mounted at
> different locations.  It's allowed to reflink between these volumes, but
> the vfsmount check disallows this.  Instead fix dedupe to check for the
> same superblock, and simply remove the vfsmount check for reflink as it
> already does the superblock check.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

This has some history, people have been asking for this for a long time
(the workaround is to mount the toplevel subvolume elsewhere and do it
from there). I did a review back then what could possibly break on the
VFS level, eg. lack of references of the affected files, or potential
deadlocks. On the filesystem level there's no difference, the extents
are processed in the same way, it does not matter if the VFS entry point
is the same mount or cross-mount. The same-mount limitation seems rather
artificial and has been inherited from the original implementation.

Reviewed-by: David Sterba <dsterba@suse.com>

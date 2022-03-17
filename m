Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70F04DC322
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 10:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbiCQJpE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 05:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiCQJpE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:45:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D3016F6F3;
        Thu, 17 Mar 2022 02:43:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A589021112;
        Thu, 17 Mar 2022 09:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647510226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DFWUSkd4grL19DFDB5+w67woVPRC/6JXoVuQx8Tt1BE=;
        b=UgY4MmIo/99tez4EdWkQdmC30OGtPfhCa7QDm+cGJhcCGJeMGCHvovlsnBgfDHWem+ELuF
        glYTZ2nBNQNdURK8PnccbBbGq+cNZF2WOdnF3EtCcvcQ5Uj7A3dQ1f0OzsTFgzm6viJ0rf
        zKTT05afs/HmaXfUC5a7nETQ6ZAqTMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647510226;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DFWUSkd4grL19DFDB5+w67woVPRC/6JXoVuQx8Tt1BE=;
        b=2pw/H3XZRxrPCe7n/gPiLACwOASm1Xr54f79xLwFNzAZTE/qyULNihLSzsGDSjrgeQX5O+
        2PjKV+ND4zvyO4Dw==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 25FC1A3B89;
        Thu, 17 Mar 2022 09:43:46 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BBA6DA0615; Thu, 17 Mar 2022 10:43:44 +0100 (CET)
Date:   Thu, 17 Mar 2022 10:43:44 +0100
From:   Jan Kara <jack@suse.cz>
To:     Thomas Dreibholz <dreibh@simula.no>
Cc:     gandalf@winds.org, david@fromorbit.com, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, willy@infradead.org
Subject: Re: Is it time to remove reiserfs?
Message-ID: <20220317094344.5s3shqk54qfpumey@quack3.lan>
References: <1a5cd8ce-e7c7-5aa8-e475-ad7810e2f057@winds.org>
 <842c582a-ecb6-31a1-fad1-54a4e9c05b94@simula.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <842c582a-ecb6-31a1-fad1-54a4e9c05b94@simula.no>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

On Thu 17-03-22 09:53:22, Thomas Dreibholz wrote:
> I just noticed the thread about ReiserFS deprecation. We are currently still
> using ReiserFS on ca. 50 production machines of the NorNet Core
> infrastructure (https://www.nntb.no/). While newer machines use BTRFS
> instead, the older machines had ReiserFS used, due to its stability and
> better performance in comparison to ext4. At their installation time, we did
> not consider BTRFS being mature enough. A deprecation period of ca. 5 years
> from now seems to be reasonable, although it would be nice to have at least
> a read-only capability available for some longer time, for the case it
> becomes necessary to read an old ReiserFS file system on a newer system.

Thanks for your feedback! So the current plan is to remove the support from
current upstream kernel in ~3 years, as people noted, you can still use
upstream -stable kernels branched at the end of the deprecation period for
another two years which gives you around 5 years to migrate if you are
using upstream stable kernels. 

You can still use sufficiently old kernel (VM?) or FUSE (although someone
motivated would probably need to write proper support module but e.g. grub2
has reiserfs support in userspace implemented) to get data out of
Reiserfs partitions after that... At least that's the current plan.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

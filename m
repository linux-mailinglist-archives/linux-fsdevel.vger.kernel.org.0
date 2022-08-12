Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6F759152E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Aug 2022 20:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238997AbiHLSBm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Aug 2022 14:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238136AbiHLSBl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Aug 2022 14:01:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7F582861;
        Fri, 12 Aug 2022 11:01:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94D1FB8252C;
        Fri, 12 Aug 2022 18:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13741C433D7;
        Fri, 12 Aug 2022 18:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660327297;
        bh=MJn6b9K2tOrxM+NNckNZKyioTF5k86AdU9ZZ5TUKmGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X97sPjmGf9xks/NCjFO0MbvVTowoL0Yr57yqPTst5NNZJGWuznicH20iQIv5VE6eX
         ZLRzUb1rk/OxAfScBf/dKSa+J/GyCOuJQUxvWIKVJZD37IKqH7C8T3LsW8GXrVxFrZ
         59QdjyMg6jdpxMa8y3H6tyctyKYna1zZ+3jm9DLiYv1y1JUW5DyTm87xr4jNiO18k8
         Yn8LCrBzNnN9iIj/M4z2H6+hqkj3LTtPt2vpvNfPDaEHz94bpitYrAgALA5BlUTZS6
         /iNTkkGumuJowoX0LEOl4Is0NhVlAjIMOZ4sW42Qa86+/FBz9lPPEsZjYWgRCmosZk
         Da0pajfWAXYiw==
Date:   Fri, 12 Aug 2022 11:01:35 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jlayton@kernel.org,
        jack@suse.cz, linux-fsdevel@vger.kernel.org, david@fromorbit.com,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 2/3] fs: record I_DIRTY_TIME even if inode already has
 I_DIRTY_INODE
Message-ID: <YvaVf1Zl/Y2vHMpi@sol.localdomain>
References: <20220812123727.46397-1-lczerner@redhat.com>
 <20220812123727.46397-2-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812123727.46397-2-lczerner@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 12, 2022 at 02:37:26PM +0200, Lukas Czerner wrote:
> Fix it by allowing I_DIRTY_TIME to be set even if the inode already has
> I_DIRTY_INODE.

How can this be reconciled with the below code in __mark_inode_dirty(), which
this patch doesn't touch?

	/* I_DIRTY_INODE supersedes I_DIRTY_TIME. */
	flags &= ~I_DIRTY_TIME;

Also inode_is_dirtytime_only(), which I thought I mentioned before:

	/*
	 * Returns true if the given inode itself only has dirty timestamps (its pages
	 * may still be dirty) and isn't currently being allocated or freed.
	 * Filesystems should call this if when writing an inode when lazytime is
	 * enabled, they want to opportunistically write the timestamps of other inodes
	 * located very nearby on-disk, e.g. in the same inode block.  This returns true
	 * if the given inode is in need of such an opportunistic update.  Requires
	 * i_lock, or at least later re-checking under i_lock.
	 */
	static inline bool inode_is_dirtytime_only(struct inode *inode)
	{
		return (inode->i_state & (I_DIRTY_TIME | I_NEW |
					I_FREEING | I_WILL_FREE)) == I_DIRTY_TIME;
	}

- Eric

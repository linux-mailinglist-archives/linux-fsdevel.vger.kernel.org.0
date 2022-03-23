Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B5F4E4C89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 07:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241155AbiCWGKa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 02:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbiCWGK2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 02:10:28 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94EA6E8F0;
        Tue, 22 Mar 2022 23:08:58 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6D0A368AFE; Wed, 23 Mar 2022 07:08:55 +0100 (CET)
Date:   Wed, 23 Mar 2022 07:08:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 21/40] btrfs: cleanup btrfs_submit_data_bio
Message-ID: <20220323060855.GE24302@lst.de>
References: <20220322155606.1267165-1-hch@lst.de> <20220322155606.1267165-22-hch@lst.de> <eba7673d-9364-a60e-9243-811162b76ddd@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eba7673d-9364-a60e-9243-811162b76ddd@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 23, 2022 at 08:44:19AM +0800, Qu Wenruo wrote:
> Previously we would also call bio_endio() on the bio, do we miss the
> endio call on it?

The first patch in the series moves the bio_endio call into one of the
callers of this function instead.  That being said mainline has a
different fix from Josef that makes the endio call on errors conditional
so this part of the series will require some rework.

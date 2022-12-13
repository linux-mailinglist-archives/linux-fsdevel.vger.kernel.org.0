Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB6B64BE1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 21:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236601AbiLMUud (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 15:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbiLMUuc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 15:50:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944F917400;
        Tue, 13 Dec 2022 12:50:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3972A61697;
        Tue, 13 Dec 2022 20:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74393C433EF;
        Tue, 13 Dec 2022 20:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670964630;
        bh=SpgJ+obKx83Lq1XBPYt1iT5OGJo7ww6maCEqb/nwhgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vN10+gkiNN/rsh59ISL6F7Haurw/ZTKR4Qfs3CoSQswlux28y4JMV2a/foBi8GPLJ
         lrrtVheMczkZls9rcbTLJIncYGOCnr+43zKxLXtLl5T3HDvu6pMUCVvPWt873MgcTT
         ti2c7WcSUkfelWwidSiSi6lY1/4zdwpF2fTpn77UbYxrqrZ80TQsRlOBapKYWzjG8M
         1O+xS6fzhPAzA/PJ/zChGxZjLRo5t4nwu/SuD+wDjV2OH7RXFxgmLFZd5rDCyEvMv1
         34U7tL0eTuPXdEZDRaGYtyAf2ASEmrc/TENdbtWSvwtQPpOSdakWq8IdiBKikAE06R
         Q464gs56KXBJg==
Date:   Tue, 13 Dec 2022 12:50:28 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andrey Albershteyn <aalbersh@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 00/11] fs-verity support for XFS
Message-ID: <Y5jllLwXlfB7BzTz@sol.localdomain>
References: <20221213172935.680971-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213172935.680971-1-aalbersh@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 13, 2022 at 06:29:24PM +0100, Andrey Albershteyn wrote:
> Not yet implemented:
> - No pre-fetching of Merkle tree pages in the
>   read_merkle_tree_page()

This would be helpful, but not essential.

> - No marking of already verified Merkle tree pages (each read, the
>   whole tree is verified).

This is essential to have, IMO.

You *could* do what btrfs does, where it caches the Merkle tree pages in the
inode's page cache past i_size, even though btrfs stores the Merkle tree
separately from the file data on-disk.

However, I'd guess that the other XFS developers would have an adversion to that
approach, even though it would not affect the on-disk storage.

The alternatives would be to create a separate in-memory-only inode for the
cache, or to build a custom cache with its own shrinker.

- Eric

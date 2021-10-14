Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486AC42D8D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 14:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhJNMIB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 08:08:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58974 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbhJNMIA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 08:08:00 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1973B21A73;
        Thu, 14 Oct 2021 12:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634213155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1lCTGMRX/b9nCVG2qyQaFqQ4VXAM+Au8QJ5IJdpaqz0=;
        b=cJLBiqP392lvvwTK0oxt/wd6afmkwLcaVSsVZ6YpYsq7u5QFu77T6uQBSggwIYxzj9VBJF
        wnW+G7QcYhH/oDCtvKScDPCQ9hoYi2s4M2IIcUDbkCnv0XULppin9xL3Qgc8198XaVFQi8
        6o2YA6yl0/kUd5bsaoti6FH/Sh40RAg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C7E1813D8D;
        Thu, 14 Oct 2021 12:05:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id C6I7LiIdaGG8MgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 14 Oct 2021 12:05:54 +0000
Subject: Re: [PATCH v11 03/14] btrfs: don't advance offset for compressed bios
 in btrfs_csum_one_bio()
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <cover.1630514529.git.osandov@fb.com>
 <40d0097d3b5e1ba14e6b6d090ba6d0e5c046985f.1630514529.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <3fa3456d-3d53-6025-e305-8ab8080c9ba5@suse.com>
Date:   Thu, 14 Oct 2021 15:05:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <40d0097d3b5e1ba14e6b6d090ba6d0e5c046985f.1630514529.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1.09.21 г. 20:00, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> btrfs_csum_one_bio() loops over each filesystem block in the bio while
> keeping a cursor of its current logical position in the file in order to
> look up the ordered extent to add the checksums to. However, this
> doesn't make much sense for compressed extents, as a sector on disk does
> not correspond to a sector of decompressed file data. It happens to work
> because 1) the compressed bio always covers one ordered extent and 2)
> the size of the bio is always less than the size of the ordered extent.
> However, the second point will not always be true for encoded writes.
> 
> Let's add a boolean parameter to btrfs_csum_one_bio() to indicate that
> it can assume that the bio only covers one ordered extent. Since we're
> already changing the signature, let's get rid of the contig parameter
> and make it implied by the offset parameter, similar to the change we
> recently made to btrfs_lookup_bio_sums(). Additionally, let's rename
> nr_sectors to blockcount to make it clear that it's the number of
> filesystem blocks, not the number of 512-byte sectors.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Code-wise this looks, though I don't know why we are guaranteed that a
compressed extent will only cover a single OE. But I trust you so:

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

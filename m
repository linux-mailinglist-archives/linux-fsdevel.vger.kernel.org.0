Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1AC28D1A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 17:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388985AbgJMP6B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 11:58:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:35008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388898AbgJMP6B (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 11:58:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D8BFEAAB2;
        Tue, 13 Oct 2020 15:57:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2D223DA7C3; Tue, 13 Oct 2020 17:56:33 +0200 (CEST)
Date:   Tue, 13 Oct 2020 17:56:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH v8 04/41] btrfs: Check and enable ZONED mode
Message-ID: <20201013155633.GF6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <cover.1601572459.git.naohiro.aota@wdc.com>
 <c6d9f70f9b9264497aa630d6c95d8d387b012d57.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6d9f70f9b9264497aa630d6c95d8d387b012d57.1601574234.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 02, 2020 at 03:36:11AM +0900, Naohiro Aota wrote:
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -588,6 +588,9 @@ struct btrfs_fs_info {
>  	struct btrfs_root *free_space_root;
>  	struct btrfs_root *data_reloc_root;
>  
> +	/* Zone size when in ZONED mode */
> +	u64 zone_size;

I think this could be reused to avoid the lengthy

	if (btrfs_fs_incompat(fs_info, ZONED))

to do

	if (fs_info->zoned)

In order to keep the semantics of both an anonymouns union should work:

	union {
		u64 zone_size;
		u64 zone;
	};

and the existing usage of zone_size can be kept intact.

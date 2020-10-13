Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB5B28D23A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 18:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgJMQ1p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 12:27:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:47244 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgJMQ1p (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 12:27:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AF09EAC6C;
        Tue, 13 Oct 2020 16:27:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 03547DA7C3; Tue, 13 Oct 2020 18:26:16 +0200 (CEST)
Date:   Tue, 13 Oct 2020 18:26:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 38/41] btrfs: extend zoned allocator to use dedicated
 tree-log block group
Message-ID: <20201013162616.GH6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
References: <cover.1601572459.git.naohiro.aota@wdc.com>
 <17f8b62a6fc896598378ecf88bdab5f6b3d3b9cc.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17f8b62a6fc896598378ecf88bdab5f6b3d3b9cc.1601574234.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 02, 2020 at 03:36:45AM +0900, Naohiro Aota wrote:
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -3656,6 +3656,9 @@ struct find_free_extent_ctl {
>  
>  	/* Allocation policy */
>  	enum btrfs_extent_allocation_policy policy;
> +
> +	/* Allocation is called for tree-log */
> +	bool for_treelog;

There are already bool flags in find_free_extent_ctl, move it after
orig_have_caching_bg.

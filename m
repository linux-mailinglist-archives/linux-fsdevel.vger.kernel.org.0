Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520573D7131
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 10:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbhG0IaV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 04:30:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235740AbhG0IaV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 04:30:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF0E9611AD;
        Tue, 27 Jul 2021 08:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627374619;
        bh=RC6Acl2iuH0vikxc0De/SVQbosapIi4KuvPx7aSVX/E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ENHoxaf1pjgjGoribd/AIOnp0lb7C0kwIJD0P/oAJmBBP1u0cuZ97ejG/GYq2pqUn
         g+GrK0qh/mqMcRKcDsebAnEjcsUZTGy9H2ZtnPKYjlG1Fzif/TCbXjTCSyZ0Tkm5wm
         xkMaZhzARG/O3vaMe3ImgzJDqjVPmSaBvWGZev5pod/VdQQ6tyENezrmgtDJXlbhSu
         JcMCgBWzuOmWQo86CRS4gcaD1KjLTxqZZwM7ZJHwPz1JphFZ7Kt1gwycsv7QD66d3g
         QU9blu8qpG2RN9Yi7Zpr6VHd9y16Co5w9YvkHtIHn9+LdmsCproxP0Q99CMlVM6BhD
         3+dGTikJOeLIw==
Subject: Re: [PATCH 3/9] f2fs: rework write preallocations
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
References: <20210716143919.44373-1-ebiggers@kernel.org>
 <20210716143919.44373-4-ebiggers@kernel.org>
 <14782036-f6a5-878a-d21f-e7dd7008a285@kernel.org>
 <YP2l+1umf9ct/4Sp@sol.localdomain> <YP9oou9sx4oJF1sc@google.com>
 <70f16fec-02f6-cb19-c407-856101cacc23@kernel.org>
 <YP+38QzXS6kpLGn0@sol.localdomain>
From:   Chao Yu <chao@kernel.org>
Message-ID: <70d9c954-d7f0-bbe2-f078-62273229342f@kernel.org>
Date:   Tue, 27 Jul 2021 16:30:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YP+38QzXS6kpLGn0@sol.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/7/27 15:38, Eric Biggers wrote:
> That's somewhat helpful, but I've been doing some more investigation and now I'm
> even more confused.  How can f2fs support non-overwrite DIO writes at all
> (meaning DIO writes in LFS mode as well as DIO writes to holes in non-LFS mode),
> given that it has no support for unwritten extents?  AFAICS, as-is users can

I'm trying to pick up DAX support patch created by Qiuyang from huawei, and it
looks it faces the same issue, so it tries to fix this by calling sb_issue_zeroout()
in f2fs_map_blocks() before it returns.

> easily leak uninitialized disk contents on f2fs by issuing a DIO write that
> won't complete fully (or might not complete fully), then reading back the blocks
> that got allocated but not written to.
> 
> I think that f2fs will have to take the ext2 approach of not allowing
> non-overwrite DIO writes at all...
Yes,

Another option is to enhance f2fs metadata's scalability which needs to update layout
of dnode block or SSA block, after that we can record the status of unwritten data block
there... it's a big change though...

Thanks,

> 
> - Eric
> 

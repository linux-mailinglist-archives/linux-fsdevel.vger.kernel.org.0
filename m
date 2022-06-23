Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182C7556F98
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 02:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358502AbiFWAmQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 20:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237295AbiFWAmO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 20:42:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5CD424BA;
        Wed, 22 Jun 2022 17:42:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BAFF61C16;
        Thu, 23 Jun 2022 00:42:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F45C34114;
        Thu, 23 Jun 2022 00:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655944932;
        bh=4npytdzwvKZpccogoQp7RnVfqzasKCP7V71zBvDkfMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qf+m0/8cZwm78jw7iKWEJkatIJ1BZLCSIU0RzmzOIdw9kAv9VhtN9l0twYJcpFddb
         PAI4AVWPQRv0HknnKBoN2VrXXv3fp/KWPzhA7UJ/pihaCDGvLfikhMLlxszNZtO3j7
         QWO2t+4jnnCquzdOloMeNjJnBDWkR21gPdjKeYWlnoU4XJ6F+bR9UYrianT+IHEx1f
         FgoV+bWVoAm4ngrFy52uUZPklNSMg9cbHyPhFzw/EMn3ho4dsB2hk5QV1jaX1bQ3lJ
         PGAKFoLkAI3jIFgJkh2Wtb+vdGP4vXaPmDZF9b1/SaC+b5h0WE8gUzG520+7CZY+Rm
         x4jBbzUr7GpRA==
Date:   Wed, 22 Jun 2022 17:42:11 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 25/25] xfs: Support large folios
Message-ID: <YrO243DkbckLTfP7@magnolia>
References: <20211216210715.3801857-1-willy@infradead.org>
 <20211216210715.3801857-26-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216210715.3801857-26-willy@infradead.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[resend with shorter 522.out file to keep us under the 300k maximum]

On Thu, Dec 16, 2021 at 09:07:15PM +0000, Matthew Wilcox (Oracle) wrote:
> Now that iomap has been converted, XFS is large folio safe.
> Indicate to the VFS that it can now create large folios for XFS.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/xfs/xfs_icache.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index da4af2142a2b..cdc39f576ca1 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -87,6 +87,7 @@ xfs_inode_alloc(
>  	/* VFS doesn't initialise i_mode or i_state! */
>  	VFS_I(ip)->i_mode = 0;
>  	VFS_I(ip)->i_state = 0;
> +	mapping_set_large_folios(VFS_I(ip)->i_mapping);
>  
>  	XFS_STATS_INC(mp, vn_active);
>  	ASSERT(atomic_read(&ip->i_pincount) == 0);
> @@ -320,6 +321,7 @@ xfs_reinit_inode(
>  	inode->i_rdev = dev;
>  	inode->i_uid = uid;
>  	inode->i_gid = gid;
> +	mapping_set_large_folios(inode->i_mapping);

Hmm.  Ever since 5.19-rc1, I've noticed that fsx in generic/522 now
reports file corruption after 20 minutes of runtime.  The corruption is
surprisingly reproducible (522.out.bad attached below) in that I ran it
three times and always got the same bad offset (0x6e000) and always the
same opcode (6213798(166 mod 256) MAPREAD).

I turned off multipage folios and now 522 has run for over an hour
without problems, so before I go do more debugging, does this ring a
bell to anyone?

[addendum: Apparently vger now has a 300K message size limit; if you
want the full output, see https://djwong.org/docs/522.out.txt ]

--D

QA output created by 522
READ BAD DATA: offset = 0x69e3e, size = 0x1c922, fname = /mnt/junk
OFFSET	GOOD	BAD	RANGE
0x6e000	0x0000	0x9173	0x00000
operation# (mod 256) for the bad data may be 145
0x6e001	0x0000	0x7391	0x00001
operation# (mod 256) for the bad data may be 145
0x6e002	0x0000	0x9195	0x00002
operation# (mod 256) for the bad data may be 145
0x6e003	0x0000	0x9591	0x00003
operation# (mod 256) for the bad data may be 145
0x6e004	0x0000	0x91b5	0x00004
operation# (mod 256) for the bad data may be 145
0x6e005	0x0000	0xb591	0x00005
operation# (mod 256) for the bad data may be 145
0x6e006	0x0000	0x91e2	0x00006
operation# (mod 256) for the bad data may be 145
0x6e007	0x0000	0xe291	0x00007
operation# (mod 256) for the bad data may be 145
0x6e008	0x0000	0x919d	0x00008
operation# (mod 256) for the bad data may be 145
0x6e009	0x0000	0x9d91	0x00009
operation# (mod 256) for the bad data may be 145
0x6e00a	0x0000	0x91e8	0x0000a
operation# (mod 256) for the bad data may be 145
0x6e00b	0x0000	0xe891	0x0000b
operation# (mod 256) for the bad data may be 145
0x6e00c	0x0000	0x91c9	0x0000c
operation# (mod 256) for the bad data may be 145
0x6e00d	0x0000	0xc991	0x0000d
operation# (mod 256) for the bad data may be 145
0x6e00e	0x0000	0x9147	0x0000e
operation# (mod 256) for the bad data may be 145
0x6e00f	0x0000	0x4791	0x0000f
operation# (mod 256) for the bad data may be 145
LOG DUMP (6213798 total operations):

<snip>

6213732(100 mod 256): COLLAPSE 0x3b000 thru 0x4efff	(0x14000 bytes)
6213733(101 mod 256): READ     0x1953d thru 0x29311	(0xfdd5 bytes)
6213734(102 mod 256): INSERT 0x14000 thru 0x2ffff	(0x1c000 bytes)
6213735(103 mod 256): COPY 0x1d381 thru 0x36d38	(0x199b8 bytes) to 0x64491 thru 0x7de48	******EEEE
6213736(104 mod 256): ZERO     0x74247 thru 0x927bf	(0x1e579 bytes)
6213737(105 mod 256): INSERT 0x8000 thru 0x16fff	(0xf000 bytes)
6213738(106 mod 256): READ     0x87aba thru 0x8ce48	(0x538f bytes)
6213739(107 mod 256): TRUNCATE DOWN	from 0x8ce49 to 0x46571	******WWWW
6213740(108 mod 256): SKIPPED (no operation)
6213741(109 mod 256): ZERO     0x55674 thru 0x70d41	(0x1b6ce bytes)	******ZZZZ
6213742(110 mod 256): PUNCH    0xc8b5 thru 0xe80d	(0x1f59 bytes)
6213743(111 mod 256): TRUNCATE DOWN	from 0x70d42 to 0x11ade	******WWWW
6213744(112 mod 256): COLLAPSE 0x6000 thru 0xffff	(0xa000 bytes)
6213745(113 mod 256): SKIPPED (no operation)
6213746(114 mod 256): MAPREAD  0x2625 thru 0x7add	(0x54b9 bytes)
6213747(115 mod 256): CLONE 0x2000 thru 0x6fff	(0x5000 bytes) to 0x10000 thru 0x14fff
6213748(116 mod 256): SKIPPED (no operation)
6213749(117 mod 256): TRUNCATE UP	from 0x15000 to 0x8d131	******WWWW
6213750(118 mod 256): WRITE    0x82547 thru 0x88334	(0x5dee bytes)
6213751(119 mod 256): DEDUPE 0x7d000 thru 0x83fff	(0x7000 bytes) to 0x22000 thru 0x28fff
6213752(120 mod 256): READ     0x11e69 thru 0x2864c	(0x167e4 bytes)
6213753(121 mod 256): INSERT 0x41000 thru 0x45fff	(0x5000 bytes)
6213754(122 mod 256): COPY 0x2ca4c thru 0x2ed9f	(0x2354 bytes) to 0x2fef1 thru 0x32244
6213755(123 mod 256): MAPWRITE 0x70677 thru 0x8b993	(0x1b31d bytes)
6213756(124 mod 256): FALLOC   0x7229f thru 0x91158	(0x1eeb9 bytes) INTERIOR
6213757(125 mod 256): COLLAPSE 0x13000 thru 0x2bfff	(0x19000 bytes)
6213758(126 mod 256): COPY 0x9271 thru 0xba34	(0x27c4 bytes) to 0x3227c thru 0x34a3f
6213759(127 mod 256): CLONE 0x23000 thru 0x2cfff	(0xa000 bytes) to 0x6c000 thru 0x75fff	******JJJJ
6213760(128 mod 256): READ     0x44cff thru 0x4c4a1	(0x77a3 bytes)
6213761(129 mod 256): DEDUPE 0x60000 thru 0x73fff	(0x14000 bytes) to 0x39000 thru 0x4cfff	BBBB******
6213762(130 mod 256): COLLAPSE 0x39000 thru 0x3ffff	(0x7000 bytes)
6213763(131 mod 256): WRITE    0x57565 thru 0x5e710	(0x71ac bytes)
6213764(132 mod 256): MAPREAD  0x39c49 thru 0x4accd	(0x11085 bytes)
6213765(133 mod 256): ZERO     0x4faf5 thru 0x6a5cc	(0x1aad8 bytes)
6213766(134 mod 256): MAPREAD  0x57f8 thru 0x8c98	(0x34a1 bytes)
6213767(135 mod 256): MAPREAD  0x5cbd8 thru 0x72130	(0x15559 bytes)	***RRRR***
6213768(136 mod 256): SKIPPED (no operation)
6213769(137 mod 256): INSERT 0x24000 thru 0x32fff	(0xf000 bytes)
6213770(138 mod 256): COPY 0x32b0c thru 0x4d035	(0x1a52a bytes) to 0x4f97f thru 0x69ea8
6213771(139 mod 256): DEDUPE 0x3f000 thru 0x52fff	(0x14000 bytes) to 0x23000 thru 0x36fff
6213772(140 mod 256): READ     0x6d9bf thru 0x81130	(0x13772 bytes)	***RRRR***
6213773(141 mod 256): TRUNCATE DOWN	from 0x81131 to 0x569c0	******WWWW
6213774(142 mod 256): MAPREAD  0x354d5 thru 0x44e7b	(0xf9a7 bytes)
6213775(143 mod 256): MAPWRITE 0x547c4 thru 0x60a8e	(0xc2cb bytes)
6213776(144 mod 256): SKIPPED (no operation)
6213777(145 mod 256): WRITE    0x28ada thru 0x4356c	(0x1aa93 bytes)
6213778(146 mod 256): ZERO     0x74c28 thru 0x91fec	(0x1d3c5 bytes)
6213779(147 mod 256): INSERT 0x12000 thru 0x1cfff	(0xb000 bytes)
6213780(148 mod 256): ZERO     0x30834 thru 0x330f7	(0x28c4 bytes)
6213781(149 mod 256): PUNCH    0x36080 thru 0x42edc	(0xce5d bytes)
6213782(150 mod 256): DEDUPE 0x14000 thru 0x19fff	(0x6000 bytes) to 0x49000 thru 0x4efff
6213783(151 mod 256): DEDUPE 0x51000 thru 0x5efff	(0xe000 bytes) to 0x2a000 thru 0x37fff
6213784(152 mod 256): WRITE    0x2448e thru 0x400f5	(0x1bc68 bytes)
6213785(153 mod 256): ZERO     0x87615 thru 0x927bf	(0xb1ab bytes)
6213786(154 mod 256): READ     0x5afc thru 0xa32c	(0x4831 bytes)
6213787(155 mod 256): SKIPPED (no operation)
6213788(156 mod 256): ZERO     0x7aab0 thru 0x7e2b3	(0x3804 bytes)
6213789(157 mod 256): INSERT 0x45000 thru 0x58fff	(0x14000 bytes)
6213790(158 mod 256): FALLOC   0x1a80e thru 0x289a3	(0xe195 bytes) INTERIOR
6213791(159 mod 256): SKIPPED (no operation)
6213792(160 mod 256): SKIPPED (no operation)
6213793(161 mod 256): FALLOC   0x2aca thru 0x20562	(0x1da98 bytes) INTERIOR
6213794(162 mod 256): ZERO     0x72fb9 thru 0x75887	(0x28cf bytes)
6213795(163 mod 256): COPY 0xa62e thru 0x218d0	(0x172a3 bytes) to 0x28ab1 thru 0x3fd53
6213796(164 mod 256): SKIPPED (no operation)
6213797(165 mod 256): COPY 0xa666 thru 0xf6a1	(0x503c bytes) to 0x353f0 thru 0x3a42b
6213798(166 mod 256): MAPREAD  0x69e3e thru 0x8675f	(0x1c922 bytes)	***RRRR***
Log of operations saved to "/mnt/junk.fsxops"; replay with --replay-ops
Correct content saved for comparison
(maybe hexdump "/mnt/junk" vs "/mnt/junk.fsxgood")
Silence is golden

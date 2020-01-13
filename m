Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 623321390CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 13:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgAMMIx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 07:08:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:53824 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgAMMIx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 07:08:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B1A75AD12;
        Mon, 13 Jan 2020 12:08:51 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 540C91E0D0E; Mon, 13 Jan 2020 13:08:51 +0100 (CET)
Date:   Mon, 13 Jan 2020 13:08:51 +0100
From:   Jan Kara <jack@suse.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: udf: Suspicious values in udf_statfs()
Message-ID: <20200113120851.GG23642@quack2.suse.cz>
References: <20200112162311.khkvcu2u6y4gbbr7@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200112162311.khkvcu2u6y4gbbr7@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Sun 12-01-20 17:23:11, Pali Rohár wrote:
> I looked at udf_statfs() implementation and I see there two things which
> are probably incorrect:
> 
> First one:
> 
> 	buf->f_blocks = sbi->s_partmaps[sbi->s_partition].s_partition_len;
> 
> If sbi->s_partition points to Metadata partition then reported number
> of blocks seems to be incorrect. Similar like in udf_count_free().

Oh, right. This needs similar treatment like udf_count_free(). I'll fix it.
Thanks for spotting.

> Second one:
> 
> 	buf->f_files = (lvidiu != NULL ? (le32_to_cpu(lvidiu->numFiles) +
> 					  le32_to_cpu(lvidiu->numDirs)) : 0)
> 			+ buf->f_bfree;
> 
> What f_files entry should report? Because result of sum of free blocks
> and number of files+directories does not make sense for me.

This is related to the fact that we return 'f_bfree' as the number of 'free
file nodes' in 'f_ffree'. And tools generally display f_files-f_ffree as
number of used inodes. In other words we treat every free block also as a
free 'inode' and report it in total amount of 'inodes'. I know this is not
very obvious but IMHO it causes the least confusion to users reading df(1)
output.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

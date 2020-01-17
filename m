Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3E2E140920
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 12:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgAQLii (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 06:38:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:56612 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbgAQLii (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 06:38:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1A825AED5;
        Fri, 17 Jan 2020 11:38:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7586A1E0D53; Fri, 17 Jan 2020 12:38:33 +0100 (CET)
Date:   Fri, 17 Jan 2020 12:38:33 +0100
From:   Jan Kara <jack@suse.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: udf: Suspicious values in udf_statfs()
Message-ID: <20200117113833.GG17141@quack2.suse.cz>
References: <20200112162311.khkvcu2u6y4gbbr7@pali>
 <20200113120851.GG23642@quack2.suse.cz>
 <20200116153019.5awize7ufnxtjagf@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200116153019.5awize7ufnxtjagf@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 16-01-20 16:30:19, Pali Rohár wrote:
> On Monday 13 January 2020 13:08:51 Jan Kara wrote:
> > > Second one:
> > > 
> > > 	buf->f_files = (lvidiu != NULL ? (le32_to_cpu(lvidiu->numFiles) +
> > > 					  le32_to_cpu(lvidiu->numDirs)) : 0)
> > > 			+ buf->f_bfree;
> > > 
> > > What f_files entry should report? Because result of sum of free blocks
> > > and number of files+directories does not make sense for me.
> > 
> > This is related to the fact that we return 'f_bfree' as the number of 'free
> > file nodes' in 'f_ffree'. And tools generally display f_files-f_ffree as
> > number of used inodes. In other words we treat every free block also as a
> > free 'inode' and report it in total amount of 'inodes'. I know this is not
> > very obvious but IMHO it causes the least confusion to users reading df(1)
> > output.
> 
> So current code which returns sum of free blocks and number of
> files+directories is correct. Could be this information about statvfs
> f_files somewhere documented? Because this is not really obvious nor for
> userspace applications which use statvfs() nor for kernel filesystem
> drivers.

Well, I can certainly add a comment to udf_statfs(). Documenting in some
manpage might be worth it but I'm not 100% sure where - maybe directly in
the statfs(2) to the NOTES section? Also note that this behavior is not
unique to UDF - e.g. XFS also does the same.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

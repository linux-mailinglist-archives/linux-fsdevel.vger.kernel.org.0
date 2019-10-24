Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5DBDE2B51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 09:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407111AbfJXHqZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 03:46:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:35658 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404822AbfJXHqZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 03:46:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 456BEAC22;
        Thu, 24 Oct 2019 07:46:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0CF971E4A99; Thu, 24 Oct 2019 09:46:19 +0200 (CEST)
Date:   Thu, 24 Oct 2019 09:46:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Petr Vorel <pvorel@suse.cz>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Cyril Hrubis <chrubis@suse.cz>,
        Yong Sun <yosun@suse.com>
Subject: Re: "New" ext4 features tests in LTP
Message-ID: <20191024074619.GI31271@quack2.suse.cz>
References: <20191023155846.GA28604@dell5510>
 <20191023225824.GB7630@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023225824.GB7630@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 23-10-19 18:58:24, Theodore Y. Ts'o wrote:
> On Wed, Oct 23, 2019 at 05:58:46PM +0200, Petr Vorel wrote:
> > ext4-inode-version [4]
> > ------------------
> > Directory containing the shell script which is used to test inode version field
> > on disk of ext4.
> 
> This is basically testing whether or not i_version gets incremented
> after various file system operations.  There's some checks about
> whether i_version is 32 bit or 64 bit based on the inode size, which
> seems a bit pointless, and also checking whether the file system can
> be mounted as ext3, which is even more pointless.
> 
> The i_version increment check can be done in a much more general (file
> systme independant) way by using the FS_IOC_GETVERSION ioctl (there is
> also an FS_IOC_SETVERSION).  

Yeah, I believe this may be useful to implement in fstests in some fs
agnostic way.

> > ext4-nsec-timestamps [6]
> > --------------------
> > Directory containing the shell script which is used to test nanosec timestamps
> > of ext4.
> 
> This basically tests that the file system supports nanosecond
> timestamps, with a 0.3% false positive failure rate.   Again, why?
> 
> > ext4-subdir-limit [9]
> > -----------------
> > Directory containing the shell script which is used to test subdirectory limit
> > of ext4. According to the kernel documentation, we create more than 32000
> > subdirectorys on the ext4 filesystem.
> 
> This is a valid test, although it's not what I would call a "high
> value" test.  (As in, it's testing maybe a total of four simple lines
> of code that are highly unlikely to fail.)

These two may be IMHO worth carrying over to fstests in some form. The other
tests seem either already present in various fstests configs we run or
pointless as Ted wrote.
	
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

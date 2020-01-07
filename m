Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63889132217
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 10:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgAGJQp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 04:16:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:40790 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727698AbgAGJQo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:16:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C9A2CAC7D;
        Tue,  7 Jan 2020 09:16:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 498A71E0B47; Tue,  7 Jan 2020 10:16:42 +0100 (CET)
Date:   Tue, 7 Jan 2020 10:16:42 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Sitsofe Wheeler <sitsofe@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, drh@sqlite.org,
        Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Theodore Tso <tytso@mit.edu>,
        harshad shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: Questions about filesystems from SQLite author presentation
Message-ID: <20200107091642.GC26849@quack2.suse.cz>
References: <CALjAwxi3ZpRZLS9QaGfAqwAVST0Biyj_p-b22f=iq_ns4ZQyiA@mail.gmail.com>
 <CAOQ4uxhJhzUj_sjhDknGzdLs6kOXzt3GO2vyCzmuBNTSsAQLGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhJhzUj_sjhDknGzdLs6kOXzt3GO2vyCzmuBNTSsAQLGA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 06-01-20 17:40:20, Amir Goldstein wrote:
> On Mon, Jan 6, 2020 at 9:26 AM Sitsofe Wheeler <sitsofe@gmail.com> wrote:
> > If a power loss occurs at about the same time that a file is being extended
> > with new data, will the file be guaranteed to contain valid data after reboot,
> > or might the extended area of the file contain all zeros or all ones or
> > arbitrary content? In other words, is the file data always committed to disk
> > ahead of the file size?
> 
> While that statement would generally be true (ever since ext3
> journal=ordered...),
> you have no such guaranty. Getting such a guaranty would require a new API
> like O_ATOMIC.

This is not quite true.

1) The rule you can rely on is: No random data in a file. So after a power
failure the state of the can be:
  a) original file state
  b) file size increased (possibly only partially), each block in the
     extended area contains either correct data or zeros.

There are exceptions to this for filesystems that don't maintain metadata
consistency on crash such as ext2, vfat, udf, or ext4 in data=writeback
mode. There the outcome after a crash is undefined...

> > If a write occurs on one or two bytes of a file at about the same time as a power
> > loss, are other bytes of the file guaranteed to be unchanged after reboot?
> > Or might some other bytes within the same sector have been modified as well?
> 
> I don't see how other bytes could change in this scenario, but I don't
> know if the hardware provides this guarantee. Maybe someone else knows
> the answer.

As Matthew wrote this boils down to whether the HW provides sector write
atomicity. Practically that seems to be the case.

> > Is it possible (or helpful) to tell the filesystem that the content of a particular file
> > does not need to survive reboot?
> 
> Not that I know of.
> 
> > Is it possible (or helpful) to tell the filesystem that a particular file can be
> > unlinked upon reboot?
> 
> Not that I know of.

Well, you could create the file with O_TMPFILE flag. That will give you
unlinked inode which will get just deleted once the file is closed (and
also on reboot). If you don't want to keep the file open all the time you
use it, then I don't know of a way.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C24F11355B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 20:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfLDTCI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 14:02:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:44306 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728114AbfLDTCI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:02:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3B16EB2F9;
        Wed,  4 Dec 2019 19:02:04 +0000 (UTC)
Date:   Wed, 4 Dec 2019 20:01:54 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@google.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hou Tao <houtao1@huawei.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Hannes Reinecke <hare@suse.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 rebase 00/10] Fix cdrom autoclose
Message-ID: <20191204190154.GA28406@kitsune.suse.cz>
References: <cover.1574797504.git.msuchanek@suse.de>
 <c6fe572c-530e-93eb-d62a-cb2f89c7b4ec@kernel.dk>
 <20191126202151.GY11661@kitsune.suse.cz>
 <08bcfd0a-7433-2fa4-9ca2-ea008836b747@kernel.dk>
 <20191127081144.GZ11661@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191127081144.GZ11661@kitsune.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 27, 2019 at 09:11:44AM +0100, Michal Suchánek wrote:
> On Tue, Nov 26, 2019 at 04:13:32PM -0700, Jens Axboe wrote:
> > On 11/26/19 1:21 PM, Michal Suchánek wrote:
> > > On Tue, Nov 26, 2019 at 01:01:42PM -0700, Jens Axboe wrote:
> > >> On 11/26/19 12:54 PM, Michal Suchanek wrote:
> > >>> Hello,
> > >>>
> > >>> there is cdrom autoclose feature that is supposed to close the tray,
> > >>> wait for the disc to become ready, and then open the device.
> > >>>
> > >>> This used to work in ancient times. Then in old times there was a hack
> > >>> in util-linux which worked around the breakage which probably resulted
> > >>> from switching to scsi emulation.
> > >>>
> > >>> Currently util-linux maintainer refuses to merge another hack on the
> > >>> basis that kernel still has the feature so it should be fixed there.
> > >>> The code needs not be replicated in every userspace utility like mount
> > >>> or dd which has no business knowing which devices are CD-roms and where
> > >>> the autoclose setting is in the kernel.
> > >>>
> > >>> This is rebase on top of current master.
> > >>>
> > >>> Also it seems that most people think that this is fix for WMware because
> > >>> there is one patch dealing with WMware.
> > >>
> > >> I think the main complaint with this is that it's kind of a stretch to
> > >> add core functionality for a device type that's barely being
> > >> manufactured anymore and is mostly used in a virtualized fashion. I

That optical drives are hardly manufactured is kind of a stretch. I have
no problem obtaining drives from a few manufacturers in any nearby
computer store. While using DVDs may be slowly getting out of fashion
the same applies to all optical drives, including Blueray. Some of these
will stay for forseeable future.

> > >> think it you could fix this without 10 patches of churn and without
> > >> adding a new ->open() addition to fops, then people would be a lot more
> > >> receptive to the idea of improving cdrom auto-close.
> > > 
> > > I see no way to do that cleanly.
> > > 
> > > There are two open modes for cdrom devices - blocking and
> > > non-blocking.
> > > 
> > > In blocking mode open() should analyze the medium so that it's ready
> > > when it returns. In non-blocking mode it should return immediately so
> > > long as you can talk to the device.
> > > 
> > > When waiting in open() with locks held the processes trying to open
> > > the device are locked out regradless of the mode they use.
> > > 
> > > The only way to solve this is to pretend that the device is open and
> > > do the wait afterwards with the device unlocked.
> > 
> > How is this any different from an open on a file that needs to bring in
> > meta data on a busy rotating device, which can also take seconds?
> 
> First, accessing a file will take seconds only when your system is
> seriously overloaded or misconfigured. The access time for rotational
> storage is tens of milliseconds. With cdrom the access time after
> closing the door is measured in tens of seconds on common hardware. It
> can be shorter but also possibly longer. I am not aware of any limit
> there. It may be reasonable to want to get device status during this
> time.
> 
> Second, fetching the metadata for the file does not block operations that
> don't need the metadata. Here waiting for the drive to get ready blocks
> all access. You could get drive status if you did not try to open it
> but once you do you can no longer talk to it.

So let's look at the alternatives. One proposed alternative was to
change the locking calls to the locks that are held while waiting in
open() to interuptible so that impatient users can at least kill
processes waiting on their CD medium to become ready.

What is held are sr_mutex and bd_mutex.

bd_mutex is per_device so any open() or close() on the same CD-ROM
device is blocked. There are a number of other sites where bd_mutex is
locked and it will be needed to figure out which of these can be called
with a cd-rom device and change them to killable so that processes
waiting on the lock to don't get uninterriptibly stuck. This may be more
code churn than this patchset. I think we can exclude loop.c and
zram-dev.c but ioctl.c, xen-blkfront.c, and block_dev.c apply. Don't
know about dasd.

The bd_mutex is held in iterate_bdevs so all bets are off wrt being able
to operate the system.  Once a process is stuck waiting in blkdev_get()
which calls open() on the cdrom you cannot iterate block devices. With
boot times measured in seconds and medium analysis times measured in
tens of seconds users will not be amused.

autoclose defaults to on, and blkid reads deviced in blocking mode
causing all the fun stuff to trigger (patch pending to change that).
Nonetheless any number of utilities still not aware of this nonblock
quirk out there will try to open the device sooner or later blocking all
operations that require iterating the list of block devices.

Adding tens of seconds to block device opening time (which I assume
might need iterating list of block devices) might even overflow some
systemd timeout and fail boot.  There is timeout for each particular job
but there are also cumulative timeouts for something like 'locate device
with this UUID' which are fixed regardles of the number of layers (LVM,
md, ..) involved.

The other approach is to do like harddisks. With a harddisk a medium is
'fixed' - that is assumed to be present always. Any error accessing the
medium is reported on read() or write() and not necessarily on open().
This would require hooking the autoclose to the operations that require
actual medium - probably something like count_tracks(), and eschew
calling these from open(). That would work but breaks the contract
described in the current API documentation - that is if you don't open
with O_NONBLOCK and there is obvious medium error like no medium at all
or no usable track you get the error on open() rather than on whatever
opration that tries to use the track.

Thanks

Michal

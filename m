Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72E4D10A55D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 21:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfKZUV4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 15:21:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:52240 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726036AbfKZUV4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 15:21:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D5F01B147;
        Tue, 26 Nov 2019 20:21:53 +0000 (UTC)
Date:   Tue, 26 Nov 2019 21:21:51 +0100
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
Message-ID: <20191126202151.GY11661@kitsune.suse.cz>
References: <cover.1574797504.git.msuchanek@suse.de>
 <c6fe572c-530e-93eb-d62a-cb2f89c7b4ec@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6fe572c-530e-93eb-d62a-cb2f89c7b4ec@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 26, 2019 at 01:01:42PM -0700, Jens Axboe wrote:
> On 11/26/19 12:54 PM, Michal Suchanek wrote:
> > Hello,
> > 
> > there is cdrom autoclose feature that is supposed to close the tray,
> > wait for the disc to become ready, and then open the device.
> > 
> > This used to work in ancient times. Then in old times there was a hack
> > in util-linux which worked around the breakage which probably resulted
> > from switching to scsi emulation.
> > 
> > Currently util-linux maintainer refuses to merge another hack on the
> > basis that kernel still has the feature so it should be fixed there.
> > The code needs not be replicated in every userspace utility like mount
> > or dd which has no business knowing which devices are CD-roms and where
> > the autoclose setting is in the kernel.
> > 
> > This is rebase on top of current master.
> > 
> > Also it seems that most people think that this is fix for WMware because
> > there is one patch dealing with WMware.
> 
> I think the main complaint with this is that it's kind of a stretch to
> add core functionality for a device type that's barely being
> manufactured anymore and is mostly used in a virtualized fashion. I
> think it you could fix this without 10 patches of churn and without
> adding a new ->open() addition to fops, then people would be a lot more
> receptive to the idea of improving cdrom auto-close.

I see no way to do that cleanly.

There are two open modes for cdrom devices - blocking and non-blocking.

In blocking mode open() should analyze the medium so that it's ready
when it returns. In non-blocking mode it should return immediately so
long as you can talk to the device.

When waiting in open() with locks held the processes trying to open the
device are locked out regradless of the mode they use.

The only way to solve this is to pretend that the device is open and do
the wait afterwards with the device unlocked.

Thanks

Michal

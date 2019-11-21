Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2393B10503C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 11:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfKUKPg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 05:15:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:55124 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726994AbfKUKPg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:15:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2CEEEB1EC;
        Thu, 21 Nov 2019 10:15:34 +0000 (UTC)
Date:   Thu, 21 Nov 2019 11:15:32 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-scsi@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] bdev: add open_finish.
Message-ID: <20191121101532.GI11661@kitsune.suse.cz>
References: <cover.1571834862.git.msuchanek@suse.de>
 <ea2652294651cbc8549736728c650d16d2fe1808.1571834862.git.msuchanek@suse.de>
 <20191024022232.GB11485@infradead.org>
 <20191024085514.GI938@kitsune.suse.cz>
 <20191024131254.GE2963@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191024131254.GE2963@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 24, 2019 at 06:12:54AM -0700, Matthew Wilcox wrote:
> On Thu, Oct 24, 2019 at 10:55:14AM +0200, Michal Suchánek wrote:
> > On Wed, Oct 23, 2019 at 07:22:32PM -0700, Christoph Hellwig wrote:
> > > On Wed, Oct 23, 2019 at 02:52:45PM +0200, Michal Suchanek wrote:
> > > > Opening a block device may require a long operation such as waiting for
> > > > the cdrom tray to close. Performing this operation with locks held locks
> > > > out other attempts to open the device. These processes waiting to open
> > > > the device are not killable.
> 
> You can use mutex_lock_killable() to fix that.
> 
That fixes only half of the problem.

Other processes still cannot access the device while you wait on
mutex_lock_killable

Thanks

Michal

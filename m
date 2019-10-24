Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 017EAE2E67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 12:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405188AbfJXKLR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 06:11:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:56916 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390611AbfJXKLQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:11:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 89A03B68C;
        Thu, 24 Oct 2019 10:11:14 +0000 (UTC)
Date:   Thu, 24 Oct 2019 12:11:12 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-scsi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jens Axboe <axboe@kernel.dk>,
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
Subject: Re: [PATCH v2 7/8] scsi: sr: workaround VMware ESXi cdrom emulation
 bug
Message-ID: <20191024101112.GK938@kitsune.suse.cz>
References: <cover.1571834862.git.msuchanek@suse.de>
 <abf81ec4f8b6139fffc609df519856ff8dc01d0d.1571834862.git.msuchanek@suse.de>
 <08f1e291-0196-2402-1947-c0cdaaf534da@suse.de>
 <20191023162313.GE938@kitsune.suse.cz>
 <2bc50e71-6129-a482-00bd-0425b486ce07@suse.de>
 <20191024085631.GJ938@kitsune.suse.cz>
 <15c972ea-5b3a-487f-7be5-a62d780896da@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15c972ea-5b3a-487f-7be5-a62d780896da@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 24, 2019 at 11:41:38AM +0200, Hannes Reinecke wrote:
> On 10/24/19 10:56 AM, Michal Suchánek wrote:
> > On Thu, Oct 24, 2019 at 07:46:57AM +0200, Hannes Reinecke wrote:
> >> On 10/23/19 6:23 PM, Michal Suchánek wrote:
> >>> On Wed, Oct 23, 2019 at 04:13:15PM +0200, Hannes Reinecke wrote:
> [ .. ]>>>> This looks something which should be handled via a blacklist
> flag, not
> >>>> some inline hack which everyone forgets about it...
> >>>
> >>> AFAIK we used to have a blacklist but don't have anymore. So either it
> >>> has to be resurrected for this one flag or an inline hack should be good
> >>> enough.
> >>>
> >> But we do have one for generic scsi; cf drivers/scsi/scsi_devinfo.c.
> >> And this pretty much falls into the category of SCSI quirks, so I'd
> >> prefer have it hooked into that.
> > 
> > But generic scsi does not know about cdrom trays, does it?
> > 
> No, just about 'flags'. What you _do_ with those flags is up to you.
> Or, rather, the driver.
> Just define a 'tray detection broken' flag, and evaluate it in sr.c.
> 
> Where is the problem with that?

And how do you set the flag?

The blacklist lists exact manufacturer and model while this rule only
depends on model because manufacturer is bogus. Also the blacklist
itself is deprecated:

/*
 * scsi_static_device_list: deprecated list of devices that require
 * settings that differ from the default, includes black-listed (broken)
 * devices. The entries here are added to the tail of scsi_dev_info_list
 * via scsi_dev_info_list_init.
 *
 * Do not add to this list, use the command line or proc interface to add
 * to the scsi_dev_info_list. This table will eventually go away.
 */

Thanks

Michal

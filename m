Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9C2296426
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 19:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368410AbgJVRya (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 13:54:30 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38189 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368401AbgJVRy3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 13:54:29 -0400
Received: by mail-pj1-f67.google.com with SMTP id lw2so1365526pjb.3;
        Thu, 22 Oct 2020 10:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jZuHlEwh3g7UcDcJaONWe8EfIxBYtT9I7AYk4QdFzwc=;
        b=HpUKeYLOpey2keZ7sqmID8yCJJa9s8k9XXg194te9ikqq7sUoJgXsGO+0Mzyl8gNES
         eacpNxyEJ5MFm4cjqQjfIK/DxIV9StLF5a1drbN5lhmqxA+Co5DlCbDmuWUeLRSr3ir3
         kFx2/LZcD9SZlo6PAN+Rna7UUpt08byAxKSwPiDjt1AF470BndULHvqyPclInZ1prSxO
         EGGQHV9dmF4XsCGNgMJnV2sjsvrTmYkIB9xfcl0PsDFSe81Z0DfqFV/GGdOVxQTbOl+k
         G/XceJLqD910vdO7Cv48Wjh4YhVTmjTDXGvnOvVLm34AH9AA4ay7nnUjwl5mnBOAEXqW
         5EQw==
X-Gm-Message-State: AOAM532ZCrkUmIg+dCbL6MGWHrLtq4I1GmI0p1GrFEdNDwcKjtAFkuCy
        ravVzeaaGskJ5KlTZXYMlYPM3AYtiKeXcxojjG4=
X-Google-Smtp-Source: ABdhPJxcm7nxDfpt8QtfKwOARuDT6nuFczBSIqDJ7vYnHyrPosWkJvFSDvOcbTMeVUL5SpoaDYnY4onxzd0QAP3w2Bs=
X-Received: by 2002:a17:902:c254:b029:d4:c2d4:15f with SMTP id
 20-20020a170902c254b02900d4c2d4015fmr3651304plg.18.1603389267970; Thu, 22 Oct
 2020 10:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <1603271049-20681-1-git-send-email-sergei.shtepa@veeam.com>
 <71926887-5707-04a5-78a2-ffa2ee32bd68@suse.de> <20201021141044.GF20749@veeam.com>
 <ca8eaa40-b422-2272-1fd9-1d0a354c42bf@suse.de> <20201022094402.GA21466@veeam.com>
 <BL0PR04MB6514AC1B1FF313E6A14D122CE71D0@BL0PR04MB6514.namprd04.prod.outlook.com>
 <20201022135213.GB21466@veeam.com> <20201022151418.GR9832@magnolia>
In-Reply-To: <20201022151418.GR9832@magnolia>
From:   Mike Snitzer <snitzer@redhat.com>
Date:   Thu, 22 Oct 2020 13:54:16 -0400
Message-ID: <CAMM=eLfO_L-ZzcGmpPpHroznnSOq_KEWignFoM09h7Am9yE83g@mail.gmail.com>
Subject: Re: [PATCH 0/2] block layer filter and block device snapshot module
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Sergei Shtepa <sergei.shtepa@veeam.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "jack@suse.cz" <jack@suse.cz>, "tj@kernel.org" <tj@kernel.org>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "osandov@fb.com" <osandov@fb.com>,
        "koct9i@gmail.com" <koct9i@gmail.com>,
        "steve@sk2.org" <steve@sk2.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        device-mapper development <dm-devel@redhat.com>,
        Alasdair G Kergon <agk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 22, 2020 at 11:14 AM Darrick J. Wong
<darrick.wong@oracle.com> wrote:
>
> On Thu, Oct 22, 2020 at 04:52:13PM +0300, Sergei Shtepa wrote:
> > The 10/22/2020 13:28, Damien Le Moal wrote:
> > > On 2020/10/22 18:43, Sergei Shtepa wrote:
> > > >
> > > > Maybe, but the problem is that I can't imagine how to implement
> > > > dm-intercept yet.
> > > > How to use dm to implement interception without changing the stack
> > > > of block devices. We'll have to make a hook somewhere, isn`t it?
> > >
> > > Once your dm-intercept target driver is inserted with "dmsetup" or any user land
> > > tool you implement using libdevicemapper, the "hooks" will naturally be in place
> > > since the dm infrastructure already does that: all submitted BIOs will be passed
> > > to dm-intercept through the "map" operation defined in the target_type
> > > descriptor. It is then that driver job to execute the BIOs as it sees fit.
> > >
> > > Look at simple device mappers like dm-linear or dm-flakey for hints of how
> > > things work (driver/md/dm-linear.c). More complex dm drivers like dm-crypt,
> > > dm-writecache or dm-thin can give you hints about more features of device mapper.
> > > Functions such as __map_bio() in drivers/md/dm.c are the core of DM and show
> > > what happens to BIOs depending on the the return value of the map operation.
> > > dm_submit_bio() and __split_and_process_bio() is the entry points for BIO
> > > processing in DM.
> > >
> >
> > Is there something I don't understand? Please correct me.
> >
> > Let me remind that by the condition of the problem, we can't change
> > the configuration of the block device stack.
> >
> > Let's imagine this configuration: /root mount point on ext filesystem
> > on /dev/sda1.
> > +---------------+
> > |               |
> > |  /root        |
> > |               |
> > +---------------+
> > |               |
> > | EXT FS        |
> > |               |
> > +---------------+
> > |               |
> > | block layer   |
> > |               |
> > | sda queue     |
> > |               |
> > +---------------+
> > |               |
> > | scsi driver   |
> > |               |
> > +---------------+
> >
> > We need to add change block tracking (CBT) and snapshot functionality for
> > incremental backup.
> >
> > With the DM we need to change the block device stack. Add device /dev/sda1
> > to LVM Volume group, create logical volume, change /etc/fstab and reboot.
> >
> > The new scheme will look like this:
> > +---------------+
> > |               |
> > |  /root        |
> > |               |
> > +---------------+
> > |               |
> > | EXT FS        |
> > |               |
> > +---------------+
> > |               |
> > | LV-root       |
> > |               |
> > +------------------+
> > |                  |
> > | dm-cbt & dm-snap |
> > |                  |
> > +------------------+
> > |               |
> > | sda queue     |
> > |               |
> > +---------------+
> > |               |
> > | scsi driver   |
> > |               |
> > +---------------+
> >
> > But I cannot change block device stack. And so I propose a scheme with
> > interception.
> > +---------------+
> > |               |
> > |  /root        |
> > |               |
> > +---------------+
> > |               |
> > | EXT FS        |
> > |               |
> > +---------------+   +-----------------+
> > |  |            |   |                 |
> > |  | blk-filter |-> | cbt & snapshot  |
> > |  |            |<- |                 |
> > |  +------------+   +-----------------+
> > |               |
> > | sda blk queue |
> > |               |
> > +---------------+
> > |               |
> > | scsi driver   |
> > |               |
> > +---------------+
> >
> > Perhaps I can make "cbt & snapshot" inside the DM, but without interception
> > in any case, it will not work. Isn't that right?
>
> Stupid question: Why don't you change the block layer to make it
> possible to insert device mapper devices after the blockdev has been set
> up?

Not a stupid question.  Definitely something that us DM developers
have wanted to do for a while.  Devil is in the details but it is the
right way forward.

Otherwise, this intercept is really just a DM-lite remapping layer
without any of DM's well established capabilities.  Encouragingly, all
of the replies have effectively echoed this point.  (amusingly, seems
every mailing list under the sun is on the cc except dm-devel... now
rectified)

Alasdair has some concrete ideas on this line of work; I'm trying to
encourage him to reply ;)

Mike

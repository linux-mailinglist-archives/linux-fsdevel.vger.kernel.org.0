Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68EE831DDA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 17:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbhBQQuN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 11:50:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:57380 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234227AbhBQQuM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:50:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3A0A7B7A5;
        Wed, 17 Feb 2021 16:49:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 18D671E0F3B; Wed, 17 Feb 2021 17:49:28 +0100 (CET)
Date:   Wed, 17 Feb 2021 17:49:28 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/7] fsnotify: support hashed notification queue
Message-ID: <20210217164928.GG14758@quack2.suse.cz>
References: <20210202162010.305971-1-amir73il@gmail.com>
 <20210202162010.305971-3-amir73il@gmail.com>
 <20210216150247.GB21108@quack2.suse.cz>
 <CAOQ4uxhLQBPd3aeVOj0E3HpKiYoqpfzPv9wZ8H8ncWTG4FOrtA@mail.gmail.com>
 <20210217134837.GD14758@quack2.suse.cz>
 <CAOQ4uxjWXJpLBFQU8Z1WsaWxYTFB6_3HwAnUv5A5nKkTRtrXzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjWXJpLBFQU8Z1WsaWxYTFB6_3HwAnUv5A5nKkTRtrXzA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 17-02-21 17:42:34, Amir Goldstein wrote:
> On Wed, Feb 17, 2021 at 3:48 PM Jan Kara <jack@suse.cz> wrote:
> > > > > +static inline size_t fsnotify_group_size(unsigned int q_hash_bits)
> > > > > +{
> > > > > +     return sizeof(struct fsnotify_group) + (sizeof(struct list_head) << q_hash_bits);
> > > > > +}
> > > > > +
> > > > > +static inline unsigned int fsnotify_event_bucket(struct fsnotify_group *group,
> > > > > +                                              struct fsnotify_event *event)
> > > > > +{
> > > > > +     /* High bits are better for hash */
> > > > > +     return (event->key >> (32 - group->q_hash_bits)) & group->max_bucket;
> > > > > +}
> > > >
> > > > Why not use hash_32() here? IMHO better than just stripping bits...
> > >
> > > See hash_ptr(). There is a reason to use the highest bits.
> >
> > Well, but event->key is just a 32-bit number so I don't follow how high
> > bits used by hash_ptr() matter?
> 
> Of course, you are right.
> But that 32-bit number was already generated using a xor of several
> hash_32() results from hash_ptr() and full_name_hash(), so we do not really
> need to mix it anymore to get better entropy in the higher 7 bits.

True. Just masking it with q_hash_bits is fine as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

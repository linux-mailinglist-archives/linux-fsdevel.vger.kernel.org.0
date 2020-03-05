Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7AA617A930
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 16:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgCEPtL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Mar 2020 10:49:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:49572 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgCEPtK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:49:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3E8ACAF98;
        Thu,  5 Mar 2020 15:49:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 752B61E0FC2; Thu,  5 Mar 2020 16:49:08 +0100 (CET)
Date:   Thu, 5 Mar 2020 16:49:08 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 11/16] fanotify: prepare to encode both parent and
 child fid's
Message-ID: <20200305154908.GK21048@quack2.suse.cz>
References: <20200226102354.GE10728@quack2.suse.cz>
 <CAOQ4uxivfnmvXag8+f5wJujqRgp9FW+2_CVD6MSgB40_yb+sHw@mail.gmail.com>
 <20200226170705.GU10728@quack2.suse.cz>
 <CAOQ4uxgW9Jcj_hG639nw=j0rFQ1fGxBHJJz=nHKTPBat=L+mXg@mail.gmail.com>
 <CAOQ4uxih7zhAj6qUp39B_a_On5gv80SKm-VsC4D8ayCrC6oSRw@mail.gmail.com>
 <20200227112755.GZ10728@quack2.suse.cz>
 <CAOQ4uxgavT6e97dYEOLV9BUOXQzMw2ADjMoZHTT0euERoZFoJg@mail.gmail.com>
 <20200227133016.GD10728@quack2.suse.cz>
 <CAOQ4uxghKxf4Gfw9GX1QZ_ju3RhZcOLxtYnhAn9A3MJtt3PMCQ@mail.gmail.com>
 <CAOQ4uxiHA5fM9SjA+XXcGQOg2u4UPvs_-nm+sKXcNXoGKxVgTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiHA5fM9SjA+XXcGQOg2u4UPvs_-nm+sKXcNXoGKxVgTg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir!

On Sun 01-03-20 18:26:25, Amir Goldstein wrote:
> > > I'd rather do the fanotity_fh padding optimization I outlined in another
> > > email. That would save one long without any packing and the following u8
> > > name_len would get packed tightly after the fanotify_fh by the compiler.
> > >
> >
> > OK. I will try that and the non-inherited variant of perm/name event struct
> > and see how it looks like.
> >
> 
> Pushed sample code to branch fanotify_name-wip:
> 
> b5e56d3e1358 fanotify: fanotify_perm_event inherits from fanotify_path_event
> 55041285b3b7 fanotify: divorce fanotify_path_event and fanotify_fid_event

Thanks for the work!

> I opted for fanotify_name_event inherits from fanotify_fid_event,
> because it felt better this way.

I've commented on github in the patches - I'm not sure the inheritance
really brings a significant benefit and it costs 6 bytes per name event.
Maybe there can be more simplifications gained from the inheritance (but I
think the move of fsid out of fanotify_fid mostly precludes that) but at
this point it doesn't seem to be worth it to me.

> I wasn't sure about fanotify_perm_event inherits from fanotify_path_event,
> so did that is a separate patch so you can judge both variants.
> IMO, neither variant is that good or bad, so I could go with either.

Yeah, I don't think the inheritance is really worth the churn.

> I do like the end result with your suggestions better than fanotify_name-v2.
> If you like this version, I will work the changes into the series.

Yes, overall the code look better! Thanks!

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2C0019DC25
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 18:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404456AbgDCQw2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 12:52:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:41364 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728420AbgDCQw2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:52:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C4AFCAA7C;
        Fri,  3 Apr 2020 16:52:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 816351E1235; Fri,  3 Apr 2020 18:52:25 +0200 (CEST)
Date:   Fri, 3 Apr 2020 18:52:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        boqun.feng@gmail.com, Amir Goldstein <amir73il@gmail.com>,
        "open list:FSNOTIFY: FILESYSTEM NOTIFICATION INFRASTRUCTURE" 
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/7] fsnotify: Add missing annotation for
 fsnotify_finish_user_wait()
Message-ID: <20200403165225.GC29920@quack2.suse.cz>
References: <0/7>
 <20200331204643.11262-1-jbi.octave@gmail.com>
 <20200331204643.11262-3-jbi.octave@gmail.com>
 <20200401092433.GA19466@quack2.suse.cz>
 <alpine.LFD.2.21.2004031710120.10601@earth.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.2004031710120.10601@earth.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 03-04-20 17:15:44, Jules Irenge wrote:
> 
> 
> On Wed, 1 Apr 2020, Jan Kara wrote:
> 
> > On Tue 31-03-20 21:46:38, Jules Irenge wrote:
> > > Sparse reports a warning at fsnotify_finish_user_wait()
> > > 
> > > warning: context imbalance in fsnotify_finish_user_wait()
> > > 	- wrong count at exit
> > > 
> > > The root cause is the missing annotation at fsnotify_finish_user_wait()
> > > Add the missing __acquires(&fsnotify_mark_srcu) annotation.
> > > 
> > > Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> > 
> > OK, but then fsnotify_prepare_user_wait() needs __releases annotation as
> > well if we're going to be serious about sparse warnings in this code?
> > 
> > 								Honza
> > 
> > > ---
> > >  fs/notify/mark.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> > > index 1d96216dffd1..44fea637bb02 100644
> > > --- a/fs/notify/mark.c
> > > +++ b/fs/notify/mark.c
> > > @@ -350,6 +350,7 @@ bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info)
> > >  }
> > > 
> > >  void fsnotify_finish_user_wait(struct fsnotify_iter_info *iter_info)
> > > +	__acquires(&fsnotify_mark_srcu)
> > >  {
> > >  	int type;
> > > 
> > > --
> > > 2.24.1
> > > 
> > -- 
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
> > 
> 
> Thanks for the reply. I think adding an annotation at
> fsnotify_prepare_user_wait() will not theoretically remove the warning.
> That's the only reason why I skipped it .

Well, I think the goal isn't really to remove warnings but to make
annotations correct... So even if sparse was not clever enough to spot that
missing annotation, you should add it if you've decided to fix sparse
annotations for fsnotify code.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

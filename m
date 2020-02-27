Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3265C1718B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 14:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgB0NaS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 08:30:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:57982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729110AbgB0NaS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:30:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CFE3EB061;
        Thu, 27 Feb 2020 13:30:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 89D241E0E88; Thu, 27 Feb 2020 14:30:16 +0100 (CET)
Date:   Thu, 27 Feb 2020 14:30:16 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 11/16] fanotify: prepare to encode both parent and
 child fid's
Message-ID: <20200227133016.GD10728@quack2.suse.cz>
References: <20200217131455.31107-1-amir73il@gmail.com>
 <20200217131455.31107-12-amir73il@gmail.com>
 <20200226102354.GE10728@quack2.suse.cz>
 <CAOQ4uxivfnmvXag8+f5wJujqRgp9FW+2_CVD6MSgB40_yb+sHw@mail.gmail.com>
 <20200226170705.GU10728@quack2.suse.cz>
 <CAOQ4uxgW9Jcj_hG639nw=j0rFQ1fGxBHJJz=nHKTPBat=L+mXg@mail.gmail.com>
 <CAOQ4uxih7zhAj6qUp39B_a_On5gv80SKm-VsC4D8ayCrC6oSRw@mail.gmail.com>
 <20200227112755.GZ10728@quack2.suse.cz>
 <CAOQ4uxgavT6e97dYEOLV9BUOXQzMw2ADjMoZHTT0euERoZFoJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgavT6e97dYEOLV9BUOXQzMw2ADjMoZHTT0euERoZFoJg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 27-02-20 14:12:30, Amir Goldstein wrote:
> >
> > > struct fanotify_fh_name {
> > >          union {
> > >                 struct {
> > >                        u8 fh_type;
> > >                        u8 fh_len;
> > >                        u8 name_len;
> > >                        u32 hash;
> > >                 };
> > >                 u64 hash_len;
> > >         };
> > >         union {
> > >                 unsigned char fh[FANOTIFY_INLINE_FH_LEN];
> > >                 unsigned char *ext_fh;
> > >         };
> > >         char name[0];
> > > };
> >
> > So based on the above I wouldn't add just name hash to fanotify_fh_name at
> > this point...
> >
> 
> OK. but what do you think about tying name with fh as above?
> At least name_len gets to use the hole this way.

Is saving that one byte for name_len really worth the packing? If anything,
I'd rather do the fanotity_fh padding optimization I outlined in another
email. That would save one long without any packing and the following u8
name_len would get packed tightly after the fanotify_fh by the compiler.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

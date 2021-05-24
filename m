Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7CD38DFFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 May 2021 05:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhEXD5e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 May 2021 23:57:34 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:53212 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232120AbhEXD5e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 May 2021 23:57:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UZr-VFk_1621828564;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0UZr-VFk_1621828564)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 24 May 2021 11:56:04 +0800
Date:   Mon, 24 May 2021 11:56:04 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kmo@daterainc.com>
Subject: Re: [PATCH 1/3] Initial bcachefs support
Message-ID: <20210524035604.GD60846@e18g06458.et15sqa>
References: <20210427164419.3729180-1-kent.overstreet@gmail.com>
 <20210427164419.3729180-2-kent.overstreet@gmail.com>
 <YJfzVSGu2BbE4oMY@desktop>
 <YKrchSzj8Zo4CnDs@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKrchSzj8Zo4CnDs@moria.home.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 23, 2021 at 06:51:49PM -0400, Kent Overstreet wrote:
[snip]

> > >  	;;
> > > @@ -1179,6 +1197,19 @@ _repair_scratch_fs()
> > >  	fi
> > >  	return $res
> > >          ;;
> > > +    bcachefs)
> > > +	fsck -t $FSTYP -n $SCRATCH_DEV 2>&1
> > 
> > _repair_scratch_fs() is supposed to actually fix the errors, does
> > "fsck -n" fix errors for bcachefs?
> 
> No - but with bcachefs fsck finding errors _always_ indicates a bug, so for the
> purposes of these tests I think this is the right thing to do - I don't want the
> tests to pass if fsck is finding and fixing errors.

Then _check_scratch_fs() should be used instead, which will fail the
test if any fsck finds any corruptions. _repair_scratch_fs() is meant to
fix errors, and only report failure when there's unfixable errors.

Thanks,
Eryu

> 
> > > diff --git a/tests/generic/042 b/tests/generic/042
> > > index 35727bcbc6..42919e2313 100755
> > > --- a/tests/generic/042
> > > +++ b/tests/generic/042
> > > @@ -63,7 +63,8 @@ _crashtest()
> > >  
> > >  	# We should /never/ see 0xCD in the file, because we wrote that pattern
> > >  	# to the filesystem image to expose stale data.
> > > -	if hexdump -v -e '/1 "%02X "' $file | grep -q "CD"; then
> > > +	# The file is not required to exist since we didn't sync before going down:
> > > +	if [[ -f $file ]] && hexdump -v -e '/1 "%02X "' $file | grep -q "CD"; then
> > >  		echo "Saw stale data!!!"
> > >  		hexdump $file
> > >  	fi
> > 
> > Updates for individual test should be in a separate patch.
> 
> Ok, I'll split those out.

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47D44E8A25
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Mar 2022 23:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbiC0VFK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Mar 2022 17:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiC0VFH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Mar 2022 17:05:07 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A94D496BA;
        Sun, 27 Mar 2022 14:03:27 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-150-27.pa.vic.optusnet.com.au [49.186.150.27])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id B445B10E6855;
        Mon, 28 Mar 2022 08:03:20 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nYa2h-00AeCQ-BD; Mon, 28 Mar 2022 08:03:19 +1100
Date:   Mon, 28 Mar 2022 08:03:19 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "raven@themaw.net" <raven@themaw.net>,
        "kzak@redhat.com" <kzak@redhat.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "mszeredi@redhat.com" <mszeredi@redhat.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "christian@brauner.io" <christian@brauner.io>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>
Subject: Re: [RFC PATCH] getvalues(2) prototype
Message-ID: <20220327210319.GM1609613@dread.disaster.area>
References: <20220322192712.709170-1-mszeredi@redhat.com>
 <20220323225843.GI1609613@dread.disaster.area>
 <CAJfpegv6PmZ_RXipBs9UEjv_WfEUtTDE1uNZq+9fBkCzWPvXkw@mail.gmail.com>
 <20220324203116.GJ1609613@dread.disaster.area>
 <5d5c170949a5c4e2e4b8ef8949e5cdc5110eeabf.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d5c170949a5c4e2e4b8ef8949e5cdc5110eeabf.camel@hammerspace.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=6240d11d
        a=sPqof0Mm7fxWrhYUF33ZaQ==:117 a=sPqof0Mm7fxWrhYUF33ZaQ==:17
        a=8nJEP1OIZ-IA:10 a=o8Y5sQTvuykA:10 a=7-415B0cAAAA:8
        a=SMe7BH-ruLLs_FX_YN0A:9 a=wPNLvfGTeEIA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 25, 2022 at 04:42:27PM +0000, Trond Myklebust wrote:
> On Fri, 2022-03-25 at 07:31 +1100, Dave Chinner wrote:
> > > and anyway the point of a
> > > hierarchical namespace is to be able to list nodes on each level. 
> > > We
> > > can use getxattr() for this purpose, just like getvalues() does in
> > > the
> > > above example.
> > 
> > Yup, and like Casey suggests, you could implement a generic
> > getvalues()-like user library on top of it so users don't even need
> > to know where and how the values are located or retrieved.
> > 
> > The other advantage of an xattr interface is that is also provides a
> > symmetrical API for -changing- values. No need for some special
> > configfs or configfd thingy for setting parameters - just change the
> > value of the parameter or mount option with a simple setxattr call.
> > That retains the simplicity of proc and sysfs attributes in that you
> > can change them just by writing a new value to the file....
> 
> The downsides are, however, that the current interface provides little
> in the way of atomicity if you want to read or write to multiple
> attributes at the same time. Something like a backup program might want
> to be able to atomically retrieve the ctime when it is backing up the
> attributes.

I assumed that batched updates were implied and understood after
my earlier comments about XFS_IOC_ATTRMULTI_BY_HANDLE as used
by xfsdump/restore for the past 20+ years.

> Also, when setting attributes, I'd like to avoid multiple syscalls when
> I'm changing multiple related attributes.
>
> IOW: Adding a batching interface that is akin to what Miklos was
> proposing would be a helpful change if we want to go down this path.

Yup, that's exactly what XFS_IOC_ATTRMULTI_BY_HANDLE provides and
I'm assuming that would also be provided by whatever formalised
generic syscall API we come up with here...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

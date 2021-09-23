Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8774167FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 00:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243437AbhIWW1z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 18:27:55 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:54569 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234844AbhIWW1z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 18:27:55 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 00167883316;
        Fri, 24 Sep 2021 08:26:20 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mTXAY-00FxAF-Kr; Fri, 24 Sep 2021 08:26:18 +1000
Date:   Fri, 24 Sep 2021 08:26:18 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>, stefanha@redhat.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, bo.liu@linux.alibaba.com,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v5 2/5] fuse: make DAX mount option a tri-state
Message-ID: <20210923222618.GB2361455@dread.disaster.area>
References: <20210923092526.72341-1-jefflexu@linux.alibaba.com>
 <20210923092526.72341-3-jefflexu@linux.alibaba.com>
 <YUzPUYU8R5LL4mzU@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUzPUYU8R5LL4mzU@redhat.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=7-415B0cAAAA:8
        a=F2Qf-auwut6mfQwlICEA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 03:02:41PM -0400, Vivek Goyal wrote:
> On Thu, Sep 23, 2021 at 05:25:23PM +0800, Jeffle Xu wrote:
> > We add 'always', 'never', and 'inode' (default). '-o dax' continues to
> > operate the same which is equivalent to 'always'. To be consistemt with
> > ext4/xfs's tri-state mount option, when neither '-o dax' nor '-o dax='
> > option is specified, the default behaviour is equal to 'inode'.
> 
> So will "-o dax=inode" be used for per file DAX where dax mode comes
> from server?
> 
> I think we discussed this. It will be better to leave "-o dax=inode"
> alone. It should be used when we are reading dax status from file
> attr (like ext4 and xfs). 
> 
> And probably create separate option say "-o dax=server" where server
> specifies which inode should use dax.

That seems like a poor idea to me.

The server side already controls what the client side does by
controlling the inode attributes that the client side sees.  That
is, if the server is going to specify whether the client side data
access is going to use dax, then the server presents the client with
an inode that has the DAX attribute flag set on it.

In that case, turning off dax on the guest side should be
communicated to the fuse server so the server turns off the DAX flag
on the server side iff server side policy allows it.  When the guest
then purges it's local inode and reloads it from the server then it
will get an inode with the DAX flag set according to server side
policy.

Hence if the server side is configured with "dax=always" or
dax="never" semantics it means the client side inode flag state
cannot control DAX mode. That means, regardless of the client side
mount options, DAX is operating under always or never policy,
enforced by the server side by direct control of the client inode
DAX attribute flag. If dax=inode is in use on both sides, the the
server honours the requests of the client to set/clear the inode
flags and presents the inode flag according to the state the client
side has requested.

This policy state probably should be communicated to
the fuse client from the server at mount time so policy conflicts
can be be resolved at mount time (e.g. reject mount if policy
conflict occurs, default to guest overrides server or vice versa,
etc). This then means that that the client side mount policies will
default to server side policy when they set "dax=inode" but also
provide a local override for always or never local behaviour.

Hence, AFAICT, there is no need for a 'dax=server' option - this
seems to be exactly what 'dax=inode' behaviour means on the client
side - it behaves according to how the server side propagates the
DAX attribute to the client for each inode.

> Otherwise it will be very confusing. People familiar with "-o dax=inode"
> on ext4/xfs will expect file attr to work and that's not what we
> are implementing, IIUC.

The dax mount option behaviour is already confusing enough without
adding yet another weird, poorly documented, easily misunderstood
mode that behaves subtly different to existing modes.

Please try to make the virtiofs behaviour compatible with existing
modes - it's not that hard to make the client dax=inode behaviour be
controlled by the server side without any special client side mount
modes.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

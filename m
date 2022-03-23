Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6300C4E517F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 12:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243956AbiCWLoW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 07:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbiCWLoV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 07:44:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD9879385;
        Wed, 23 Mar 2022 04:42:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F00DCB81E85;
        Wed, 23 Mar 2022 11:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0E1C340E8;
        Wed, 23 Mar 2022 11:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648035769;
        bh=AX3abbornC9FM40TMDR9pJEAVnDGmX3E+mfdfSSC5xI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Apt6NVYWGYqoV9pWyMXsDMiJOfEiyhunqbrscSTMrQR+PW+kTafTW02Cm/97eg84W
         75nUv0lOOwEHQMrgiEd0+NcdbvjqP4rVYfiK+u/hU1AH9NgjLzZ0tO/mAuzzV/vuFS
         SeicNiFy08qDfL13M1ouV92Ks/on9bSEE/K9AkN0=
Date:   Wed, 23 Mar 2022 12:42:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Dharmendra Singh <dsingh@ddn.com>
Subject: Re: [RFC PATCH] getvalues(2) prototype
Message-ID: <YjsHtg7uzRGUlsb3@kroah.com>
References: <20220322192712.709170-1-mszeredi@redhat.com>
 <YjrJWf+XMnWVd6K0@kroah.com>
 <d0e2573a-7736-bb3e-9f6a-5fa25e6d31a2@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0e2573a-7736-bb3e-9f6a-5fa25e6d31a2@ddn.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 23, 2022 at 11:26:11AM +0100, Bernd Schubert wrote:
> On 3/23/22 08:16, Greg KH wrote:
> > On Tue, Mar 22, 2022 at 08:27:12PM +0100, Miklos Szeredi wrote:
> > > Add a new userspace API that allows getting multiple short values in a
> > > single syscall.
> > > 
> > > This would be useful for the following reasons:
> > > 
> > > - Calling open/read/close for many small files is inefficient.  E.g. on my
> > >    desktop invoking lsof(1) results in ~60k open + read + close calls under
> > >    /proc and 90% of those are 128 bytes or less.
> > 
> > As I found out in testing readfile():
> > 	https://lore.kernel.org/r/20200704140250.423345-1-gregkh@linuxfoundation.org
> > 
> > microbenchmarks do show a tiny improvement in doing something like this,
> > but that's not a real-world application.
> > 
> > Do you have anything real that can use this that shows a speedup?
> 
> Add in network file systems. Demonstrating that this is useful locally and
> with micro benchmarks - yeah, helps a bit to make it locally faster. But the
> real case is when thousands of clients are handled by a few network servers.
> Even reducing wire latency for a single client would make a difference here.

I think I tried running readfile on NFS.  Didn't see any improvements.
But please, try it again.  Also note that this proposal isn't for NFS,
or any other "real" filesystem :)

> There is a bit of chicken-egg problem - it is a bit of work to add to file
> systems like NFS (or others that are not the kernel), but the work won't be
> made there before there is no syscall for it. To demonstrate it on NFS one
> also needs a an official protocol change first. And then applications also
> need to support that new syscall first.
> I had a hard time explaining weather physicist back in 2009 that it is not a
> good idea to have millions of 512B files on  Lustre. With recent AI workload
> this gets even worse.

Can you try using the readfile() patch to see if that helps you all out
on Lustre?  If so, that's a good reason to consider it.  But again, has
nothing to do with this getvalues(2) api.

thanks,

greg k-h

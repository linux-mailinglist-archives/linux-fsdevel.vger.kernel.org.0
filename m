Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8784E5EFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Mar 2022 07:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348249AbiCXG6I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Mar 2022 02:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiCXG6H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Mar 2022 02:58:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD74797284;
        Wed, 23 Mar 2022 23:56:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68C91B81DDE;
        Thu, 24 Mar 2022 06:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57068C340F0;
        Thu, 24 Mar 2022 06:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648104993;
        bh=t7ZJC+nb03OJhruyjJMshPqBsDPc27EJQOvu6/pKRwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p+2mxlDm/Y1xr/p0OUWJrcZ66gIMW04Vgb7md5J0s7MAJoIPQB+VZsH+halolMzp/
         hnhPaJffyBkZusGuTOcc0JXhpOCDyIJaQlwNDwN7Vl5iTULbpmBqY0GMwdb4iZKEXA
         fNXyI8STxgYWAMryldGFDv9mv/5p8eJasA19T3IM=
Date:   Thu, 24 Mar 2022 07:56:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [RFC PATCH] getvalues(2) prototype
Message-ID: <YjwWHk9YYGrb6i07@kroah.com>
References: <20220322192712.709170-1-mszeredi@redhat.com>
 <20220323114215.pfrxy2b6vsvqig6a@wittgenstein>
 <CAJfpegsCKEx41KA1S2QJ9gX9BEBG4_d8igA0DT66GFH2ZanspA@mail.gmail.com>
 <Yjsiv2XesJRzoeTW@kroah.com>
 <CAJfpegsBmed6dchjgVeQ-OPGYBiU+2GPgsoJegjuPTrcLs6-8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsBmed6dchjgVeQ-OPGYBiU+2GPgsoJegjuPTrcLs6-8g@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 23, 2022 at 04:23:34PM +0100, Miklos Szeredi wrote:
> On Wed, 23 Mar 2022 at 14:38, Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > This has been proposed in the past a few times.  Most recently by the
> > KVM developers, which tried to create a "generic" api, but ended up just
> > making something to work for KVM as they got tired of people ignoring
> > their more intrusive patch sets.  See virt/kvm/binary_stats.c for what
> > they ended up with, and perhaps you can just use that same type of
> > interface here as well?
> 
> So this looks like a fixed set of statistics where each one has a
> descriptor (a name, size, offset, flags, ...) that tells about the
> piece of data to be exported.  The stats are kept up to date in kernel
> memory and copied to userspace on read.  The copy can be selective,
> since the read can specify the offset and size of data it would like
> to retrieve.
> 
> The interface is self descriptive and selective, but its structure is
> fixed for a specific object type, there's no way this could be
> extended to look up things like extended attributes.  Maybe that's not
> a problem, but the lack of a hierarchical namespace could turn out to
> be a major drawback.
> 
> I think people underestimate the usefulness of hierarchical
> namespaces, even though we use them extensively in lots of well
> established interfaces.

I like the namespaces, they work well.  If you want self-describing
interfaces (which I think your patch does), then why not just use the
varlink protocol?  It's been implemented for the kernel already many
years ago:
	https://github.com/varlink
and specifically:
	https://github.com/varlink/linux-varlink

It doesn't need a new syscall.

thanks,

greg k-h

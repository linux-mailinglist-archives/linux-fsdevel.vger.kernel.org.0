Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30400518A8C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 18:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239929AbiECQ6J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 12:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239915AbiECQ6H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 12:58:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2053A735;
        Tue,  3 May 2022 09:54:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04738B81F77;
        Tue,  3 May 2022 16:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7148AC385A4;
        Tue,  3 May 2022 16:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651596871;
        bh=ytgntH0O/XbW8+1fR6Md9tL+ex4msLbEc4nV5PiKs1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oSd/lUGqJGSI3Aru/ScbE5nSf8QCpZOfA+/k9fDh+sazrcp49byG0adp8zTqWNHZM
         nWXVQgz7KK7l9iJvVMYB6Jmi91ePINmm7iDqLV4ImcFNGDGo6qyLCI3qu4fUE+fPI5
         zoeHKmX1CgE9y4LY5N2yzU88o0wPCdxcPymmulSA=
Date:   Tue, 3 May 2022 18:54:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>, Karel Zak <kzak@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [RFC PATCH] getting misc stats/attributes via xattr API
Message-ID: <YnFeRe02RqclvZ87@kroah.com>
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com>
 <CAOQ4uxim+JmFbXPQcasELDEgRDP-spdPtJrLuhvSiyxErSUkvw@mail.gmail.com>
 <YnFB/ct2Q/yYBnm8@kroah.com>
 <CAJfpegtZjRca5QPm2QgPtPG0-BJ=15Vtd48OTnRnr5G7ggAtmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtZjRca5QPm2QgPtPG0-BJ=15Vtd48OTnRnr5G7ggAtmA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 03, 2022 at 05:04:06PM +0200, Miklos Szeredi wrote:
> On Tue, 3 May 2022 at 16:53, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, May 03, 2022 at 05:39:46PM +0300, Amir Goldstein wrote:
> 
> > > It should be noted that while this API mandates text keys,
> > > it does not mandate text values, so for example, sb iostats could be
> > > exported as text or as binary struct, or as individual text/binary records or
> > > all of the above.
> >
> > Ugh, no, that would be a total mess.  Don't go exporting random binary
> > structs depending on the file, that's going to be completely
> > unmaintainable.  As it is, this is going to be hard enough with random
> > text fields.
> >
> > As for this format, it needs to be required to be documented in
> > Documentation/ABI/ for each entry and key type so that we have a chance
> > of knowing what is going on and tracking how things are working and
> > validating stuff.
> 
> My preference would be a single text value for each key.

Yes!  That's the only sane way to maintain apis, and is why we do that
for sysfs.

If the key isn't present, there's no value, so userspace "knows" this
automatically and parsing this is trivial.

> Contents of ":mnt:info" contradicts that, but mountinfo has a long
> established, well documented format, and nothing prevents exporting
> individual attributes with separate names as well (the getvalues(2)
> patch did exactly that).

I understand, for "legacy" things like this, that's fine, but don't add
new fields or change them over time please, that way just gets us back
to the nightmare of preserving /proc/ file apis.

thanks,

greg k-h

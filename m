Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED824E4D1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 08:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbiCWHPl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 03:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiCWHPj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:15:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFC76E8C6;
        Wed, 23 Mar 2022 00:14:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3F5461614;
        Wed, 23 Mar 2022 07:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C96AC340E8;
        Wed, 23 Mar 2022 07:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648019649;
        bh=hmXlP/3KkYC9olmjEpmQ0hcW/3wqRHuMgj5g8NhFibk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QLEWpsMnuvyQEqlQjQNNG92zDvh4BjRB7deVjeEnFYaRt3cqwUxEu/ekQT1nNzSgT
         DTqt9566RSHNzKs+nZd43aDmjj6KWy00QRVM7B3j+XLgdh44BzzlpWB11QBH/ltgWa
         t0MEJg07DGYGWogi2mK1ptQ1gAft/XwvlNuM5Q94=
Date:   Wed, 23 Mar 2022 08:14:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
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
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [RFC PATCH] getvalues(2) prototype
Message-ID: <YjrIvRCg2iUeMN2V@kroah.com>
References: <20220322192712.709170-1-mszeredi@redhat.com>
 <f80f372b-4249-eb25-ed95-9f8615877745@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f80f372b-4249-eb25-ed95-9f8615877745@schaufler-ca.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 22, 2022 at 01:36:26PM -0700, Casey Schaufler wrote:
> On 3/22/2022 12:27 PM, Miklos Szeredi wrote:
> > Add a new userspace API that allows getting multiple short values in a
> > single syscall.
> > 
> > This would be useful for the following reasons:
> > 
> > - Calling open/read/close for many small files is inefficient.  E.g. on my
> >    desktop invoking lsof(1) results in ~60k open + read + close calls under
> >    /proc and 90% of those are 128 bytes or less.
> 
> You don't need the generality below to address this issue.
> 
> int openandread(const char *path, char *buffer, size_t size);
> 
> would address this case swimmingly.

Or you can use my readfile(2) proposal:
	https://lore.kernel.org/r/20200704140250.423345-1-gregkh@linuxfoundation.org

But you had better actually benchmark the thing.  Turns out that I could
not find a real-world use that shows improvements in anything.

Miklos, what userspace tool will use this new syscall and how will it be
faster than readfile() was?

I should rebase that against 5.17 again and see if anything is different
due to the new spectre-bhb slowdowns.

thanks,

greg k-h

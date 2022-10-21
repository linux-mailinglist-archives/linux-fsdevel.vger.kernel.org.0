Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07C8606CAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 02:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJUAwq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 20:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJUAwp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 20:52:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5A2230811;
        Thu, 20 Oct 2022 17:52:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0253B82924;
        Fri, 21 Oct 2022 00:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3C2C433C1;
        Fri, 21 Oct 2022 00:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666313542;
        bh=xhtO9l6Zw6uXqsnXZIrGAwFLvsejDmkqFMkVXTirtro=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0CnEMEb8oHjmtcyWq34BSjGROAcPwNGzX7CSJDL29WrtVj9dIiIgPwaZbAOTmcS2S
         8wTrDSwoskmNhW9iiV+IAF/IGaJXCrPimThzeyaD7cB0VrLDY5C4urs6W0sQ0oIhXh
         LzivxOCGuKD6302gGnWo4rc8BN09l1tBVZYrABNE=
Date:   Thu, 20 Oct 2022 17:52:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Ivan Babrou <ivan@cloudflare.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>,
        David Laight <David.Laight@aculab.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Mike Rapoport <rppt@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH v3] proc: report open files as size in stat() for
 /proc/pid/fd
Message-Id: <20221020175221.534de6ad08512d9d8a590760@linux-foundation.org>
In-Reply-To: <Y0/fbSL0QDlTU6Yv@bfoster>
References: <20221018045844.37697-1-ivan@cloudflare.com>
        <Y07taqdJ/J3EyJoB@bfoster>
        <CABWYdi37Ts7KDshSvwMf34EKuUrz25duL7W8hOO8t1Xm53t2rA@mail.gmail.com>
        <Y0/fbSL0QDlTU6Yv@bfoster>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 19 Oct 2022 07:28:45 -0400 Brian Foster <bfoster@redhat.com> wrote:

> On Tue, Oct 18, 2022 at 11:51:02AM -0700, Ivan Babrou wrote:
> > On Tue, Oct 18, 2022 at 11:16 AM Brian Foster <bfoster@redhat.com> wrote:
> > > > +static int proc_readfd_count(struct inode *inode)
> > > > +{
> > > > +     struct task_struct *p = get_proc_task(inode);
> > > > +     struct fdtable *fdt;
> > > > +     unsigned int open_fds = 0;
> > > > +
> > > > +     if (!p)
> > > > +             return -ENOENT;
> > >
> > > Maybe this shouldn't happen, but do you mean to assign the error code to
> > > stat->size in the caller? Otherwise this seems reasonable to me.
> > 
> > You are right. As unlikely as it is to happen, we shouldn't return
> > negative size.
> > 
> > What's the idiomatic way to make this work? My two options are:
> > 
> > 1. Pass &stat->size into proc_readfd_count:
> > 
> >   if (S_ISDIR(inode->i_mode)) {
> >     rv = proc_readfd_count(inode, &stat->size);
> >     if (rv < 0)
> >       goto out;
> >   }
> > 
> > out:
> >   return rv;
> > 
> > OR without a goto:
> > 
> >   if (S_ISDIR(inode->i_mode)) {
> >     rv = proc_readfd_count(inode, &stat->size));
> >     if (rv < 0)
> >       return rv;
> >   }
> > 
> >   return rv;
> > 
> > 2. Return negative count as error (as we don't expect negative amount
> > of files open):
> > 
> >   if (S_ISDIR(inode->i_mode)) {
> >     size = proc_readfd_count(inode);
> >     if (size < 0)
> >       return size;
> >     stat->size = size;
> >   }
> > 
> 
> I suppose the latter is less of a change to the original patch..? Either
> way seems reasonable to me. I have no strong preference FWIW.

If get_proc_task() failed then something has gone horridly wrong,
hasn't it?  Wouldn't it make sense in this situation to make the
.getattr() itself return an errno, in which case the data at *stat
dosen't matter - it's invalid anyway.

This seems to be the general approach in procfs when get_proc_task()
fails - return -ESRCH (or, seemingly randomly, -ENOENT) to the caller.


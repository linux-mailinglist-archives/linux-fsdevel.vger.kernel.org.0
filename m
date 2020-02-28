Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09493172FBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 05:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbgB1EWT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 23:22:19 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:53448 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730815AbgB1EWT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 23:22:19 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7XA8-002DXv-ND; Fri, 28 Feb 2020 04:22:08 +0000
Date:   Fri, 28 Feb 2020 04:22:08 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ian Kent <raven@themaw.net>, Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH 00/11] fs/dcache: Limit # of negative dentries
Message-ID: <20200228042208.GI23230@ZenIV.linux.org.uk>
References: <20200226161404.14136-1-longman@redhat.com>
 <20200226162954.GC24185@bombadil.infradead.org>
 <2EDB6FFC-C649-4C80-999B-945678F5CE87@dilger.ca>
 <9d7b76c32d09492137a253e692624856388693db.camel@themaw.net>
 <20200228033412.GD29971@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228033412.GD29971@bombadil.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 27, 2020 at 07:34:12PM -0800, Matthew Wilcox wrote:
> On Thu, Feb 27, 2020 at 05:55:43PM +0800, Ian Kent wrote:
> > Not all file systems even produce negative hashed dentries.
> > 
> > The most beneficial use of them is to improve performance of rapid
> > fire lookups for non-existent names. Longer lived negative hashed
> > dentries don't give much benefit at all unless they suddenly have
> > lots of hits and that would cost a single allocation on the first
> > lookup if the dentry ttl expired and the dentry discarded.
> > 
> > A ttl (say jiffies) set at appropriate times could be a better
> > choice all round, no sysctl values at all.
> 
> The canonical argument in favour of negative dentries is to improve
> application startup time as every application searches the library path
> for the same libraries.  Only they don't do that any more:

	Tell that to scripts that keep looking through $PATH for
binaries each time they are run.  Tell that to cc(1) looking through
include path, etc.

	Ian, autofs is deeply pathological in that respect; that's OK,
since it has very unusual needs, but please don't use it as a model
for anything else - its needs *are* unusual.

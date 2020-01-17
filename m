Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99E76140F77
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 17:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgAQQ7M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 11:59:12 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:35478 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgAQQ7M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:59:12 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isUxc-00AMwe-6Y; Fri, 17 Jan 2020 16:59:04 +0000
Date:   Fri, 17 Jan 2020 16:59:04 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>, "hch@lst.de" <hch@lst.de>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
Message-ID: <20200117165904.GN8904@ZenIV.linux.org.uk>
References: <364531.1579265357@warthog.procyon.org.uk>
 <d2730b78cf0eac685c3719909df34d8d1b0bc347.camel@hammerspace.com>
 <20200117154657.GK8904@ZenIV.linux.org.uk>
 <20200117163616.GA282555@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117163616.GA282555@vader>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 17, 2020 at 08:36:16AM -0800, Omar Sandoval wrote:

> The semantics I implemented in my series were basically "linkat with
> AT_REPLACE replaces the target iff rename would replace the target".
> Therefore, symlinks are replaced, not followed, and mountpoints get
> EXDEV. In my opinion that's both sane and unsurprising.

Umm...  EXDEV in rename() comes when _parents_ are on different mounts.
rename() over a mountpoint is EBUSY if it has mounts in caller's
namespace, but it succeeds (and detaches all mounts on the victim
in any namespaces) otherwise.

When are you returning EXDEV?  Incidentally, mounts _are_ traversed on
the link source, so what should that variant do when /tmp/foo is
a mountpoint and you feed it "/tmp/foo" both for source and target?

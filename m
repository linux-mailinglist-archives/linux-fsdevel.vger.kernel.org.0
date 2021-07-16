Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E17C3CB071
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 03:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhGPBfw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 21:35:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57620 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229603AbhGPBfw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 21:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626399177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bPGhP6VKv5DekaUsHYhQlzArZpPv2c0XZLeRqI8dw5w=;
        b=IKhqNzl7L1s5v3GxTNSbRUpigRw/OznJTqqfyr3bgDtvMK6DewZATi7RuR6EoK3PMHT07I
        wqGFyrXP0CkhvOqJoNGmDIYV516ZV2LOQFc3Rd1HDXFXFCGnCr6uwKoCzjvUpC6wqlP9kV
        tviNpaXXXGjXGOjxfDh9sG5idpZqXqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467--tkivL6ANOmAgcGpdc6I0g-1; Thu, 15 Jul 2021 21:32:54 -0400
X-MC-Unique: -tkivL6ANOmAgcGpdc6I0g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A291818D6A25;
        Fri, 16 Jul 2021 01:32:52 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-72.rdu2.redhat.com [10.10.116.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BB8960BF1;
        Fri, 16 Jul 2021 01:32:48 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id D059122021C; Thu, 15 Jul 2021 21:32:47 -0400 (EDT)
Date:   Thu, 15 Jul 2021 21:32:47 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     Liu Bo <bo.liu@linux.alibaba.com>, stefanha@redhat.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [RFC PATCH 3/3] fuse: add per-file DAX flag
Message-ID: <YPDhv0JJHqbMCyXD@redhat.com>
References: <20210715093031.55667-1-jefflexu@linux.alibaba.com>
 <20210715093031.55667-4-jefflexu@linux.alibaba.com>
 <20210716004028.GA30967@rsjd01523.et2sqa>
 <YPDX9S3/TD3CL0CZ@redhat.com>
 <6d956097-47c1-5193-bbaa-faf14f0989ef@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d956097-47c1-5193-bbaa-faf14f0989ef@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 16, 2021 at 09:18:34AM +0800, JeffleXu wrote:
> 
> 
> On 7/16/21 8:51 AM, Vivek Goyal wrote:
> > On Fri, Jul 16, 2021 at 08:40:29AM +0800, Liu Bo wrote:
> >> On Thu, Jul 15, 2021 at 05:30:31PM +0800, Jeffle Xu wrote:
> >>> Add one flag for fuse_attr.flags indicating if DAX shall be enabled for
> >>> this file.
> >>>
> >>> When the per-file DAX flag changes for an *opened* file, the state of
> >>> the file won't be updated until this file is closed and reopened later.
> >>>
> >>> Currently it is not implemented yet to change per-file DAX flag inside
> >>> guest kernel, e.g., by chattr(1).
> >>
> >> Thanks for the patch, it looks good to me.
> >>
> >> I think it's a good starting point, what I'd like to discuss here is
> >> whether we're going to let chattr to toggle the dax flag.
> > 
> > I have the same question. Why not take chattr approach as taken
> > by ext4/xfs as well.
> > 
> > Vivek
> 
> Thanks.
> 
> We can implement the chattr approach as ext4/xfs do, if we have this use
> scenario. It's an RFC patch, and I want to collect more feedback as soon
> as possible.

I guess chattr approach will allow client (as well as server) to control
which files should be DAX. While this approach allows only server to
specify which files should use DAX. Given currently we let client
control whether to use dax or not (-o dax), it probably will make
sense to use chattr based approach?

I will look at the patches. Do you have a corresponding user space
implementation somewhere so that I can test it?

Vivek


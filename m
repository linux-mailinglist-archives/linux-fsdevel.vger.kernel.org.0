Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7DA5186BB2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Mar 2020 14:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbgCPNC4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Mar 2020 09:02:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56102 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730974AbgCPNCz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Mar 2020 09:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584363774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LLQsyKzFI2FWMsfb3WnnDbhofXGcpSrAYcxTSH7lcYc=;
        b=UZdHOmHtUvglgyKP51IdS9C12kT7WIu2m6D/+0+6Lzorux6sFW9wIzaLn+7wT1BAzVgDUj
        JWcJ2b4aa7k5lTXIfQgg84R+6tviWu9XnGLTw/cQHb/bDX2nNbKPTv1lO46KfkxtrMczce
        B2FAgq4x3rSPRcBvZpShB4RO7Vf8pmw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-qiNL0Hy_PamcS1YiC1ZLyw-1; Mon, 16 Mar 2020 09:02:44 -0400
X-MC-Unique: qiNL0Hy_PamcS1YiC1ZLyw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 722D81005516;
        Mon, 16 Mar 2020 13:02:43 +0000 (UTC)
Received: from horse.redhat.com (ovpn-121-211.rdu2.redhat.com [10.10.121.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC04C92D0C;
        Mon, 16 Mar 2020 13:02:34 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 1FFCA2234E4; Mon, 16 Mar 2020 09:02:34 -0400 (EDT)
Date:   Mon, 16 Mar 2020 09:02:34 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Patrick Ohly <patrick.ohly@intel.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 00/20] virtiofs: Add DAX support
Message-ID: <20200316130234.GA4013@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <yrjh1rpzggg4.fsf@pohly-mobl1.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yrjh1rpzggg4.fsf@pohly-mobl1.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 11, 2020 at 02:38:03PM +0100, Patrick Ohly wrote:
> Vivek Goyal <vgoyal@redhat.com> writes:
> > This patch series adds DAX support to virtiofs filesystem. This allows
> > bypassing guest page cache and allows mapping host page cache directly
> > in guest address space.
> >
> > When a page of file is needed, guest sends a request to map that page
> > (in host page cache) in qemu address space. Inside guest this is
> > a physical memory range controlled by virtiofs device. And guest
> > directly maps this physical address range using DAX and hence gets
> > access to file data on host.
> >
> > This can speed up things considerably in many situations. Also this
> > can result in substantial memory savings as file data does not have
> > to be copied in guest and it is directly accessed from host page
> > cache.
> 
> As a potential user of this, let me make sure I understand the expected
> outcome: is the goal to let virtiofs use DAX (for increased performance,
> etc.) or also let applications that use virtiofs use DAX?
> 
> You are mentioning using the host's page cache, so it's probably the
> former and MAP_SYNC on virtiofs will continue to be rejected, right?

Hi Patrick,

You are right. Its the former. That is we want virtiofs to be able to
make use of DAX to bypass guest page cache. But there is no persistent
memory so no persistent memory programming semantics available to user
space. For that I guess we have virtio-pmem.

We expect users will issue fsync/msync like a regular filesystem to
make changes persistent. So in that aspect, rejecting MAP_SYNC
makes sense. I will test and see if current code is rejecting MAP_SYNC
or not.

Thanks
Vivek


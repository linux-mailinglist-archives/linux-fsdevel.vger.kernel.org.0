Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0EA53A2722
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 10:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhFJIfz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 04:35:55 -0400
Received: from nautica.notk.org ([91.121.71.147]:42159 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229823AbhFJIfz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 04:35:55 -0400
X-Greylist: delayed 125520 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Jun 2021 04:35:54 EDT
Received: by nautica.notk.org (Postfix, from userid 108)
        id 0AEFBC020; Thu, 10 Jun 2021 10:33:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1623314038; bh=iZa1+1qRIau0JA4G4mFy2PSaXoZ0Z9gDo5Hw1Npi34I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QRM+WQ2kQ9sx5Y4/XpGwbQkVDQYGGG6kTh5bNn3v+wNTCxV1GgyxeL+y/vxWOwW77
         jNSv+/4WpMaiIgTDWQi/MLMov+9COh71KPjjyWf5wIMLkeTqtpVTcPPn/57G5Yy4xP
         EmLrh9hgh+L3Cx6nydAsBPJogUXxerfIBBKvsqX2mIWhs5hdLIv5taAPze6B7l0lEc
         787LsGpnHNb4Ab88lbksT5Vkrn2ZrxN7PnJo4OG8xFCujkSE7vYgUVwjQFOrjPZ+D5
         VxJMgHGoOpwvR5siK6P5HqFA2v9Ejp4KS5MqQjAHVeYU0vpvDkK1jhKY1Tf3N+fahB
         sfy0uOuQ8ngPA==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id CBA7FC01A;
        Thu, 10 Jun 2021 10:33:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1623314037; bh=iZa1+1qRIau0JA4G4mFy2PSaXoZ0Z9gDo5Hw1Npi34I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kGqKC7AFVeIEp0fUgzcQS2c8VETAH1wLr0t3yFTzhPwRejmEg9Zcpu+JsrUWANfGB
         3EOPQYGvGI1CxHfxsK5+jACZk9LTEbrng404FtnrBelEryaGPAwAwZrmyyq+KhEt08
         To2C+BRqzZjyQTUwQL2nPUdfE6UvVGC5O/ADjTWNawEXw3q0gaZrQo8uByM8sXtow1
         Ehr+RutqLn8WN8yavzhmGLXakaHLFKfUHmvYaXr0ojkZZ4f/L1aGdHFVhmk3VjuwMl
         QodbN244pHG/7FS6g0TX8hpoyWc03/Vv5Rk1wcXbTqrq0HG4Wrpm2a4jP7K/vA8DXe
         W8mIarOt8lKJw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 8d60faf2;
        Thu, 10 Jun 2021 08:33:49 +0000 (UTC)
Date:   Thu, 10 Jun 2021 17:33:34 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com,
        linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        Richard Weinberger <richard.weinberger@gmail.com>,
        dgilbert@redhat.com, v9fs-developer@lists.sourceforge.net,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] init/do_mounts.c: Add root="fstag:<tag>" syntax for root
 device
Message-ID: <YMHOXn2cpGh1T9vz@codewreck.org>
References: <20210608153524.GB504497@redhat.com>
 <YMCPPCbjbRoPAEcL@stefanha-x1.localdomain>
 <20210609154543.GA579806@redhat.com>
 <YMHKZhfT0CUgeLno@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YMHKZhfT0CUgeLno@stefanha-x1.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stefan Hajnoczi wrote on Thu, Jun 10, 2021 at 09:16:38AM +0100:
> virtio-9p should be simple. I'm not sure how much additional setup the
> other 9p transports require. TCP and RDMA seem doable if there are
> kernel parameters to configure things before the root file system is
> mounted.

For TCP, we can probably piggyback on what nfs does for this, see the
ip= parameter in Documentation/admin-guide/nfs/nfsroot.rst -- it lives
in net/ipv4/ipconfig.c so should just work out of the box

For RDMA I'm less optimistic, technically if we can setup ipoib with an
ip with the same parameter it should work, but I have nothing to test it
on anyway so that'll wait until someone who cares actually does try...


Either way, we've got to start somewhere, so it's good there's something :)
-- 
Dominique



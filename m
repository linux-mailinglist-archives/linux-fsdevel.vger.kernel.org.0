Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B45C81970F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 00:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgC2W5L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Mar 2020 18:57:11 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:55786 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728619AbgC2W5L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Mar 2020 18:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585522631; x=1617058631;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=eO8/lmtA1ESg7YIFIcXZ+YqLFipul2JN4z7U2vqwfjc=;
  b=sHt246iKPIbw7nH/4oKwT8nAvR5QtUYYtvdXlPQwiL3kjQdpqbflIfQA
   msGvlfW1MhQPOceOywh1PZmqdY2EKAA/SIyuFoaJDZVJIFlw6mR/MROaH
   ZkcC1847IwGlTCPGuDh69BmYg0c140XacTIllnC7cXJiGVoGr5Z6zBp7v
   k=;
IronPort-SDR: C+IU9xBelEhvQFcu1GQuCw616HTMTlFKmv2EafDWJ/a6TjtFVj0e80uwNe/QYPiTR+l8381rnb
 Y6r+sU/dl9xg==
X-IronPort-AV: E=Sophos;i="5.72,322,1580774400"; 
   d="scan'208";a="25727200"
Subject: Re: vfs_listxattr and the NFS server: namespaces
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 29 Mar 2020 22:57:09 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (Postfix) with ESMTPS id A1EAEA20D1;
        Sun, 29 Mar 2020 22:57:07 +0000 (UTC)
Received: from EX13D24UWA002.ant.amazon.com (10.43.160.200) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 29 Mar 2020 22:57:06 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D24UWA002.ant.amazon.com (10.43.160.200) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 29 Mar 2020 22:57:07 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Sun, 29 Mar 2020 22:57:06 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 1043DC13B5; Sun, 29 Mar 2020 22:57:07 +0000 (UTC)
Date:   Sun, 29 Mar 2020 22:57:07 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Chuck Lever <chuck.lever@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Message-ID: <20200329225706.GA20307@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200327232717.15331-1-fllinden@amazon.com>
 <20200327232717.15331-11-fllinden@amazon.com>
 <20200329202546.GA31026@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <EBEE9C01-03A2-4269-A17F-5E391844AC3F@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <EBEE9C01-03A2-4269-A17F-5E391844AC3F@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 29, 2020 at 05:54:38PM -0400, Chuck Lever wrote:
> > Alternatively, we could decide that the temporarily allocation of 64k
> > is no big deal.
> 
> An order-4 allocation is not something that can be relied upon. I would
> rather find a way to avoid the need for it if at all possible.

It's not strictly an order-4 allocation anymore, as I changed
svcxdr_tmpalloc to use kvmalloc.

But sure, it's best to avoid it, it's a waste.

- Frank

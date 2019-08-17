Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDCC490C1A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2019 04:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfHQCYW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 22:24:22 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2869 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfHQCYW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 22:24:22 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5765580000>; Fri, 16 Aug 2019 19:24:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 16 Aug 2019 19:24:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 16 Aug 2019 19:24:21 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 17 Aug
 2019 02:24:21 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 17 Aug 2019 02:24:21 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d5765550000>; Fri, 16 Aug 2019 19:24:21 -0700
From:   <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [RFC PATCH v2 0/3] mm/gup: introduce vaddr_pin_pages_remote(), FOLL_PIN
Date:   Fri, 16 Aug 2019 19:24:16 -0700
Message-ID: <20190817022419.23304-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566008664; bh=cCBt59CWewaBIVEcA498iHRyQV6bodOTBBV+5/6So/Y=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=kkkl/f/UoNGU6FK/KdkQCX3YCPwYCnNXbf01z2x4dt7QASf7pR39O4CIg1mZFS88g
         Fx/XdwN929OPjhQ7ioyJ3sMzlsI3gOEetwXdW8wXH96UWABayyIFFCxiXXdA+ATrXU
         szUHbZRFKqefq4YoGrJA7bE8TUArVyykiCp1YgMmp5+AJgNd0ZtFi/j6g6+0WUUS+g
         AfED/9jTR9gazFuk9sVLtOyXpcFPV2riKtj5KnGo3e4yzUrPG3s8XdNWpM8ksXHnFR
         JDWTzCIDuOGXbvcM+zwS36d+kd7qP4IrjH4yQZ4gRK/Z/K4mE7XPlVXOvw8LGU6qgy
         /RgdQLtU2pBAQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Hi Ira,

As requested, this is for your tree:
https://github.com/weiny2/linux-kernel.git (mmotm-rdmafsdax-b0-v4), to be
applied at your last authored commit, which is: commit f625f92ecfb4
("mm/gup: Remove FOLL_LONGTERM DAX exclusion"). In other words, please
delete my previous patches from the tree, and apply these replacement
patches.

This now has a user for the new vaddr_pin_user_pages_remote() call. And
it also moves the gup flag setting out to the caller.

I'm pretty pleased to be able to include a bit of documentation (see the
FOLL_PIN patch) that covers those four cases. This should really help
clarify things. Thanks to Jan Kara and Vlastimil Babka for providing
the meaingful core of that documentation.

The naming can of course be tweaked to match whatever the final is. For
now, I've used vaddr_pin_user_pages_remote(). That addresses Jason's
request for a "user" in the name, and it also makes it very clear that
it's a replacement for get_user_pages_remote().

v1 of this RFC is here:
https://lore.kernel.org/r/20190812015044.26176-1-jhubbard@nvidia.com

John Hubbard (3):
  For Ira: tiny formatting tweak to kerneldoc
  mm/gup: introduce FOLL_PIN flag for get_user_pages()
  mm/gup: introduce vaddr_pin_pages_remote(), and invoke it

 include/linux/mm.h     | 61 +++++++++++++++++++++++++++++++++++++-----
 mm/gup.c               | 37 +++++++++++++++++++++++--
 mm/process_vm_access.c | 23 +++++++++-------
 3 files changed, 104 insertions(+), 17 deletions(-)

--=20
2.22.1


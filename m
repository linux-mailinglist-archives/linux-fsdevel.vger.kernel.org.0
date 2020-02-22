Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98CA9168C37
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2020 04:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgBVDmm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 22:42:42 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7190 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgBVDmm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 22:42:42 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e50a30f0000>; Fri, 21 Feb 2020 19:42:07 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 21 Feb 2020 19:42:41 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 21 Feb 2020 19:42:41 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 22 Feb
 2020 03:42:41 +0000
From:   John Hubbard <jhubbard@nvidia.com>
Subject: [LSF/MM/BPF ATTEND]: gup+dma, struct-less page support for devices,
 THP migration, memory hinting
X-Nvconfidentiality: public
To:     <lsf-pc@lists.linuxfoundation.org>, Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Message-ID: <9fe958f2-5a96-9f0c-7eeb-76123d1bfca0@nvidia.com>
Date:   Fri, 21 Feb 2020 19:42:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582342927; bh=TbXBPrLq5M8QW+k0aPKocsr/O7hXql8xggisjzzib1E=;
        h=X-PGP-Universal:From:Subject:X-Nvconfidentiality:To:Message-ID:
         Date:User-Agent:MIME-Version:X-Originating-IP:X-ClientProxiedBy:
         Content-Type:Content-Language:Content-Transfer-Encoding;
        b=L7r/a3iL03hB1G+3mPIDsbLeN5tuhkX9kXcnZwVisTq6CQ5IJf5PkKyCRk/splsEy
         VRNw4260DTAzVXC4b5IdFtXNgp8bueXwlWlFcr/XTUWlji3VQhy/c8/3P+IewAaakH
         FrKyPQrWU6aSFLgSa8+LyBc7JNmqhFGUBVI3BIVSWMBvwAtuWxXGedWU3oCC8I1RYw
         P3Pzb+bkO575ITDyDMZYjzaRkgu4iy7o7NVRMehy54g8ANh23i3MolHOXvdrEPd9v5
         5OP7TwiDnGcUtSmKDu1pbcNksA2QphPlZGdPC51za9GgPupwbBHoesjHm9PbGH67dI
         wUN7oQ2dahvGg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I'm interested in several areas: 

* Next steps for the gup/dma work: pin_user_pages*() and related APIs. I'm pretty 
  sure Jan Kara is going to propose that as a TOPIC, but if not, it's fine for 
  the hallway and after hours discussion track.

* GPU-centric memory management interests:

  * The topic areas that Jerome brought up are really important to me: Generic
    page protection, especially. Without those (or some other clever solution
    that maybe someone will dream up) there is no way to support atomic
    operations on memory that the CPU and GPU might both have mapped.

  * Peer-to-peer RDMA/migration

  * Representing device memory. (Maybe this means without struct pages.)

  * THP: modern GPUs love-love-love huge pages, and THP seems like The Way. So
    all things that make THP work better, especially THP migration, are of
    interest here.

  * Memory hinting and other ways of solving the problem of what to do upon
    a page fault (CPU or GPU page fault, actually): migrate? migrate peer to
    peer? What should map to where? Slightly richer information would help.
    This can easily be answered with device drivers and custom allocators,
    but for NUMA memory (malloc/mmap) it's still not all there.


thanks,
-- 
John Hubbard
NVIDIA

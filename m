Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAFA590C2E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2019 04:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfHQCgC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 22:36:02 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8949 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfHQCgC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 22:36:02 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5768140000>; Fri, 16 Aug 2019 19:36:04 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 16 Aug 2019 19:36:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 16 Aug 2019 19:36:01 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 17 Aug
 2019 02:36:01 +0000
Subject: Re: [RFC PATCH v2 2/3] mm/gup: introduce FOLL_PIN flag for
 get_user_pages()
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>
References: <20190817022419.23304-1-jhubbard@nvidia.com>
 <20190817022419.23304-3-jhubbard@nvidia.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <5a95d15b-f54c-e663-7031-c2bf9b19899e@nvidia.com>
Date:   Fri, 16 Aug 2019 19:36:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190817022419.23304-3-jhubbard@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566009364; bh=sE67K9fwIddpKrmhvFzA734CgzzbX9SZq+iv3kZAz2w=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=hFZ0vcWdyLiGQwiXX3Y10mhCJJf+AmVotZCRIlH6k5DvM3CCW3nIgqqR6lisrOEnR
         1KwzKfW2/WjOh6jyBIh8h7eM6kvwvJXUXbqmPGV/Z6x6gf9WAIjqyXDhu7TvWXYBN1
         z2QRG5bVbbSRIgx+AhzYx1xWPpl7v7//YhoAWd2kh66/zvvF3dBs32yl23astlWp1+
         cobexpvrVCOLw/KWOFcnMrlxE7G0FNhPPExrKnBhyE5qL/76s/MXDyJuwRrY5TwIwL
         n05vuoQ3bpFknPNNEcuIBzSI0daHr+RI3oI1Ho0gQejhc8bPjTtz4U6ho+nXdmFCxp
         W04D395kWA7Zg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/16/19 7:24 PM, jhubbard@nvidia.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> DKIM-Signature: v=01 a a-sha256; c=0Elaxed/relaxed; d idia.com; s=01;
> 	t=1566008674; bh=05Mai0va6k/z2enpQJ4Nfvbj5WByFxGAO1JwdIBbXio	h PGP-Unive=
rsal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
> 	 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
> 	 Content-Transfer-Encoding:Content-Type;
> 	b=C3=96UDSde9XF/IsNteBaYOBWeKiHhWmeU9ekUJNvCviHssBDCtw0T+M/2TlEPEzomIT
> 	 fGXzIQNlGN6MXFbaBoyBmF/zjCu02TmTNExbVJ3/5N6PTyOuJFCx9ZN1/5gXsB11m1
> 	 xAHIWE+VOZs4qqDeHDBqKZq+FaxQHNvGz0j6lyVBA70TfseNoZqZZrSil8uvaKJwKd
> 	 TQ1ht+AGWbw9p610JmaPb4u6o/eV6Ns8Sl3EVnjWWu94T6ISNIaWCiC6wQQF6L1YCH
> 	 G5Pjn+0rEjhk6XG4TyLudi5lWp3IVBHd8+WlWlnl+bvLCC55RUAjPJLn7LaVyVdh0F
> 	 nLHwm3bN2Jotg

I cannot readily explain the above email glitch, but I did just now switch
back to mailgw.nvidia.com for this patchset, in order to get the nice behav=
ior
of having "From:" really be my native NVIDIA email address. That's very nic=
e,
but if the glitches happen again, I'll switch back to using gmail for=20
git-send-email.

Sorry about the weirdness. It does still let you apply the patch, I
just now checked on that.

thanks,
--=20
John Hubbard
NVIDIA


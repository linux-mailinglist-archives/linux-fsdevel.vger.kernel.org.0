Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0ECD355F5E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 01:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244362AbhDFXTg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 19:19:36 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:36621 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244327AbhDFXTf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 19:19:35 -0400
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id D446C1AEB59;
        Wed,  7 Apr 2021 09:19:25 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lTuyj-00DXI3-4m; Wed, 07 Apr 2021 09:19:25 +1000
Date:   Wed, 7 Apr 2021 09:19:25 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH][CIFS] Insert and Collapse range
Message-ID: <20210406231925.GE1990290@dread.disaster.area>
References: <CAH2r5mvhUQEqXQmrz5KKbTCFaeS5ejZBGysaeQVC_ESSc-snuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mvhUQEqXQmrz5KKbTCFaeS5ejZBGysaeQVC_ESSc-snuw@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_x
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=kj9zAlcOel0A:10 a=3YhXtTcJ-WEA:10 a=7-415B0cAAAA:8
        a=mhv_l09cUW-47tK0WSYA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 01, 2021 at 01:30:28PM -0500, Steve French wrote:
> Updated version of Ronnie's patch for FALLOC_FL_INSERT_RANGE and
> FALLOC_FL_COLLAPSE_RANGE attached (cleaned up the two redundant length
> checks noticed out by Aurelien, and fixed the endian check warnings
> pointed out by sparse).
> 
> They fix at least six xfstests (but still more xfstests to work
> through that seem to have other new feature dependencies beyond
> fcollapse)
> 
> # ./check -cifs generic/072 generic/145 generic/147 generic/153
> generic/351 generic/458
> FSTYP         -- cifs
> PLATFORM      -- Linux/x86_64 smfrench-Virtual-Machine
> 5.12.0-051200rc4-generic #202103212230 SMP Sun Mar 21 22:33:27 UTC
> 2021
> 
> generic/072 7s ...  6s
> generic/145 0s ...  1s
> generic/147 1s ...  0s
> generic/153 0s ...  1s
> generic/351 5s ...  3s
> generic/458 1s ...  1s
> Ran: generic/072 generic/145 generic/147 generic/153 generic/351 generic/458
> Passed all 6 tests

FWIW, I think you need to also run all the fsstress and fsx tests as
well. fsx, especially, as that will do data integrity checking on
insert/collapse operations.

`git grep -iwl fsx tests/` will give you an idea of the extra fsx
based tests to run....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

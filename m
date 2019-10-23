Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 101D8E2700
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 01:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391143AbfJWX0Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 19:26:24 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40971 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731522AbfJWX0Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 19:26:24 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9NNQEfO002547
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Oct 2019 19:26:15 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 91B42420456; Wed, 23 Oct 2019 19:26:14 -0400 (EDT)
Date:   Wed, 23 Oct 2019 19:26:14 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org
Subject: Re: [RFC 0/5] Ext4: Add support for blocksize < pagesize for
 dioread_nolock
Message-ID: <20191023232614.GB1124@mit.edu>
References: <20191016073711.4141-1-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016073711.4141-1-riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ritesh,

I haven't had a chance to dig into the test failures yet, but FYI....
when I ran the auto test group in xfstests, I saw failures for
generic/219, generic 273, and generic/476 --- these errors did not
show up when running using a standard 4k blocksize on x86, and they
also did not show up when running dioread_nolock using a 4k blocksize.

So I tried running "generic/219 generic/273 generic/476" 30 times,
using in a Google Compute Engine VM, using gce-xfstests, and while I
wasn't able to get generic/219 to fail when run in isolation,
generic/273 seems to fail quite reliably, and generic/476 about a
third of the time.

How much testing have you done with these patches?

Thanks,

							- Ted

TESTRUNID: tytso-20191023144956
KERNEL:    kernel 5.4.0-rc3-xfstests-00005-g39b811602906 #1244 SMP Wed Oct 23 11:30:25 EDT 2019 x86_64
CMDLINE:   --update-files -C 30 -c dioread_nolock_1k generic/219 generic/273 generic/476
CPUS:      2
MEM:       7680

ext4/dioread_nolock_1k: 90 tests, 42 failures, 10434 seconds
  Failures: generic/273 generic/273 generic/273 generic/273
    generic/476 generic/273 generic/476 generic/273 generic/273
    generic/273 generic/476 generic/273 generic/476 generic/273
    generic/476 generic/273 generic/476 generic/273 generic/273
    generic/273 generic/273 generic/273 generic/476 generic/273
    generic/273 generic/273 generic/273 generic/476 generic/273
    generic/476 generic/273 generic/476 generic/273 generic/273
    generic/273 generic/273 generic/273 generic/273 generic/273
    generic/476 generic/273 generic/476
Totals: 90 tests, 0 skipped, 42 failures, 0 errors, 10434s


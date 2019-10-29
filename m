Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1564E93C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 00:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfJ2Xed (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Oct 2019 19:34:33 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35379 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726053AbfJ2Xec (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Oct 2019 19:34:32 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9TNY2XX011791
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Oct 2019 19:34:03 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E8116420456; Tue, 29 Oct 2019 19:34:01 -0400 (EDT)
Date:   Tue, 29 Oct 2019 19:34:01 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     jack@suse.cz, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v6 00/11] ext4: port direct I/O to iomap infrastructure
Message-ID: <20191029233401.GB8537@mit.edu>
References: <cover.1572255424.git.mbobrowski@mbobrowski.org>
 <20191029233159.GA8537@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029233159.GA8537@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 29, 2019 at 07:31:59PM -0400, Theodore Y. Ts'o wrote:
> Hi Matthew, it looks like there are a number of problems with this
> patch series when using the ext3 backwards compatibility mode (e.g.,
> no extents enabled).
> 
> So the following configurations are failing:
> 
> kvm-xfstests -c ext3   generic/091 generic/240 generic/263

Here are the details of the generic/240 failure:

root@kvm-xfstests:~# diff -u /root/xfstests/tests/generic/240.out /results/ext4/results-ext3/generic/240.out.bad
--- /root/xfstests/tests/generic/240.out	2019-10-21 15:29:56.000000000 -0400
+++ /results/ext4/results-ext3/generic/240.out.bad	2019-10-29 19:32:29.166850310 -0400
@@ -1,2 +1,7 @@
 QA output created by 240
 Silence is golden.
+AIO write offset 4608 expected 4096 got 512
+AIO write offset 8704 expected 4096 got 512
+non one buffer at buf[0] => 0x00,00,00,00
+non-one read at offset 12800
+*** WARNING *** /vdd/aiodio_sparse has not been unlinked; if you don't rm it manually first, it may influence the next run

     	     	 		    	    - Ted

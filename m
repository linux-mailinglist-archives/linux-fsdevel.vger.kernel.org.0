Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6B7B16881A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 21:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgBUULU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 15:11:20 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45761 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727998AbgBUULU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 15:11:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582315878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uRP0kTpYUnrOv+Lvd4Y6Qf2YuD8AbSPgX2qmL9GoFeg=;
        b=aXi7eHQx9CDfzJ2Q3d5YghUiWwfQH0bHC5cOgkNCo0g2wi0GOMF2ttXzCkZ9p3U2XvwJHz
        TxYExDNcCaZG8uVQLA2CT7NDLil3qljSpPEqLCOUQu00tTwWtMv2902+RRQjHrvfFV3AwD
        ah5u9JIwObEbTCQUQGqOF4BJ2ttwxXw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-FPdgxLhVMQ2qup8ahp3gwg-1; Fri, 21 Feb 2020 15:11:14 -0500
X-MC-Unique: FPdgxLhVMQ2qup8ahp3gwg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E255800D4E;
        Fri, 21 Feb 2020 20:11:13 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F2F8660499;
        Fri, 21 Feb 2020 20:11:12 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH V2 0/3] fstests: fixes for 64k pages and dax
References: <20200220200632.14075-1-jmoyer@redhat.com>
        <20200220212100.GC9506@magnolia>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 21 Feb 2020 15:11:11 -0500
In-Reply-To: <20200220212100.GC9506@magnolia> (Darrick J. Wong's message of
        "Thu, 20 Feb 2020 13:21:00 -0800")
Message-ID: <x494kvj3dls.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Darrick,

"Darrick J. Wong" <darrick.wong@oracle.com> writes:

>> One class of failures is tests that create a really small file system
>> size.  Some of those tests seem to require the very small size, but
>> others seem like they could live with a slightly bigger size that
>> would then fit the log (the typical failure is a mkfs failure due to
>> not enough blocks for the log).  For the former case, I'm tempted to
>> send patches to _notrun those tests, and for the latter, I'd like to
>> bump the file system sizes up.  300MB seems to be large enough to
>> accommodate the log.  Would folks be opposed to those approaches?
>
> Seems fine to me.  Do we have a helper function to compute (or maybe
> just format) the minimum supported filesystem size for the given
> MKFS_OPTIONS?

Not that I could find.  I'm not sure how you'd do that, even.

>> Another class of failure is tests that either hard-code a block size
>> to trigger a specific error case, or that test a multitude of block
>> sizes.  I'd like to send a patch to _notrun those tests if there is
>> a user-specified block size.  That will require parsing the MKFS_OPTIONS
>> based on the fs type, of course.  Is that something that seems
>> reasonable?
>
> I think it's fine to _notrun a test that requires a specific blocksize
> when when that blocksize is not supported by the system under test.

OK.

> The ones that cycle through a range of block sizes, not so much--I guess
> the question here is can we distinguish "test only this blocksize" vs
> "default to this block size"?  And do we want to?

Well, I'd like to prevent false test failures.  In this instance, the
block size is required in order for the system to function.  I'm
guessing this is a new and special kind of suck.  If we treat the
MKFS_OPTIONS as advisory, then there will be false positive failures.
If we treat MKFS_OPTIONS as mandatory, then there will be less test
coverage for a given set of options.  I think that's the preferrable
solution, but I'm probably too focused on this one use case.

-Jeff


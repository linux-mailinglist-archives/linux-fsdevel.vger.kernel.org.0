Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1431568999A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 14:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjBCNV0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Feb 2023 08:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjBCNVY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 08:21:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A356893AE2;
        Fri,  3 Feb 2023 05:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2HifOJA9xEveZM8S1gjqMUhg2gHpRif7oy7buFyjGZM=; b=tyPVIsUVRpIoIoazplnubKmX1v
        VwBTgmYii/7IPUTEh3FWs/+3N1G7cKSAAwVe5uNCqYKeI5R5ip0/9MzqHlwdJQb1C/1gHW0SVBgZD
        TTNWZnJdMQQ+nx9ncuzJ4NH67LYSnA5bg+XBwru4I25XIPz8EY3tDHScxiFgW3OBr5d+97Or/4Pe8
        vW784qBalVKSP+hbLlpcQpt3/rC47rVDm3QvjeTJ8u2q9haDI7oHiRDw05qhuodbvBiKedIqGpPAd
        IvuCLnuK7HNTfy/Txxb8YdoJ6dHlD/16YEZ1SYt+fl7Ryd0Ix8Jzhp8YXQfvgVjMyBHZI43i0mIGF
        bWT8hCpg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNw0D-00EKdy-V5; Fri, 03 Feb 2023 13:21:18 +0000
Date:   Fri, 3 Feb 2023 13:21:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 0/5] Fix a minor POSIX conformance problem
Message-ID: <Y90KTSXCKGd8Gaqc@casper.infradead.org>
References: <20230202204428.3267832-1-willy@infradead.org>
 <DCEDB8BB-8D10-4E17-9C27-AE48718CB82F@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCEDB8BB-8D10-4E17-9C27-AE48718CB82F@dilger.ca>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 02, 2023 at 04:08:49PM -0700, Andreas Dilger wrote:
> On Feb 2, 2023, at 1:44 PM, Matthew Wilcox (Oracle) <willy@infradead.org> wrote:
> > 
> > POSIX requires that on ftruncate() expansion, the new bytes must read
> > as zeroes.  If someone's mmap()ed the file and stored past EOF, for
> > most filesystems the bytes in that page will be not-zero.  It's a
> > pretty minor violation; someone could race you and write to the file
> > between the ftruncate() call and you reading from it, but it's a bit
> > of a QOI violation.
> 
> Is it possible to have mmap return SIGBUS for the writes beyond EOF?

Well, no.  The hardware only tells us about accesses on a per-page
basis.  We could SIGBUS on writes that _start_ after EOF, but this
test doesn't do that (it starts before EOF and extends past EOF).
And once the page is mapped writable, there's no page fault taken
for subsequent writes.

> On the one hand, that might indicate incorrect behavior of the application,
> and on the other hand, it seems possible that the application doesn't
> know it is writing beyond EOF and expects that data to be read back OK?

POSIX says:

"The system shall always zero-fill any partial page at the end of an
object. Further, the system shall never write out any modified portions
of the last page of an object which are beyond its end. References
within the address range starting at pa and continuing for len bytes to
whole pages following the end of an object shall result in delivery of
a SIGBUS signal."

https://pubs.opengroup.org/onlinepubs/9699919799/functions/mmap.html

So the application can't expect to read back anything it's written
(and if you look at page writeback, we currently zero beyond EOF at
writeback time).

> IMHO, this seems better to stop the root of the problem (mmap() allowing
> bad writes), rather than trying to fix it after the fact.

That would be nice, but we're rather stuck with the hardware that exists.
IIUC Cray-1 had byte-granularity range registers, but page-granularity
is what we have.


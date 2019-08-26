Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27A689D6CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 21:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbfHZTcN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 15:32:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45860 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729669AbfHZTcN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 15:32:13 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i2Kio-0000ci-3n; Mon, 26 Aug 2019 19:32:11 +0000
Date:   Mon, 26 Aug 2019 20:32:10 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     =?iso-8859-1?Q?=22Kai_M=E4kisara_=28Kolumbus=29=22?= 
        <kai.makisara@kolumbus.fi>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Octavian Purdila <octavian.purdila@intel.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi@vger.kernel.org
Subject: Re: [RFC] Re: broken userland ABI in configfs binary attributes
Message-ID: <20190826193210.GP1131@ZenIV.linux.org.uk>
References: <20190826024838.GN1131@ZenIV.linux.org.uk>
 <20190826162949.GA9980@ZenIV.linux.org.uk>
 <B35B5EA9-939C-49F5-BF65-491D70BCA8D4@kolumbus.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B35B5EA9-939C-49F5-BF65-491D70BCA8D4@kolumbus.fi>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 26, 2019 at 09:34:37PM +0300, "Kai Mäkisara (Kolumbus)" wrote:
> 
> 
> > On 26 Aug 2019, at 19.29, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > 
> > On Mon, Aug 26, 2019 at 03:48:38AM +0100, Al Viro wrote:
> > 
> >> 	We might be able to paper over that mess by doing what /dev/st does -
> >> checking that file_count(file) == 1 in ->flush() instance and doing commit
> >> there in such case.  It's not entirely reliable, though, and it's definitely
> >> not something I'd like to see spreading.
> > 
> > 	This "not entirely reliable" turns out to be an understatement.
> > If you have /proc/*/fdinfo/* being read from at the time of final close(2),
> > you'll get file_count(file) > 1 the last time ->flush() is called.  In other
> > words, we'd get the data not committed at all.
> > 
> ...
> > PS: just dropping the check in st_flush() is probably a bad idea -
> > as it is, it can't overlap with st_write() and after such change it
> > will…
> Yes, don’t just drop it. The tape semantics require that a file mark is written when the last opener closes this sequential device. This is why the check is there. Of course, it is good if someone finds a better solution for this.

D'oh...  OK, that settles it; exclusion with st_write() would've been
painful, but playing with the next st_write() on the same struct file
rewinding the damn thing to overwrite what st_flush() had spewed is
an obvious no-go.

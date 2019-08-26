Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87D5C9D5F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 20:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbfHZSk6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 14:40:58 -0400
Received: from vs24.mail.saunalahti.fi ([62.142.117.201]:49396 "EHLO
        vs24.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbfHZSk6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 14:40:58 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Aug 2019 14:40:56 EDT
Received: from vs24.mail.saunalahti.fi (localhost [127.0.0.1])
        by vs24.mail.saunalahti.fi (Postfix) with ESMTP id E62EF20F63;
        Mon, 26 Aug 2019 21:34:45 +0300 (EEST)
Received: from gw02.mail.saunalahti.fi (gw02.mail.saunalahti.fi [195.197.172.116])
        by vs24.mail.saunalahti.fi (Postfix) with ESMTP id DB0AE20F61;
        Mon, 26 Aug 2019 21:34:45 +0300 (EEST)
Received: from [192.168.1.132] (87-100-205-87.bb.dnainternet.fi [87.100.205.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kh8831)
        by gw02.mail.saunalahti.fi (Postfix) with ESMTPSA id 4B92C40025;
        Mon, 26 Aug 2019 21:34:38 +0300 (EEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC] Re: broken userland ABI in configfs binary attributes
From:   =?utf-8?B?IkthaSBNw6RraXNhcmEgKEtvbHVtYnVzKSI=?= 
        <kai.makisara@kolumbus.fi>
In-Reply-To: <20190826162949.GA9980@ZenIV.linux.org.uk>
Date:   Mon, 26 Aug 2019 21:34:37 +0300
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Octavian Purdila <octavian.purdila@intel.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <B35B5EA9-939C-49F5-BF65-491D70BCA8D4@kolumbus.fi>
References: <20190826024838.GN1131@ZenIV.linux.org.uk>
 <20190826162949.GA9980@ZenIV.linux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On 26 Aug 2019, at 19.29, Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> On Mon, Aug 26, 2019 at 03:48:38AM +0100, Al Viro wrote:
> 
>> 	We might be able to paper over that mess by doing what /dev/st does -
>> checking that file_count(file) == 1 in ->flush() instance and doing commit
>> there in such case.  It's not entirely reliable, though, and it's definitely
>> not something I'd like to see spreading.
> 
> 	This "not entirely reliable" turns out to be an understatement.
> If you have /proc/*/fdinfo/* being read from at the time of final close(2),
> you'll get file_count(file) > 1 the last time ->flush() is called.  In other
> words, we'd get the data not committed at all.
> 
...
> PS: just dropping the check in st_flush() is probably a bad idea -
> as it is, it can't overlap with st_write() and after such change it
> will…
Yes, don’t just drop it. The tape semantics require that a file mark is written when the last opener closes this sequential device. This is why the check is there. Of course, it is good if someone finds a better solution for this.

Thanks,
Kai


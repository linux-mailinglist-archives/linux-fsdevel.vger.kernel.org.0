Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B37AD15B20E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 21:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgBLUoq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 15:44:46 -0500
Received: from zimbra.cs.ucla.edu ([131.179.128.68]:53110 "EHLO
        zimbra.cs.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgBLUoq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:44:46 -0500
X-Greylist: delayed 390 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Feb 2020 15:44:46 EST
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id AB5EF16009A;
        Wed, 12 Feb 2020 12:38:15 -0800 (PST)
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xnhXg-7Pb7A0; Wed, 12 Feb 2020 12:38:14 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id C5DEF1600AB;
        Wed, 12 Feb 2020 12:38:14 -0800 (PST)
X-Virus-Scanned: amavisd-new at zimbra.cs.ucla.edu
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qRds0Tazbc71; Wed, 12 Feb 2020 12:38:14 -0800 (PST)
Received: from Penguin.CS.UCLA.EDU (Penguin.CS.UCLA.EDU [131.179.64.200])
        by zimbra.cs.ucla.edu (Postfix) with ESMTPSA id A3E9816009A;
        Wed, 12 Feb 2020 12:38:14 -0800 (PST)
Subject: Re: XFS reports lchmod failure, but changes file system contents
To:     Florian Weimer <fw@deneb.enyo.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, libc-alpha@sourceware.org,
        linux-fsdevel@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Gnulib bugs <bug-gnulib@gnu.org>
References: <874kvwowke.fsf@mid.deneb.enyo.de>
 <20200212161604.GP6870@magnolia> <20200212181128.GA31394@infradead.org>
 <20200212183718.GQ6870@magnolia> <87d0ajmxc3.fsf@mid.deneb.enyo.de>
 <20200212195118.GN23230@ZenIV.linux.org.uk>
 <87wo8rlgml.fsf@mid.deneb.enyo.de>
From:   Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
Message-ID: <33a0e120-14d7-7d9a-2e00-2fb7e1db99f7@cs.ucla.edu>
Date:   Wed, 12 Feb 2020 12:38:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87wo8rlgml.fsf@mid.deneb.enyo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/12/20 12:01 PM, Florian Weimer wrote:
> I assumed that an O_PATH descriptor was not intending to
> confer that capability.

I originally assumed the other way, as I don't see any security reason 
why fchmod should not work on O_PATH-opened descriptors. I see that the 
Linux man page says open+O_PATH doesn't work with fchmod, but that's 
just a bug in the spec.

In Android, the bionic C library has worked around this problem since 
2015 by wrapping fchmod so that it works even when the fd was 
O_PATH-opened. Bionic then uses O_PATH + fchmod to work around the 
fchmodat+AT_SYMLINK_NOFOLLOW problem[1]. glibc (and Gnulib, etc.) could 
do the same. It's the most sane way out of this mess.

[1] 
https://android.googlesource.com/platform/bionic/+/3cbc6c627fe57c9a9783c52d148078f8d52f7b96

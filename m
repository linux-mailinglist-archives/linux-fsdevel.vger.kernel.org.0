Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8470219A415
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 06:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgDAEAm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 00:00:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41456 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgDAEAm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 00:00:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0313sjWH044988;
        Wed, 1 Apr 2020 04:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=obROhXjAve/kpZaKiv7NWOZ2z2jo7yzeO27qepEQr7k=;
 b=fJTI/W2EHKpH+kB3SSlDBzAj/z+tuY2wcGMI5Iyhf/pfi7/9J1WdZq2TIhdiTZV7tJeI
 AqY6m4egj4B3EnySHxxuRh0K4yKurwkmsWIa0zJ9rADKdKtmO+3ZwU2bFy3AXPPqBuq8
 v0JeiSR1X4H+wL8mvT6hEaZro2F7KFmeRQ+1w1U8TkdDMCCfmEvOHl7NEdDDEvI+to82
 kaPWDXXc/aNZ6J2E2S7XBkfiV94pA+ox4IkJUdGw40/blrox6ONxW9mB7AebiybaWKkt
 CbpUIE2jGxr+Nz7akcWjS4paSdhCaXwyhe8u1vogilr0MM+MkETQD/D722m7Fr8ifkoG SA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 303cev322q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Apr 2020 04:00:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0313qqwE192638;
        Wed, 1 Apr 2020 04:00:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 302g2fgxjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Apr 2020 04:00:29 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03140Q1b001068;
        Wed, 1 Apr 2020 04:00:26 GMT
Received: from localhost (/67.169.218.210) by default (Oracle Beehive Gateway
 v4.0) with ESMTP ; Tue, 31 Mar 2020 21:00:23 -0700
USER-AGENT: Mutt/1.9.4 (2018-02-28)
MIME-Version: 1.0
Message-ID: <20200401040021.GC56958@magnolia>
Date:   Wed, 1 Apr 2020 04:00:21 +0000 (UTC)
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Ira Weiny <ira.weiny@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH V5 00/12] Enable per-file/per-directory DAX operations V5
References: <20200227052442.22524-1-ira.weiny@intel.com>
 <20200305155144.GA5598@lst.de>
 <20200309170437.GA271052@iweiny-DESK2.sc.intel.com>
 <20200311033614.GQ1752567@magnolia> <20200311062952.GA11519@lst.de>
 <CAPcyv4h9Xg61jk=Uq17xC6AGj9yOSAJnCaTzHcfBZwOVdRF9dw@mail.gmail.com>
 <20200316095224.GF12783@quack2.suse.cz> <20200316095509.GA13788@lst.de>
In-Reply-To: <20200316095509.GA13788@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9577 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010035
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9577 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010035
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 16, 2020 at 10:55:09AM +0100, Christoph Hellwig wrote:
> On Mon, Mar 16, 2020 at 10:52:24AM +0100, Jan Kara wrote:
> > > This sounds reasonable to me.
> > > 
> > > As for deprecating the mount option, I think at a minimum it needs to
> > > continue be accepted as an option even if it is ignored to not break
> > > existing setups.
> > 
> > Agreed. But that's how we usually deprecate mount options. Also I'd say
> > that statx() support for reporting DAX state and some education of
> > programmers using DAX is required before we deprecate the mount option
> > since currently applications check 'dax' mount option to determine how much
> > memory they need to set aside for page cache before they consume everything
> > else on the machine...
> 
> I don't even think we should deprecate it.  It isn't painful to maintain
> and actually useful for testing.  Instead we should expand it into a
> tristate:
> 
>   dax=off
>   dax=flag
>   dax=always
> 
> where the existing "dax" option maps to "dax=always" and nodax maps
> to "dax=off". and dax=flag becomes the default for DAX capable devices.

That works for me.  In summary:

 - Applications must call statx to discover the current S_DAX state.

 - There exists an advisory file inode flag FS_XFLAG_DAX that can be
   changed on files that have no blocks allocated to them.  Changing
   this flag does not necessarily change the S_DAX state immediately
   but programs can query the S_DAX state via statx.

   If FS_XFLAG_DAX is set and the fs is on pmem then it will always
   enable S_DAX at inode load time; if FS_XFLAG_DAX is not set, it will
   never enable S_DAX.  Unless overridden...

 - There exists a dax= mount option.  dax=off means "never set S_DAX,
   ignore FS_XFLAG_DAX"; dax=always means "always set S_DAX (at least on
   pmem), ignore FS_XFLAG_DAX"; and dax=iflag means "follow FS_XFLAG_DAX"
   and is the default.  "dax" by itself means "dax=always".  "nodax"
   means "dax=off".

 - There exists an advisory directory inode flag FS_XFLAG_DAX that can
   be changed at any time.  The flag state is copied into any files or
   subdirectories created within that directory.  If programs require
   that file access runs in S_DAX mode, they'll have to create those
   files themselves inside a directory with FS_XFLAG_DAX set, or mount
   the fs with dax=always.

Ok?  Let's please get this part finished for 5.8, then we can get back
to arguing about fs-rmap and reflink and dax and whatnot.

--D

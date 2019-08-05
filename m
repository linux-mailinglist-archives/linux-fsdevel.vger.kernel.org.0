Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC4E081FE7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 17:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbfHEPNY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 11:13:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36364 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729231AbfHEPNY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 11:13:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x75F9MQq138000;
        Mon, 5 Aug 2019 15:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=dw2AnVkSeqtXfAEn6fPeTen3NsinTcJtAjutNBxMQLI=;
 b=Zh/zRLsJ8lW1xqiJQRwzvOm/LFke/qMeaz00eMmRMOGck9LxUlnYpBgsYOb7KmEHp6KS
 8BeGnoTMCSAOFWVWy5cZ4cUN9RtATbgFsxd78lIPynjpGdq1xFQElIgBxdo7n9F3osnC
 Npzl+80FzRtK6nRcz970GUJpdZk9v5sTvuaSbVntBYh7GiRImz5+w0xd9kGZ54QJYj6x
 aDOdBNkoA9sE2IGoOFGAoZwsgxV0Mk5R+zlsxqcJQ+Qutu0cCPttsSY9AKlzz4ScIpQV
 lThJKQnEDE9vTu1+n6nB698vJHvw+1CRRfNPAXbXHSr9WlxBlZYisoDC73upDQpmk6eh qg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2u52wqyu21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Aug 2019 15:13:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x75F81vQ110796;
        Mon, 5 Aug 2019 15:13:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2u50abv0xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Aug 2019 15:13:06 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x75FD0iw032601;
        Mon, 5 Aug 2019 15:13:00 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Aug 2019 08:12:59 -0700
Date:   Mon, 5 Aug 2019 08:12:58 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/9] fibmap: Use bmap instead of ->bmap method in
 ioctl_fibmap
Message-ID: <20190805151258.GD7129@magnolia>
References: <20190731141245.7230-1-cmaiolino@redhat.com>
 <20190731141245.7230-5-cmaiolino@redhat.com>
 <20190731231217.GV1561054@magnolia>
 <20190802091937.kwutqtwt64q5hzkz@pegasus.maiolino.io>
 <20190802151400.GG7138@magnolia>
 <20190805102729.ooda6sg65j65ojd4@pegasus.maiolino.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805102729.ooda6sg65j65ojd4@pegasus.maiolino.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9340 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908050169
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9340 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908050169
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 05, 2019 at 12:27:30PM +0200, Carlos Maiolino wrote:
> On Fri, Aug 02, 2019 at 08:14:00AM -0700, Darrick J. Wong wrote:
> > On Fri, Aug 02, 2019 at 11:19:39AM +0200, Carlos Maiolino wrote:
> > > Hi Darrick.
> > > 
> > > > > +		return error;
> > > > > +
> > > > > +	block = ur_block;
> > > > > +	error = bmap(inode, &block);
> > > > > +
> > > > > +	if (error)
> > > > > +		ur_block = 0;
> > > > > +	else
> > > > > +		ur_block = block;
> > > > 
> > > > What happens if ur_block > INT_MAX?  Shouldn't we return zero (i.e.
> > > > error) instead of truncating the value?  Maybe the code does this
> > > > somewhere else?  Here seemed like the obvious place for an overflow
> > > > check as we go from sector_t to int.
> > > > 
> > > 
> > > The behavior should still be the same. It will get truncated, unfortunately. I
> > > don't think we can actually change this behavior and return zero instead of
> > > truncating it.
> > 
> > But that's even worse, because the programs that rely on FIBMAP will now
> > receive *incorrect* results that may point at a different file and
> > definitely do not point at the correct file block.
> 
> How is this worse? This is exactly what happens today, on the original FIBMAP
> implementation.

Ok, I wasn't being 110% careful with my words.  Delete "will now" from
the sentence above.

> Maybe I am not seeing something or having a different thinking you have, but
> this is the behavior we have now, without my patches. And we can't really change
> it; the user view of this implementation.
> That's why I didn't try to change the result, so the truncation still happens.

I understand that we're not generally supposed to change existing
userspace interfaces, but the fact remains that allowing truncated
responses causes *filesystem corruption*.

We know that the most well known FIBMAP callers are bootloaders, and we
know what they do with the information they get -- they use it to record
the block map of boot files.  So if the IPL/grub/whatever installer
queries the boot file and the boot file is at block 12345678901 (a
34-bit number), this interface truncates that to 3755744309 (a 32-bit
number) and that's where the bootloader will think its boot files are.
The installation succeeds, the user reboots and *kaboom* the system no
longer boots because the contents of block 3755744309 is not a bootloader.

Worse yet, grub1 used FIBMAP data to record the location of the grub
environment file and installed itself between the MBR and the start of
partition 1.  If the environment file is at offset 1234578901, grub will
write status data to its environment file (which it thinks is at
3755744309) and *KABOOM* we've just destroyed whatever was in that
block.

Far better for the bootloader installation script to hit an error and
force the admin to deal with the situation than for the system to become
unbootable.  That's *why* the (newer) iomap bmap implementation does not
return truncated mappings, even though the classic implementation does.

The classic code returning truncated results is a broken behavior.

> > Note also that the iomap (and therefore xfs) implementation WARNs on
> > integer overflow and returns 0 (error) to prevent an incorrect access.
> 
> It does not really prevent anything. It just issue a warning saying the result
> will be truncated, in an attempt to notify the FIBMAP interface user that he/she
> can't trust the result, but it does not prevent a truncated result to be

I disagree; the iomap bmap implementation /does/ prevent truncated responses:

: static loff_t
: iomap_bmap_actor(struct inode *inode, loff_t pos, loff_t length,
: void *data, struct iomap *iomap)
: {
: 	sector_t *bno = data, addr;
: 
: 	if (iomap->type == IOMAP_MAPPED) {
: 		addr = (pos - iomap->offset + iomap->addr) >> inode->i_blkbits;
: 		if (addr > INT_MAX)
: 			WARN(1, "would truncate bmap result\n");

Notice how we don't set *bno here?

: 		else
: 			*bno = addr;

And only set it in the case that there isn't an integer overflow?

: 	}
: 	return 0;
: }
:
: /* legacy ->bmap interface.  0 is the error return (!) */
: sector_t
: iomap_bmap(struct address_space *mapping, sector_t bno,
: 		const struct iomap_ops *ops)
: {
: 	struct inode *inode = mapping->host;
: 	loff_t pos = bno << inode->i_blkbits;
: 	unsigned blocksize = i_blocksize(inode);
: 
: 	if (filemap_write_and_wait(mapping))
: 		return 0;
: 
: 	bno = 0;

We initialize bno to zero here...

: 	iomap_apply(inode, pos, blocksize, 0, ops, &bno, iomap_bmap_actor);

...then pass bno's address to the apply function to pass to
iomap_bmap_actor, so either the _actor function set bno or in the case
of overflow it left it set to zero.

: 	return bno;
: }

> returned. And IIRC, iomap is the only interface now that cares about issuing a
> warning.
>
> I think the *best* we could do here, is to make the new bmap() to issue the same
> kind of WARN() iomap does, but we can't really change the end result.

I'd rather we break legacy code than corrupt filesystems.

--D

> 
> > 
> > --D
> > 
> > > > --D
> > > > 
> > > > > +
> > > > > +	error = put_user(ur_block, p);
> > > > > +
> > > > > +	return error;
> > > > >  }
> > > > >  
> > > > >  /**
> > > > > -- 
> > > > > 2.20.1
> > > > > 
> > > 
> > > -- 
> > > Carlos
> 
> -- 
> Carlos

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 096FD1843D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 05:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfEIDzw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 May 2019 23:55:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59402 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfEIDzw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 May 2019 23:55:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x493n05u071785;
        Thu, 9 May 2019 03:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=hJIYrUgvzDq6Te0tRYDeiwHQT+jPEyBWyEAJIgCmVhs=;
 b=TeNWgXLpm0wMuMvNRrbaJMF5k3/47HPyIT2zSFe6gU5kJ5fjNtoeH4AbpN+houhDWatf
 4yCm196maBxXY+3quMDWBSqkzywdzRASKoiRRcnkeWxv1hlfjYtIS5P0VGhHqISM508V
 J4y42PVB/hz3LeSuURLWr+I2V4w9zodVAesmKmpcgRompbpiGIkrxlO/1AHY+EP/Qwhd
 ZUS1o5JIYQAhc/0xzCc2OE5Af1/U7T2O3HiRt0b/8DsZ6ANu5DTCQSPJRolT+LMJTPu8
 RZAAXYlIrOf2Vq1Z/xeUAj+AcbDvr/L1TFNLaqISzuLD+PP/4b5SODh4ZEiYNzWAVNCf tQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2s94b10350-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 03:55:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x493t6du146526;
        Thu, 9 May 2019 03:55:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2s9ayfxnss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 03:55:35 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x493tY4O001941;
        Thu, 9 May 2019 03:55:34 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 May 2019 20:55:34 -0700
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ric Wheeler <ricwheeler@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        lczerner@redhat.com
Subject: Re: Testing devices for discard support properly
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <4a484c50-ef29-2db9-d581-557c2ea8f494@gmail.com>
        <20190507220449.GP1454@dread.disaster.area>
        <yq1ef58ly5j.fsf@oracle.com>
        <20190508223157.GS1454@dread.disaster.area>
Date:   Wed, 08 May 2019 23:55:31 -0400
In-Reply-To: <20190508223157.GS1454@dread.disaster.area> (Dave Chinner's
        message of "Thu, 9 May 2019 08:31:57 +1000")
Message-ID: <yq1h8a4i8ng.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9251 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905090023
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9251 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905090023
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Dave,

> Only when told to do PUNCH_HOLE|NO_HIDE_STALE which means "we don't
> care what the device does" as this fallcoate command provides no
> guarantees for the data returned by subsequent reads. It is,
> esssentially, a get out of gaol free mechanism for indeterminate
> device capabilities.

Correct. But the point of discard is to be a lightweight mechanism to
convey to the device that a block range is no longer in use. Nothing
more, nothing less.

Not everybody wants the device to spend resources handling unwritten
extents. I understand the importance of that use case for XFS but other
users really just need deallocate semantics.

> People used to make that assertion about filesystems, too. It took
> linux filesystem developers years to realise that unwritten extents
> are actually very simple and require very little extra code and no
> extra space in metadata to implement. If you are already tracking
> allocated blocks/space, then you're 99% of the way to efficient
> management of logically zeroed disk space.

I don't disagree. But since "discard performance" checkmark appears to
be absent from every product requirements document known to man, very
little energy has been devoted to ensuring that discard operations can
coexist with read/write I/O without impeding the performance.

I'm not saying it's impossible. Just that so far it hasn't been a
priority. Even large volume customers have been unable to compel their
suppliers to produce a device that doesn't suffer one way or the other.

On the SSD device side, vendors typically try to strike a suitable
balance between what's handled by the FTL and what's handled by
over-provisioning.

>> 2. Our expectation for the allocating REQ_ZEROOUT (FL_ZERO_RANGE), which
>>    gets translated into NVMe WRITE ZEROES, SCSI WRITE SAME, is that the
>>    command executes in O(n) but that it is faster -- or at least not
>>    worse -- than doing a regular WRITE to the same block range.
>
> You're missing the important requirement of fallocate(ZERO_RANGE):
> that the space is also allocated and ENOSPC will never be returned
> for subsequent writes to that range. i.e. it is allocated but
> "unwritten" space that contains zeros.

That's what I implied when comparing it to a WRITE.

>> 3. Our expectation for the deallocating REQ_ZEROOUT (FL_PUNCH_HOLE),
>>    which gets translated into ATA DSM TRIM w/ whitelist, NVMe WRITE
>>    ZEROES w/ DEAC, SCSI WRITE SAME w/ UNMAP, is that the command will
>>    execute in O(1) for any portion of the block range described by the
>
> FL_PUNCH_HOLE has no O(1) requirement - it has a "all possible space
> must be freed" requirement. The larger the range, to longer it will
> take.

OK, so maybe my O() notation lacked a media access moniker. What I meant
to convey was that no media writes take place for the properly aligned
multiple of the internal granularity. The FTL update takes however long
it takes, but the only potential media accesses would be the head and
tail pieces. For some types of devices, these might be handled in
translation tables. But for others, zeroing blocks on the media is the
only way to do it.

> That's expected, and exaclty what filesystems do for sub-block punch
> and zeroing ranges.

Yep.

> What I'm saying is that we should be pushing standards to ensure (3)
> is correctly standardise, certified and implemented because that is
> what the "Linux OS" requires from future hardware.

That's well-defined for both NVMe and SCSI.

However, I do not agree that a deallocate operation has to imply
zeroing. I think there are valid use cases for pure deallocate.

In an ideal world the performance difference between (1) and (3) would
be negligible and make this distinction moot. However, we have to
support devices that have a wide variety of media and hardware
characteristics. So I don't see pure deallocate going away. Doesn't mean
that I am not pushing vendors to handle (3) because I think it is very
important. And why we defined WRITE ZEROES in the first place.

-- 
Martin K. Petersen	Oracle Linux Engineering

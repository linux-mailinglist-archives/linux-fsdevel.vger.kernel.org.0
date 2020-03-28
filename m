Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10CB4196A19
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Mar 2020 00:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgC1Xrd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Mar 2020 19:47:33 -0400
Received: from mgw-02.mpynet.fi ([82.197.21.91]:37298 "EHLO mgw-02.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgC1Xrd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Mar 2020 19:47:33 -0400
X-Greylist: delayed 1751 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Mar 2020 19:47:32 EDT
Received: from pps.filterd (mgw-02.mpynet.fi [127.0.0.1])
        by mgw-02.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 02SNIJbS057325;
        Sun, 29 Mar 2020 01:18:19 +0200
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-02.mpynet.fi with ESMTP id 301u51ruas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 29 Mar 2020 01:18:19 +0200
Received: from tuxera-exch.ad.tuxera.com (10.20.48.11) by
 tuxera-exch.ad.tuxera.com (10.20.48.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 29 Mar 2020 01:18:19 +0200
Received: from tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789]) by
 tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789%12]) with mapi id
 15.00.1497.006; Sun, 29 Mar 2020 01:18:19 +0200
From:   Anton Altaparmakov <anton@tuxera.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Simon Gander <simon@tuxera.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] hfsplus: Fix crash and filesystem corruption when
 deleting files
Thread-Topic: [PATCH] hfsplus: Fix crash and filesystem corruption when
 deleting files
Thread-Index: AQHWBFBvABHegCrodkyM5KCF6UkTsKhegyeAgAABBQA=
Date:   Sat, 28 Mar 2020 23:18:18 +0000
Message-ID: <3B55501C-2534-45AE-A2A5-D7CB4F89D09A@tuxera.com>
References: <20200327155541.1521-1-simon@tuxera.com>
 <20200328161439.d38f14698fe7b5671eada4a5@linux-foundation.org>
In-Reply-To: <20200328161439.d38f14698fe7b5671eada4a5@linux-foundation.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [109.155.186.24]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E981CF933F29F443BDB2C412463D7E51@ex13.tuxera.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-28_10:2020-03-27,2020-03-28 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003280216
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andrew,

> On 28 Mar 2020, at 23:14, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Fri, 27 Mar 2020 16:55:40 +0100 Simon Gander <simon@tuxera.com> wrote:
>> When removing files containing extended attributes, the hfsplus driver
>> may remove the wrong entries from the attributes b-tree, causing major
>> filesystem damage and in some cases even kernel crashes.
>> 
>> To remove a file, all its extended attributes have to be removed as well.
>> The driver does this by looking up all keys in the attributes b-tree with
>> the cnid of the file. Each of these entries then gets deleted using the
>> key used for searching, which doesn't contain the attribute's name when it
>> should. Since the key doesn't contain the name, the deletion routine will
>> not find the correct entry and instead remove the one in front of it. If
>> parent nodes have to be modified, these become corrupt as well. This causes
>> invalid links and unsorted entries that not even macOS's fsck_hfs is able
>> to fix.
>> 
>> To fix this, modify the search key before an entry is deleted from the
>> attributes b-tree by copying the found entry's key into the search key,
>> therefore ensuring that the correct entry gets removed from the tree.
> 
> This seems fairly important.  Should it have a cc:stable?

It is - that is why we are pushing it upstream.  And yes, I think a cc:stable would be a good idea!

Best regards,

	Anton
-- 
Anton Altaparmakov <anton at tuxera.com> (replace at with @)
Lead in File System Development, Tuxera Inc., http://www.tuxera.com/
Linux NTFS maintainer


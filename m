Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2C0251786
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 13:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbgHYL1X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 07:27:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32988 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729710AbgHYL1U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 07:27:20 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07PB25S6154263;
        Tue, 25 Aug 2020 07:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding : message-id; s=pp1;
 bh=B1qyqojXR92JVqFXYtxyMktWqQiNpvFkxQqCMMDj0/I=;
 b=r8x2763eVN89nimWE4m05z3cNTvGuITti4EpIR3wpBg4kZkndApz/dtKWA/JOx1Qb8HA
 B4+UhE2hgPdkYyB3P7+hPMO+jpETBLFpM2Bn6ciXm/tbontFu9veb3DmrDAqW6SjvI9C
 BuHrEmDa6H0sf2h35mgAxKlx9rFHikOJrMIx81PkiWz6c0yDTU1wKCLATWZ7oej7VrKP
 hKyINj97VtIcm5AahPVboR1X8mUSBs24/HU+zy172C54QYf0fglyLjn6ojqbDzIWgO+g
 JZQFeW1DloT9yI2g//4BstQtjqZ61DQ5xS9I/scSziYJ0nLKqthhuV+aNg3fx0BPrqSU vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 334yt63383-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 07:27:08 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07PB2IjA154798;
        Tue, 25 Aug 2020 07:27:07 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 334yt6336w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 07:27:07 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07PBR55o018249;
        Tue, 25 Aug 2020 11:27:05 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 33498u99ru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 11:27:05 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07PBR3n130146940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 11:27:03 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DCB5AE056;
        Tue, 25 Aug 2020 11:27:03 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D725AE045;
        Tue, 25 Aug 2020 11:27:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.43.157])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Aug 2020 11:27:01 +0000 (GMT)
Subject: Re: [PATCH] iomap: iomap_bmap should accept unwritten maps
To:     Yuxuan Shui <yshuiv7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca
References: <20200505183608.10280-1-yshuiv7@gmail.com>
 <20200505193049.GC5694@magnolia>
 <CAGqt0zzA5NRx+vrcwyekW=Z18BL5CGTuZEBvpRO3vK5rHCBs=A@mail.gmail.com>
 <20200825102040.GA15394@infradead.org>
 <CAGqt0zxoJZrYXS+wp7bwfsajfpaotu02oUy53VkQ5CTGcE_2hA@mail.gmail.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 25 Aug 2020 16:57:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAGqt0zxoJZrYXS+wp7bwfsajfpaotu02oUy53VkQ5CTGcE_2hA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200825112702.0D725AE045@d06av26.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-25_02:2020-08-25,2020-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250079
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/25/20 4:10 PM, Yuxuan Shui wrote:
> Hi,
> 
> On Tue, Aug 25, 2020 at 11:20 AM Christoph Hellwig <hch@infradead.org> wrote:
>>
>> On Tue, Aug 25, 2020 at 10:26:14AM +0100, Yuxuan Shui wrote:
>>> Hi,
>>>
>>> Do we actually want to fix this bug or not? There are a number of
>>> people actually seeing this bug.
>>
>> bmap should not succeed for unwritten extents.
> 
> Why not? Unwritten extents are still allocated extents.
> 
>>
>>> If you think this is not the right fix, what do you think we should
>>> do? If the correct fix is to make ext4 use iomap_swapfile_activate,
>>> maybe we should CC the ext4 people too?
>>
>> Yes, ext4 should use iomap_swapfile_activate.
> 
> OK, let me CC the ext4 people.
> 
> Context:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=207585

Thanks for adding ext4 list. Noticed this report for the first time now.
Maybe I missed it from fsdevel. Let me have a look at it.

-ritesh

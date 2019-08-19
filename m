Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7693692509
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 15:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfHSNby (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 09:31:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12116 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727301AbfHSNby (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:31:54 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JDTUXG053502
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2019 09:31:53 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ufuepkms5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2019 09:31:52 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <chandan@linux.ibm.com>;
        Mon, 19 Aug 2019 14:31:50 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 19 Aug 2019 14:31:46 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7JDVjd655574772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Aug 2019 13:31:45 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00B214C040;
        Mon, 19 Aug 2019 13:31:45 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 804964C044;
        Mon, 19 Aug 2019 13:31:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.69.146])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 19 Aug 2019 13:31:42 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, hch@infradead.org, tytso@mit.edu,
        ebiggers@kernel.org, adilger.kernel@dilger.ca,
        chandanrmail@gmail.com, jaegeuk@kernel.org
Subject: Re: [f2fs-dev] [PATCH V4 5/8] f2fs: Use read_callbacks for decrypting file data
Date:   Mon, 19 Aug 2019 19:03:23 +0530
Organization: IBM
In-Reply-To: <bb3dc624-1249-2418-f9da-93da8c11e7f5@kernel.org>
References: <20190816061804.14840-1-chandan@linux.ibm.com> <20190816061804.14840-6-chandan@linux.ibm.com> <bb3dc624-1249-2418-f9da-93da8c11e7f5@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 19081913-0020-0000-0000-000003615D4C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081913-0021-0000-0000-000021B6895A
Message-Id: <20104514.oSSJcvNEEM@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190153
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sunday, August 18, 2019 7:15:42 PM IST Chao Yu wrote:
> Hi Chandan,
> 
> On 2019-8-16 14:18, Chandan Rajendra wrote:
> > F2FS has a copy of "post read processing" code using which encrypted
> > file data is decrypted. This commit replaces it to make use of the
> > generic read_callbacks facility.
> 
> I remember that previously Jaegeuk had mentioned f2fs will support compression
> later, and it needs to reuse 'post read processing' fwk.
> 
> There is very initial version of compression feature in below link:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/log/?h=compression
> 
> So my concern is how can we uplift the most common parts of this fwk into vfs,
> and meanwhile keeping the ability and flexibility when introducing private
> feature/step in specified filesytem(now f2fs)?
> 
> According to current f2fs compression's requirement, maybe we can expand to
> 
> - support callback to let filesystem set the function for the flow in
> decompression/verity/decryption step.
> - support to use individual/common workqueue according the parameter.
> 
> Any thoughts?
>

Hi,

F2FS can be made to use fscrypt's queue for decryption and hence can reuse
"read callbacks" code for decrypting data.

For decompression, we could have a STEP_MISC where we invoke a FS provided
callback function for FS specific post read processing? 

Something like the following can be implemented in read_callbacks(),
	  case STEP_MISC:
		  if (ctx->enabled_steps & (1 << STEP_MISC)) {
			  /*
			    ctx->fs_misc() must process bio in a workqueue
			    and later invoke read_callbacks() with
			    bio->bi_private's value as an argument.
			  */
			  ctx->fs_misc(ctx->bio);
			  return;
		  }
		  ctx->cur_step++;

The fs_misc() callback can be passed in by the filesystem when invoking
read_callbacks_setup_bio().

-- 
chandan




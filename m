Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD2A14917
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2019 13:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbfEFLkP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 07:40:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60212 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725852AbfEFLkP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 07:40:15 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x46Be2CO047899
        for <linux-fsdevel@vger.kernel.org>; Mon, 6 May 2019 07:40:14 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sah6tqrgp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 May 2019 07:40:09 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <chandan@linux.ibm.com>;
        Mon, 6 May 2019 12:33:36 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 May 2019 12:33:33 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x46BXWb446465208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 May 2019 11:33:32 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CA04AE056;
        Mon,  6 May 2019 11:33:32 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20D5FAE04D;
        Mon,  6 May 2019 11:33:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.70.42])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 May 2019 11:33:30 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/13] fscrypt: clean up some BUG_ON()s in block encryption/decryption
Date:   Mon, 06 May 2019 13:54:45 +0530
Organization: IBM
In-Reply-To: <20190501224515.43059-5-ebiggers@kernel.org>
References: <20190501224515.43059-1-ebiggers@kernel.org> <20190501224515.43059-5-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 19050611-4275-0000-0000-00000331DF52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050611-4276-0000-0000-000038414613
Message-Id: <4366146.XrkeSAOiMl@dhcp-9-109-212-164>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-06_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=581 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905060103
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday, May 2, 2019 4:15:06 AM IST Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Replace some BUG_ON()s with WARN_ON_ONCE() and returning an error code,
> and move the check for len divisible by FS_CRYPTO_BLOCK_SIZE into
> fscrypt_crypt_block() so that it's done for both encryption and
> decryption, not just encryption.

Looks good to me,

Reviewed-by: Chandan Rajendra <chandan@linux.ibm.com>

-- 
chandan




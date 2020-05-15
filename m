Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A955C1D59E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 21:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgEOTXA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 15:23:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50840 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726183AbgEOTXA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 15:23:00 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04FJ3j20036564;
        Fri, 15 May 2020 15:22:54 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 310t9pysxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 May 2020 15:22:53 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04FJKYwo032716;
        Fri, 15 May 2020 19:22:52 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3100ub65j1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 May 2020 19:22:51 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04FJMnhF10092974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 May 2020 19:22:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D1C44C046;
        Fri, 15 May 2020 19:22:49 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A1674C04E;
        Fri, 15 May 2020 19:22:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.153.130])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 15 May 2020 19:22:48 +0000 (GMT)
Message-ID: <1589570568.5111.46.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/2] fs: avoid fdput() after failed fdget() in
 kernel_read_file_from_fd()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Shuah Khan <skhan@linuxfoundation.org>, viro@zeniv.linux.org.uk,
        axboe@kernel.dk, zohar@linux.vnet.ibm.com, mcgrof@kernel.org,
        keescook@chromium.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 15 May 2020 15:22:48 -0400
In-Reply-To: <62659de2dbf32e8c05cff7fe09f6efd24cfaf445.1589411496.git.skhan@linuxfoundation.org>
References: <cover.1589411496.git.skhan@linuxfoundation.org>
         <62659de2dbf32e8c05cff7fe09f6efd24cfaf445.1589411496.git.skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-15_07:2020-05-15,2020-05-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=981 phishscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 cotscore=-2147483648 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 clxscore=1011 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005150155
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-05-13 at 17:33 -0600, Shuah Khan wrote:
> Fix kernel_read_file_from_fd() to avoid fdput() after a failed fdget().
> fdput() doesn't do fput() on this file since FDPUT_FPUT isn't set
> in fd.flags. Fix it anyway since failed fdget() doesn't require
> a fdput().
> 
> This was introduced in a commit that added kernel_read_file_from_fd() as
> a wrapper for the VFS common kernel_read_file().
> 
> Fixes: b844f0ecbc56 ("vfs: define kernel_copy_file_from_fd()")
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks, Shuah.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

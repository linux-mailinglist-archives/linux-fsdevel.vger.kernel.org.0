Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FE144C613
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 18:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbhKJRmZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 12:42:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230230AbhKJRmY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 12:42:24 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AAHCQ7w011648;
        Wed, 10 Nov 2021 17:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=DsmJTDmYa8Ou29XXykXIjUTIY5EdNVZGfdayt//X1SI=;
 b=IFU9TaKB+ZFGGaz6licffK4uHbty8THDCH7Hj6LC2KcUFOvKhWeVl5ijW/nXY9Zztive
 5JHCmDUTBUl/a6jIdq0AaCwW7rufgDwdYjGsulZcDVebI9WkwJv7ipBJvOn8edDyeBpc
 YmcDaTUl/GKz16efuq2ZrL9Jjqn39Tmv5gVra+k8b+6wdckFm64N7QoEQEZ1jB3Jr9pd
 7ten2aXSudrLibS2toDXj4kPQs+OlNq4dvbACnUuj2LzMD7ZTVwyJ1y5vBLmaKUePhVn
 tuVfPWapNlQXhARmn9hYGJ4f4F5cMkiX4dDqnssskovEa2UKwgyrc2iYzLfj0N57bDj7 2A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c8j9e0qtv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Nov 2021 17:39:35 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AAHCs5L014537;
        Wed, 10 Nov 2021 17:39:35 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c8j9e0qt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Nov 2021 17:39:35 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AAHXqCp005851;
        Wed, 10 Nov 2021 17:39:32 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3c5gykb91t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Nov 2021 17:39:32 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AAHWpE751315172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 17:32:51 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7557D52050;
        Wed, 10 Nov 2021 17:39:30 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.122.189])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7024F52087;
        Wed, 10 Nov 2021 17:39:29 +0000 (GMT)
Message-ID: <6213c2f886637f824b14c67de7f9534349417b49.camel@linux.ibm.com>
Subject: Re: [RFC PATCH] ima: differentiate overlay, pivot_root, and other
 pathnames
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Michael Peters <michael00peters@gmail.com>
Cc:     amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu
Date:   Wed, 10 Nov 2021 12:39:28 -0500
In-Reply-To: <CAJQqANe-SFvPEEQcQrGUsn9n1aFybCOQaofvnmS+qZGvnNh7nQ@mail.gmail.com>
References: <CAJQqANe-SFvPEEQcQrGUsn9n1aFybCOQaofvnmS+qZGvnNh7nQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bzOCqSqLSHHbM0ebbLhv52CMp5eObhbZ
X-Proofpoint-GUID: G5MeeHsLaLTk7BHMG7xNU-B0ujXzhGA3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-10_06,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501
 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111100087
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-11-10 at 10:28 -0500, Michael Peters wrote:

> This looks good, but would be even better if the flag that controlled
> this was settable in the ima_policy. That's much easier to work with
> in a lot of DevOps toolchains and pipelines and is similar to how the
> other ima configuration is done.

Thanks, Michael.  Agreed, which is one of the reasons for posting this
patch as an RFC.  The other reason is that it is an incomplete
solution, since it doesn't address mount namespaces.  Any suggestions
for addressing mount namespaces would be appreciated. Assuming there is
a benefit for a partial solution, I'll add the per policy rule support.

thanks,

Mimi


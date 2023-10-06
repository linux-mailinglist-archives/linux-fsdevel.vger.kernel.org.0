Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577D17BB863
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 15:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjJFNBR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 09:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjJFNBD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:01:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFAC10F0;
        Fri,  6 Oct 2023 06:00:28 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 396Cm2Yi027588;
        Fri, 6 Oct 2023 13:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=bYY3YhVBnbQhx5HFvODLAVARQ2hrt7AtExXhXmnuCmc=;
 b=UvfJBi6twavdh6VuM7py0/MJogO2UoNLGYDznpZNJONODZ+/AHltUs0x3gwUUrtZ6htV
 nKbs4yuMoDZQ7HqFDygGvx4hnPUDAq5L9fnZOexfKNHXtjcr604QsqS+Srh3YcKP8MPo
 4em9dQsifQzZf05XPwoFFTH9M6g9XgQJXY58RHyS79aen2v6hP/h3fzUucO3uoJ8ZFws
 5Pk1uny+5g3bkCDtuERkI8IJj/t88v9pXVXZV1ZpEqnEd43UbLdWXPpANV8LyIITTkeU
 NzCJZbgirM9HBxVn2gF5TfbFrmNCmRsTGKDJZJLCq9CGG9UP6YI0IQqLgNYkwP9m/mRy Og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tjjj70fn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 13:00:25 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 396CmiNE029118;
        Fri, 6 Oct 2023 12:59:11 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tjjj70dum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 12:59:11 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 396Co7oo010941;
        Fri, 6 Oct 2023 12:54:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tf0q32wes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 12:54:06 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 396Cs4eH65470872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Oct 2023 12:54:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95EDF20040;
        Fri,  6 Oct 2023 12:54:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 731662004B;
        Fri,  6 Oct 2023 12:54:04 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  6 Oct 2023 12:54:04 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Test failure from "file: convert to SLAB_TYPESAFE_BY_RCU"
References: <00e5cc23-a888-46ce-8789-fc182a2131b0@sirena.org.uk>
        <yt9dil7k151d.fsf@linux.ibm.com> <ZR//+QDRI3sBpqY4@f>
Date:   Fri, 06 Oct 2023 14:54:04 +0200
In-Reply-To: <ZR//+QDRI3sBpqY4@f> (Mateusz Guzik's message of "Fri, 6 Oct 2023
        14:39:21 +0200")
Message-ID: <yt9d4jj3zzbn.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 71RIwD2D7PaWMMg9nMWSBGc6cV0z4AY0
X-Proofpoint-GUID: Y-SGr6yrQUi3vyfhwUSYbiM_p6srS_3k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_10,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=579
 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310060096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mateusz Guzik <mjguzik@gmail.com> writes:

> On Fri, Oct 06, 2023 at 11:19:58AM +0200, Sven Schnelle wrote:
>> I'm seeing the same with the strace test-suite on s390. The problem is
>> that /proc/*/fd now contains the file descriptors of the calling
>> process, and not the target process.
>> 
>
> This is why:
>
> +static inline struct file *files_lookup_fdget_rcu(struct files_struct *files, unsigned int fd)
> +{
> +       RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
> +                        "suspicious rcu_dereference_check() usage");
> +       return lookup_fdget_rcu(fd);
> +}
>
> files argument is now thrown away, instead it always uses current.

Yes, passing files to lookup_fdget_rcu() fixes the issue.

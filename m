Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8036248D753
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 13:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbiAMMRe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 07:17:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5920 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232859AbiAMMRd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:17:33 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20DBxS7W016291;
        Thu, 13 Jan 2022 12:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=9aPU+stAVNBLD4l18gFpeDNu8lWn5ruJ8jdovoj7DjY=;
 b=gpZyAiNxrTgTJRUCXQIxGMnU5l23EMwCLXWGd2hsbf5WYK+SV3dcQ8IR8HpetqzwDlmg
 9+fRdmnwdg4lLDvDeZpuOcXsyuCoT69JVVvFt1zE/TAaKbbUZOhMld8Gjj9Y1PdCd2qG
 xSl6pA0ix1d8vZgMdRWdyUm6CpnbV8Caf0iIsbu5uZw0nzHwmMLSfFth1IH14RyWDpVa
 r5FlopY3Nw2s/pwchASynoL5KLpaVcNrZ5ddwlI9RWcuR0jiBYD3N2MYgUZzvxNVqnWQ
 s3ksBKi8ho55QASRBtrzlAIoJG+Qb8UnmSL+AlrL9jsZ9CY6HunKLMuAqt/D9gwo+HSn +g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3djkpdrbr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 12:17:27 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20DC9kOS027389;
        Thu, 13 Jan 2022 12:17:27 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3djkpdrbqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 12:17:27 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20DCCHwn022191;
        Thu, 13 Jan 2022 12:17:25 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3df28a45t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 12:17:25 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20DC8HJb44958108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 12:08:17 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE7954C052;
        Thu, 13 Jan 2022 12:17:22 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62CE24C046;
        Thu, 13 Jan 2022 12:17:22 +0000 (GMT)
Received: from localhost (unknown [9.43.54.234])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Jan 2022 12:17:22 +0000 (GMT)
Date:   Thu, 13 Jan 2022 17:47:21 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, tytso@mit.edu,
        Eric Whitney <enwlinux@gmail.com>
Subject: Re: [PATCH 5/6] jbd2: Refactor wait logic for transaction updates
 into a common function
Message-ID: <20220113121721.nyn7kdmr6boaazvp@riteshh-domain>
References: <cover.1642044249.git.riteshh@linux.ibm.com>
 <95fa94cbeb4bb0275430a6721a588bd738d5a9aa.1642044249.git.riteshh@linux.ibm.com>
 <20220113113051.5ehxl2ap3v64eyya@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113113051.5ehxl2ap3v64eyya@quack3.lan>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6uWLuj5I2dF1xXvNSG00zmpRusw9winC
X-Proofpoint-GUID: oECPVMpELi1QaZM75eOM1n1l1knGAp_B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_04,2022-01-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 suspectscore=0 mlxlogscore=724 lowpriorityscore=0
 clxscore=1015 adultscore=0 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201130073
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/01/13 12:30PM, Jan Kara wrote:
> On Thu 13-01-22 08:56:28, Ritesh Harjani wrote:
> > No functionality change as such in this patch. This only refactors the
> > common piece of code which waits for t_updates to finish into a common
> > function named as jbd2_journal_wait_updates(journal_t *)
> >
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>
> Just one nit, otherwise. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> > @@ -1757,6 +1757,35 @@ static inline unsigned long jbd2_log_space_left(journal_t *journal)
> >  	return max_t(long, free, 0);
> >  }
> >
> > +/*
> > + * Waits for any outstanding t_updates to finish.
> > + * This is called with write j_state_lock held.
> > + */
> > +static inline void jbd2_journal_wait_updates(journal_t *journal)
> > +{
> > +	transaction_t *commit_transaction = journal->j_running_transaction;
> > +
> > +	if (!commit_transaction)
> > +		return;
> > +
> > +	spin_lock(&commit_transaction->t_handle_lock);
> > +	while (atomic_read(&commit_transaction->t_updates)) {
> > +		DEFINE_WAIT(wait);
> > +
> > +		prepare_to_wait(&journal->j_wait_updates, &wait,
> > +					TASK_UNINTERRUPTIBLE);
> > +		if (atomic_read(&commit_transaction->t_updates)) {
> > +			spin_unlock(&commit_transaction->t_handle_lock);
> > +			write_unlock(&journal->j_state_lock);
> > +			schedule();
> > +			write_lock(&journal->j_state_lock);
> > +			spin_lock(&commit_transaction->t_handle_lock);
> > +		}
> > +		finish_wait(&journal->j_wait_updates, &wait);
> > +	}
> > +	spin_unlock(&commit_transaction->t_handle_lock);
> > +}
> > +
>
> I don't think making this inline makes sence. Neither the commit code nor
> jbd2_journal_lock_updates() are so hot that it would warrant this large
> inline function...

Yes, make sense. Thanks for the review.
Will do the needful in v2.

-ritesh

>
> 								Honza
>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

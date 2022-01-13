Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F34648D819
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 13:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbiAMMi6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 07:38:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51442 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232900AbiAMMi5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:38:57 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20DCT15d015119;
        Thu, 13 Jan 2022 12:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=D7+ZKGdHs7N8lXUJv5riuyYwvPvtWC0CcxPd3Kx/t2M=;
 b=CjkjQEHzRIKn+FO/5EdM4KNrEIU72bxQZIW4c83MlLCdqn/5gs2hgVe5oAiK1+EYMrNs
 nmRG8p67kPFapLB65MOJd+KVFn+t2aCQya/T8I3tI7z2PhcfgOwzkN2q6ylFmPtOOi2L
 XO5fnQHXuwUUHArrP46CCfyGo9oR3iZq/Fz/J2DqJyqMVV9zS940ma4u3LHqd9aFupRE
 aliC8Cxs6YALIZNLy9RG4XdWmn4bieY9MjVKB/GQZ2oxH22iZUX1gwg/tQOKu61HN3rF
 bFpEySVE+UFDDf4lRfV4arEaQgY+MOyOmX8RVuhBF8Uv8JU9LCk6kTSqkkIMdW2BBif1 Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3djjbxj89w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 12:38:49 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20DCUXAf024113;
        Thu, 13 Jan 2022 12:38:48 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3djjbxj89d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 12:38:48 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20DCcIwD031705;
        Thu, 13 Jan 2022 12:38:46 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3df1vjmhdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 12:38:46 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20DCciuB45613526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 12:38:44 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B869A406E;
        Thu, 13 Jan 2022 12:38:44 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 940F8A4065;
        Thu, 13 Jan 2022 12:38:43 +0000 (GMT)
Received: from localhost (unknown [9.43.54.234])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Jan 2022 12:38:43 +0000 (GMT)
Date:   Thu, 13 Jan 2022 18:08:42 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, tytso@mit.edu,
        Eric Whitney <enwlinux@gmail.com>
Subject: Re: [PATCH 6/6] jbd2: No need to use t_handle_lock in
 jbd2_journal_wait_updates
Message-ID: <20220113123842.3rpfcyecylt5n3wo@riteshh-domain>
References: <cover.1642044249.git.riteshh@linux.ibm.com>
 <e7e0f8c54306591a3a9c8fead1e0e54358052ab6.1642044249.git.riteshh@linux.ibm.com>
 <20220113112749.d5tfszcksvxvshnn@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113112749.d5tfszcksvxvshnn@quack3.lan>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6Cn2v6OG7A4s6QRjewK07qtJCT-HNgvi
X-Proofpoint-GUID: S08JEU3Z0S9v0cMSbxsI7xEy65BB9m0d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_04,2022-01-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201130075
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/01/13 12:27PM, Jan Kara wrote:
> On Thu 13-01-22 08:56:29, Ritesh Harjani wrote:
> > Since jbd2_journal_wait_updates() uses waitq based on t_updates atomic_t
> > variable. So from code review it looks like we don't need to use
> > t_handle_lock spinlock for checking t_updates value.
> > Hence this patch gets rid of the spinlock protection in
> > jbd2_journal_wait_updates()
> >
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>
> This patch looks good. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> Actually looking at it, t_handle_lock seems to be very much unused. I agree

I too had this thought in mind. Thanks for taking a deeper look into it :)

>
> we don't need it when waiting for outstanding handles but the only
> remaining uses are:
>
> 1) jbd2_journal_extend() where it is not needed either - we use
> atomic_add_return() to manipulate t_outstanding_credits and hold
> j_state_lock for reading which provides us enough exclusion.
>
> 2) update_t_max_wait() - this is the only valid use of t_handle_lock but we
> can just switch it to cmpxchg loop with a bit of care. Something like:
>
> 	unsigned long old;
>
> 	ts = jbd2_time_diff(ts, transaction->t_start);
> 	old = transaction->t_max_wait;
> 	while (old < ts)
> 		old = cmpxchg(&transaction->t_max_wait, old, ts);
>
> So perhaps you can add two more patches to remove other t_handle_lock uses
> and drop it completely.

Thanks for providing the details Jan :)
Agree with jbd2_journal_extend(). I did looked a bit around t_max_wait and
I agree that something like above could work. I will spend some more time around
that code and will submit those changes together in v2.

-ritesh

>
> 								Honza
>
> > ---
> >  include/linux/jbd2.h | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> > index 34b051aa9009..9bef47622b9d 100644
> > --- a/include/linux/jbd2.h
> > +++ b/include/linux/jbd2.h
> > @@ -1768,22 +1768,18 @@ static inline void jbd2_journal_wait_updates(journal_t *journal)
> >  	if (!commit_transaction)
> >  		return;
> >
> > -	spin_lock(&commit_transaction->t_handle_lock);
> >  	while (atomic_read(&commit_transaction->t_updates)) {
> >  		DEFINE_WAIT(wait);
> >
> >  		prepare_to_wait(&journal->j_wait_updates, &wait,
> >  					TASK_UNINTERRUPTIBLE);
> >  		if (atomic_read(&commit_transaction->t_updates)) {
> > -			spin_unlock(&commit_transaction->t_handle_lock);
> >  			write_unlock(&journal->j_state_lock);
> >  			schedule();
> >  			write_lock(&journal->j_state_lock);
> > -			spin_lock(&commit_transaction->t_handle_lock);
> >  		}
> >  		finish_wait(&journal->j_wait_updates, &wait);
> >  	}
> > -	spin_unlock(&commit_transaction->t_handle_lock);
> >  }
> >
> >  /*
> > --
> > 2.31.1
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C926E4822
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 14:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjDQMp6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 08:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjDQMp5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:45:57 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8E1E6;
        Mon, 17 Apr 2023 05:45:55 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HCh8uY022220;
        Mon, 17 Apr 2023 12:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Me3xl4OpCSeGXaMuaTCLA7+/DYZluuE1PRxzYqFhpEg=;
 b=ETbjwJmLvWd2Op/GmOgktP8anNkCO8a0bH3soeywbbpx2eE2YgUySA6EGFyxRzON6HRz
 9YjfKGEj43rfjaTo/JAU75GdS0WtudD9HGE/gnGklBumcVLAOu5vR8iBzGVcRIANEpvn
 HqdDTneTt54nfvSVXCvuLxWvsmLVyAr12n2N9RgytSVpiVFo9C3ywd+KyfJnQ0T1/87H
 7pT4XM70OZuyFWkTWceyb70bNd9SvY5ehfus3QE+HJAxvxNZh251eKc+aDWUYUoW3OUI
 nnbx9nMZPjVtzg7QnGYSO5t2w7juxTrbLdlTSht5PnVQHSBoBlm/nDqXgueQH+lDBIYJ Tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q13jtvpky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 12:45:44 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33HCaUxV003374;
        Mon, 17 Apr 2023 12:45:44 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q13jtvpkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 12:45:44 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33HBo8Ve015441;
        Mon, 17 Apr 2023 12:45:43 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3pykj72vx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 12:45:43 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33HCjgAm15467250
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Apr 2023 12:45:42 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09EE658062;
        Mon, 17 Apr 2023 12:45:42 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C48D75803F;
        Mon, 17 Apr 2023 12:45:40 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 17 Apr 2023 12:45:40 +0000 (GMT)
Message-ID: <176640ae-3ff7-c3e9-218a-2952425336e7@linux.ibm.com>
Date:   Mon, 17 Apr 2023 08:45:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM after
 writes
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
 <90a25725b4b3c96e84faefdb827b261901022606.camel@kernel.org>
 <e2455c0e-5a17-7fc1-95e3-5f2aca2eb409@linux.ibm.com>
 <94c2aadfb2fe7830d0289ffe6084581b99505a58.camel@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <94c2aadfb2fe7830d0289ffe6084581b99505a58.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 85Q8tAJWRbLCXkztfuFx5wGoC_6DRp6r
X-Proofpoint-GUID: M7pTikFpMhcOf2yCNYob2HPnxFymdJ7z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_07,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 suspectscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=989 mlxscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304170113
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/17/23 06:05, Jeff Layton wrote:
> On Sun, 2023-04-16 at 21:57 -0400, Stefan Berger wrote:
>>
>> On 4/7/23 09:29, Jeff Layton wrote:

>>>
>>> Note that there Stephen is correct that calling getattr is probably
>>> going to be less efficient here since we're going to end up calling
>>> generic_fillattr unnecessarily, but I still think it's the right thing
>>> to do.
>>
>> I was wondering whether to use the existing inode_eq_iversion() for all
>> other filesystems than overlayfs, nfs, and possibly other ones (which ones?)
>> where we would use the vfs_getattr_nosec() via a case on inode->i_sb->s_magic?
>> If so, would this function be generic enough to be a public function for libfs.c?
>>
>> I'll hopefully be able to test the proposed patch tomorrow.
>>
>>
> 
> No, you don't want to use inode_eq_iversion here because (as the comment
> over it says):

In the ima_check_last_writer() case the usage of inode_eq_iversion() was correct since
at this point no record of  its value was made and therefore no writer needed to change
the i_value again due to IMA:

		update = test_and_clear_bit(IMA_UPDATE_XATTR,
					    &iint->atomic_flags);
		if (!IS_I_VERSION(inode) ||
		    !inode_eq_iversion(inode, iint->version) ||
		    (iint->flags & IMA_NEW_FILE)) {
			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
			iint->measured_pcrs = 0;
			if (update)
				ima_update_xattr(iint, file);
		}

The record of the value is only made when the actual measurement is done in
ima_collect_measurement()

Compared to this the usage of vfs_getattr_nosec() is expensive since it resets the flag.

         if ((request_mask & STATX_CHANGE_COOKIE) && IS_I_VERSION(inode)) {
                 stat->result_mask |= STATX_CHANGE_COOKIE;
                 stat->change_cookie = inode_query_iversion(inode);
         }

	idmap = mnt_idmap(path->mnt);
	if (inode->i_op->getattr)
		return inode->i_op->getattr(idmap, path, stat,
					    request_mask, query_flags);

Also, many filesystems will have their getattr now called as well.

I understand Christian's argument about the maintenance headache to a certain degree...

    Stefan

> 
>   * Note that we don't need to set the QUERIED flag in this case, as the value
>   * in the inode is not being recorded for later use.
> 
> The IMA code _does_ record the value for later use. Furthermore, it's
> not valid to use inode_eq_iversion on a non-IS_I_VERSION inode, so it's
> better to just use vfs_getattr_nosec which allows IMA to avoid all of
> those gory details.
> 
> Thanks,

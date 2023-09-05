Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CD8792EEC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 21:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243086AbjIETcT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 15:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239175AbjIETcR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:32:17 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFE3AC;
        Tue,  5 Sep 2023 12:31:49 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385JNS3C014223;
        Tue, 5 Sep 2023 19:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cYk2QJV1wTG0qdIaOxYgpGZ8rWOSG7NYLsW6ayRd4tU=;
 b=EbeWeemQ5nLajlVIvAVvRuNgzY5RtK+ugHoXXg7Lr8OlYVCb7UlPkqy3PnjacoqyCtJj
 OGXa3JBJ/V9NwlpgwYYvOixWmqljVb+3yHFm2XIFEAhdQM2paM8YfZmZNrRbCHdTRl1I
 x6N62feT6NkEk6eMEVzqLvt36Vxmj56clRvKzlDaIodbb9n+P3Ok8/qXvtgeVHwDdnWf
 ifMr9prgzkx/3q0g+G2DqU9PZgiQHLrZI0zmEvFVqoRDbpvNoB3YXg+Li07e+OAdoTUg
 1zfH4fUemgpsdxt5edlACgEItRw+Oe5hz1lcRpyRw4oYUK/RB22imXyH0lgtWPEwUOt/ Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxaeug910-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 19:30:52 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 385JOJoh018216;
        Tue, 5 Sep 2023 19:30:51 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxaeug8vw-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 19:30:51 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 385ICcTS021478;
        Tue, 5 Sep 2023 19:04:55 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svfrydcee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 19:04:54 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 385J4sUE39584198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Sep 2023 19:04:54 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F2B058056;
        Tue,  5 Sep 2023 19:04:54 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 986465803F;
        Tue,  5 Sep 2023 19:04:52 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  5 Sep 2023 19:04:52 +0000 (GMT)
Message-ID: <4cb6a1f1-571a-8fdd-2a1c-716e46b5edc6@linux.ibm.com>
Date:   Tue, 5 Sep 2023 15:04:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 20/25] security: Introduce key_post_create_or_update
 hook
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
 <20230904134049.1802006-1-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230904134049.1802006-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mraNSwh95jIqrzx1EUzNY4K2xmRAFPnw
X-Proofpoint-GUID: MJCoqjLEf_RJgpklwBRHEDHVVeLOB0UL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050166
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 9/4/23 09:40, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the key_post_create_or_update hook.
>
> It is useful for IMA to measure the key content after creation or update,
> so that remote verifiers are aware of the operation.
>
> LSMs can benefit from this hook to make their decision on the new or
> successfully updated key content. The new hook cannot return an error and
> cannot cause the operation to be reverted.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   include/linux/lsm_hook_defs.h |  3 +++
>   include/linux/security.h      | 11 +++++++++++
>   security/keys/key.c           |  7 ++++++-
>   security/security.c           | 19 +++++++++++++++++++
>   4 files changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index eedc26790a07..7512b4c46aa8 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -399,6 +399,9 @@ LSM_HOOK(void, LSM_RET_VOID, key_free, struct key *key)
>   LSM_HOOK(int, 0, key_permission, key_ref_t key_ref, const struct cred *cred,
>   	 enum key_need_perm need_perm)
>   LSM_HOOK(int, 0, key_getsecurity, struct key *key, char **buffer)
> +LSM_HOOK(void, LSM_RET_VOID, key_post_create_or_update, struct key *keyring,
> +	 struct key *key, const void *payload, size_t payload_len,
> +	 unsigned long flags, bool create)
>   #endif /* CONFIG_KEYS */
>   
>   #ifdef CONFIG_AUDIT
> diff --git a/include/linux/security.h b/include/linux/security.h
> index e543ae80309b..f50b78481753 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1959,6 +1959,9 @@ void security_key_free(struct key *key);
>   int security_key_permission(key_ref_t key_ref, const struct cred *cred,
>   			    enum key_need_perm need_perm);
>   int security_key_getsecurity(struct key *key, char **_buffer);
> +void security_key_post_create_or_update(struct key *keyring, struct key *key,
> +					const void *payload, size_t payload_len,
> +					unsigned long flags, bool create);
>   
>   #else
>   
> @@ -1986,6 +1989,14 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
>   	return 0;
>   }
>   
> +static inline void security_key_post_create_or_update(struct key *keyring,
> +						      struct key *key,
> +						      const void *payload,
> +						      size_t payload_len,
> +						      unsigned long flags,
> +						      bool create)
> +{ }
> +
>   #endif
>   #endif /* CONFIG_KEYS */
>   
> diff --git a/security/keys/key.c b/security/keys/key.c
> index 5c0c7df833f8..0f9c6faf3491 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -934,6 +934,8 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
>   		goto error_link_end;
>   	}
>   
> +	security_key_post_create_or_update(keyring, key, payload, plen, flags,
> +					   true);
>   	ima_post_key_create_or_update(keyring, key, payload, plen,
>   				      flags, true);
>   
> @@ -967,10 +969,13 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
>   
>   	key_ref = __key_update(key_ref, &prep);
>   
> -	if (!IS_ERR(key_ref))
> +	if (!IS_ERR(key_ref)) {
> +		security_key_post_create_or_update(keyring, key, payload, plen,
> +						   flags, false);
>   		ima_post_key_create_or_update(keyring, key,
>   					      payload, plen,
>   					      flags, false);
> +	}
>   
>   	goto error_free_prep;
>   }
> diff --git a/security/security.c b/security/security.c
> index 554f4925323d..957e53ba904f 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -5169,6 +5169,25 @@ int security_key_getsecurity(struct key *key, char **buffer)
>   	*buffer = NULL;
>   	return call_int_hook(key_getsecurity, 0, key, buffer);
>   }
> +
> +/**
> + * security_key_post_create_or_update() - Notification of key create or update
> + * @keyring: keyring to which the key is linked to
> + * @key: created or updated key
> + * @payload: data used to instantiate or update the key
> + * @payload_len: length of payload
> + * @flags: key flags
> + * @create: flag indicating whether the key was created or updated
> + *
> + * Notify the caller of a key creation or update.
> + */
> +void security_key_post_create_or_update(struct key *keyring, struct key *key,
> +					const void *payload, size_t payload_len,
> +					unsigned long flags, bool create)
> +{
> +	call_void_hook(key_post_create_or_update, keyring, key, payload,
> +		       payload_len, flags, create);
> +}
>   #endif	/* CONFIG_KEYS */
>   
>   #ifdef CONFIG_AUDIT


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>



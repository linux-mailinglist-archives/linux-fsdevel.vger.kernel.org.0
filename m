Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046D23BF931
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jul 2021 13:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhGHLn0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jul 2021 07:43:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48411 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231575AbhGHLnZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jul 2021 07:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625744443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OnBGurHzEmnbPIJjNhwa4TPwnm7svYBq0xSh3uzR7V0=;
        b=ae0ec9G/nWcc5DCFCsueVxC/Tl+VILHIQULZSitIWeTdqXv/TEPn5ZU0lplh9CBD0sxKfy
        KbWQR1v60riatTorcC/XC4Bb4vOhyrVSwvHS7uqnSl6lNaJsbRDKDLh87shyQKtJvUUGZc
        vaqLThs1iuQYDndwA4C1YdCftQUAz2g=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-rsgYSQ8XMHOCJf68NiVVQA-1; Thu, 08 Jul 2021 07:40:42 -0400
X-MC-Unique: rsgYSQ8XMHOCJf68NiVVQA-1
Received: by mail-pj1-f69.google.com with SMTP id n1-20020a17090a5a81b02901725317619dso3612752pji.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jul 2021 04:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OnBGurHzEmnbPIJjNhwa4TPwnm7svYBq0xSh3uzR7V0=;
        b=YxehPv0HlrWwZ7vX/ayYt50iU0eR5tkVnkP9K1E1r8p9XANLTBrWmbnUgrK4WV5fXU
         giYLujBEBHNQ00DEQjdhxDU5wdiWSRH4DwVApTX2Mt37kVsoJkYD5i8jzyYe8pzxDIRg
         aRTzz7wcDOcyuf2a0d3S3QAjwYX2fDlbhRk/6C0JvKC96z6oZ9995aRCuNIwlu9zCk+m
         ABOtPHrzs35wY/TvwqVakj+homhnpZv13ovwLjeyCPbtEYXNtKQ0TzPH19H+7ffauzPN
         6MvAl8bRxXVaRkhv9GUEUx87bRuE7hmisb510NBX+RFEmlIOWq9ZW4UhMhTmeBlZ486T
         p1YA==
X-Gm-Message-State: AOAM530/5xl6b6CKCNoaIRr2tqNL46DhWjse68rFUz/YUGvJjPKnUKzr
        wRhfREI7l0rTO/U5Xp7i6O7uumz9OCuSHHtVgumB4zfCHBCzuviof+cBD0lh14bHHIQnzHkHb1o
        mZ5yJl/GLrgWAJbt7mYwqs7qJaQ==
X-Received: by 2002:a62:8603:0:b029:31c:5cb3:ca2e with SMTP id x3-20020a6286030000b029031c5cb3ca2emr25385842pfd.1.1625743968504;
        Thu, 08 Jul 2021 04:32:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBogfvoG+8Oy4irpgiG8MLVSyJ6kI9ca/rjsIT7mg6LSRyLnpX5fOuGnBNh9jozvnNwCx82g==
X-Received: by 2002:a62:8603:0:b029:31c:5cb3:ca2e with SMTP id x3-20020a6286030000b029031c5cb3ca2emr25385819pfd.1.1625743968166;
        Thu, 08 Jul 2021 04:32:48 -0700 (PDT)
Received: from [10.72.12.57] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l20sm9586711pjq.24.2021.07.08.04.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 04:32:47 -0700 (PDT)
Subject: Re: [RFC PATCH v7 12/24] ceph: add fscrypt ioctls
To:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
Cc:     lhenriques@suse.de, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, dhowells@redhat.com
References: <20210625135834.12934-1-jlayton@kernel.org>
 <20210625135834.12934-13-jlayton@kernel.org>
 <912b5949-ae85-f093-0f23-0650aad606fc@redhat.com>
 <63ed309073c0d57cdb1a02ea43c566fd3d4116b9.camel@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <33776a62-e6ba-b0db-fcc8-3462d62a1439@redhat.com>
Date:   Thu, 8 Jul 2021 19:32:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <63ed309073c0d57cdb1a02ea43c566fd3d4116b9.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 7/8/21 7:26 PM, Jeff Layton wrote:
> On Thu, 2021-07-08 at 15:30 +0800, Xiubo Li wrote:
>> On 6/25/21 9:58 PM, Jeff Layton wrote:
>>> We gate most of the ioctls on MDS feature support. The exception is the
>>> key removal and status functions that we still want to work if the MDS's
>>> were to (inexplicably) lose the feature.
>>>
>>> For the set_policy ioctl, we take Fcx caps to ensure that nothing can
>>> create files in the directory while the ioctl is running. That should
>>> be enough to ensure that the "empty_dir" check is reliable.
>>>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>    fs/ceph/ioctl.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 83 insertions(+)
>>>
>>> diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
>>> index 6e061bf62ad4..477ecc667aee 100644
>>> --- a/fs/ceph/ioctl.c
>>> +++ b/fs/ceph/ioctl.c
>>> @@ -6,6 +6,7 @@
>>>    #include "mds_client.h"
>>>    #include "ioctl.h"
>>>    #include <linux/ceph/striper.h>
>>> +#include <linux/fscrypt.h>
>>>    
>>>    /*
>>>     * ioctls
>>> @@ -268,8 +269,54 @@ static long ceph_ioctl_syncio(struct file *file)
>>>    	return 0;
>>>    }
>>>    
>>> +static int vet_mds_for_fscrypt(struct file *file)
>>> +{
>>> +	int i, ret = -EOPNOTSUPP;
>>> +	struct ceph_mds_client	*mdsc = ceph_sb_to_mdsc(file_inode(file)->i_sb);
>>> +
>>> +	mutex_lock(&mdsc->mutex);
>>> +	for (i = 0; i < mdsc->max_sessions; i++) {
>>> +		struct ceph_mds_session *s = mdsc->sessions[i];
>>> +
>>> +		if (!s)
>>> +			continue;
>>> +		if (test_bit(CEPHFS_FEATURE_ALTERNATE_NAME, &s->s_features))
>>> +			ret = 0;
>>> +		break;
>>> +	}
>>> +	mutex_unlock(&mdsc->mutex);
>>> +	return ret;
>>> +}
>>> +
>>> +static long ceph_set_encryption_policy(struct file *file, unsigned long arg)
>>> +{
>>> +	int ret, got = 0;
>>> +	struct inode *inode = file_inode(file);
>>> +	struct ceph_inode_info *ci = ceph_inode(inode);
>>> +
>>> +	ret = vet_mds_for_fscrypt(file);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	/*
>>> +	 * Ensure we hold these caps so that we _know_ that the rstats check
>>> +	 * in the empty_dir check is reliable.
>>> +	 */
>>> +	ret = ceph_get_caps(file, CEPH_CAP_FILE_SHARED, 0, -1, &got);
>> In the commit comment said it will host the Fsx, but here it is only
>> trying to hold the Fs. Will the Fx really needed ?
>>
> No. What we're interested in here is that the directory remains empty
> while we're encrypting it. If we hold Fs caps, then no one else can
> modify the directory, so this is enough to ensure that.

Yeah, this is what I thought.

Thanks


>>
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = fscrypt_ioctl_set_policy(file, (const void __user *)arg);
>>> +	if (got)
>>> +		ceph_put_cap_refs(ci, got);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>>    long ceph_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>>>    {
>>> +	int ret;
>>> +
>>>    	dout("ioctl file %p cmd %u arg %lu\n", file, cmd, arg);
>>>    	switch (cmd) {
>>>    	case CEPH_IOC_GET_LAYOUT:
>>> @@ -289,6 +336,42 @@ long ceph_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>>>    
>>>    	case CEPH_IOC_SYNCIO:
>>>    		return ceph_ioctl_syncio(file);
>>> +
>>> +	case FS_IOC_SET_ENCRYPTION_POLICY:
>>> +		return ceph_set_encryption_policy(file, arg);
>>> +
>>> +	case FS_IOC_GET_ENCRYPTION_POLICY:
>>> +		ret = vet_mds_for_fscrypt(file);
>>> +		if (ret)
>>> +			return ret;
>>> +		return fscrypt_ioctl_get_policy(file, (void __user *)arg);
>>> +
>>> +	case FS_IOC_GET_ENCRYPTION_POLICY_EX:
>>> +		ret = vet_mds_for_fscrypt(file);
>>> +		if (ret)
>>> +			return ret;
>>> +		return fscrypt_ioctl_get_policy_ex(file, (void __user *)arg);
>>> +
>>> +	case FS_IOC_ADD_ENCRYPTION_KEY:
>>> +		ret = vet_mds_for_fscrypt(file);
>>> +		if (ret)
>>> +			return ret;
>>> +		return fscrypt_ioctl_add_key(file, (void __user *)arg);
>>> +
>>> +	case FS_IOC_REMOVE_ENCRYPTION_KEY:
>>> +		return fscrypt_ioctl_remove_key(file, (void __user *)arg);
>>> +
>>> +	case FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS:
>>> +		return fscrypt_ioctl_remove_key_all_users(file, (void __user *)arg);
>>> +
>>> +	case FS_IOC_GET_ENCRYPTION_KEY_STATUS:
>>> +		return fscrypt_ioctl_get_key_status(file, (void __user *)arg);
>>> +
>>> +	case FS_IOC_GET_ENCRYPTION_NONCE:
>>> +		ret = vet_mds_for_fscrypt(file);
>>> +		if (ret)
>>> +			return ret;
>>> +		return fscrypt_ioctl_get_nonce(file, (void __user *)arg);
>>>    	}
>>>    
>>>    	return -ENOTTY;


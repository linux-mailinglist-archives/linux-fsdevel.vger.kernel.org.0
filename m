Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 440EA1573E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 03:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfEGBXk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 21:23:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40690 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEGBXk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 21:23:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id u17so7705516pfn.7;
        Mon, 06 May 2019 18:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=S2cRcGKJfAAsHZOe9gweZp9eHEagiwXIabFs3M+jIXs=;
        b=ruDazUs6KICBAsFaSMF2UArudnFzhpTkyPfOhrkkZSrU27ChGOn+19M8AB1hIladCj
         ljBu6QX//oEyyvBo5pkB9hN0Q702j7kXoUfbHjdYDmmiIDH2SqxzEUkqYHjlWhVr30vX
         D6YUYY0LNlll0Mnsn1CrUdvkL6agTs/UuSZwvggRJgENRrTJfznUXIDdwoXz/SvLti4C
         2EJGxAf8It786MeNjqdvSi16aa8PPDmSKZKbKa/v73RfmOA09p9Zmc4NZrrYDb/navht
         cfAfwmMTemMrM/NKYKdZVpiqkLe6EJtjf6g36obL8dMuR6zwsg7o8/Nj7LHPBNeMdSgO
         vDnQ==
X-Gm-Message-State: APjAAAXYeACXqh/4tAfu2KtTZBTlB1PzlicMer3OM+HN9SlHaVL7pa5i
        Licd8QOkSsANmD/YB7plWp3blugP
X-Google-Smtp-Source: APXvYqxrlpxOexLO2gc+nDwdaf/2Dt6Zm8NCC6uTNDoz8opdiglNffBOSAQvLp8lWgWnbVnHWBb3nw==
X-Received: by 2002:a65:6554:: with SMTP id a20mr36982558pgw.284.1557192219168;
        Mon, 06 May 2019 18:23:39 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id o2sm26530518pgq.1.2019.05.06.18.23.36
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 18:23:37 -0700 (PDT)
Subject: Re: [RFC PATCH 3/4] fscrypt: wire up fscrypt to use blk-crypto
To:     Satya Tangirala <satyat@google.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Parshuram Raju Thombare <pthombar@cadence.com>,
        Ladvine D Almeida <ladvine.dalmeida@synopsys.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>
References: <20190506223544.195371-1-satyat@google.com>
 <20190506223544.195371-4-satyat@google.com>
From:   Bart Van Assche <bvanassche@acm.org>
Openpgp: preference=signencrypt
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <daa7c452-0f73-67e7-7a9a-55499372cc0d@acm.org>
Date:   Mon, 6 May 2019 18:23:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506223544.195371-4-satyat@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/6/19 3:35 PM, Satya Tangirala wrote:
[ ... ]
> diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
> index 7da276159593..d6d65c88a629 100644
> --- a/fs/crypto/fscrypt_private.h
> +++ b/fs/crypto/fscrypt_private.h
> @@ -49,6 +49,16 @@ struct fscrypt_symlink_data {
>  	char encrypted_path[1];
>  } __packed;
>  
> +/* Master key referenced by FS_POLICY_FLAG_DIRECT_KEY policy */
> +struct fscrypt_master_key {
> +	struct hlist_node mk_node;
> +	refcount_t mk_refcount;
> +	const struct fscrypt_mode *mk_mode;
> +	struct crypto_skcipher *mk_ctfm;
> +	u8 mk_descriptor[FS_KEY_DESCRIPTOR_SIZE];
> +	u8 mk_raw[FS_MAX_KEY_SIZE];
> +};
> [ ... ]
> -/* Master key referenced by FS_POLICY_FLAG_DIRECT_KEY policy */
> -struct fscrypt_master_key {
> -	struct hlist_node mk_node;
> -	refcount_t mk_refcount;
> -	const struct fscrypt_mode *mk_mode;
> -	struct crypto_skcipher *mk_ctfm;
> -	u8 mk_descriptor[FS_KEY_DESCRIPTOR_SIZE];
> -	u8 mk_raw[FS_MAX_KEY_SIZE];
> -};

How about introducing the file fs/crypto/fscrypt_private.h in patch 2/4
such that the fscrypt_master_key definition does not have to be moved
around?

Thanks,

Bart.

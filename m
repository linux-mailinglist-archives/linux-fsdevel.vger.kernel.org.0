Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33B76156F4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 02:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfEGAhc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 20:37:32 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45102 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfEGAhc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 20:37:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id a5so2272289pls.12;
        Mon, 06 May 2019 17:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=v6zUI+3e5Ng+OCg16P1F5C9DE8X8QyIm8rrrvjAJQCI=;
        b=QAxjzj6NF34kzEixpM35XrvZFHXb5Agpu343+xUnT7UkCMQBVn6UWZUWJzw9273yOq
         Gpc1izRkAF6o2RVYroHZqPoM3j50lVq4OImfHO8QMNg1zz4yftpDf6bh6K+kDMPhw/h0
         KPGgLaJ/azwaQyV3lRAjXqR8kfhhOraykqMSBgp0ZJI6A0MQmBA1X/kjuXSFhJTAuG+A
         ZLA9a7mGxsZeZ2q/J30GeGOMtXDIZQnxGy9kRVDkVr+upXl9ZWwKDQwelb+vUtNwwUv2
         tZtMIfG+zLnQ5i+/c5wFuwbaRgaB1eOaGrhie3Pl54LzMcQTyJho0p2MumYB8AcU6WKP
         nngA==
X-Gm-Message-State: APjAAAVOZYLRiPC8Mixfeozk/W5e3cEJAxehJtp1+sBKlm9DPsNuqclu
        k3z7P2EkvpR4I1g++EHtYGE=
X-Google-Smtp-Source: APXvYqwu/rQCdyYSa6ypfeRG3t1ilYUiuwGDR3EY3lXe8HsmcfW8Q3GF4DO0EwJCUmnB3Um7puZUCg==
X-Received: by 2002:a17:902:324:: with SMTP id 33mr28434997pld.284.1557189450787;
        Mon, 06 May 2019 17:37:30 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id q14sm3590408pgg.10.2019.05.06.17.37.29
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 17:37:29 -0700 (PDT)
Subject: Re: [RFC PATCH 1/4] block: Block Layer changes for Inline Encryption
 Support
To:     Satya Tangirala <satyat@google.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Parshuram Raju Thombare <pthombar@cadence.com>,
        Ladvine D Almeida <ladvine.dalmeida@synopsys.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>
References: <20190506223544.195371-1-satyat@google.com>
 <20190506223544.195371-2-satyat@google.com>
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
Message-ID: <8d44c89f-cc61-9324-adaa-a343f2373556@acm.org>
Date:   Mon, 6 May 2019 17:37:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506223544.195371-2-satyat@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/6/19 3:35 PM, Satya Tangirala wrote:
> +#ifdef CONFIG_BLK_CRYPT_CTX
> +static inline void bio_crypt_advance(struct bio *bio, unsigned int bytes)
> +{
> +	if (bio_is_encrypted(bio)) {
> +		bio->bi_crypt_context.data_unit_num +=
> +			bytes >> bio->bi_crypt_context.data_unit_size_bits;
> +	}
> +}
> +
> +void bio_clone_crypt_context(struct bio *dst, struct bio *src)
> +{
> +	if (bio_crypt_swhandled(src))
> +		return;
> +	dst->bi_crypt_context = src->bi_crypt_context;
> +
> +	if (!bio_crypt_has_keyslot(src))
> +		return;
> +
> +	/**

Please use "/*" to start comment blocks other than kernel-doc headers.

> +	 * This should always succeed because the src bio should already
> +	 * have a reference to the keyslot.
> +	 */
> +	BUG_ON(!keyslot_manager_get_slot(src->bi_crypt_context.processing_ksm,
> +					  src->bi_crypt_context.keyslot));

Are you aware that using BUG_ON() if there is a reasonable way to
recover is not acceptable?

> +}
> +
> +bool bio_crypt_should_process(struct bio *bio, struct request_queue *q)
> +{
> +	if (!bio_is_encrypted(bio))
> +		return false;
> +
> +	WARN_ON(!bio_crypt_has_keyslot(bio));
> +	return q->ksm == bio->bi_crypt_context.processing_ksm;
> +}
> +EXPORT_SYMBOL(bio_crypt_should_process);
> +
> +#endif /* CONFIG_BLK_CRYPT_CTX */

Please move these new functions into a separate source file instead of
using #ifdef / #endif. I think the coding style documentation mentions
this explicitly.

> +static struct blk_crypto_keyslot {
> +	struct crypto_skcipher *tfm;
> +	int crypto_alg_id;
> +	union {
> +		u8 key[BLK_CRYPTO_MAX_KEY_SIZE];
> +		u32 key_words[BLK_CRYPTO_MAX_KEY_SIZE/4];
> +	};
> +} *slot_mem;

What is the purpose of the key_words[] member? Is it used anywhere? If
not, can it be left out?

> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 1c9d4f0f96ea..55133c547bdf 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -614,6 +614,59 @@ int blk_rq_map_sg(struct request_queue *q, struct request *rq,
>  }
>  EXPORT_SYMBOL(blk_rq_map_sg);
>  
> +#ifdef CONFIG_BLK_CRYPT_CTX
> +/*
> + * Checks that two bio crypt contexts are compatible - i.e. that
> + * they are mergeable except for data_unit_num continuity.
> + */
> +static inline bool bio_crypt_ctx_compatible(struct bio *b_1, struct bio *b_2)
> +{
> +	struct bio_crypt_ctx *bc1 = &b_1->bi_crypt_context;
> +	struct bio_crypt_ctx *bc2 = &b_2->bi_crypt_context;
> +
> +	if (bio_is_encrypted(b_1) != bio_is_encrypted(b_2) ||
> +	    bc1->keyslot != bc2->keyslot)
> +		return false;
> +
> +	return !bio_is_encrypted(b_1) ||
> +		bc1->data_unit_size_bits == bc2->data_unit_size_bits;
> +}
> +
> +/*
> + * Checks that two bio crypt contexts are compatible, and also
> + * that their data_unit_nums are continuous (and can hence be merged)
> + */
> +static inline bool bio_crypt_ctx_back_mergeable(struct bio *b_1,
> +						unsigned int b1_sectors,
> +						struct bio *b_2)
> +{
> +	struct bio_crypt_ctx *bc1 = &b_1->bi_crypt_context;
> +	struct bio_crypt_ctx *bc2 = &b_2->bi_crypt_context;
> +
> +	if (!bio_crypt_ctx_compatible(b_1, b_2))
> +		return false;
> +
> +	return !bio_is_encrypted(b_1) ||
> +		(bc1->data_unit_num +
> +		(b1_sectors >> (bc1->data_unit_size_bits - 9)) ==
> +		bc2->data_unit_num);
> +}
> +
> +#else /* CONFIG_BLK_CRYPT_CTX */
> +static inline bool bio_crypt_ctx_compatible(struct bio *b_1, struct bio *b_2)
> +{
> +	return true;
> +}
> +
> +static inline bool bio_crypt_ctx_back_mergeable(struct bio *b_1,
> +						unsigned int b1_sectors,
> +						struct bio *b_2)
> +{
> +	return true;
> +}
> +
> +#endif /* CONFIG_BLK_CRYPT_CTX */

Can the above functions be moved into a new file such that the
#ifdef/#endif construct can be avoided?

> +	/* Wait till there is a free slot available */
> +	while (atomic_read(&ksm->num_idle_slots) == 0) {
> +		mutex_unlock(&ksm->lock);
> +		wait_event(ksm->wait_queue,
> +			   (atomic_read(&ksm->num_idle_slots) > 0));
> +		mutex_lock(&ksm->lock);
> +	}

Using an atomic_read() inside code protected by a mutex is suspicious.
Would protecting all ksm->num_idle_slots manipulations with ksm->lock
and making ksm->num_idle_slots a regular integer have a negative
performance impact?

> +struct keyslot_mgmt_ll_ops {
> +	int (*keyslot_program)(void *ll_priv_data, const u8 *key,
> +			       unsigned int data_unit_size,
> +			       /* crypto_alg_id returned by crypto_alg_find */
> +			       unsigned int crypto_alg_id,
> +			       unsigned int slot);
> +	/**
> +	 * Evict key from all keyslots in the keyslot manager.
> +	 * The key, data_unit_size and crypto_alg_id are also passed down
> +	 * so that for e.g. dm layers that have their own keyslot
> +	 * managers can evict keys from the devices that they map over.
> +	 * Returns 0 on success, -errno otherwise.
> +	 */
> +	int (*keyslot_evict)(void *ll_priv_data, unsigned int slot,
> +			     const u8 *key, unsigned int data_unit_size,
> +			     unsigned int crypto_alg_id);
> +	/**
> +	 * Get a crypto_alg_id (used internally by the lower layer driver) that
> +	 * represents the given blk-crypto crypt_mode and data_unit_size. The
> +	 * returned crypto_alg_id will be used in future calls to the lower
> +	 * layer driver (in keyslot_program and keyslot_evict) to reference
> +	 * this crypt_mode, data_unit_size combo. Returns negative error code
> +	 * if a crypt_mode, data_unit_size combo is not supported.
> +	 */
> +	int (*crypto_alg_find)(void *ll_priv_data,
> +			       enum blk_crypt_mode_index crypt_mode,
> +			       unsigned int data_unit_size);
> +	/**
> +	 * Returns the slot number that matches the key,
> +	 * or -ENOKEY if no match found, or negative on error
> +	 */
> +	int (*keyslot_find)(void *ll_priv_data, const u8 *key,
> +			    unsigned int data_unit_size,
> +			    unsigned int crypto_alg_id);
> +};

Have you considered to use kernel-doc format for documenting the members
of the keyslot_mgmt_ll_ops structure?

Thanks,

Bart.

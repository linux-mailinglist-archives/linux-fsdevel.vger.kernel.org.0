Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311E13F6271
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 18:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhHXQMR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 12:12:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31748 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229705AbhHXQMP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629821491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zztC89NUsnI49tBFDzJHfqMcg0PYYsKWW693C6SIn40=;
        b=ROP2AlunAim0vB18DNyFNZufoU3UtiTE8Q6zHhDVrQpv4lZjPoJT9qhGjgWaCIdhr1xaS7
        26uVvrc7J07XNPuAzBlX0bnu89b1PDQeGiV5sL2F09lfntDnguq/gqEnnHMRRm92E8UGka
        19ZySxyawzvV0Np7bxU8ZooiBLhzOZI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-UyJ1Z8nTMby5Nf8cJUE2vA-1; Tue, 24 Aug 2021 12:11:29 -0400
X-MC-Unique: UyJ1Z8nTMby5Nf8cJUE2vA-1
Received: by mail-qk1-f199.google.com with SMTP id b4-20020a3799040000b02903b899a4309cso14615701qke.14
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Aug 2021 09:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=zztC89NUsnI49tBFDzJHfqMcg0PYYsKWW693C6SIn40=;
        b=FAFoHFPH9te9D4Rlws+OhuP5d7VOXt53uDqYyMBMEB+pYTVaeqE1g4d5nsG3kg5Zku
         8D4cxnCTCFEbyAI2g2uFB5jmm5adhB8W0RN4d9pv0S6DUwHzLGsAOWY/Q6PZgjw8U71o
         bhuW+YkYo14LRZ+f1cZ7l0mi6Yri31+dhZqVt1QN3p6w8VPnAbgbg/rhcWwsizeTAQrY
         S5qLwxnfvHIc9Cm9LChYt4mHij5PBPxsT4eDjXQwu/TpYqbiL7G5URNsM/OTckSdGe3g
         yUYc10/hhR3jroBYlJaYv/GQnC6RRL82VJtB0uQKoIoE/Uoe7KU5FCD6nfxMflReTtBf
         IMGw==
X-Gm-Message-State: AOAM533of1kCxGDUvrMJLyfKFFwN2IWDE0EZFD9Qw/AmaoWCwpqbjPZa
        UJJQv27MOqqTBKx0UqSFudLuSEuHOeAShr9Hz4guQLYITpbskIK1hVa1IyWOTR+UFHoKKZ96ZQ7
        SaimqWYtM+KAnthGAUkkFCfzWjg==
X-Received: by 2002:ac8:58ce:: with SMTP id u14mr1640618qta.99.1629821489405;
        Tue, 24 Aug 2021 09:11:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCKqllfX/tvqrWatVeQf20ul8F8guKIBuisU0F+aEkBMrzdmA5+I16yDHMCyu87N39B0rdPQ==
X-Received: by 2002:ac8:58ce:: with SMTP id u14mr1640586qta.99.1629821489175;
        Tue, 24 Aug 2021 09:11:29 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id l13sm11361132qkp.97.2021.08.24.09.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:11:28 -0700 (PDT)
Message-ID: <3d98729b59c2afcad1299a7742211bcdf1598623.camel@redhat.com>
Subject: Re: [PATCH 10/12] fscache: Fix cookie key hashing
From:   Jeff Layton <jlayton@redhat.com>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 24 Aug 2021 12:11:27 -0400
In-Reply-To: <162431201844.2908479.8293647220901514696.stgit@warthog.procyon.org.uk>
References: <162431188431.2908479.14031376932042135080.stgit@warthog.procyon.org.uk>
         <162431201844.2908479.8293647220901514696.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-06-21 at 22:46 +0100, David Howells wrote:
> The current hash algorithm used for hashing cookie keys is really bad,
> producing almost no dispersion (after a test kernel build, ~30000 files
> were split over just 18 out of the 32768 hash buckets).
> 
> Borrow the full_name_hash() hash function into fscache to do the hashing
> for cookie keys and, in the future, volume keys.
> 
> I don't want to use full_name_hash() as-is because I want the hash value to
> be consistent across arches and over time as the hash value produced may
> get used on disk.
> 
> I can also optimise parts of it away as the key will always be a padded
> array of aligned 32-bit words.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 

What happens when this patch encounters a cache that was built before
it? Do you need to couple this with some sort of global cache
invalidation or rehashing event?

>  fs/fscache/cookie.c   |   14 +-------------
>  fs/fscache/internal.h |    2 ++
>  fs/fscache/main.c     |   39 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 42 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
> index ec9bce33085f..2558814193e9 100644
> --- a/fs/fscache/cookie.c
> +++ b/fs/fscache/cookie.c
> @@ -87,10 +87,8 @@ void fscache_free_cookie(struct fscache_cookie *cookie)
>  static int fscache_set_key(struct fscache_cookie *cookie,
>  			   const void *index_key, size_t index_key_len)
>  {
> -	unsigned long long h;
>  	u32 *buf;
>  	int bufs;
> -	int i;
>  
>  	bufs = DIV_ROUND_UP(index_key_len, sizeof(*buf));
>  
> @@ -104,17 +102,7 @@ static int fscache_set_key(struct fscache_cookie *cookie,
>  	}
>  
>  	memcpy(buf, index_key, index_key_len);
> -
> -	/* Calculate a hash and combine this with the length in the first word
> -	 * or first half word
> -	 */
> -	h = (unsigned long)cookie->parent;
> -	h += index_key_len + cookie->type;
> -
> -	for (i = 0; i < bufs; i++)
> -		h += buf[i];
> -
> -	cookie->key_hash = h ^ (h >> 32);
> +	cookie->key_hash = fscache_hash(0, buf, bufs);
>  	return 0;
>  }
>  
> diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
> index 200082cafdda..a49136c63e4b 100644
> --- a/fs/fscache/internal.h
> +++ b/fs/fscache/internal.h
> @@ -74,6 +74,8 @@ extern struct workqueue_struct *fscache_object_wq;
>  extern struct workqueue_struct *fscache_op_wq;
>  DECLARE_PER_CPU(wait_queue_head_t, fscache_object_cong_wait);
>  
> +extern unsigned int fscache_hash(unsigned int salt, unsigned int *data, unsigned int n);
> +
>  static inline bool fscache_object_congested(void)
>  {
>  	return workqueue_congested(WORK_CPU_UNBOUND, fscache_object_wq);
> diff --git a/fs/fscache/main.c b/fs/fscache/main.c
> index c1e6cc9091aa..4207f98e405f 100644
> --- a/fs/fscache/main.c
> +++ b/fs/fscache/main.c
> @@ -93,6 +93,45 @@ static struct ctl_table fscache_sysctls_root[] = {
>  };
>  #endif
>  
> +/*
> + * Mixing scores (in bits) for (7,20):
> + * Input delta: 1-bit      2-bit
> + * 1 round:     330.3     9201.6
> + * 2 rounds:   1246.4    25475.4
> + * 3 rounds:   1907.1    31295.1
> + * 4 rounds:   2042.3    31718.6
> + * Perfect:    2048      31744
> + *            (32*64)   (32*31/2 * 64)
> + */
> +#define HASH_MIX(x, y, a)	\
> +	(	x ^= (a),	\
> +	y ^= x,	x = rol32(x, 7),\
> +	x += y,	y = rol32(y,20),\
> +	y *= 9			)
> +
> +static inline unsigned int fold_hash(unsigned long x, unsigned long y)
> +{
> +	/* Use arch-optimized multiply if one exists */
> +	return __hash_32(y ^ __hash_32(x));
> +}
> +
> +/*
> + * Generate a hash.  This is derived from full_name_hash(), but we want to be
> + * sure it is arch independent and that it doesn't change as bits of the
> + * computed hash value might appear on disk.  The caller also guarantees that
> + * the hashed data will be a series of aligned 32-bit words.
> + */
> +unsigned int fscache_hash(unsigned int salt, unsigned int *data, unsigned int n)
> +{
> +	unsigned int a, x = 0, y = salt;
> +
> +	for (; n; n--) {
> +		a = *data++;
> +		HASH_MIX(x, y, a);
> +	}
> +	return fold_hash(x, y);
> +}
> +
>  /*
>   * initialise the fs caching module
>   */
> 
> 

-- 
Jeff Layton <jlayton@redhat.com>


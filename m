Return-Path: <linux-fsdevel+bounces-6587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C15E3819FEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 14:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3868D1F2299B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 13:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC06374FD;
	Wed, 20 Dec 2023 13:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="qpVzXr/f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sequoia-grove.ad.secure-endpoints.com (sequoia-grove.ad.secure-endpoints.com [208.125.0.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29FF34540
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
	d=auristor.com; s=MDaemon; r=y; t=1703079359; x=1703684159;
	i=jaltman@auristor.com; q=dns/txt; h=Message-ID:Date:
	MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
	References:From:Organization:In-Reply-To:Content-Type:
	Content-Transfer-Encoding; bh=8/6Un6gYYbd+YxpW3ApIitxJxgZHCCKvXI
	9dX8wctdQ=; b=qpVzXr/fNg2Bz9bhlHOORwt0AbvmZaY36UzlUvH2GLkIe/pzMc
	ej0hBxd31U90ty4WULC2Ebfwlwdr8viAFXEFT/1X0cLQ9BasTSnzehILLEBE5Le2
	um7tsxdTvyvDKGfdjxnQiKQwwRU+3wIGMnHxccAXjS1b2S78ZUKu8zuQ8=
X-MDAV-Result: clean
X-MDAV-Processed: sequoia-grove.ad.secure-endpoints.com, Wed, 20 Dec 2023 08:35:59 -0500
Received: from [IPV6:2603:7000:73c:c800:b4b0:7f91:4ad9:4ee] by auristor.com (IPv6:2001:470:1f07:f77:28d9:68fb:855d:c2a5) (MDaemon PRO v23.5.1) 
	with ESMTPSA id md5001003764615.msg; Wed, 20 Dec 2023 08:35:58 -0500
X-Spam-Processed: sequoia-grove.ad.secure-endpoints.com, Wed, 20 Dec 2023 08:35:58 -0500
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7000:73c:c800:b4b0:7f91:4ad9:4ee
X-MDHelo: [IPV6:2603:7000:73c:c800:b4b0:7f91:4ad9:4ee]
X-MDArrival-Date: Wed, 20 Dec 2023 08:35:58 -0500
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=1718724d2e=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: linux-fsdevel@vger.kernel.org
Message-ID: <ad30af13-6389-4be5-9992-30bbebbe1bb3@auristor.com>
Date: Wed, 20 Dec 2023 08:35:48 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] keys, dns: Allow key types (eg. DNS) to be
 reclaimed immediately on expiry
Content-Language: en-US
To: David Howells <dhowells@redhat.com>,
 Markus Suvanto <markus.suvanto@gmail.com>,
 Marc Dionne <marc.dionne@auristor.com>
Cc: linux-afs@lists.infradead.org, keyrings@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Wang Lei <wang840925@gmail.com>, Jeff Layton <jlayton@redhat.com>,
 Steve French <sfrench@us.ibm.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, netdev@vger.kernel.org
References: <20231212144611.3100234-1-dhowells@redhat.com>
 <20231212144611.3100234-4-dhowells@redhat.com>
From: Jeffrey E Altman <jaltman@auristor.com>
Organization: AuriStor, Inc.
In-Reply-To: <20231212144611.3100234-4-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDCFSigsAdded: auristor.com

On 12/12/2023 9:46 AM, David Howells wrote:
> If a key has an expiration time, then when that time passes, the key is
> left around for a certain amount of time before being collected (5 mins by
> default) so that EKEYEXPIRED can be returned instead of ENOKEY.  This is a
> problem for DNS keys because we want to redo the DNS lookup immediately at
> that point.
>
> Fix this by allowing key types to be marked such that keys of that type
> don't have this extra period, but are reclaimed as soon as they expire and
> turn this on for dns_resolver-type keys.  To make this easier to handle,
> key->expiry is changed to be permanent if TIME64_MAX rather than 0.
>
> Furthermore, give such new-style negative DNS results a 10s default expiry
> if no other expiry time is set rather than allowing it to stick around
> indefinitely.  This shouldn't be zero as ls will follow a failing stat call
> immediately with a second with AT_SYMLINK_NOFOLLOW added.
>
> Fixes: 1a4240f4764a ("DNS: Separate out CIFS DNS Resolver code")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Wang Lei <wang840925@gmail.com>
> cc: Jeff Layton <jlayton@redhat.com>
> cc: Steve French <sfrench@us.ibm.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: Jarkko Sakkinen <jarkko@kernel.org>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: linux-afs@lists.infradead.org
> cc: linux-cifs@vger.kernel.org
> cc: linux-nfs@vger.kernel.org
> cc: ceph-devel@vger.kernel.org
> cc: keyrings@vger.kernel.org
> cc: netdev@vger.kernel.org
> ---
>
> Notes:
>      Changes
>      =======
>      ver #3)
>       - Don't add to TIME64_MAX (ie. permanent) when checking expiry time.
>
>   include/linux/key-type.h   |  1 +
>   net/dns_resolver/dns_key.c | 10 +++++++++-
>   security/keys/gc.c         | 31 +++++++++++++++++++++----------
>   security/keys/internal.h   | 11 ++++++++++-
>   security/keys/key.c        | 15 +++++----------
>   security/keys/proc.c       |  2 +-
>   6 files changed, 47 insertions(+), 23 deletions(-)
>
> diff --git a/include/linux/key-type.h b/include/linux/key-type.h
> index 7d985a1dfe4a..5caf3ce82373 100644
> --- a/include/linux/key-type.h
> +++ b/include/linux/key-type.h
> @@ -73,6 +73,7 @@ struct key_type {
>   
>   	unsigned int flags;
>   #define KEY_TYPE_NET_DOMAIN	0x00000001 /* Keys of this type have a net namespace domain */
> +#define KEY_TYPE_INSTANT_REAP	0x00000002 /* Keys of this type don't have a delay after expiring */
>   
>   	/* vet a description */
>   	int (*vet_description)(const char *description);
> diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
> index 01e54b46ae0b..3233f4f25fed 100644
> --- a/net/dns_resolver/dns_key.c
> +++ b/net/dns_resolver/dns_key.c
> @@ -91,6 +91,7 @@ const struct cred *dns_resolver_cache;
>   static int
>   dns_resolver_preparse(struct key_preparsed_payload *prep)
>   {
> +	const struct dns_server_list_v1_header *v1;
>   	const struct dns_payload_header *bin;
>   	struct user_key_payload *upayload;
>   	unsigned long derrno;
> @@ -122,6 +123,13 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
>   			return -EINVAL;
>   		}
>   
> +		v1 = (const struct dns_server_list_v1_header *)bin;
> +		if ((v1->status != DNS_LOOKUP_GOOD &&
> +		     v1->status != DNS_LOOKUP_GOOD_WITH_BAD)) {
> +			if (prep->expiry == TIME64_MAX)
> +				prep->expiry = ktime_get_real_seconds() + 10;

10 seconds is much longer than is needed to ensure that that the result 
is available for
a second stat() from "ls" in response to a failure.   I would be more 
comfortable if this
were one second.


> +		}
> +
>   		result_len = datalen;
>   		goto store_result;
>   	}
> @@ -314,7 +322,7 @@ static long dns_resolver_read(const struct key *key,
>   
>   struct key_type key_type_dns_resolver = {
>   	.name		= "dns_resolver",
> -	.flags		= KEY_TYPE_NET_DOMAIN,
> +	.flags		= KEY_TYPE_NET_DOMAIN | KEY_TYPE_INSTANT_REAP,
>   	.preparse	= dns_resolver_preparse,
>   	.free_preparse	= dns_resolver_free_preparse,
>   	.instantiate	= generic_key_instantiate,
> diff --git a/security/keys/gc.c b/security/keys/gc.c
> index 3c90807476eb..eaddaceda14e 100644
> --- a/security/keys/gc.c
> +++ b/security/keys/gc.c
> @@ -66,6 +66,19 @@ void key_schedule_gc(time64_t gc_at)
>   	}
>   }
>   
> +/*
> + * Set the expiration time on a key.
> + */
> +void key_set_expiry(struct key *key, time64_t expiry)
> +{
> +	key->expiry = expiry;
> +	if (expiry != TIME64_MAX) {
> +		if (!(key->type->flags & KEY_TYPE_INSTANT_REAP))
> +			expiry += key_gc_delay;
> +		key_schedule_gc(expiry);
> +	}
> +}
> +
>   /*
>    * Schedule a dead links collection run.
>    */
> @@ -176,7 +189,6 @@ static void key_garbage_collector(struct work_struct *work)
>   	static u8 gc_state;		/* Internal persistent state */
>   #define KEY_GC_REAP_AGAIN	0x01	/* - Need another cycle */
>   #define KEY_GC_REAPING_LINKS	0x02	/* - We need to reap links */
> -#define KEY_GC_SET_TIMER	0x04	/* - We need to restart the timer */
>   #define KEY_GC_REAPING_DEAD_1	0x10	/* - We need to mark dead keys */
>   #define KEY_GC_REAPING_DEAD_2	0x20	/* - We need to reap dead key links */
>   #define KEY_GC_REAPING_DEAD_3	0x40	/* - We need to reap dead keys */
> @@ -184,21 +196,17 @@ static void key_garbage_collector(struct work_struct *work)
>   
>   	struct rb_node *cursor;
>   	struct key *key;
> -	time64_t new_timer, limit;
> +	time64_t new_timer, limit, expiry;
>   
>   	kenter("[%lx,%x]", key_gc_flags, gc_state);
>   
>   	limit = ktime_get_real_seconds();
> -	if (limit > key_gc_delay)
> -		limit -= key_gc_delay;
> -	else
> -		limit = key_gc_delay;
>   
>   	/* Work out what we're going to be doing in this pass */
>   	gc_state &= KEY_GC_REAPING_DEAD_1 | KEY_GC_REAPING_DEAD_2;
>   	gc_state <<= 1;
>   	if (test_and_clear_bit(KEY_GC_KEY_EXPIRED, &key_gc_flags))
> -		gc_state |= KEY_GC_REAPING_LINKS | KEY_GC_SET_TIMER;
> +		gc_state |= KEY_GC_REAPING_LINKS;
>   
>   	if (test_and_clear_bit(KEY_GC_REAP_KEYTYPE, &key_gc_flags))
>   		gc_state |= KEY_GC_REAPING_DEAD_1;
> @@ -233,8 +241,11 @@ static void key_garbage_collector(struct work_struct *work)
>   			}
>   		}
>   
> -		if (gc_state & KEY_GC_SET_TIMER) {
> -			if (key->expiry > limit && key->expiry < new_timer) {
> +		expiry = key->expiry;
> +		if (expiry != TIME64_MAX) {
> +			if (!(key->type->flags & KEY_TYPE_INSTANT_REAP))
> +				expiry += key_gc_delay;
> +			if (expiry > limit && expiry < new_timer) {
>   				kdebug("will expire %x in %lld",
>   				       key_serial(key), key->expiry - limit);
>   				new_timer = key->expiry;
> @@ -276,7 +287,7 @@ static void key_garbage_collector(struct work_struct *work)
>   	 */
>   	kdebug("pass complete");
>   
> -	if (gc_state & KEY_GC_SET_TIMER && new_timer != (time64_t)TIME64_MAX) {
> +	if (new_timer != TIME64_MAX) {
>   		new_timer += key_gc_delay;
>   		key_schedule_gc(new_timer);
>   	}
> diff --git a/security/keys/internal.h b/security/keys/internal.h
> index 471cf36dedc0..2cffa6dc8255 100644
> --- a/security/keys/internal.h
> +++ b/security/keys/internal.h
> @@ -167,6 +167,7 @@ extern unsigned key_gc_delay;
>   extern void keyring_gc(struct key *keyring, time64_t limit);
>   extern void keyring_restriction_gc(struct key *keyring,
>   				   struct key_type *dead_type);
> +void key_set_expiry(struct key *key, time64_t expiry);
>   extern void key_schedule_gc(time64_t gc_at);
>   extern void key_schedule_gc_links(void);
>   extern void key_gc_keytype(struct key_type *ktype);
> @@ -215,10 +216,18 @@ extern struct key *key_get_instantiation_authkey(key_serial_t target_id);
>    */
>   static inline bool key_is_dead(const struct key *key, time64_t limit)
>   {
> +	time64_t expiry = key->expiry;
> +
> +	if (expiry != TIME64_MAX) {
> +		if (!(key->type->flags & KEY_TYPE_INSTANT_REAP))
> +			expiry += key_gc_delay;
> +		if (expiry <= limit)
> +			return true;
> +	}
> +
>   	return
>   		key->flags & ((1 << KEY_FLAG_DEAD) |
>   			      (1 << KEY_FLAG_INVALIDATED)) ||
> -		(key->expiry > 0 && key->expiry <= limit) ||
>   		key->domain_tag->removed;
>   }
>   
> diff --git a/security/keys/key.c b/security/keys/key.c
> index 0260a1902922..5b10641debd5 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -294,6 +294,7 @@ struct key *key_alloc(struct key_type *type, const char *desc,
>   	key->uid = uid;
>   	key->gid = gid;
>   	key->perm = perm;
> +	key->expiry = TIME64_MAX;
>   	key->restrict_link = restrict_link;
>   	key->last_used_at = ktime_get_real_seconds();
>   
> @@ -463,10 +464,7 @@ static int __key_instantiate_and_link(struct key *key,
>   			if (authkey)
>   				key_invalidate(authkey);
>   
> -			if (prep->expiry != TIME64_MAX) {
> -				key->expiry = prep->expiry;
> -				key_schedule_gc(prep->expiry + key_gc_delay);
> -			}
> +			key_set_expiry(key, prep->expiry);
>   		}
>   	}
>   
> @@ -606,8 +604,7 @@ int key_reject_and_link(struct key *key,
>   		atomic_inc(&key->user->nikeys);
>   		mark_key_instantiated(key, -error);
>   		notify_key(key, NOTIFY_KEY_INSTANTIATED, -error);
> -		key->expiry = ktime_get_real_seconds() + timeout;
> -		key_schedule_gc(key->expiry + key_gc_delay);
> +		key_set_expiry(key, ktime_get_real_seconds() + timeout);
>   
>   		if (test_and_clear_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags))
>   			awaken = 1;
> @@ -723,16 +720,14 @@ struct key_type *key_type_lookup(const char *type)
>   
>   void key_set_timeout(struct key *key, unsigned timeout)
>   {
> -	time64_t expiry = 0;
> +	time64_t expiry = TIME64_MAX;
>   
>   	/* make the changes with the locks held to prevent races */
>   	down_write(&key->sem);
>   
>   	if (timeout > 0)
>   		expiry = ktime_get_real_seconds() + timeout;
> -
> -	key->expiry = expiry;
> -	key_schedule_gc(key->expiry + key_gc_delay);
> +	key_set_expiry(key, expiry);
>   
>   	up_write(&key->sem);
>   }
> diff --git a/security/keys/proc.c b/security/keys/proc.c
> index d0cde6685627..4f4e2c1824f1 100644
> --- a/security/keys/proc.c
> +++ b/security/keys/proc.c
> @@ -198,7 +198,7 @@ static int proc_keys_show(struct seq_file *m, void *v)
>   
>   	/* come up with a suitable timeout value */
>   	expiry = READ_ONCE(key->expiry);
> -	if (expiry == 0) {
> +	if (expiry == TIME64_MAX) {
>   		memcpy(xbuf, "perm", 5);
>   	} else if (now >= expiry) {
>   		memcpy(xbuf, "expd", 5);
>
>

Beyond the default lifetime issue the change looks good to me.

Reviewed-by: Jeffrey Altman <jaltman@auristor.com>




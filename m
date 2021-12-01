Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475DD4646D2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 06:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346764AbhLAFt3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 00:49:29 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:37247 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230497AbhLAFt2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 00:49:28 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0UywY0em_1638337562;
Received: from 30.225.24.24(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UywY0em_1638337562)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 01 Dec 2021 13:46:04 +0800
Message-ID: <bcefb8f2-576a-b3fc-cc29-89808ebfd7c1@linux.alibaba.com>
Date:   Wed, 1 Dec 2021 13:46:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH 44/64] cachefiles: Implement key to filename encoding
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
 <163819640393.215744.15212364106412961104.stgit@warthog.procyon.org.uk>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <163819640393.215744.15212364106412961104.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 11/29/21 10:33 PM, David Howells wrote:

> +/*
> + * turn the raw key into something cooked
> + * - the key may be up to NAME_MAX in length (including the length word)
> + *   - "base64" encode the strange keys, mapping 3 bytes of raw to four of
> + *     cooked
> + *   - need to cut the cooked key into 252 char lengths (189 raw bytes)
> + */
> +bool cachefiles_cook_key(struct cachefiles_object *object)
> +{
> +	const u8 *key = fscache_get_key(object->cookie), *kend;
> +	unsigned char ch;
> +	unsigned int acc, i, n, nle, nbe, keylen = object->cookie->key_len;
> +	unsigned int b64len, len, print, pad;
> +	char *name, sep;
> +
> +	_enter(",%u,%*phN", keylen, keylen, key);
> +
> +	BUG_ON(keylen > NAME_MAX - 3);
> +
> +	print = 1;
> +	for (i = 0; i < keylen; i++) {
> +		ch = key[i];
> +		print &= cachefiles_filecharmap[ch];
> +	}
> +
> +	/* If the path is usable ASCII, then we render it directly */
> +	if (print) {
> +		len = 1 + keylen + 1;
> +		name = kmalloc(len, GFP_KERNEL);
> +		if (!name)
> +			return false;
> +
> +		name[0] = 'D'; /* Data object type, string encoding */
> +		name[1 + keylen] = 0;
> +		memcpy(name + 1, key, keylen);
> +		goto success;
			^
If we goto success from here,

> +	}
> +
> +	/* See if it makes sense to encode it as "hex,hex,hex" for each 32-bit
> +	 * chunk.  We rely on the key having been padded out to a whole number
> +	 * of 32-bit words.
> +	 */
> +	n = round_up(keylen, 4);
> +	nbe = nle = 0;
> +	for (i = 0; i < n; i += 4) {
> +		u32 be = be32_to_cpu(*(__be32 *)(key + i));
> +		u32 le = le32_to_cpu(*(__le32 *)(key + i));
> +
> +		nbe += 1 + how_many_hex_digits(be);
> +		nle += 1 + how_many_hex_digits(le);
> +	}
> +
> +	b64len = DIV_ROUND_UP(keylen, 3);
> +	pad = b64len * 3 - keylen;
> +	b64len = 2 + b64len * 4; /* Length if we base64-encode it */
> +	_debug("len=%u nbe=%u nle=%u b64=%u", keylen, nbe, nle, b64len);
> +	if (nbe < b64len || nle < b64len) {
> +		unsigned int nlen = min(nbe, nle) + 1;
> +		name = kmalloc(nlen, GFP_KERNEL);
> +		if (!name)
> +			return false;
> +		sep = (nbe <= nle) ? 'S' : 'T'; /* Encoding indicator */
> +		len = 0;
> +		for (i = 0; i < n; i += 4) {
> +			u32 x;
> +			if (nbe <= nle)
> +				x = be32_to_cpu(*(__be32 *)(key + i));
> +			else
> +				x = le32_to_cpu(*(__le32 *)(key + i));
> +			name[len++] = sep;
> +			if (x != 0)
> +				len += snprintf(name + len, nlen - len, "%x", x);
> +			sep = ',';
> +		}
> +		goto success;
> +	}
> +
> +	/* We need to base64-encode it */
> +	name = kmalloc(b64len + 1, GFP_KERNEL);
> +	if (!name)
> +		return false;
> +
> +	name[0] = 'E';
> +	name[1] = '0' + pad;
> +	len = 2;
> +	kend = key + keylen;
> +	do {
> +		acc  = *key++;
> +		if (key < kend) {
> +			acc |= *key++ << 8;
> +			if (key < kend)
> +				acc |= *key++ << 16;
> +		}
> +
> +		name[len++] = cachefiles_charmap[acc & 63];
> +		acc >>= 6;
> +		name[len++] = cachefiles_charmap[acc & 63];
> +		acc >>= 6;
> +		name[len++] = cachefiles_charmap[acc & 63];
> +		acc >>= 6;
> +		name[len++] = cachefiles_charmap[acc & 63];
> +	} while (key < kend);
> +
> +success:
> +	name[len] = 0;
	     ^
then it seems that this will cause an out-of-boundary access.


> +	object->d_name = name;
> +	object->d_name_len = len;
> +	_leave(" = %s", object->d_name);
> +	return true;
> +}
> 

-- 
Thanks,
Jeffle

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72043DB4EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 10:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237981AbhG3IL6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 04:11:58 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:18616 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237922AbhG3IL6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 04:11:58 -0400
Received: from [10.0.2.15] ([86.243.172.93])
        by mwinf5d81 with ME
        id bLBr2500S21Fzsu03LBrEA; Fri, 30 Jul 2021 10:11:53 +0200
X-ME-Helo: [10.0.2.15]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 30 Jul 2021 10:11:53 +0200
X-ME-IP: 86.243.172.93
Subject: Re: [PATCH v27 03/10] fs/ntfs3: Add bitmap
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        pali@kernel.org, dsterba@suse.cz, aaptel@suse.com,
        willy@infradead.org, rdunlap@infradead.org, joe@perches.com,
        mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com, kari.argillander@gmail.com,
        oleksandr@natalenko.name
References: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com>
 <20210729134943.778917-4-almaz.alexandrovich@paragon-software.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <33a0225a-7264-ff4c-b48e-d1a1c3d368c4@wanadoo.fr>
Date:   Fri, 30 Jul 2021 10:11:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210729134943.778917-4-almaz.alexandrovich@paragon-software.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Le 29/07/2021 à 15:49, Konstantin Komarov a écrit :
> This adds bitmap
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>   fs/ntfs3/bitfunc.c |  135 ++++
>   fs/ntfs3/bitmap.c  | 1519 ++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 1654 insertions(+)
>   create mode 100644 fs/ntfs3/bitfunc.c
>   create mode 100644 fs/ntfs3/bitmap.c
> 
> diff --git a/fs/ntfs3/bitfunc.c b/fs/ntfs3/bitfunc.c
> new file mode 100644
> index 000000000..2de5faef2
> --- /dev/null
> +++ b/fs/ntfs3/bitfunc.c

[...]

> +bool are_bits_set(const ulong *lmap, size_t bit, size_t nbits)
> +{
> +	u8 mask;
> +	size_t pos = bit & 7;
> +	const u8 *map = (u8 *)lmap + (bit >> 3);
> +
> +	if (pos) {
> +		if (8 - pos >= nbits) {
> +			mask = fill_mask[pos + nbits] & zero_mask[pos];
> +			return !nbits || (*map & mask) == mask;
> +		}
> +
> +		mask = zero_mask[pos];
> +		if ((*map++ & mask) != mask)
> +			return false;
> +		nbits -= 8 - pos;
> +	}
> +
> +	pos = ((size_t)map) & (sizeof(size_t) - 1);
> +	if (pos) {
> +		pos = sizeof(size_t) - pos;
> +		if (nbits >= pos * 8) {
> +			for (nbits -= pos * 8; pos; pos--, map++) {
> +				if (*map != 0xFF)
> +					return false;
> +			}
> +		}
> +	}
> +
> +	for (pos = nbits / BITS_IN_SIZE_T; pos; pos--, map += sizeof(size_t)) {
> +		if (*((size_t *)map) != MINUS_ONE_T)
> +			return false;
> +	}
> +
> +	for (pos = (nbits % BITS_IN_SIZE_T) >> 3; pos; pos--, map++) {
> +		if (*map != 0xFF)
> +			return false;
> +	}
> +
> +	pos = nbits & 7;
> +	if (pos) {
> +		u8 mask = fill_mask[pos];

There is no need to define a new 'mask' variable here, it just shadows 
the already existing one. 'u8' can be removed.

> +
> +		if ((*map & mask) != mask)
> +			return false;
> +	}
> +
> +	// All bits are ones
> +	return true;
> +}
> diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
> new file mode 100644
> index 000000000..32aab0031
> --- /dev/null
> +++ b/fs/ntfs3/bitmap.c

[...]

> +bool wnd_is_used(struct wnd_bitmap *wnd, size_t bit, size_t bits)
> +{
> +	bool ret = false;
> +	struct super_block *sb = wnd->sb;
> +	size_t iw = bit >> (sb->s_blocksize_bits + 3);
> +	u32 wbits = 8 * sb->s_blocksize;
> +	u32 wbit = bit & (wbits - 1);
> +	size_t end;
> +	struct rb_node *n;
> +	struct e_node *e;
> +
> +	if (RB_EMPTY_ROOT(&wnd->start_tree))
> +		goto use_wnd;
> +
> +	end = bit + bits;
> +	n = rb_lookup(&wnd->start_tree, end - 1);
> +	if (!n)
> +		goto use_wnd;
> +
> +	e = rb_entry(n, struct e_node, start.node);
> +	if (e->start.key + e->count.key > bit)
> +		return false;
> +
> +use_wnd:
> +	while (iw < wnd->nwnd && bits) {
> +		u32 tail, op;
> +
> +		if (unlikely(iw + 1 == wnd->nwnd))
> +			wbits = wnd->bits_last;
> +
> +		tail = wbits - wbit;
> +		op = tail < bits ? tail : bits;
> +
> +		if (wnd->free_bits[iw]) {
> +			bool ret;

This 'ret' shadows the one defined above. It looks spurious and could 
certainly be removed.
However is looks safe because...

> +			struct buffer_head *bh = wnd_map(wnd, iw);
> +
> +			if (IS_ERR(bh))
> +				goto out;
> +
> +			ret = are_bits_set((ulong *)bh->b_data, wbit, op);
> +			put_bh(bh);
> +			if (!ret)
> +				goto out;

... if *this* 'ret' is false, the *other* 'ret' is false as well.

> +		}
> +
> +		bits -= op;
> +		wbit = 0;
> +		iw += 1;
> +	}
> +	ret = true;
> +
> +out:
> +	return ret;
> +}

[...]

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0775F431850
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 13:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhJRMBV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 08:01:21 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38858 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhJRMBV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 08:01:21 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 21ECF21A83;
        Mon, 18 Oct 2021 11:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634558349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=14NHL/AFPNU4EGYifUy+LKT20DzlDXKjPDE0omkCDuM=;
        b=K5jxscXMp7Y8RYkmw4VGmk2TRZzq43CDDj2BpfIpj0vLyRKNcI8dhVmmX0m9AgSVgcDWva
        mVEZ5uEE3mABREDRzWa5+CNNrL8kyLSlt+1F9I4ZnAvzSi4cKz/KptfimVOOg/DuMtKD7u
        LGuRCo/FMgnflDeqdxVZ/v8EVV412GA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CDFD813DF5;
        Mon, 18 Oct 2021 11:59:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZtP2LoxhbWFmLAAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 18 Oct 2021 11:59:08 +0000
Subject: Re: [PATCH v11 13/14] btrfs: send: send compressed extents with
 encoded writes
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <cover.1630514529.git.osandov@fb.com>
 <366f92a7ec5a69dc92290dc2cf6e8603f566495c.1630514529.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <58a04b59-a2fb-bd26-606e-6ddf8bd31552@suse.com>
Date:   Mon, 18 Oct 2021 14:59:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <366f92a7ec5a69dc92290dc2cf6e8603f566495c.1630514529.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1.09.21 г. 20:01, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Now that all of the pieces are in place, we can use the ENCODED_WRITE
> command to send compressed extents when appropriate.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Overall looks sane but consider some of the nits below.


<snip>

> +static int send_encoded_extent(struct send_ctx *sctx, struct btrfs_path *path,
> +			       u64 offset, u64 len)
> +{
> +	struct btrfs_root *root = sctx->send_root;
> +	struct btrfs_fs_info *fs_info = root->fs_info;
> +	struct inode *inode;
> +	struct fs_path *p;
> +	struct extent_buffer *leaf = path->nodes[0];
> +	struct btrfs_key key;
> +	struct btrfs_file_extent_item *ei;
> +	u64 block_start;
> +	u64 block_len;
> +	u32 data_offset;
> +	struct btrfs_cmd_header *hdr;
> +	u32 crc;
> +	int ret;
> +
> +	inode = btrfs_iget(fs_info->sb, sctx->cur_ino, root);
> +	if (IS_ERR(inode))
> +		return PTR_ERR(inode);
> +
> +	p = fs_path_alloc();
> +	if (!p) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	ret = begin_cmd(sctx, BTRFS_SEND_C_ENCODED_WRITE);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
> +	if (ret < 0)
> +		goto out;
> +
> +	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
> +	ei = btrfs_item_ptr(leaf, path->slots[0],
> +			    struct btrfs_file_extent_item);
> +	block_start = btrfs_file_extent_disk_bytenr(leaf, ei);

block_start is somewhat ambiguous here, this is just the disk bytenr of
the extent.

> +	block_len = btrfs_file_extent_disk_num_bytes(leaf, ei);

Why is this called block_len when it's just the size in bytes on-disk?

> +
> +	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
> +	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
> +	TLV_PUT_U64(sctx, BTRFS_SEND_A_UNENCODED_FILE_LEN,
> +		    min(key.offset + btrfs_file_extent_num_bytes(leaf, ei) - offset,
> +			len));
> +	TLV_PUT_U64(sctx, BTRFS_SEND_A_UNENCODED_LEN,
> +		    btrfs_file_extent_ram_bytes(leaf, ei));
> +	TLV_PUT_U64(sctx, BTRFS_SEND_A_UNENCODED_OFFSET,
> +		    offset - key.offset + btrfs_file_extent_offset(leaf, ei));
> +	ret = btrfs_encoded_io_compression_from_extent(
> +				btrfs_file_extent_compression(leaf, ei));
> +	if (ret < 0)
> +		goto out;
> +	TLV_PUT_U32(sctx, BTRFS_SEND_A_COMPRESSION, ret);
> +	TLV_PUT_U32(sctx, BTRFS_SEND_A_ENCRYPTION, 0);
> +
> +	ret = put_data_header(sctx, block_len);
> +	if (ret < 0)
> +		goto out;
> +
> +	data_offset = ALIGN(sctx->send_size, PAGE_SIZE);

nit: The whole data_offset warrants a comment here, since send_buf is
now mapped from send_buf_pages, so all the TLV you've put before are
actually stored in the beginning of send_buf_pages, so by doing the
above you ensure the data write begins on a clean page boundary ...

> +	if (data_offset > sctx->send_max_size ||
> +	    sctx->send_max_size - data_offset < block_len) {
> +		ret = -EOVERFLOW;
> +		goto out;
> +	}
> +
> +	ret = btrfs_encoded_read_regular_fill_pages(inode, block_start,
> +						    block_len,
> +						    sctx->send_buf_pages +
> +						    (data_offset >> PAGE_SHIFT));
> +	if (ret)
> +		goto out;
> +
> +	hdr = (struct btrfs_cmd_header *)sctx->send_buf;
> +	hdr->len = cpu_to_le32(sctx->send_size + block_len - sizeof(*hdr));
> +	hdr->crc = 0;
> +	crc = btrfs_crc32c(0, sctx->send_buf, sctx->send_size);
> +	crc = btrfs_crc32c(crc, sctx->send_buf + data_offset, block_len);

... and because of that you can't simply use send_cmd ;(

> +	hdr->crc = cpu_to_le32(crc);
> +
> +	ret = write_buf(sctx->send_filp, sctx->send_buf, sctx->send_size,
> +			&sctx->send_off);
> +	if (!ret) {
> +		ret = write_buf(sctx->send_filp, sctx->send_buf + data_offset,
> +				block_len, &sctx->send_off);
> +	}
> +	sctx->total_send_size += sctx->send_size + block_len;
> +	sctx->cmd_send_size[le16_to_cpu(hdr->cmd)] +=
> +		sctx->send_size + block_len;
> +	sctx->send_size = 0;
> +
> +tlv_put_failure:
> +out:
> +	fs_path_free(p);
> +	iput(inode);
> +	return ret;
> +}
> +
> +static int send_extent_data(struct send_ctx *sctx, struct btrfs_path *path,
> +			    const u64 offset, const u64 len)

nit: Instead of sending around a btrfs_path struct around and
"polluting" callees to deal with the oddities of our btree interface i.e
btrfs_item_ptr et al. Why not refactor the code so that when we know we
are about to send an extent data simply initialize some struct
extent_info with all the necessary data items: extent type, compression
type, based on the extent type properly initialize a size attribute etc
and pass that. Right now you have send_extent_data fiddling with
path->nodes[0], then based on that you either call
send_encoded_inline_extent or send_encoded_extent, instead pass
extent_info to send_extent_data/clone_range and be done with it.


<snip>

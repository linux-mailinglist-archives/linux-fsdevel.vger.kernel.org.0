Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85AC432B19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 02:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbhJSANp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 20:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhJSANp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 20:13:45 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CADC061745
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Oct 2021 17:11:33 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e65so15318165pgc.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Oct 2021 17:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ARK4CV1QCHDnqAC2jNbm2HtT+N4X81UOF1A1BxlVJKw=;
        b=maB/z56EOiViRmDaFOcRjKQXpDVo9UjXlEHFwOKHKijCm06zqz3YUtJKdTr1Xekdtt
         aBBjwhHhYYzsbMyq4bhA4QuLOe1aTzjtf9Av5Pe0bRVNZlQp49rfrHbtoHxnIzCk4VaV
         jpCKQnS0Gm3ypaZDAGgryz5JUO5mJASzSEUaZW2zBdXaOu9GxGHmSSGpYjqoxpm2woaO
         MFEdY2mQt7RmFBeRQl58MzabrIKrt8sE1LCF5DJN4sJoHmn8zoxs0nIo57uVLYnDKKng
         RbbLFLzuSC0za6Buhj9BNbGP82sDHcLL/FubB2H3fqOfbwcR9E0CAZB0IIrKhKb3oodb
         0Mpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ARK4CV1QCHDnqAC2jNbm2HtT+N4X81UOF1A1BxlVJKw=;
        b=5nKGDaHQVyeYjy0ytttjifE3+6fGq5xSMH1KaXiuQsNE4vSQQPYzcmdCx0W+1CGZ8p
         S++ZvyAx6ewagasFPC86MmXWoWGjbeVkCmsgtDDUOsHmuwCRgM1HAtO/QMNBQLHBdEhj
         MgG6hEfnVeLwX2YT5bzJ/LP63Ess0PYC8BRrj0NDexVxbCD+CFsWSPpvRsbwmmQxnODe
         FZZ4OAUZaqsa1elLHjxdjElIispIj6ZKu9+k/4UCcKnZsxnLlT9dHxHhg6wUCVFozJsY
         xqQ678yosgITmlM6n2Up64hnB0dKPNv0S2KE/b+8Oa62vYjGakbZEKOuJSlJJ7PHWDt9
         ddkQ==
X-Gm-Message-State: AOAM530r2eslUKi9mI7xJiLk93dRxwibwTVTtVNMnkPvIXtyxAiKn+aT
        hKzS6BHT0fAU5+YxbZCnJCBQMJCwUf8a9w==
X-Google-Smtp-Source: ABdhPJwkq+JbuAPjxkqH5uajHT8uTqmxVG6G07sGmUpGKjrYBt7MEogonkifl446sTBWnU+MPHfaMQ==
X-Received: by 2002:a63:7119:: with SMTP id m25mr14678645pgc.253.1634602292615;
        Mon, 18 Oct 2021 17:11:32 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:b911])
        by smtp.gmail.com with ESMTPSA id x17sm14004418pfa.209.2021.10.18.17.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 17:11:32 -0700 (PDT)
Date:   Mon, 18 Oct 2021 17:11:30 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v11 13/14] btrfs: send: send compressed extents with
 encoded writes
Message-ID: <YW4NMkw0K4uMrckI@relinquished.localdomain>
References: <cover.1630514529.git.osandov@fb.com>
 <366f92a7ec5a69dc92290dc2cf6e8603f566495c.1630514529.git.osandov@fb.com>
 <58a04b59-a2fb-bd26-606e-6ddf8bd31552@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58a04b59-a2fb-bd26-606e-6ddf8bd31552@suse.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 18, 2021 at 02:59:08PM +0300, Nikolay Borisov wrote:
> 
> 
> On 1.09.21 г. 20:01, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > Now that all of the pieces are in place, we can use the ENCODED_WRITE
> > command to send compressed extents when appropriate.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> 
> Overall looks sane but consider some of the nits below.
> 
> 
> <snip>
> 
> > +static int send_encoded_extent(struct send_ctx *sctx, struct btrfs_path *path,
> > +			       u64 offset, u64 len)
> > +{
> > +	struct btrfs_root *root = sctx->send_root;
> > +	struct btrfs_fs_info *fs_info = root->fs_info;
> > +	struct inode *inode;
> > +	struct fs_path *p;
> > +	struct extent_buffer *leaf = path->nodes[0];
> > +	struct btrfs_key key;
> > +	struct btrfs_file_extent_item *ei;
> > +	u64 block_start;
> > +	u64 block_len;
> > +	u32 data_offset;
> > +	struct btrfs_cmd_header *hdr;
> > +	u32 crc;
> > +	int ret;
> > +
> > +	inode = btrfs_iget(fs_info->sb, sctx->cur_ino, root);
> > +	if (IS_ERR(inode))
> > +		return PTR_ERR(inode);
> > +
> > +	p = fs_path_alloc();
> > +	if (!p) {
> > +		ret = -ENOMEM;
> > +		goto out;
> > +	}
> > +
> > +	ret = begin_cmd(sctx, BTRFS_SEND_C_ENCODED_WRITE);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
> > +	ei = btrfs_item_ptr(leaf, path->slots[0],
> > +			    struct btrfs_file_extent_item);
> > +	block_start = btrfs_file_extent_disk_bytenr(leaf, ei);
> 
> block_start is somewhat ambiguous here, this is just the disk bytenr of
> the extent.
> 
> > +	block_len = btrfs_file_extent_disk_num_bytes(leaf, ei);
> 
> Why is this called block_len when it's just the size in bytes on-disk?

I copied this naming from extent_map since btrfs_encoded_read() was the
reference for this code, but I'll change the naming here.

> > +
> > +	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
> > +	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
> > +	TLV_PUT_U64(sctx, BTRFS_SEND_A_UNENCODED_FILE_LEN,
> > +		    min(key.offset + btrfs_file_extent_num_bytes(leaf, ei) - offset,
> > +			len));
> > +	TLV_PUT_U64(sctx, BTRFS_SEND_A_UNENCODED_LEN,
> > +		    btrfs_file_extent_ram_bytes(leaf, ei));
> > +	TLV_PUT_U64(sctx, BTRFS_SEND_A_UNENCODED_OFFSET,
> > +		    offset - key.offset + btrfs_file_extent_offset(leaf, ei));
> > +	ret = btrfs_encoded_io_compression_from_extent(
> > +				btrfs_file_extent_compression(leaf, ei));
> > +	if (ret < 0)
> > +		goto out;
> > +	TLV_PUT_U32(sctx, BTRFS_SEND_A_COMPRESSION, ret);
> > +	TLV_PUT_U32(sctx, BTRFS_SEND_A_ENCRYPTION, 0);
> > +
> > +	ret = put_data_header(sctx, block_len);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	data_offset = ALIGN(sctx->send_size, PAGE_SIZE);
> 
> nit: The whole data_offset warrants a comment here, since send_buf is
> now mapped from send_buf_pages, so all the TLV you've put before are
> actually stored in the beginning of send_buf_pages, so by doing the
> above you ensure the data write begins on a clean page boundary ...

Yup, I'll add a comment.

> > +	if (data_offset > sctx->send_max_size ||
> > +	    sctx->send_max_size - data_offset < block_len) {
> > +		ret = -EOVERFLOW;
> > +		goto out;
> > +	}
> > +
> > +	ret = btrfs_encoded_read_regular_fill_pages(inode, block_start,
> > +						    block_len,
> > +						    sctx->send_buf_pages +
> > +						    (data_offset >> PAGE_SHIFT));
> > +	if (ret)
> > +		goto out;
> > +
> > +	hdr = (struct btrfs_cmd_header *)sctx->send_buf;
> > +	hdr->len = cpu_to_le32(sctx->send_size + block_len - sizeof(*hdr));
> > +	hdr->crc = 0;
> > +	crc = btrfs_crc32c(0, sctx->send_buf, sctx->send_size);
> > +	crc = btrfs_crc32c(crc, sctx->send_buf + data_offset, block_len);
> 
> ... and because of that you can't simply use send_cmd ;(
> 
> > +	hdr->crc = cpu_to_le32(crc);
> > +
> > +	ret = write_buf(sctx->send_filp, sctx->send_buf, sctx->send_size,
> > +			&sctx->send_off);
> > +	if (!ret) {
> > +		ret = write_buf(sctx->send_filp, sctx->send_buf + data_offset,
> > +				block_len, &sctx->send_off);
> > +	}
> > +	sctx->total_send_size += sctx->send_size + block_len;
> > +	sctx->cmd_send_size[le16_to_cpu(hdr->cmd)] +=
> > +		sctx->send_size + block_len;
> > +	sctx->send_size = 0;
> > +
> > +tlv_put_failure:
> > +out:
> > +	fs_path_free(p);
> > +	iput(inode);
> > +	return ret;
> > +}
> > +
> > +static int send_extent_data(struct send_ctx *sctx, struct btrfs_path *path,
> > +			    const u64 offset, const u64 len)
> 
> nit: Instead of sending around a btrfs_path struct around and
> "polluting" callees to deal with the oddities of our btree interface i.e
> btrfs_item_ptr et al. Why not refactor the code so that when we know we
> are about to send an extent data simply initialize some struct
> extent_info with all the necessary data items: extent type, compression
> type, based on the extent type properly initialize a size attribute etc
> and pass that. Right now you have send_extent_data fiddling with
> path->nodes[0], then based on that you either call
> send_encoded_inline_extent or send_encoded_extent, instead pass
> extent_info to send_extent_data/clone_range and be done with it.

I don't like this for a few reasons:

* An extra "struct extent_info" layer of abstraction would just be extra
  cognitive overhead. I hate having to trace back where the fields in
  some struct came from when it's information that's readily available
  in more well-known data structures.
* send_encoded_inline_extent() (called by send_extent_data()) needs the
  btrfs_path in order to get the inline data anyways.
* clone_range() also already deals with btrfs_paths, so it's not new.

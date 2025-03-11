Return-Path: <linux-fsdevel+bounces-43709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B095CA5C159
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 13:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC883A9599
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 12:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E60253F3B;
	Tue, 11 Mar 2025 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wGDR1m69"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F02250C11
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696528; cv=none; b=CRXO2kbjSP71NNcbcJphgqiAVL75QiYN5id2eumsxmjETHTvML9Bq/+nejz8Jw8/Hqq4xXhNlVQTo9mpYdu2BUEsgkWlOEcdjbgQwBn/U9OUAKuVL5V8euNHXKaLRklTSmJZp2z89EvQNVkA9BNZW1KAkP8kZNE2YG7j0TasPnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696528; c=relaxed/simple;
	bh=p6fe1ptthMjSUOtwZ5GUk9Ay5PH7mcRR/f9UMQePvzY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PmNUP8zpiIE27XU6IvGuoQRh3Sh2BLX+EVlXeyf9o/2GE1QAyzM8P2YuvI1yPxXKeU6pw7gmcYze8xot9JoWCY1SVT///hquXOue8TREYRyjIfS7nH6Etjnmb9Yxw75soJ/QRNXO9R0fP+eL4Y+kB5u+NhBQFF4IXeo7/dNGbDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wGDR1m69; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3913fdd003bso1382093f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 05:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741696525; x=1742301325; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mFLRfux8MEso/Q3dWW34G5XBUg2Wlpf2sZAsvGmTJBk=;
        b=wGDR1m69O35jW2dcjBcB2rxwo43OdCGHV9RKQV/Yj9IW6W+BP34m37GPuG3x+paNMJ
         XXQH29LbQkpc9gFM5GfNyvcfxO21APH9LFJLlUFzaOeqyq5ebQ8BnHRiLHkLdifv671T
         1kg9mzfI4qVDJ5AU3CgKJ8uMHdcS/rw7BNvDSmhcf540pywlP63S6XkRrZVsj/PPSNQ3
         BtrqB4THrcbVCAvQaetuoA65TAzMNRHxSo9u60EVKXENFac5/+kPVQGIRHUU7Z6Od9RC
         SvfvKdQ7/Vr4Yxe7Dmbv159u8vx0dyRGs/9GDF7l7FyEKfB71qYIGaD1lR+l4kjNVxpy
         gU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696525; x=1742301325;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mFLRfux8MEso/Q3dWW34G5XBUg2Wlpf2sZAsvGmTJBk=;
        b=jBVoPzzrGEX1FTBtMb50Oyy4O3CNYy7/HZk2Bzrso2tSx22TbfpaBHm3c9CbOlVj53
         8qxSnBecouglJtCrGMqjtUbt2av1377GHeGsehDZBWsf0fGAetEtYfQpaKHxUYjxhGxv
         OPC540+FWE7GZfsDucHwdnqXpZSm+Dw7Yx+6znAZLJnU49ehmZNpss+2Ijxjy7yMSEJr
         xGLH2quxCSyy2/0tND30fZQlW5xtSd+ALeSHu2mIQJYAHLcbWBER/hTtjyF4d9yEs+TK
         o51R/vpxiOpcfRhCraBtkbFaoTcWC8zmjHiNTitTY0bphCBSJAobSNtGsf3ScI2HHWB6
         WbeA==
X-Forwarded-Encrypted: i=1; AJvYcCUBVAgpBPkmr4sHQKCvzVhCvIWQ+A1YhWC7JiyS2PfmRVD35Ku0XSRzyskHk8562OQj4wU+T1HzRhtT6QZY@vger.kernel.org
X-Gm-Message-State: AOJu0YzA9NqEMMqCrUQ8oSrG1PvLxkzn7rUy3S8hwClWCPTQL68yXOBt
	cjhsCUkPU0L/NZVlldR5LjK2OoJZtSVEJMNeUXAgkPmWPEL679p1GZHyU6R3UpM=
X-Gm-Gg: ASbGncu21t3bDxZs1PTjViujP4is1KAFLWhLwm0CP3VIvTmPmqZ2DxpvORxv6TsZblh
	ZQR7iwNtmruhpGQxGnlWlsVhGlCtJLcVPYnZLRIoPEprw3VRIcRt3ohvSyLANPdYA0u8jXsiTSm
	LP0PfxK5oTgauvQ6gIaG9RKm+RZJ8l9TWoamiOQ4fFJhvA+THdi6We0GnwbZb9GBJy6f4QZBUtW
	B89rQkSzfD3wYGSUrsILL/Yf143ARt8sWRGcLEzHr3v2KAaTi4VJD82AYXBETJkrD58PoNminEM
	6vQuhr/HWQ6GVsOALTPT60AovWv6yM5XmTn0fEpnu08BEDy46w==
X-Google-Smtp-Source: AGHT+IEGuitoAA3I0RaPYJJg4mD9NiHSfRoOrV74yPgVT70D585bPDZ89T6C1L5KYCRhaooalhvfsA==
X-Received: by 2002:a05:6000:1f8e:b0:390:ff84:532b with SMTP id ffacd0b85a97d-3926c3b8b43mr3735543f8f.7.1741696524718;
        Tue, 11 Mar 2025 05:35:24 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43cee67ae5esm99330595e9.33.2025.03.11.05.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:35:24 -0700 (PDT)
Date: Tue, 11 Mar 2025 15:35:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Fabian Frederick <fabf@skynet.be>
Cc: Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org
Subject: [bug report] udf: merge bh free
Message-ID: <cb514af7-bbe0-435b-934f-dd1d7a16d2cd@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Fabian Frederick,

Commit 02d4ca49fa22 ("udf: merge bh free") from Jan 6, 2017
(linux-next), leads to the following Smatch static checker warning:

	fs/udf/namei.c:442 udf_mkdir()
	warn: passing positive error code '(-117),(-28),(-22),(-12),(-5),(-1),1' to 'ERR_PTR'

fs/udf/namei.c
    422 static struct dentry *udf_mkdir(struct mnt_idmap *idmap, struct inode *dir,
    423                                 struct dentry *dentry, umode_t mode)
    424 {
    425         struct inode *inode;
    426         struct udf_fileident_iter iter;
    427         int err;
    428         struct udf_inode_info *dinfo = UDF_I(dir);
    429         struct udf_inode_info *iinfo;
    430 
    431         inode = udf_new_inode(dir, S_IFDIR | mode);
    432         if (IS_ERR(inode))
    433                 return ERR_CAST(inode);
    434 
    435         iinfo = UDF_I(inode);
    436         inode->i_op = &udf_dir_inode_operations;
    437         inode->i_fop = &udf_dir_operations;
    438         err = udf_fiiter_add_entry(inode, NULL, &iter);
    439         if (err) {
    440                 clear_nlink(inode);
    441                 discard_new_inode(inode);
--> 442                 return ERR_PTR(err);

Returning ERR_PTR(1) will lead to an Oops in the caller.

    443         }

The issue is this code from inode_getblk():

fs/udf/inode.c
   787          /*
   788           * Move prev_epos and cur_epos into indirect extent if we are at
   789           * the pointer to it
   790           */
   791          ret = udf_next_aext(inode, &prev_epos, &tmpeloc, &tmpelen, &tmpetype, 0);
   792          if (ret < 0)
   793                  goto out_free;
   794          ret = udf_next_aext(inode, &cur_epos, &tmpeloc, &tmpelen, &tmpetype, 0);
                ^^^^^^^^^^^^^^^^^^^
ret is set here.  It can be a negative error code, zero for EOF or one
on success.

   795          if (ret < 0)
   796                  goto out_free;
   797  
   798          /* if the extent is allocated and recorded, return the block
   799             if the extent is not a multiple of the blocksize, round up */
   800  
   801          if (!isBeyondEOF && etype == (EXT_RECORDED_ALLOCATED >> 30)) {
   802                  if (elen & (inode->i_sb->s_blocksize - 1)) {
   803                          elen = EXT_RECORDED_ALLOCATED |
   804                                  ((elen + inode->i_sb->s_blocksize - 1) &
   805                                   ~(inode->i_sb->s_blocksize - 1));
   806                          iinfo->i_lenExtents =
   807                                  ALIGN(iinfo->i_lenExtents,
   808                                        inode->i_sb->s_blocksize);
   809                          udf_write_aext(inode, &cur_epos, &eloc, elen, 1);
   810                  }
   811                  map->oflags = UDF_BLK_MAPPED;
   812                  map->pblk = udf_get_lb_pblock(inode->i_sb, &eloc, offset);
   813                  goto out_free;

Smatch is concerned that the ret = 1 from this goto out_free gets
propagated back to the caller.

   814          }
   815  


This seems intentional.  The caller has similar code earlier earlier but
it won't be triggered on this path because UDF_MAP_CREATE is set.

   405  static int udf_map_block(struct inode *inode, struct udf_map_rq *map)
   406  {
   407          int ret;
   408          struct udf_inode_info *iinfo = UDF_I(inode);
   409  
   410          if (WARN_ON_ONCE(iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB))
   411                  return -EFSCORRUPTED;
   412  
   413          map->oflags = 0;
   414          if (!(map->iflags & UDF_MAP_CREATE)) {
   415                  struct kernel_lb_addr eloc;
   416                  uint32_t elen;
   417                  sector_t offset;
   418                  struct extent_position epos = {};
   419                  int8_t etype;
   420  
   421                  down_read(&iinfo->i_data_sem);
   422                  ret = inode_bmap(inode, map->lblk, &epos, &eloc, &elen, &offset,
   423                                   &etype);
   424                  if (ret < 0)
   425                          goto out_read;
   426                  if (ret > 0 && etype == (EXT_RECORDED_ALLOCATED >> 30)) {
   427                          map->pblk = udf_get_lb_pblock(inode->i_sb, &eloc,
   428                                                          offset);
   429                          map->oflags |= UDF_BLK_MAPPED;
   430                          ret = 0;
   431                  }
   432  out_read:
   433                  up_read(&iinfo->i_data_sem);
   434                  brelse(epos.bh);
   435  
   436                  return ret;

ret could be either zero or one here.

   437          }

It's unclear what to do...

regards,
dan carpenter


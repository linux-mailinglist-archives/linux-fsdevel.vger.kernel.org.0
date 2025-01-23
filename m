Return-Path: <linux-fsdevel+bounces-39934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 067C5A1A516
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 14:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C781881AB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 13:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C5C20F967;
	Thu, 23 Jan 2025 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="leJ6fV/z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C26026AF5
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737639264; cv=none; b=C6ap1/oVMkYVY8nOhrI1bEPByVrn8OPLFIKLfKwh/sGHrFNGR8refvS3LG219brvQvw8gGtYh5zmo+sHRm6p6FG7VGIpYM+98waFIDdL/AouezOnx5mbIeF+4r6ML5zhzs/vy9y3THGGOJZIlpyYFvhZCRcjvaRRjXnaC9s9AIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737639264; c=relaxed/simple;
	bh=Fl7JCciVWRd7VPcQEIkQkcz+MazJoJKrZDNxq81oq/8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=awXq7O7s34jcuMIifp32P/GyVYuVjuJ0ixho53H8THqgUcnaB45N9oneLQsJurmiVW17GoS7s7rnGOsmMBeFmrk7+49RDmKSbZLxJ14OEZGoTBapDCCC4CF2OIilvk6co7HHBKRAh2koYJMVh5fNn3yUw1NVDCIfbmNz3ipGkVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=leJ6fV/z; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43621d27adeso6099095e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 05:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737639260; x=1738244060; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5AWt1dsVShnvqa44Je6QYqLOjStp2+ar0wS+QmTVOTU=;
        b=leJ6fV/zE4c2Dmn6VK3aGFHFe4h+waHrTscdDNWwrHVeQR0IAsBgKBzHlGTCxW7F8S
         AXRVmiTuteDlmG2jOJGs5qBkBTWjzQcKsHxue61/JfJutNrUU81EVqtCyoqa1FIzKVb3
         ZbJWtEVw8ouAtzqVDlRCmusmMrJl68Zn7c2VLsGfnCFPzC/VNFHASdxfhpIQ2t2OJ6q+
         0rVOUjJMjTRNR45y4bKAPMy18Ie4mrFLyrr1xOYKlAiDlCBvg92b0hX8IPigFbg25xy+
         /cOTeNM5Dm7gUVmdCmgOk/twcFcMY7Jxb6xJu0QNzcPY1eB4dsKJwSA7fk1RHLNFajoS
         43oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737639260; x=1738244060;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5AWt1dsVShnvqa44Je6QYqLOjStp2+ar0wS+QmTVOTU=;
        b=SUuhG62qAhAuOvNbX+rEQ89d+2lM70fGR6hpMX43jDzl3AD45Oh4hufQhkcTO3J8u+
         L4iSdGYnlQ1B/rIanr1yg7NbqDQL/aOZLo3sc2g8E0B50b6fIcoWthzodKDiBnjMkyP6
         stQCc2yll5aHpD39Tt58BU4hZRRk1kCC6dnoQr6zncLBwj6SzMEoNYdRW2eXGZf8NVfL
         0zezVUqddE7T9ySV1hC80eC+3U9kHbO+iCeE41z6OBjwjd+l3FFSLC5bN2Bev34LwVAj
         JtF3BAchnqM+XwfiPKR4eELThzu04FimtNRhEOuyJHOwwbE32LkDgpKNkS0S3nhGLMsc
         Bm1w==
X-Gm-Message-State: AOJu0YyEZEyGxT1QRZAumTVxjwAWQZshxz37cHSHzyIz8VX/HQS+Yyb/
	+4lgSLqelBdP7GOqyrEI+lynHelGccHLNDWrZedh91JCV1arHtAvIgPR/yleDt4=
X-Gm-Gg: ASbGncsDr3mtsOdHuSJNbShOiERzp9YGXjR6+EToJbrz5HR8xctAWrQYBYvp7uPYkMe
	4XfmRwOXQ5YNuFJuoQixzxjPcT0hElXklidBBPA21yRCGXE9qXT1/doZJVQPsVACvbZDaNtMUmz
	TSxdA+Tcd2XLG/cPwRGBAeDeAA/9nXzvG//JpemFfmPXU030CwsNy+4N641cUsbz93Xi9Lm+P8p
	Y2KUMt4UYsVab+mJzR2s29/DHMN8+EGzEbpDSDcnX60G09DHoWNdGO5jVZL2xrEDZ6c66uTueP/
	ymXyT88spQ==
X-Google-Smtp-Source: AGHT+IEH5eHJjLW2cpuECjAWsshZ/oELHazYRsaQGUZ6Q7H7J8k59+7o8XoohGwL0wExV8xeUlo4jQ==
X-Received: by 2002:a05:600c:218b:b0:436:e751:e417 with SMTP id 5b1f17b1804b1-43891919404mr249706455e9.7.1737639260291;
        Thu, 23 Jan 2025 05:34:20 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31ca3f8sm65145425e9.40.2025.01.23.05.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 05:34:19 -0800 (PST)
Date: Thu, 23 Jan 2025 16:34:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: [bug report] fuse: make args->in_args[0] to be always the header
Message-ID: <63469478-559b-4bad-9b0f-82b8d094a428@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Bernd Schubert,

Commit e24b7a3b70ae ("fuse: make args->in_args[0] to be always the
header") from Jan 20, 2025 (linux-next), leads to the following
Smatch static checker warning:

	fs/fuse/dir.c:596 get_create_ext()
	error: buffer overflow 'args->in_args' 3 <= 3

fs/fuse/dax.c
   921  static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
   922                          struct dentry *entry, const char *link)
   923  {
   924          struct fuse_mount *fm = get_fuse_mount(dir);
   925          unsigned len = strlen(link) + 1;
   926          FUSE_ARGS(args);
   927  
   928          args.opcode = FUSE_SYMLINK;
   929          args.in_numargs = 3;

opcode is FUSE_SYMLINK.  in->in_numargs is 3.

   930          fuse_set_zero_arg0(&args);
   931          args.in_args[1].size = entry->d_name.len + 1;
   932          args.in_args[1].value = entry->d_name.name;
   933          args.in_args[2].size = len;
   934          args.in_args[2].value = link;
   935          return create_new_entry(idmap, fm, &args, dir, entry, S_IFLNK);
                                                   ^^^^^

   936  }

fs/fuse/dir.c
   782  static int create_new_entry(struct mnt_idmap *idmap, struct fuse_mount *fm,
   783                              struct fuse_args *args, struct inode *dir,
   784                              struct dentry *entry, umode_t mode)
   785  {
   786          struct fuse_entry_out outarg;
   787          struct inode *inode;
   788          struct dentry *d;
   789          int err;
   790          struct fuse_forget_link *forget;
   791  
   792          if (fuse_is_bad(dir))
   793                  return -EIO;
   794  
   795          forget = fuse_alloc_forget();
   796          if (!forget)
   797                  return -ENOMEM;
   798  
   799          memset(&outarg, 0, sizeof(outarg));
   800          args->nodeid = get_node_id(dir);
   801          args->out_numargs = 1;
   802          args->out_args[0].size = sizeof(outarg);
   803          args->out_args[0].value = &outarg;
   804  
   805          if (args->opcode != FUSE_LINK) {

FUSE_LINK is 13.  FUSE_SYMLINK is 6.

   806                  err = get_create_ext(idmap, args, dir, entry, mode);
                                                    ^^^^
   807                  if (err)
   808                          goto out_put_forget_req;
   809          }

fs/fuse/dir.c
    578 static int get_create_ext(struct mnt_idmap *idmap,
    579                           struct fuse_args *args,
    580                           struct inode *dir, struct dentry *dentry,
    581                           umode_t mode)
    582 {
    583         struct fuse_conn *fc = get_fuse_conn_super(dentry->d_sb);
    584         struct fuse_in_arg ext = { .size = 0, .value = NULL };
    585         int err = 0;
    586 
    587         if (fc->init_security)
    588                 err = get_security_context(dentry, mode, &ext);
    589         if (!err && fc->create_supp_group)
    590                 err = get_create_supp_group(idmap, dir, &ext);
    591 
    592         if (!err && ext.size) {
                            ^^^^^^^^
I don't know what ext.size is.  Maybe it's zero for symlinks?  In that
case just ignore this static checker warning.

    593                 WARN_ON(args->in_numargs >= ARRAY_SIZE(args->in_args));
    594                 args->is_ext = true;
    595                 args->ext_idx = args->in_numargs++;
--> 596                 args->in_args[args->ext_idx] = ext;
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
3 results an out of bounds warning here.

    597         } else {
    598                 kfree(ext.value);
    599         }
    600 
    601         return err;
    602 }

regards,
dan carpenter


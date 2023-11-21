Return-Path: <linux-fsdevel+bounces-3316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1360F7F3256
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 16:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03E62819A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 15:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED0458106;
	Tue, 21 Nov 2023 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdL7xkwX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752BA58101
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 15:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1319C433C8;
	Tue, 21 Nov 2023 15:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700580487;
	bh=Q0Xz3Gkog1UnTKaFW39C5U5TVNk+fosWdRo6SUG9CJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZdL7xkwX5IMw1qNrHoFdInJlHkUJbhHIIMV0J//NnlDsinmH2xYl6YHJ/o3XsQuQa
	 hvHQf+5r4abLHc7gfTo6DlvcQuwEiVGw3YmZ/F0YHcUSO2enZPry588LxeBONK105/
	 iIJ1eytZjKxV3Ku+ycrViRL8IRzNZi+g6t75vFoUZ37T3Hdh5t52d+pPl+yP1z7gcB
	 go6zm15zY49yES+dz1ISytj/NsuQnmHptJ2LbFJ+2FbEAH7GfbFaPVXa/x2z1ENEEO
	 QpWjKoFL4IAsSV5ORCfZELSn8bfOGYenyKw0Pc/IOkSoFilGE/0VIT8eO8D9pdEDoz
	 ADS/x11q6OZLw==
Date: Tue, 21 Nov 2023 16:28:03 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/15] fs: move permission hook out of do_iter_read()
Message-ID: <20231121-wohnumfeld-zerreden-26405deaf7da@brauner>
References: <20231114153321.1716028-1-amir73il@gmail.com>
 <20231114153321.1716028-12-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231114153321.1716028-12-amir73il@gmail.com>

> +ssize_t vfs_iocb_iter_read(struct file *file, struct kiocb *iocb,
> +			   struct iov_iter *iter)

Fyi, vfs_iocb_iter_read() and vfs_iter_read() end up with the same checks:

        if (!file->f_op->read_iter)
                return -EINVAL;
        if (!(file->f_mode & FMODE_READ))
                return -EBADF;
        if (!(file->f_mode & FMODE_CAN_READ))
                return -EINVAL;

        tot_len = iov_iter_count(iter);
        if (!tot_len)
                goto out;
        ret = rw_verify_area(READ, file, &iocb->ki_pos, tot_len);
        if (ret < 0)
                return ret;

So if you resend you might want to static inline this. But idk, might
not matter too much.


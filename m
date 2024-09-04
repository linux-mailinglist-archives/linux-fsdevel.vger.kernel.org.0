Return-Path: <linux-fsdevel+bounces-28576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9805696C2AB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 17:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 561DA281687
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 15:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B871DFE39;
	Wed,  4 Sep 2024 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Kck8y50B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615D11DEFFB
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464464; cv=none; b=Yf7dnV4zY8GtH3aSm9BnM+YqmqJa/62wTo+2+9tYm6BrW/6BYxzEgP+7aYl2wzaavL/hIyTWyE0Pya0Qs9kzMzPTy9gaytKLpLQQvy0teNanJ4scoNk5fpLyw82dKsesBDAgBQdccglDR89nMN5NVvaEQ489GUbLt9vcmHMOR3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464464; c=relaxed/simple;
	bh=KIcOCaqptOd9Y4prAOFBX98dzPjewLw3kQWGFOAPyuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7eK929yB5faM7F7OM5PZu1url0wbxsrAFFBt9LIES4JGSSaNJXtW7lAry4YOaip0YvDUx2OsNWxSrPKkHljJX0j9s9oecIfCTjKs1Wvte1yMIxYWKxs4LJ3FXXZDjTEQqvJw9emqXVrYcNIz+F9OsBBkDm62kh4pojjt7GCX5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Kck8y50B; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-39fcae1d459so2454005ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2024 08:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725464461; x=1726069261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WAFlTPL+vKIMNdae5uadFzoY5XYBmFrJcvMwEsWTuzo=;
        b=Kck8y50BHdgzgZJ2OOsotVQJtNL5Lzd4XBk4+fqM2Hs5kG+EhZPOLja4XCuQ1jUB3z
         +oaHFx41wpgSRLgzkuGid9jhnCAqJE64qmQc2FeBsnaGBxp3FmULqU2rIacJt7/+aQQH
         O7HObsmkRDfeBO2yEOXg3vm1gjqUuJjAcPG0BFw/gSO9eZbrGQRfNoBWZaWMnnjhaObq
         Q2dU+A4d1Q4+Bh7VTLrhQlZEySZ0VBvOCarF7nIsZ2UwuAaHt1BHwXSDCRw7aYRZm54c
         BnF2SEfVIoly5DUs8uuvzSaBMWMVIR01RsaqxvKGZ3NyZxh0/w4YU1o1wusgviDnZhZ6
         kxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725464461; x=1726069261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WAFlTPL+vKIMNdae5uadFzoY5XYBmFrJcvMwEsWTuzo=;
        b=gh8hD4DEhBwi+g3a0q7w5wlC0AE6Ff8+Z7Bs2rV2WkDHytItoDwHJSvp/OTkgURc5x
         3FeQzNusm8PpH0VqqJIL/UjoEDLeFiTqxnvU3peOtXTW3Day92s0Uh5jwyqkDwlYn/ve
         oQFkJgbLW//8W9gxbUowYkXo/H+wu933ALgxuUkrndL+zlzXSkzCY2+VWpVLcXqkopmU
         fHRAfUcQNqDlsBdvvQ8YvctXBmjy9FCN/jRBGHBNdgZtWjG6/9mkr2BR3wKrliUY8Z4H
         J2WKDY1Lsf61VBrFVM3rka081SSSzWrunhq6d+Om8LISnyvRxSk1O1ZzNv3uX1UFbHrI
         zzew==
X-Gm-Message-State: AOJu0YzmBceLRSbRYiTYFCyAAaZcX7XQVkiR17dQVBDlQpj4paPrkrYC
	sC4WyCccnsAssxn8CZ3LLIGWvxmhKCZ6qKC8l3nlSiXdtMqZdMJBKprXp7ZMnj0=
X-Google-Smtp-Source: AGHT+IGESMUyfDsR4zaM7rj4hDdfhoYfsLxff6zWxpSobRuSuzbZcEg5dZcm2CX4BpTiyaR+uhnJSQ==
X-Received: by 2002:a92:b741:0:b0:39f:5282:3ba5 with SMTP id e9e14a558f8ab-39f52823eb2mr97495255ab.22.1725464461483;
        Wed, 04 Sep 2024 08:41:01 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3b03f266sm37295565ab.57.2024.09.04.08.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 08:41:00 -0700 (PDT)
Message-ID: <2d682763-90b2-4653-b44c-32787ce6227a@kernel.dk>
Date: Wed, 4 Sep 2024 09:40:59 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 08/17] fuse: {uring} Handle SQEs - register
 commands
To: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Pavel Begunkov <asml.silence@gmail.com>, bernd@fastmail.fm
Cc: linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Amir Goldstein <amir73il@gmail.com>
References: <20240901-b4-fuse-uring-rfcv3-without-mmap-v3-0-9207f7391444@ddn.com>
 <20240901-b4-fuse-uring-rfcv3-without-mmap-v3-8-9207f7391444@ddn.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240901-b4-fuse-uring-rfcv3-without-mmap-v3-8-9207f7391444@ddn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/24 7:37 AM, Bernd Schubert wrote:
> +/**
> + * Entry function from io_uring to handle the given passthrough command
> + * (op cocde IORING_OP_URING_CMD)
> + */
> +int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
> +{
> +	const struct fuse_uring_cmd_req *cmd_req = io_uring_sqe_cmd(cmd->sqe);
> +	struct fuse_dev *fud;
> +	struct fuse_conn *fc;
> +	struct fuse_ring *ring;
> +	struct fuse_ring_queue *queue;
> +	struct fuse_ring_ent *ring_ent = NULL;
> +	u32 cmd_op = cmd->cmd_op;
> +	int ret = 0;
> +
> +	ret = -ENODEV;
> +	fud = fuse_get_dev(cmd->file);
> +	if (!fud)
> +		goto out;
> +	fc = fud->fc;
> +
> +	ring = fc->ring;
> +	if (!ring)
> +		goto out;
> +
> +	queue = fud->ring_q;
> +	if (!queue)
> +		goto out;
> +
> +	ret = -EINVAL;
> +	if (queue->qid != cmd_req->qid)
> +		goto out;
> +
> +	ret = -ERANGE;
> +	if (cmd_req->tag > ring->queue_depth)
> +		goto out;
> +
> +	ring_ent = &queue->ring_ent[cmd_req->tag];
> +
> +	pr_devel("%s:%d received: cmd op %d qid %d (%p) tag %d  (%p)\n",
> +		 __func__, __LINE__, cmd_op, cmd_req->qid, queue, cmd_req->tag,
> +		 ring_ent);
> +
> +	spin_lock(&queue->lock);
> +	ret = -ENOTCONN;
> +	if (unlikely(fc->aborted || queue->stopped))
> +		goto err_unlock;
> +
> +	switch (cmd_op) {
> +	case FUSE_URING_REQ_FETCH:
> +		ret = fuse_uring_fetch(ring_ent, cmd, issue_flags);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		pr_devel("Unknown uring command %d", cmd_op);
> +		goto err_unlock;
> +	}
> +out:
> +	pr_devel("uring cmd op=%d, qid=%d tag=%d ret=%d\n", cmd_op,
> +		 cmd_req->qid, cmd_req->tag, ret);
> +
> +	if (ret < 0) {
> +		if (ring_ent != NULL) {
> +			pr_info_ratelimited("error: uring cmd op=%d, qid=%d tag=%d ret=%d\n",
> +					    cmd_op, cmd_req->qid, cmd_req->tag,
> +					    ret);
> +
> +			/* must not change the entry state, as userspace
> +			 * might have sent random data, but valid requests
> +			 * might be registered already - don't confuse those.
> +			 */
> +		}
> +		io_uring_cmd_done(cmd, ret, 0, issue_flags);
> +	}
> +
> +	return -EIOCBQUEUED;
> +
> +err_unlock:
> +	spin_unlock(&queue->lock);
> +	goto out;
> +}

Just a minor thing, but you should be able to just return an error from
here, at least for commands where you don't yet have teardown associated
with it, rather than punting through task_work for that too. Doesn't
really matter and maybe it's cleaner to just keep it the same.

-- 
Jens Axboe


